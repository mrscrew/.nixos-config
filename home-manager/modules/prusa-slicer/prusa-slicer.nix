{ pkgs, ... }:

let
  # Путь к файлу локализации
  my-be-file = ./PrusaSlicer.mo;

  # Оверлей для модификации пакета prusa-slicer
  myOverlay = self: super: {
    prusa-slicer = super.prusa-slicer.overrideAttrs (oldAttrs: {
      postInstall = oldAttrs.postInstall + ''
        mkdir -p $out/share/PrusaSlicer/localization/be
        cp ${my-be-file} $out/share/PrusaSlicer/localization/be/
      '';
    });
  };
in
{
  home.packages = with pkgs; [
    prusa-slicer
  ];

  # Подключение оверлея
  nixpkgs.overlays = [ myOverlay ];
}

