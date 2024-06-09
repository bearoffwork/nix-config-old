rebuild-switch:
  git add .
  darwin-rebuild switch --flake .

update:
  nix flake update
