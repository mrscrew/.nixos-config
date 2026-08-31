{ pkgs, ... }: {
  # Общий модуль определения пользователя master для всех хостов
  users.users.master = {
    isNormalUser = true;
    description = "Хозяин";
    extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
    packages = with pkgs; [ ];
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
