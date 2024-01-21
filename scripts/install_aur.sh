#!/bin/bash
#|---/ /+-----------------------------------+---/ /|#
#|--/ /-| Script to install aur helper, yay |--/ /-|#
#|-/ /--| Prasanth Rangan                   |-/ /--|#
#|/ /---+-----------------------------------+/ /---|#

source global_fn.sh

if [ $? -ne 0 ]; then
	echo -e "${red}[!!]${no_color} Error: Unable to access global_fn.sh, must be in the same directory..."
	exit 1
fi

aurhlpr="${1:-yay}"

if pkg_installed yay || pkg_installed paru; then
	echo -e "${green}[*]${no_color}  Aur helper is already installed..."
	exit 0
fi

if [ -d "$HOME/.sources" ]; then
	rm -rf ~/.sources/$aurhlpr
else
	mkdir -p ~/.sources/
fi

if pkg_installed git; then
	git clone https://aur.archlinux.org/$aurhlpr.git ~/.sources/$aurhlpr
else
	echo "git dependency is not installed..."
	exit 1
fi

cd ~/.sources/$aurhlpr
makepkg ${use_default} -si

if [ $? -eq 0 ]; then
	echo -e "${green}[*]${no_color}  $aurhlpr was installed..."
	cd ${CloneDir}/scripts
else
	echo -e "${red}[!!]${no_color}   Error: $aurhlpr installation failed..."
	exit 1
fi
