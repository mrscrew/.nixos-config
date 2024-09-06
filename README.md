# ❄️ My NixOS Config

```bash
git clone https://github.com/mrscrew/NixOS/nix-config-gnome nix-config
mv nixos-config $HOME/nix # Config is supposed to be in the ~/nix directory
cd $HOME/nix
sudo nixos-install --root /mnt --flake '.#nixos'
sudo nixos-rebuild switch --flake .#nixos-master
home-manager switch --flake .#master
```

Enjoy!

![Screenshot](./background.png)
