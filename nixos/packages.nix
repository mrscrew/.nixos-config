{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "python-2.7.18.8" "electron-25.9.0" ];
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
    gnome-tweaks
    dconf-editor
    telegram-desktop
    freecad
    openscad
    # kicad
    esphome
    gparted
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

    # GNOME Extensions
    gnomeExtensions.settingscenter
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect

    # Coding stuff
    gnumake
    gcc
    nodejs
    python3Full
    #(python3.withPackages (ps: with ps; [ requests ]))

    # CLI utils
    neofetch
    file
    tree
    wget
    git
    fastfetch
    htop
    nix-index
    unzip
    scrot
    ffmpeg
    light
    lux
    mediainfo
    zram-generator
    cava
    zip
    ntfs3g
    yt-dlp
    openssl
    lazygit
    bluez
    bluez-tools

    # GUI utils
    numix-gtk-theme
    numix-icon-theme
    numix-icon-theme-circle
    numix-cursor-theme
    # feh
    # imv
    # dmenu
    # screenkey
    # mako
    # gromit-mpx

    # Xorg stuff
    #xterm
    #xclip
    #xorg.xbacklight

    # Wayland stuff
    xwayland
    wl-clipboard
    cliphist

    # WMs and stuff
    # herbstluftwm
    # hyprland
    # seatd
    # xdg-desktop-portal-hyprland
    # polybar
    # waybar

    # Sound
    pipewire
    pulseaudio
    pamixer

    # GPU stuff 
    # amdvlk
    # rocm-opencl-icd
    # glaxnimate

    # Screenshotting
    # grim
    # grimblast
    # slurp
    # flameshot
    # swappy

    # Other
    home-manager
    spice-vdagent
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    papirus-nord
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
