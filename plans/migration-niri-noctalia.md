# План миграции на Niri + Noctalia (NixOS unstable)

## 1. Цель

Перевести личную систему **nixos-master** с GNOME на минималистичную связку:
- **Niri** — композитор Wayland (скроллящийся тайлинг);
- **Noctalia** — нативный десктоп-шелл (бар, уведомления, контрольная панель), работает поверх Niri;
- **Noctalia Greeter** — графический вход на основе `greetd`.

Удалить весь текущий пользовательский софт. GUI оставить только два приложения:
- **VS Code** с текущим набором плагинов;
- **yandex-browser-stable**.

## 2. Принятые решения

| Параметр | Решение |
|----------|---------|
| Версия nixpkgs | `nixos-unstable` (основной вход уже такой); удалить неиспользуемый `nixpkgs-stable` |
| `system.stateVersion` | остаётся `24.05` |
| Пользовательский софт | удаляется из конфигов (кроме vscode и yandex-browser) |
| Оболочка | Niri + Noctalia |
| CLI-утилиты | максимальный набор (см. раздел 5) |
| Дисплейный менеджер | Noctalia Greeter (greetd) |
| Локальные пакеты | `orca-slicer`, `hiddify-next` — уточнить судьбу |

## 3. Источники (официальная документация)

- Noctalia NixOS: модули `nixosModules.default`, `homeModules.default`, пакет `noctalia` (unstable).
- Noctalia Greeter: вход `github:noctalia-dev/noctalia-greeter`, модуль `nixosModules.default`, опция `programs.noctalia-greeter.enable`.
- Niri: настраивается через Home Manager `programs.niri.enable`.

Требуемые для Noctalia сервисы: NetworkManager, Bluetooth, power-profiles-daemon или tuned, upower.

## 4. Изменения в flake.nix

1. Удалить вход `nixpkgs-stable`.
2. Добавить входы:
   - `noctalia = { url = "github:noctalia-dev/noctalia"; }` (для бинарного кэша можно ветку `/cachix` без `follows`);
   - `noctalia-greeter = { url = "github:noctalia-dev/noctalia-greeter"; }`.
3. Передавать `inputs` в модули хостов через `specialArgs`.
4. При необходимости — `nixConfig.extra-substituters` для кэша Noctalia (Cachix).
5. `description` привести к русскому языку.

## 5. Новый набор пакетов (CLI, максимум)

```
# Терминалы / редактирование
kitty                # терминал (для графической сессии)
neovim               # редактор
tmux                 # мультиплексор терминала (альтернатива zellij)

# Поиск и навигация
ripgrep              # быстрый поиск по коду
fd                   # аналог find
fzf                  # нечёткий поиск
bat                  # просмотр файлов с подсветкой
eza                  # современная замена ls
zoxide               # умная навигация по каталогам

# Мониторинг
btop                 # монитор ресурсов
htop                 # процессы (оставляем текущий)

# Git / разработка
lazygit              # TUI для git
git                  # уже есть
docker               # контейнеры
jq                   # работа с JSON

# Медиа и утилиты
imv                  # просмотрщик изображений
mpv                  # видеоплеер
feh                  # лёгкий просмотр/обои
curl                 # загрузка по сети
wget                 # загрузка файлов
```

## 6. Системный модуль (nixos)

Новый модуль (например `nixos/modules/niri-noctalia.nix`) на хосте **master**:
```nix
{ inputs, lib, ... }: {
  imports = [
    inputs.noctalia.nixosModules.default
    inputs.noctalia-greeter.nixosModules.default
  ];

  # Noctalia — шелл поверх композитора
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true; # NM, Bluetooth, UPower, power profile
  };

  # Noctalia Greeter — вход
  programs.noctalia-greeter = {
    enable = true;
    # settings = { ... }; # при необходимости greeter.toml
  };

  # Требуемые сервисы (подстраховка)
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
}
```

Вход подхватывается автоматически (`greetd`, `accounts-daemon` включены модулем).

## 7. Home Manager (пользователь master)

В `home-manager/users/master/home.nix`:
- Импортировать `inputs.noctalia.homeModules.default`.
- Включить `programs.noctalia` с настройками (тема, обои).
- Включить композитор Niri: `programs.niri.enable = true`.
- Оставить конфигурацию Zsh, VS Code, иконки/курсор.

Текущие модули, связанные с GNOME (dconf и пр.), на master отключить.

## 8. Что удаляем из конфигов (master)

- GNOME: `desktopManager.gnome`, `displayManager.gdm` (из `xserver.nix` — заменить на модуль Niri).
- `services.gnome.gnome-settings-daemon`, расширения GNOME, `gnome-*` пакеты.
- Старые пакеты из `packages.nix`: gimp, cheese, ffmpeg_7, gnome-music, gnome-photos, gnome-terminal, gnome-tweaks, totem, vlc, libreoffice, evince, menulibre, scrot, темы Numix и т.д.
- Алиасы/редакторы привести к согласованному виду.

## 9. Различия хостов (осторожно)

- `master` — ext4 + swap с `boot.resumeDevice`.
- `mama` — btrfs с `subvol=@`, без swap, пользователи `master`+`mama`.
- Миграция на Niri затрагивает в первую очередь `master`. Вопрос охвата `mama` открыт (см. обсуждение).

## 10. Порядок реализации

1. Правим `flake.nix` (входы, передача `inputs`).
2. Создаём модуль `niri-noctalia.nix`, подключаем на `master`.
3. Обновляем `home-manager/users/master` (Noctalia, Niri, набор пакетов).
4. Чистим `packages.nix` и системные пакеты от старых GUI.
5. Запускаем `nix flake check`, `nixos-rebuild dry-build` на `master`.
6. Переносим чистку на `mama` (если охват подтверждён).

## 11. Риски

- Noctalia v5+ отсутствует в стабильном nixpkgs — требуется `unstable` (решение принято).
- Для бинарного кэша нужно использовать ветку `cachix` без `follows` на nixpkgs (иначе пересборка из исходников).
- Greeter: имя сессии должно совпадать с `Name=` из `.desktop` (для Niri — `niri`, проверить командой `noctalia-greeter sessions`).
- `stateVersion` оставляем `24.05` — это безопасно и не требует апгрейда профиля.