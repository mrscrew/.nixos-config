{ inputs, ... }: {
  # Импорт аппаратной конфигурации, общих настроек, сервисов, пакетов и модулей
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ../../services.nix              # Сервисы: SSH, Docker, AppImage
    ../../cli-packages.nix          # CLI-утилиты
    ../../fonts.nix                 # Системные шрифты
    ../../users/master.nix          # Пользователь master (администратор)
    ../../modules/bundle.nix        # Набор модулей NixOS
  ];

  # Определение имени хоста
  networking.hostName = "nixos-master";
}
