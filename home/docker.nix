{ pkgs, lib, config, ... }:
{
  home.packages = with pkgs; [
    colima
    docker-client
    dive
    docker-credential-helpers
    amazon-ecr-credential-helper
  ];

  programs = {
  };

  home.sessionVariables = {
    DOCKER_HOST = "unix:///${config.home.homeDirectory}/.colima/default/docker.sock";
  };
}
