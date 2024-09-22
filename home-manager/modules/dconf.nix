{ pkgs, ... }: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/background" = {
        # Установка обои пользователя
        picture-uri = "file://$HOME/background.jpg";
      };
      "org/gnome/login-screen" = {
        # Установка аватара пользователя
        logo = "file://$HOME/avatar.jpg";
      };
      "org/gnome/desktop/interface" = {
        gtk-theme = "Numix";
        icon-theme = "Numix";
        cursor-theme = "Numix-Cursor-Light";
        color-scheme = "prefer-dark";
        font-name = "Noto Sans 10";
        document-font-name = "Noto Sans 10";
        monospace-font-name = "Noto Sans Mono 10";
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          appindicator.extensionUuid
          gsconnect.extensionUuid
          tophat.extensionUuid
        ];
      };
    };
  };
}
