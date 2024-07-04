{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    dnsmasq
  ];

  programs = {
    dnsmasq.enable = true;
  };
}
