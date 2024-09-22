{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases =
      let
        flakeDir = "~/.nixos-config";
      in
      {
        rb = "sudo nixos-rebuild switch --flake ${flakeDir}.#nixos-master";
        upd = "nix flake update ${flakeDir}";
        upg = "sudo nixos-rebuild switch --upgrade --flake ${flakeDir}.#nixos-master";
        
        # Автоматизация работы с флейками
        flks = "nix flake show ${flakeDir}";    # Показать информацию о флейке
        flkc = "nix flake check ${flakeDir}";   # Проверяет валидность флейка.
        flku = "nix flake update ${flakeDir}";  # Обновить флейк

        hms = "home-manager switch --flake ${flakeDir}.#master";

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
