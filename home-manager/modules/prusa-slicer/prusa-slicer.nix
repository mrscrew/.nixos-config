{ pkgs, ... }:{
  home.packages = with pkgs; [
    prusa-slicer.overrideAttrs
    (prusaSlicerAttrs: {
      # ... (другие настройки)
      localization = {
        be = {
          PrusaSlicer.mo = "./PrusaSlicer.mo"; # Замените путь на реальный
        };
      };
    })
  ];
}
