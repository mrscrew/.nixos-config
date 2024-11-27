{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
      let
        host_name = "$HOST"; 
        flakeDir = "~/.nixos-config";
      in
      {
        # Очистка системы от мусора
        gc = "echo Глубокая очистка && gcu && gcs";
        gcs = "echo Очистка системы && sudo nix-collect-garbage -d";
        gcu = "echo Очистка профиля пользователя && nix-collect-garbage -d";

        # Обновить систему и пересобрать конфигурацию для определенной системы
        upg = "echo Полное обновление системы:$HOST && \
              echo Обновляю каналы && sudo nix-channel --update && \
              echo Пересобираю конфигурасию для $HOST && \
              sudo nixos-rebuild switch --upgrade --flake ${flakeDir}/.#$HOST";

        rb = "sudo nixos-rebuild switch --flake ${flakeDir}/.#nixos-master";

        # Автоматизация работы с флейками
        flks = "nix flake show ${flakeDir}"; # Показать информацию о флейке
        flkc = "nix flake check ${flakeDir}"; # Проверяет валидность флейка.
        flku = "nix flake update ${flakeDir}"; # Обновить флейк

        # Автоматизация работы с home-manager
        hms = "home-manager switch --flake ${flakeDir}/.#master";

        # Список установленных програм
        lsapps = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq";
        lsappu = "nix-env --query";

        conf = "nano ${flakeDir}/nixos/hosts/nixos-master/configuration.nix";
        pkgs = "nano ${flakeDir}/nixos/packages.nix";

        ll = "ls -l";
        no = "nano";
      };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "agnoster"; # blinks is also really nice
    };
  };
}
