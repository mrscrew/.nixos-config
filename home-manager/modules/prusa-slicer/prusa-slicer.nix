{ pkgs, ... }:

let
  # Добавляем оверлей для модификации prusa-slicer
  psOverlay = self: super: {
    prusa-slicer = super.prusa-slicer.overrideAttrs (oldAttrs: {
      postInstall = oldAttrs.postInstall + ''
        mkdir -p $out/share/PrusaSlicer/localization/be
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
  nixpkgs.overlays = [ psOverlay ];

  # Указываем путь к файлу локализации, который хотим добавить
  PrusaSlicer.mo = ./PrusaSlicer.mo;
}
