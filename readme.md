# Dotfiles

This is my personal dotfiles setup.

I use dotbot to manage: https://github.com/anishathalye/dotbot

```bash
git clone https://github.com/richardhallett/dotfiles ~/.dotfiles && cd ~/.dotfiles && ./install
```

## Optional
```bash
# Download and setup links for core binaries
./install -vv -c install-core-binaries-linux.conf.yaml
```

```bash
# link patched symbol fonts
./install -c install-fonts.conf.yaml
```

# Packages to install

These are typically what I have setup, depending on linux package manamgent to be install manually.

- fish - Shell
- starship - Shell prompt
- emoji font e.g. noto-fonts-emoji (depending on linux distro may not be required)
- nvim - Editor
-
