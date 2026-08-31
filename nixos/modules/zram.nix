{
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    # 50% от RAM вместо 100% — баланс между памятью и CPU.
    # 100% на старых CPU давал высокий overhead на сжатие.
    memoryPercent = 50;
    priority = 999;
  };
}
