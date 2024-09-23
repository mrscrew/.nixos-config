{ pkgs, ... }:

let
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

  # Указываем путь к файлу локализации
  my-be-file = ./PrusaSlicer.mo;

  nixpkgs.overlays = [ myOverlay ];
}
