{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim

    lua-language-server

    # nix formatter
    alejandra
  ];
}
