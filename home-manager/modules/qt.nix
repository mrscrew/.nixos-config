{
  qt = {
    enable = true;
    platformTheme.name = "kvantum"; # Используем Kvantum как платформенную тему
    style.name = "kvantum"; # Используем Kvantum как стиль
  };

  # Конфигурация для Kvantum
  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Adwaita  # Устанавливаем Adwaita Kvantum по умолчанию
    '';

    # Поддержка темы Adwaita Kvantum
    "Kvantum/Adwaita".source = "${pkgs.adwaita-qt-theme}/share/Kvantum/Adwaita";

    # Поддержка темы Materia Kvantum
    "Kvantum/Materia".source = "${pkgs.materia-kde-theme}/share/Kvantum/Materia";
  };
}
