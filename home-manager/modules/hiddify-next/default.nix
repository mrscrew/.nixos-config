# default.nix

{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ./hiddify-next.nix {}
