# default.nix
# { pkgs ? import <nixpkgs> {} }:
# pkgs.callPackage ./orca-slicer.nix {}

{ pkgs, ... }:

let
  orca-slicer-bin = pkgs.callPackage ./orca-slicer.nix { };
in

{
  home.packages = [
    orca-slicer-bin
  ];
}
