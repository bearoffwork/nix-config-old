{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    git
    delta
    gh
  ];

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Bear.Y";
    userEmail = "codes@rra3b.io";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autoStash = true;
      merge.ff = false;

      alias = {
        s = "show";
        st = "status";
        ch = "checkout";
        chb = "checkout -b";
        pl = "pull --rebase";
        pu = "push";
        mr = "merge --no-ed";

        aa = "add -A";
        c = "commit";
        cm = "commit -m";
        cam = "commit -am";
        caa = "commit -a --amend --no-edit";
      };
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
