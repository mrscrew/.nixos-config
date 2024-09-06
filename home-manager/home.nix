{ pkgs, ... }: {
  imports = [
    ./zsh.nix
    ./modules/bundle.nix
  ];
  home = {
    username = "master";
    homeDirectory = "/home/master";
    stateVersion = "24.05";
  };
}
