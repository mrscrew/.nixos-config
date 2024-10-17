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
    install -m 444 -D ${appimageContents}/hiddify.desktop -t $out/share/applications
    cp -r ${appimageContents}/usr/share/icons $out/share
    substituteInPlace $out/share/applications/hiddify.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
  '';
}
