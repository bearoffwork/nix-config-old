{ pkgs, self, system, username, ... }: 
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
  [
    coreutils
    rsync # replace with 3.x version
    gnused # replace bsd sed with gnu version
    gnumake
    gcc
    fontconfig

    skhd # hotkeyd
    wezterm # terminal

    utm # vm

    python3
  ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina

  services = {
    skhd = {
      enable = true;
    };
  };
}
