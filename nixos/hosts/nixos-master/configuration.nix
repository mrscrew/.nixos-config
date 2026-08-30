{ inputs, ... }: {
  # Импорт аппаратной конфигурации, общих настроек, пакетов и модулей
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ../../packages.nix
    ../../modules/nixos-master-users.nix
    ../../modules/bundle.nix
  ];

  # Определение имени хоста
  networking.hostName = "nixos-master";
}
