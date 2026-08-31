{
  description = "Конфигурация NixOS с Home Manager для нескольких систем на базе Niri + Noctalia";

  # Бинарный кэш Noctalia (Cachix), чтобы не пересобирать шелл из исходников
  # Кэширование тяжелых пакетов: noctalia, niri, greetd, VS Code extensions
  nixConfig = {
    extra-substituters = [ 
      "https://noctalia.cachix.org"
      "https://cache.nixos.org"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    # Включение бинарных подстановок по умолчанию для ускорения сборки
    substituters = [
      "https://noctalia.cachix.org"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    # Основной канал NixOS — стабильная версия 26.05 (актуальная на 2025 год)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # Home Manager: управление конфигурациями пользователя (версия соответствует NixOS)
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia — нативный десктоп-шелл Wayland (ветка cachix гарантирует кэшированные сборки)
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
    };

    # Noctalia Greeter — графический вход на основе greetd
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
    };
  };

  outputs = { self, nixpkgs, home-manager, noctalia, noctalia-greeter, ... }@inputs:
    let
      system = "x86_64-linux"; # Архитектура системы

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # Разрешение несвободных пакетов
      };

      # Общие аргументы, передаваемые в модули систем и Home Manager
      specialArgs = {
        inherit pkgs inputs;
      };
    in
    {
      nixosConfigurations = {
        # Система nixos-master
        nixos-master = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit specialArgs;
          modules = [
            ./nixos/hosts/nixos-master/configuration.nix
          ];
        };

        # Система nixos-mama
        nixos-mama = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit specialArgs;
          modules = [
            ./nixos/hosts/nixos-mama/configuration.nix
          ];
        };
      };

      homeConfigurations.master = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home-manager/users/master/home.nix ];
      };

      homeConfigurations.mama = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home-manager/users/mama/home.nix ];
      };
    };
}
