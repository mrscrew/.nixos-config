{ pkgs, ... }: {
  # Модуль системных шрифтов
  # Базовые шрифты Noto, эмодзи и иконки Font Awesome
  
  fonts.packages = with pkgs; [
    noto-fonts           # базовые шрифты Noto
    noto-fonts-emoji     # эмодзи Noto
    font-awesome         # иконки (для баров и уведомлений)
  ];
}
