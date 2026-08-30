{
  description = "Конфигурация NixOS с Home Manager для нескольких систем на базе Niri + Noctalia";

  # Бинарный кэш Noctalia (Cachix), чтобы не пересобирать шелл из исходников
  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    # Основной вход — нестабильная версия nixpkgs для свежих пакетов
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager: управление конфигурациями пользователя
    home-manager = {
      url = "github:nix-community/home-manager";
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

  outputs = { self, nixpkgs, home-manager, noctalia, noctalia-greeter, ... }:
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
