{ config, ... }: {
  # Конфигурация Zsh для пользователя master
  # Использует общий модуль и добавляет уникальные алиасы администратора
  
  imports = [ ../../modules/zsh/common.nix ];
  
  programs.zsh.shellAliases =
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
      upg = "echo Полное обновление системы: $HOST && \
             echo Обновляю каналы && sudo nix-channel --update && \
             echo Пересобираю конфигурацию для $HOST && \
             sudo nixos-rebuild switch --upgrade --flake ${flakeDir}/.#$HOST";

      rb = "sudo nixos-rebuild switch --flake ${flakeDir}#nixos-master";

      # Автоматизация работы с флейками
      flks = "nix flake show ${flakeDir}"; # Показать информацию о флейке
      flkc = "nix flake check ${flakeDir}"; # Проверяет валидность флейка.
      flku = "nix flake update ${flakeDir}"; # Обновить флейк

      # Автоматизация работы с home-manager
      hms = "home-manager switch --flake ${flakeDir}/.#master";

      # Список установленных програм
      lsapps = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq";
      lsappu = "nix-env --query";

      # Алиасы для редактирования конфигов и пакетов
      conf = "micro ${flakeDir}/nixos/hosts/nixos-master/configuration.nix";
      pkgs = "micro ${flakeDir}/nixos/cli-packages.nix";

      ll = "ls -l";
      no = "micro";
    };
}
