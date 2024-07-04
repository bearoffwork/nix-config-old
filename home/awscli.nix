{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    awscli2
  ];

  programs = {
    awscli = {
      enable = true;
      package = pkgs.awscli2;
    };
  };
}
