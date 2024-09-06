{
  description = "My system configuration"; # Описание конфигурации системы

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # URL для unstable версии nixpkgs
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05"; # URL для стабильной версии nixpkgs
    home-manager = {
      # Входные данные для Home Manager
      url = "github:nix-community/home-manager"; # URL для Home Manager
      inputs.nixpkgs.follows = "nixpkgs"; # следуйте за nixpkgs для версии
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }:
    let
      system = "x86_64-linux"; # Определение системы
      pkgs = import nixpkgs {
        # Импорт пакетов с настройкой
        inherit system;
        config.allowUnfree = true; # Разрешение использования не свободных пакетов
      };
    in
    {
      nixosConfigurations = {
        # Определение NixOS конфигураций
        nixos-master = nixpkgs.lib.nixosSystem {
          # Конфигурация для nixos-master
          system = "x86_64-linux"; # Система
          specialArgs = { inherit pkgs; }; # Специальные аргументы (пакеты)
          modules = [
            ./nixos/configuration.nix # Основной файл конфигурации
          ];
        };
        nixos-mama = nixpkgs.lib.nixosSystem {
          # Конфигурация для nixos-mama
          system = "x86_64-linux"; # Система
          specialArgs = { inherit pkgs; }; # Специальные аргументы (пакеты)
          modules = [
            ./nixos/configuration.nix # Основной файл конфигурации
          ];
        };
      };

      homeConfigurations.master = home-manager.lib.homeManagerConfiguration {
        # Конфигурация для Home Manager
        pkgs = nixpkgs.legacyPackages.${system}; # Пакеты для Home Manager
        modules = [ ./home-manager/home.nix ]; # Основной файл конфигурации Home Manager
      };

      # packages.${system} = {  # Комментируемый код для сборки пакетов
      #   nixos-mama = self.nixosConfigurations.nixos-mama.config.system.build.toplevel;  # Топ-уровневый набор для nixos-mama
      #   nixos-master = self.nixosConfigurations.nixos-master.config.system.build.toplevel;  # Топ-уровневый набор для nixos-master
      # };
      # Установите версию состояния Home Manager
    };
}
