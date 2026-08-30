{ pkgs, ... }:

# Модуль установки Яндекс.Браузера последней версии (стабильная ветка)
# из репозитория repo.yandex.ru через локальную derivation.

let
  yandex-browser = pkgs.callPackage ./yandex-browser.nix { };
in
{
  home.packages = [
    yandex-browser
  ];
}