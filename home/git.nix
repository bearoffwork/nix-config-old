{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    git
    delta
    gh
  ];

  programs.git = {
    enable = true;
    userName = "Bear.Y";
    userEmail = "codes@rra3b.io";

    extraConfig = {
      init.defaultBranch = "main";
    };

    includes = [{
      condition = "hasconfig:remote.*.url:https://github.com/euimoney/*";
      contents.user.email = "bear@eui.money";
    }];

    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
      };
    };
  };
}
