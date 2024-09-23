{ pkgs, ... }:

let
  myOverlay = self: super: {
    prusa-slicer = super.prusa-slicer.overrideAttrs (oldAttrs: {
      postInstall = oldAttrs.postInstall + ''
        mkdir -p $out/share/PrusaSlicer/localization/be
        cp ${./my-be-file.po} $out/share/PrusaSlicer/localization/be/
      '';
    });
  };
in
{
  home.packages = with pkgs; [
    prusa-slicer
  ];

  nixpkgs.overlays = [ myOverlay ];

  # Указываем путь к файлу локализации
  my-be-file.po = ./PrusaSlicer.mo;
}
