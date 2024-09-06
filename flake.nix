{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs= import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        nixos-master = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit pkgs; };
          modules = [
            ./nixos/configuration.nix
          ];
        };
        nixos-mama = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit pkgs; };
          modules = [
            ./nixos/configuration-nixos-mama.nix
          ];
        };
      };

      homeConfigurations.master = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home-manager/home.nix ];
      };

      #packages.${system} = {
      #  nixos-mama = self.nixosConfigurations.nixos-mama.config.system.build.toplevel;
      #  nixos-master = self.nixosConfigurations.nixos-master.config.system.build.toplevel;
      #};
    };
}
