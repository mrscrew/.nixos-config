# orca-slicer.nix

{ appimageTools, fetchurl }:
let
  pname = "orca-slicer";
  version = "2.1.1";

  src = fetchurl {
    url = "https://github.com/SoftFever/OrcaSlicer/releases/download/v${version}/OrcaSlicer_Linux_V${version}.AppImage";
    sha256 = "sha256-kvM1rBGEJhjRqQt3a8+I0o4ahB1Uc9qB+4PzhYoNQdM=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      substituteInPlace $out/OrcaSlicer.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
    '';
  };
in
appimageTools.wrapType2
{
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [ webkitgtk_6_0 ];

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/OrcaSlicer.desktop $out/share/applications/OrcaSlicer.desktop
    install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/192x192/apps/OrcaSlicer.png \
      $out/share/icons/hicolor/192x192/apps/OrcaSlicer.png
  '';

  profile = ''
    export GST_PLUGIN_SYSTEM_PATH_1_0=/usr/lib/gstreamer-1.0
  '';

}
