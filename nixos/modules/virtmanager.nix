{ pkgs, ... }: {
  # Модуль настройки виртуализации.
  # Включает KVM/QEMU через libvirtd и GUI-менеджер Virt-Manager для создания и управления виртуальными машинами.
  virtualisation.libvirtd.enable = true;
  programs.virt-manager = {
    enable = true;
    package = pkgs.virt-manager;
  };
}

