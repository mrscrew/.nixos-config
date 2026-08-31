{ pkgs, ... }: {
  # Общий модуль определения пользователя mama для хоста nixos-mama
  users.users.mama = {
    isNormalUser = true;
    description = "Маманя";
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [ ];
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
