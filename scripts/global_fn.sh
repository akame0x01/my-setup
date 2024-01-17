#!/bin/bash
#|---/ /+------------------+---/ /|#
#|--/ /-| Global functions |--/ /-|#
#|---/ /+------------------+---/ /|#

set -e

cfg_dir="$HOME/.config"
fonts_dir="/usr/share/fonts"
green='\033[0;32m'
no_color='\033[0m'

CloneDir=$(dirname "$(dirname "$(realpath "$0")")")

chk_basic() {
	if [ "$EUID" -eq 0 ]; then
		echo -e "${red}[!!] DO NOT be root!.${no_color}"
		exit 1
	fi

	ping -c 1 -q google.com >&/dev/null

	if [ $? != 0 ]; then
		echo -e "${red}[!!]  Must have internet connection!${no_color}"
		exit 1
	fi
}

pkg_installed() {
	local PkgIn=$1

	if pacman -Qi $PkgIn &>/dev/null; then
		#{$PkgIn} is already installed...
		return 0
	else
		#{$PkgIn} is not installed...
		return 1
	fi
}

pkg_available() {
	local PkgIn=$1

	if pacman -Si $PkgIn &>/dev/null; then
		#{$PkgIn} available in arch repo...
		return 0
	else
		#{$PkgIn} not available in arch repo...
		return 1
	fi
}

chk_aurh() {
	if pkg_installed yay; then
		aurhlpr="yay"
	elif pkg_installed paru; then
		aurhlpr="paru"
	fi
}

aur_available() {
	local $PkgIn=$1
	chk_aurh

	if $aurhlpr -Si $PkgIn &>/dev/null; then
		# {$PkgIn} available in aur repo...
		return 0
	else
		# {$PkgIn} not available in aur repo...
		return 1
	fi
}
