#!/bin/bash
#|---/ /+----------------------------------------+---/ /|#
#|--/ /-| Script to install pkgs from input list |--/ /-|#
#|/ /---+----------------------------------------+/ /---|#

source global_fn.sh

if [ $? -ne 0 ]; then
	echo -e "${green}[!!]${no_color}  Error: unable to source global_fn.sh, must be in the same directory..."
	exit 1
fi

if ! pkg_installed git; then
	echo "installing dependency git..."
	sudo pacman -S git
fi

chk_aurh

if [ -z $aurhlpr ]; then
	echo -e "${green}[*]${no_color} Select aur helper:\n1) yay\n2) paru"
	echo ""
	read -p "[*] Enter option number : " aurinp

	case $aurinp in
	1) aurhlpr="yay" ;;
	2) aurhlpr="paru" ;;
	*) echo -e "${green}[*]${no_color}  Invalid option selected... yay will be used" ;;
	esac

	echo -e "${green}[*]${no_color} installing dependency $aurhlpr..."
	echo ""
	./install_aur.sh $aurhlpr
fi

install_list="${1:-pkg_list.lst}"

# initialize the package variable
pkg_arch=''
pkg_aur=''

echo ""
spin_animation 60 "${cyan}[*]${no_color} Loading packages from $install_list" &
pid=$!

while IFS= read -r line; do
	if pkg_available "$line"; then
		pkg_arch+=" $line"

	elif aur_available "$line"; then
		pkg_aur+=" $line"

	elif aur_available "$line"; then
		pkg_aur+=" $line"
	else
		touch ~/pkgs.log
		echo "[!!] package $line couldn't be founded in any available repo, please remember to install it later"
	fi
done <$install_list
kill $pid

echo -e "${green}[*]${no_color} installing packages from $install_list..."
echo ""

if [ $(echo $pkg_arch | wc -w) -gt 0 ]; then
	echo ""
	sudo pacman --needed --noconfirm -S $pkg_arch
fi

if [ $(echo $pkg_aur | wc -w) -gt 0 ]; then
	echo ""

	for pkg in $pkg_aur; do
		if [ "$pkg" == "spotify" ]; then
			curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | gpg --import -
		fi
	done

	$aurhlpr --needed --noconfirm -S $pkg_aur
fi

$aurhlpr -Sc
echo ""
