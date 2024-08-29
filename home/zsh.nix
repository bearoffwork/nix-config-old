{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
    zsh-powerlevel10k
    zsh-fzf-tab
  ];

  home.file = {
    ".config/zsh/p10k.zsh".source = ./config/zsh/p10k.zsh;
  };

  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;

      history = {
        path = "${config.xdg.dataHome}/zsh/zsh_history";
      };

      plugins = [
        {
          name = "powerlevel10k-config";
          src = ./config/zsh;
          file = "p10k.zsh";
        }
      ];

      initExtra = ''
        bindkey '^[[1;5C' forward-word
        bindkey '^[[1;5D' backward-word

        path=(
          $HOME/.local/bin
          $HOME/src/oss/depot_tools
          $path
        )

        # prompt at bottom
        tput cup $(tput lines)

        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

        unsetopt beep
        '';
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.shellAliases = {
    j = "just";
    g = "git";
    vi = "nvim";
    vim = "nvim";
    dev = "devenv";

    random-passwd = "nix-hash --flat --type md5 --base32 <(openssl rand 32)";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };
}
