{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    awscli2
    # copilot-cli
  ];

  programs = {
    awscli = {
      enable = true;
      package = pkgs.awscli2;
    };
    zsh = {
      initExtra = ''
        complete -C ${pkgs.awscli2}/bin/aws_completer aws
      '';
    };
  };
}
