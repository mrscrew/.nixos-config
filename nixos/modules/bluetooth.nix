{
  # Модуль настройки Bluetooth.
  # Включает поддержку Bluetooth с расширенными профилями (A2DP, HSP, HID) и GUI-менеджер Blueman.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  services.blueman.enable = true;
}
