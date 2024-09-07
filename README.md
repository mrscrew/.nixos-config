# ❄️ NixOS configuration with Home Manager for multiple systems

## Описание

Этот репозиторий содержит конфигурацию для установки и управления NixOS на нескольких системах с использованием flake. Конфигурация поддерживает как системные настройки, так и пользовательские, через интеграцию с **Home Manager**.

### Структура конфигурации

- **nixos-master**: Основная система NixOS.
- **nixos-mama**: Альтернативная система NixOS.
- **master**: Пользовательская конфигурация для пользователя `master` через Home Manager.
- **mama**: Пользовательская конфигурация для пользователя `mama` через Home Manager.

Конфигурация поддерживает работу с нестабильной версией nixpkgs для получения самых свежих пакетов, а также стабильную версию для критически важных систем.

## Установка системы

Для установки NixOS и применения конфигурации:

```bash
cd
git clone https://github.com/mrscrew/.nixos-config.git
cd $HOME/.nixos-config
sudo nixos-install --root /mnt --flake .#nixos-master
```

### Применение системных настроек

После установки системы, для применения обновлённой конфигурации:

```bash
sudo nixos-rebuild switch --flake .#nixos-master
```

### Применение настроек пользователя

Чтобы применить пользовательские настройки через Home Manager для пользователя `master`:

```bash
home-manager switch --flake .#master
```

Для пользователя `mama`:

```bash
home-manager switch --flake .#mama
```

## Очистка системы

Для очистки ненужных файлов, пакетов и сборок:

```bash
nix-collect-garbage -d
```

Эта команда удалит все ненужные пакеты и сборки, которые больше не используются в системе.

---

## Основные команды

- **Установка системы**: Устанавливает NixOS с конфигурацией из флейка.
  ```bash
  sudo nixos-install --root /mnt --flake .#nixos-master
  ```

- **Применение системных настроек**: Обновляет и применяет системные настройки NixOS.
  ```bash
  sudo nixos-rebuild switch --flake .#nixos-master
  ```

- **Применение настроек пользователя**: Применяет пользовательские настройки через Home Manager.
  ```bash
  home-manager switch --flake .#master
  ```

- **Очистка системы**: Удаляет ненужные пакеты и сборки.
  ```bash
  nix-collect-garbage -d
  ```

---

## Скриншот

![Screenshot](./background.png)

---
