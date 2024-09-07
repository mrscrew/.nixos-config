{ pkgs, ... }: {
  imports = [
    ./zsh.nix
    ../../modules/bundle.nix
  ];
  home = {
    username = "mama";
    homeDirectory = "/home/mama";
    stateVersion = "24.05";
  };
}
