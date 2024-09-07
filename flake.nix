{
  description = "NixOS configuration with Home Manager for multiple systems"; # Описание конфигурации системы NixOS с использованием Home Manager

  inputs = {
    # Определение входных данных для конфигурации
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # URL для нестабильной версии nixpkgs, чтобы использовать последние обновления и пакеты
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05"; # URL для стабильной версии nixpkgs для использования стабильных пакетов
    home-manager = {
      # Входные данные для Home Manager
      url = "github:nix-community/home-manager"; # URL для репозитория Home Manager, управляющего конфигурациями пользователя
      inputs.nixpkgs.follows = "nixpkgs"; # Следование за версией nixpkgs для согласованности версий
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }:
    let
      system = "x86_64-linux"; # Определение системы для 64-битной архитектуры Linux
      pkgs = import nixpkgs {
        # Импорт пакетов для конфигурации системы
        inherit system; # Наследование архитектуры системы
        config.allowUnfree = true; # Разрешение использования несвободных пакетов (например, проприетарных драйверов или программ)
      };
    in
    {
      nixosConfigurations = {
        # Определение конфигураций для различных систем NixOS
        nixos-master = nixpkgs.lib.nixosSystem {
          # Конфигурация для системы "nixos-master"
          system = "x86_64-linux"; # Определение архитектуры системы
          specialArgs = { inherit pkgs; }; # Передача переменной пакетов `pkgs` в конфигурацию
          modules = [
            ./nixos/hosts/nixos-master/configuration.nix # Путь к основному файлу конфигурации NixOS для системы "nixos-master"
          ];
        };
        nixos-mama = nixpkgs.lib.nixosSystem {
          # Конфигурация для системы "nixos-mama"
          system = "x86_64-linux"; # Определение архитектуры системы
          specialArgs = { inherit pkgs; }; # Передача переменной пакетов `pkgs` в конфигурацию
          modules = [
            ./nixos/hosts/nixos-mama/configuration.nix # Путь к основному файлу конфигурации NixOS для системы "nixos-mama"
          ];
        };
      };

      homeConfigurations.master = home-manager.lib.homeManagerConfiguration {
        # Конфигурация Home Manager для пользователя "master"
        pkgs = nixpkgs.legacyPackages.${system}; # Использование пакетов из nixpkgs для конфигурации Home Manager
        modules = [ ./home-manager/users/master/home.nix ]; # Путь к конфигурационному файлу Home Manager для пользователя "master"
      };

      homeConfigurations.mama = home-manager.lib.homeManagerConfiguration {
        # Конфигурация Home Manager для пользователя "mama"
        pkgs = nixpkgs.legacyPackages.${system}; # Использование пакетов из nixpkgs для конфигурации Home Manager
        modules = [ ./home-manager/users/mama/home.nix ]; # Путь к конфигурационному файлу Home Manager для пользователя "mama"
      };
    };
}
