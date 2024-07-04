{ config, pkgs, ... }:

{
  home.packages = with pkgs; [

    php83Packages.composer
    (pkgs.php83.buildEnv {
      extensions = ({ enabled, all }: enabled ++ (with all; [
        php83Extensions.xdebug
      ]));
      extraConfig = ''
        [xdebug]
        xdebug.mode = debug
        xdebug.client_host = 127.0.0.1
        xdebug.client_port = 9003
      '';
    })
  ];
}
