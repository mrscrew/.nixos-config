{ pkgs, ... }:

let
  # Добавляем оверлей для модификации prusa-slicer
  psOverlay = self: super: {
    prusa-slicer = super.prusa-slicer.overrideAttrs (oldAttrs: {
      postInstall = oldAttrs.postInstall + ''
        cp ${./PrusaSlicer.mo} $out/share/PrusaSlicer/localization/be/
      '';
    });
  };
in
{
  home.packages = with pkgs; [
    prusa-slicer
  ];

  # Применяем наш оверлей
  pkgs.overlays = [ psOverlay ];

  # Указываем путь к файлу локализации, который хотим добавить
  PrusaSlicer.mo = ./PrusaSlicer.mo;
}
