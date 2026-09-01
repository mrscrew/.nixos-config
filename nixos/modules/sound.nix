{
  # Модуль настройки звуковой подсистемы PipeWire.
  # Заменяет PulseAudio на современный PipeWire с поддержкой ALSA, JACK и Bluetooth.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
