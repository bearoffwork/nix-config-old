{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    python312
    python312Packages.conda
  ];

  programs = {
  };
}
