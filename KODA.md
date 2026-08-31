# NixOS Config — Справочный файл

## Обзор проекта

Это **Nix flakes-конфигурация** для развёртывания и управления одной или несколькими машинами с NixOS. Конфигурация использует declarative-подход: вся система (пакеты, сервисы, пользователи, настройки рабочего стола) описывается в декларативных Nix-файлах и может быть воспроизведена на любом хосте.

**Тип проекта:** инфраструктура как код (NixOS + Home Manager).

### Ключевые технологии

| Технология | Назначение |
|---|---|
| **NixOS** | Основной дистрибутив Linux (декларативная конфигурация системы) |
| **Home Manager** | Управление пользовательским окружением (dotfiles, программы, shell) |
| **Nix Flakes** | Формат версионирования и зависимостей конфигурации |
| **Niri** | Wayland-композитор со скроллящимся тайлингом (рабочий стол) |
| **Noctalia** | Десктоп-шелл поверх Niri (темы, обои, UI-настройки) |
| **Cachix** | Бинарный кэш `noctalia.cachix.org` для ускорения сборок |

### Архитектура

Конфигурация организована как flakes с двумя основными направлениями:

```
nixos-config/
├── flake.nix                          # Корневой flake (точка входа)
├── nixos/                             # Системные конфигурации NixOS
│   ├── common.nix                     # Общие настройки для всех хостов
│   ├── packages.nix                   # Системные пакеты (btop, micro, Docker и т.д.)
│   ├── modules/                       # Модули NixOS
│   │   ├── bundle.nix                 # Импорт всех модулей (bootloader, sound, nm и др.)
│   │   ├── niri-noctalia.nix          # Настройка Niri + Noctalia
│   │   ├── bootloader.nix             # Загрузчик (GRUB/systemd-boot)
│   │   ├── nm.nix                     # NetworkManager
│   │   ├── sound.nix                  # PipeWire звук
│   │   ├── bluetooth.nix              # Bluetooth + blueman
│   │   ├── virtmanager.nix            # Libvirt + Virt-Manager
│   │   ├── printing.nix               # Печать (CUPS)
│   │   ├── trim.nix                   # TRIM для SSD
│   │   ├── zram.nix                   # Сжатая swap-память
│   │   ├── env.nix                    # Системные переменные окружения
│   │   ├── nixos-master-users.nix     # Пользователи хоста nixos-master
│   │   └── nixos-mama-users.nix       # Пользователи хоста nixos-mama
│   └── hosts/
│       ├── nixos-master/              # Хост: основной (машина пользователя "master")
│       │   ├── configuration.nix
│       │   └── hardware-configuration.nix
│       └── nixos-mama/                # Хост: вторичный (машина пользователя "mama")
│           ├── configuration.nix
│           └── hardware-configuration.nix
└── home-manager/
    ├── modules/                       # Модули Home Manager
    │   ├── git.nix                    # Настройки Git
    │   ├── htop.nix                   # Настройки htop/btop
    │   ├── cursor.nix                 # Тема курсора
    │   └── yandex-browser/            # Яндекс.Браузер
    └── users/
        ├── master/                    # Конфиг пользователя "master"
        │   ├── home.nix               # Домашняя директория, VS Code, Niri, Noctalia
        │   └── zsh.nix                # Zsh + oh-my-zsh
        └── mama/                      # Конфиг пользователя "mama"
            ├── home.nix
            └── zsh.nix
```

## Сборка и запуск

### Обновление всей системы
```fish
# Полный upgrade системы (каналы + пересборка флейка)
upg
```

### Пересборка хоста
```fish
# Обновление конфигурации конкретного хоста
sudo nixos-rebuild switch --flake ~/.nixos-config.#[host-name]

# Пример:
sudo nixos-rebuild switch --flake ~/.nixos-config.#[nixos-master]
```

### Home Manager
```fish
# Применение пользовательской конфигурации
hms
```

### Очистка
```fish
# Очистка профиля пользователя
gcu
# Очистка системы
gcs
# Полная глубокая очистка
gc
```

### Управление флейком
```fish
# Показать структуру флейка
flks
# Проверить валидность
flkc
# Обновить зависимости
flku
```

### Редактирование
```fish
# Открыть конфигурацию хоста
conf
# Открыть список системных пакетов
pkgs
```

## Хосты

### `nixos-master`
Основная рабочая машина. Пользователь: **master** («Хозяин»).
- Groups: `networkmanager`, `wheel`, `input`, `libvirtd`
- Рабочий стол: Niri + Noctalia (Catppuccin, dark mode)
- Браузер: Яндекс.Браузер
- IDE: VS Code с расширенным набором плагинов

### `nixos-mama`
Вторичная машина. Пользователи: **master** («Админ») и **mama** («Маманя»).
- `master`: groups `networkmanager`, `wheel`, `input`, `libvirtd`
- `mama`: groups `networkmanager`
- Аналогичный стек: Niri, Noctalia, Zsh, Git

## Общие настройки системы

- **Часовой пояс:** `Europe/Moscow`
- **Локализация:** `ru_RU.UTF-8` (все категории)
- **Nix:** flakes + nix-command, автоочистка еженедельно, автооптимизация хранилища
- **Бинарный кэш:** `https://noctalia.cachix.org`
- **Звук:** PipeWire (с поддержкой PulseAudio и JACK)
- **Bluetooth:** вкл. при загрузке, blueman
- **Виртуализация:** Libvirt + Virt-Manager + Docker
- **Шрифты:** Noto Fonts + Noto Emoji + Font Awesome
- **Версия состояния:** `24.05`

## Пользовательское окружение (master)

### Shell: Zsh + oh-my-zsh
- Тема: `agnoster`
- Плагины: `git`, `sudo`
- Автодополнение и подсветка синтаксиса
- История: 10 000 записей

### VS Code плагины
- `davidanson.vscode-markdownlint`
- `jnoortheen.nix-ide`
- `ms-azuretools.vscode-docker`
- `ms-ceintl.vscode-language-pack-ru`
- `ms-python.python`
- `ms-vscode-remote.remote-ssh`
- `ms-ceintl.vscode-language-pack-ru` (русский язык)
- `redhat.vscode-yaml`
- `remote-ssh-edit` (из marketplace)
- `koda` (AI-ассистент)
- `sourcecraft-code-assist` (Yandex Cloud, VSIX)

## Известные ограничения и проблемы

### Критическая проблема: графический вход (исправлено)

**Симптом:** После установки и перезагрузки — только консольный shell, нет графического входа.

**Причина:** NixOS по умолчанию загружается в `multi-user.target` (консольный режим). Без явного указания `boot.target = "graphical.target"` systemd не запускает `greetd` — демон графического входа, необходимый для Noctalia Greeter.

**Исправление:** В `nixos/common.nix` добавлено:
```nix
boot.target = "graphical.target";  # Запускает greetd + графический вход
```

**Дополнительные исправления:**
- `services.polkit.enable = true;` — для работы GUI-уведомлений и разрешений
- `services.accounts-daemon.enable = true;` — для greetd (показывает имена пользователей)

### Ограничение NVIDIA GPU

Niri (Wayland-композитор) **не поддерживает NVIDIA GPU** с проприетарными драйверами. Если на машине NVIDIA:
- Используйте `nomodeset` и X11 (KDE/GNOME) вместо Niri
- Или отключите Niri/Noctalia и используйте другой DE
- AMD и Intel GPU — работают корректно

### Оптимизация zram

`memoryPercent` снижен с 100% до 50% — на старых CPU 100% RAM в сжатый swap вызывал высокий overhead процессора.

## Разработка

### Структура модулей
Каждый модуль — это NixOS-модуль (или Home Manager-модуль), который можно импортировать через `imports` в конфигурации хоста или пользователя.

### Добавление нового хоста
1. Создать директорию `nixos/hosts/<hostname>/`
2. Сгенерировать `hardware-configuration.nix` через `nixos-generate-config`
3. Создать `configuration.nix`, импортируя `../../common.nix` и `../../modules/bundle.nix`
4. Добавить нужный пользовательский модуль (например, `nixos-master-users.nix`)
5. Добавить хост в `flake.nix`

### Добавление системного пакета
Добавить пакет в список `environment.systemPackages` в файле `nixos/packages.nix`.

### Добавление пользовательского пакета / настройки
Создать модуль в `home-manager/modules/` и импортировать в соответствующий `home.nix`.
