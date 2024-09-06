{
  services.xserver = {
    enable = true;
    #windowManager.herbstluftwm.enable = true;

    # displayManager = {
    #   autoLogin.enable = true;
    #   autoLogin.user = "amper";
    #   lightdm.enable = true;
    # };

    xkb = {
      layout = "us,ru";
      variant = "";
      options = grp:rctrl_rshift_toggle;
    };

    # libinput = {
    #   enable = true;
    #   mouse.accelProfile = "flat";
    #   touchpad.accelProfile = "flat";
    # };

    #videoDrivers = [ "amdgpu" ];
    #deviceSection = ''Option "TearFree" "True"'';
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
