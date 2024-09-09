{ pkgs, ... }: {
  home.packages = [
    # Используем переопределённый пакет OrcaSlicer с поддержкой перевода
    pkgs.orca-slicer.overrideAttrs (oldAttrs: rec {
      postInstall = ''
        # Скачивание файла перевода на русский язык
        wget https://raw.githubusercontent.com/SoftFever/OrcaSlicer/master/localization/i18n/OrcaSlicer_ru.po -O $out/share/OrcaSlicer/localization/i18n/OrcaSlicer_ru.po

        # Конвертация файла перевода в бинарный формат .mo
        msgfmt $out/share/OrcaSlicer/localization/i18n/OrcaSlicer_ru.po -o $out/share/OrcaSlicer/resources/i18n/ru/OrcaSlicer.mo
      '';
    })
  ];
}
