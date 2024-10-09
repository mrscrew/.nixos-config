# hiddify-next.nix

{ appimageTools, fetchurl }:
let
  pname = "hiddify";
  version = "2.0.5";

  src = fetchurl {
    url = "https://github.com/hiddify/hiddify-next/releases/download/v${version}/Hiddify-Linux-x64.AppImage";
    sha256 = "sha256-kvM1rBGEJhjRqQt3a8+I0o4ahB1Uc9qB+4PzhYoNQdM=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      substituteInPlace $out/hiddify.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
    '';
  };
in
appimageTools.wrapType2
{
  inherit pname version src;

  # extraPkgs = pkgs: with pkgs; [ webkitgtk ];

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/hiddify.desktop $out/share/applications/hiddify.desktop
    install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/128x128/apps/hiddify.png \
      $out/share/icons/hicolor/128x128/apps/hiddify.png
    install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/256x256/apps/hiddify.png \
      $out/share/icons/hicolor/256x256/apps/hiddify.png
  '';

  # profile = ''
  #   export GST_PLUGIN_SYSTEM_PATH_1_0=/usr/lib/gstreamer-1.0
  # '';

}
