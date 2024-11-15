{
  services.printing = {
    enable = true;
    # drivers = [ pkgs.hplipWithPlugin ];
    # drivers = [ pkgs.hplip ];
    drivers = [ foo2zjs ];
  };
}
