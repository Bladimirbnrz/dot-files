#!/bin/bash

# Carpeta central donde guardas todo para el repo
SYNC_DIR="$HOME/dotfiles"

# Asegúrate de que exista
mkdir -p "$SYNC_DIR/wezterm" "$SYNC_DIR/nvim" "$SYNC_DIR/fish"

# Copiar archivos específicos
cp /mnt/c/Users/bladi/.wezterm.lua "$SYNC_DIR/wezterm/wezterm.lua"
cp -r ~/.config/nvim "$SYNC_DIR"
cp -r ~/.config/fish "$SYNC_DIR"

echo "Configs sincronizadas con $SYNC_DIR"
