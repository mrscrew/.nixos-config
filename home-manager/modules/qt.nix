{
  qt = {
    enable = true;
    platformTheme.name = "qt5ct"; # Указываем qt5ct как платформенную тему
    style.name = "Adwaita"; # Используем Kvantum как стиль
  };

  # Конфигурация для qt5ct
  xdg.configFile = {
    "qt5ct/qt5ct.conf".text = ''
      [General]
      theme=Adwaita  # Устанавливаем тему Adwaita по умолчанию
    '';
  };
}
