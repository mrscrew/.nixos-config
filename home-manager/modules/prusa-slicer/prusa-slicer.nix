{ config, pkgs, lib, ... }:

let
  # Путь к вашему файлу локализации
  myLocalizationFile = ./PrusaSlicer.mo;
in
{
  home.packages = with pkgs; [
    prusa-slicer
  ];

  environment.etc."prusa-slicer-localization-be".source = myLocalizationFile;

  home.activation = {
    prusa-slicer-localization = lib.mkAfter ''
      sudo cp ${myLocalizationFile} /usr/share/PrusaSlicer/localization/be/translation.po
    '';
  };
}

