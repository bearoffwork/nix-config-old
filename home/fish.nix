{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    fish
  ];

  programs = {
    fish = {
      enable = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [ "--cmd cd" ];
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
      git = true;
      icons = true;
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  home.shellAliases = {
    j = "just";
    random-passwd = "nix-hash --flat --type md5 --base32 <(openssl rand 32)";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };
}
