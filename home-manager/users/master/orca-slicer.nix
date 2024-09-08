{ pkgs, ... }:
{
  home.packages = [
    pkgs.orca-slicer.overrideAttrs (oldAttrs: rec {
      postInstall = ''
        wget https://raw.githubusercontent.com/SoftFever/OrcaSlicer/master/localization/i18n/OrcaSlicer_ru.po -O $out/share/OrcaSlicer/localization/i18n/OrcaSlicer_ru.po
        msgfmt $out/share/OrcaSlicer/localization/i18n/OrcaSlicer_ru.po -o $out/share/OrcaSlicer/resources/i18n/ru/OrcaSlicer.mo
      '';
    })
  ];
}
