#!/bin/sh
ln -s ~/.dotfiles/configuration.nix /etc/nixos/configuration.nix
ln -s ~/.dotfiles/home.nix ~/.config/nixpkgs/home.nix
ln -s ~/.dotfiles/config.nix ~/.config/nixpkgs/config.nix
cp home.nix ~/.config/nixpkgs/home.nix
cp config.nix ~/.config/nixpkgs/config.nix
cp configuration.nix /etc/nixos/configuration.nix
