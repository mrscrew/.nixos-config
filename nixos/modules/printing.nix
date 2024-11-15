{
  services.printing = {
    enable = true;
    # drivers = [ pkgs.hplipWithPlugin ];
    drivers = [ pkgs.hplip ];
    # drivers = [ pkgs.foo2zjs ];
  };
}
