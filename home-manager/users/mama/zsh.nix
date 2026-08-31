{ config, ... }: {
  # Конфигурация Zsh для пользователя mama
  # Использует общий модуль и добавляет уникальные алиасы
  
  imports = [ ../../modules/zsh/common.nix ];
  
  programs.zsh.shellAliases =
    let
      flakeDir = "~/.nixos-config";
    in
    {
      # Пересборка конфигурации NixOS
      rb = "sudo nixos-rebuild switch --flake ${flakeDir}#nixos-mama";
      # Обновление флейка
      upd = "nix flake update ${flakeDir}";
      # Обновление системы с апгрейдом пакетов
      upg = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}#nixos-mama";

      # Применение конфигурации Home Manager
      hms = "home-manager switch --flake ${flakeDir}#mama";

      # Алиасы для редактирования конфигов и пакетов
      conf = "micro ${flakeDir}/nixos/hosts/nixos-mama/configuration.nix";
      pkgs = "micro ${flakeDir}/nixos/cli-packages.nix";

      # Прочие утилиты
      ll = "ls -l";
      v = "micro";
      se = "sudoedit";
      ff = "fastfetch";
    };
}
