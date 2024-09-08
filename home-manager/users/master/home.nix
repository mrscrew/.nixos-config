{ pkgs, ... }: {
  imports = [
    ./zsh.nix
    ./orca-slicer.nix
    ../../modules/bundle.nix
  ];
  home = {
    username = "master";
    homeDirectory = "/home/master";
    stateVersion = "24.05";
  };
}
