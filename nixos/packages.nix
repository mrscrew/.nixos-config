{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Install firefox.
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    # Desktop apps
    libreoffice-qt6-fresh
    megasync
    telegram-desktop
    freecad
    openscad
    # kicad
    esphome
    vlc
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        jnoortheen.nix-ide
        redhat.vscode-yaml
        ms-python.python
        davidanson.vscode-markdownlint
        ms-azuretools.vscode-docker
        ms-ceintl.vscode-language-pack-ru
        ms-vscode-remote.remote-ssh
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.47.2";
          sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
        }
      ];
    })
    nixpkgs-fmt
    wineWowPackages.stable
    wineWowPackages.staging
    winetricks

    # Gnome Software
    gnome-photos
    gnome-tour
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    evince # document viewer
    gnome-characters
    totem # video player
    gnome-tweaks
    gparted
    dconf-editor

    # GNOME Extensions
    gnomeExtensions.settingscenter
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect

    file
    tree
    wget
    git
    htop
    nix-index
    unzip
    scrot
    ffmpeg
    zram-generator
    zip
    ntfs3g
    openssl
    bluez
    bluez-tools

    # GUI utils
    numix-gtk-theme
    numix-icon-theme
    numix-icon-theme-circle
    numix-cursor-theme

    # Sound
    pipewire
    pulseaudio

    # Other
    home-manager
    spice-vdagent
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
  ];
}
