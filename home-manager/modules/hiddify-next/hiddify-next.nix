# hiddify-next.nix

{ appimageTools, fetchurl }:
let
  pname = "hiddify";
  version = "2.0.5";

  src = fetchurl {
    url = "https://github.com/hiddify/hiddify-next/releases/download/v${version}/Hiddify-Linux-x64.AppImage";
    sha256 = "sha256-zVwSBiKYMK0GjrUpPQrd0PaexJ4F2D9TNS/Sk8BX4BE=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      substituteInPlace $out/hiddify.desktop --replace 'Exec=LD_LIBRARY_PATH=usr/lib hiddify' 'Exec=${pname}'
    '';
  };
in
appimageTools.wrapType2
{
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [
    libayatana-appindicator
    at-spi2-core
    fontconfig
    pango
    gtk3
    glibc
    gcc
    ayatana-ido
    rubyPackages.gdk_pixbuf2
    libayatana-indicator
    libdbusmenu
    cairo
    harfbuzz
    rubyPackages.glib2
    libepoxy
  ];

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/hiddify.desktop $out/share/applications/hiddify.desktop
    install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/128x128/apps/hiddify.png \
      $out/share/icons/hicolor/128x128/apps/hiddify.png
    install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/256x256/apps/hiddify.png \
      $out/share/icons/hicolor/256x256/apps/hiddify.png
    gtk-update-icon-cache
   '';
}
