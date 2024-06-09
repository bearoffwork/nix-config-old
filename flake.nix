{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    darwin,
    home-manager,
  }: let
    username = "bear";
    hostname = "bear-mba";
    system = "aarch64-darwin";
    specialArgs =
      inputs // { inherit username hostname system; };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#hostname
    darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [ 
        ./modules/darwin.nix
        ./modules/pkgs.nix
        ./modules/osx.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home;
          home-manager.extraSpecialArgs = specialArgs;
        }
        {
          # Make the home-manager binary available
          environment.systemPackages = [
            home-manager.packages.${system}.home-manager
          ];
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
  };
}
