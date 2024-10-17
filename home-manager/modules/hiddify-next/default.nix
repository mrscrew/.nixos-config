# default.nix
# { pkgs ? import <nixpkgs> {} }:
# pkgs.callPackage ./hiddify-next.nix {}

{ pkgs, ... }:

let
  hiddify-next = pkgs.callPackage ./hiddify-next.nix { };
in

{
  home.packages = [
    hiddify-next
  ];
}
