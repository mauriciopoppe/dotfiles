#!/usr/bin/env bash

# Declare a base path for both virtual environments
venv="$HOME/.cache/vim/venv"

# Try to detect virtualenv's executable names
vrenv=virtualenv

# Ensure python 2/3 virtual environments
[ -d "$venv" ] || mkdir -p "$venv"
[ -d "$venv/neovim" ] || $vrenv "$venv/neovim"

# Install or upgrade dependencies
"$venv/neovim/bin/pip" install -U neovim PyYAML
