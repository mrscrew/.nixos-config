{ pkgs, inputs, ... }:

let
  # SourceCraft Code Assistant (расширение Yandex Cloud), официальный VSIX из хранилища Яндекса
  sourcecraft-code-assist = pkgs.vscode-utils.buildVscodeExtensionFromVsix {
    name = "sourcecraft-code-assist";
    src = pkgs.fetchurl {
      url = "https://storage.yandexcloud.net/sourcecraft-code-assistant/plugins/vscode/stable/yandex-cloud-code-assist.vsix";
      sha256 = "8bf0218f5e880ad96b5f0f50f84873125be9a2f176804f0f789df3722271cb11";
    };
  };
in
{
  # Импорт конфигураций пользователя
  imports = [
    ./zsh.nix                   # Настройки Zsh
    ../../modules/git.nix       # Настройки Git
    ../../modules/htop.nix      # Настройки htop
    ../../modules/cursor.nix    # Тема курсора
    ../../modules/yandex-browser/default.nix   # Яндекс.Браузер (последняя версия)
    inputs.noctalia.homeModules.default   # Модуль Noctalia (десктоп-шелл)
  ];

  # Разрешение несвободных пакетов и небезопасной версии Яндекс.Браузера
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "yandex-browser-stable-26.6.1.1083-1"
    ];
  };

  # Noctalia — десктоп-шелл поверх композитора Niri
  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
      wallpaper = {
        enabled = true;
        default.path = "/home/master/background.jpg";
      };
    };
  };

  # Niri — композитор Wayland (скроллящийся тайлинг)
  programs.niri = {
    enable = true;
  };

  # Основные настройки для пользователя
  home = {
    username = "master";                    # Имя пользователя
    homeDirectory = "/home/master";         # Домашняя директория
    stateVersion = "24.05";                 # Версия состояния

    # Файлы в домашней директории
    file = {
      "background.jpg".source = ./background.jpg;
      "avatar.jpg".source = ./avatar.jpg;
    };

    # Графические приложения (единственные разрешённые; Яндекс.Браузер — из модуля)
    packages = with pkgs; [
      # VS Code с текущим набором плагинов
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          davidanson.vscode-markdownlint # Линтер Markdown
          jnoortheen.nix-ide             # Поддержка Nix
          ms-azuretools.vscode-docker    # Поддержка Docker
          ms-ceintl.vscode-language-pack-ru # Русский языковой пакет
          ms-python.python               # Поддержка Python
          ms-vscode-remote.remote-ssh    # Удалённый SSH
          redhat.vscode-yaml             # Поддержка YAML
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          { name = "remote-ssh-edit"; publisher = "ms-vscode-remote"; version = "0.47.2"; sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g"; }
          { name = "koda"; publisher = "Koda"; version = "1.1.0"; sha256 = "b33cc64762a302c81e970ef7dbda138ed0acc6cadefef81bab431f310952d638"; }
        ] ++ [
          sourcecraft-code-assist        # SourceCraft Code Assistant (AI-ассистент)
        ];
      })
    ];
  };
}
