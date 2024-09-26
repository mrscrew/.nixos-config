self: super: {
  orca-slicer = super.orca-slicer.overrideAttrs (oldAttrs: {
    buildInputs = oldAttrs.buildInputs ++ [
      self.gettext
      # Добавьте другие необходимые языковые пакеты
    ];

    cmakeFlags = oldAttrs.cmakeFlags ++ [
      "-DSLIC3R_LANGUAGES=fr;ru" # Укажите нужные языки
    ];
  });
}
