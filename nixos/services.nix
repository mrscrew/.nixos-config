{ pkgs, ... }: {
  # Модуль системных сервисов
  # Включает SSH, Docker и поддержку AppImage
  
  # SSH-сервер для удалённого доступа
  services.openssh.enable = true;
  
  # Docker (демон) для контейнеризации
  virtualisation.docker.enable = true;
  
  # Поддержка AppImage-приложений через binfmt
  programs.appimage.binfmt = true;
}
