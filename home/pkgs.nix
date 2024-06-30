{ config, pkgs, ... }:

{
  home.packages = with pkgs; [

    # "modern" replacements
    ripgrep # grep
    bat # cat
    just # make
    viddy # watch

    # utils
    tig # for git graph
    jq
    htop

    # dev
    wezterm
    colima
    docker-client
    php82Packages.composer
    (pkgs.php82.buildEnv {
      extensions = ({ enabled, all }: enabled ++ (with all; [
        xdebug
      ]));
      extraConfig = ''
        xdebug.mode=debug
        xdebug.client_host = "127.0.0.1"
        xdebug.client_port = 9003
        ;xdebug.idekey = "PHPSTORM"

        xdebug.discover_client_host = yes
        xdebug.start_with_request = yes
        xdebug.cli_color = 1
        xdebug.output_dir = "~/xdebug/phpstorm/tmp/profiling"

        xdebug.var_display_max_children = -1
        xdebug.var_display_max_data = -1
        xdebug.var_display_max_depth = -1
      '';
    })

    jdk

    # nix formatter
    alejandra

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
