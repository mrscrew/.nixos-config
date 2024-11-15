{ pkgs, ... }: {
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplipWithPlugin pkgs.foo2zjs pkgs.carps-cups];
  };
}
