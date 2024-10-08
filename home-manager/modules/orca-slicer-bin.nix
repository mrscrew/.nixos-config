{ pkgs, ... }:

let
  orca-slicer-bin = pkgs.callPackage ./orca-slicer.nix { };
in

{
  home.packages = [
    orca-slicer-bin
  ];
}
