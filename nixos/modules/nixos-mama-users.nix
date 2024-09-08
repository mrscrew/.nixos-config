{ pkgs, ... }: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.master = {
      isNormalUser = true;
      description = "Админ";
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
      packages = with pkgs; [ ];
    };

    users.mama = {
      isNormalUser = true;
      description = "Маманя";
      extraGroups = [ "networkmanager" ];
      packages = with pkgs; [ ];
    };
  };

  # Enable automatic login for the user.
  # services.getty.autologinUser = "master";
}
