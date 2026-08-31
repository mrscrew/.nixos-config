{ pkgs, ... }: {
  # Модуль настройки печати.
  # Включает CUPS и устанавливает драйверы для HP, Canon и ZjStream принтеров.
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin pkgs.foo2zjs pkgs.carps-cups ];
  };
}
