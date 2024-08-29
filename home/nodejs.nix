{ pkgs, lib, config, ... }:
let
  pnpmHome = "${config.home.homeDirectory}/.local/share/pnpm/bin";
in
{
  home.packages = with pkgs; [
    nodejs
    nodePackages.aws-cdk
    pnpm
  ];

  programs = {
  };
}
