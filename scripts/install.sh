#!/bin/bash

# To do list
#
# 0.  fix the pkg.list.
# 1.  Create a function to install LazyVim instead of neovim.
#     1.1  Remove some plugins i guess
# 2.  Set your scripts to run with i3.
# 3.  customize your dotfiles
#       some repos to source here:
#       https://gitlab.com/user-asif/dotfiles
#       https://github.com/dxmxnlord/Arch-Resources/
#       https://github.com/salteax/dotfiles/
#       https://github.com/3rfaan/dotfiles

source global_fn.s
if [ $? -ne 0]; then
	echo -e "${red}[!!]${no_color} Error: Unable to access global_fn.sh, must be in the same directory"
	exit 1
fi

# Grub theme
if pkg_installed grub && [ -f /boot/grub/grub.cfg ]; then
	echo -e "${green}[*]  BOOTLOADER${no_color}: Grub detected..."

	echo ""
	while true; do
		read -p "${green}[*]${no_color}  Apply grub theme: [Y/N] : " grubtheme
		case $grubtheme in
		[Yy])
			echo -e "${green}[*]${no_color}  Changing grub theme..."
			sudo tar -xzf ${CloneDir}/grub_theme/Hanya.tar.gz
			sudo cp -r ${CloneDir}/grub_theme/Hanya /usr/share/grub/themes
			sudo sed -i '$a\GRUB_THEME="/usr/share/grub/themes/Hanya/theme.txt"' /etc/default/grub
			break
			;;

		[Nn])
			echo -e "${red}[*]${no_color}  Skipping Grub Theme..."
			break
			;;
		*)
			echo -e "${green}[*]${no_color} Invalid option selected. Please enter a valid option."
			;;
		esac
	done

	sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

# Pacman config
sudo sed -i "/^#Color/c\Color\nILoveCandy
    /^#VerbosePkgLists/c\VerbosePkgLists
    /^#ParallelDownloads/c\ParallelDownloads = 5" /etc/pacman.conf

# Xinitrc file
cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i '51,55d' ~/.xinitrc
sed -i '50a\exec i3' ~/.xinitrc

echo -e "${green}[*]${no_color} Doing a system update, cause stuff may break if it's not the latest version...${no_color}"
sudo pacman -Syyu
sudo pacman -Fy

# i3 config
#cd ~/.config && mkdir i3
#cd i3 && curl https://raw.githubusercontent.com/sainathadapa/i3-wm-config/master/i3-default-config-backup -o config
#sed -i '30s/.*/bindsym $mod+Return exec alacritty/' ~/.config/i3/config
#sudo pacman -S --noconfirm --needed base-devel wget git curl dialog fish

# Select Shell
while true; do
	if ! pkg_installed zsh && ! pkg_installed fish; then
		echo -e "${green}[*]${no_color} Select shell:\n1) zsh\n2) fish"
		read -p "${green}[*]${no_color} Enter option number : " gsh

		case $gsh in
		1) export getShell="zsh" ;;
		2) export getShell="fish" ;;
		*) echo -e "${green}[*]${no_color} Invalid option selected. Please enter a valid option." ;;
		esac

		if [[ -n "$getShell" ]]; then
			echo "${getShell}" >>pkg_list.lst
			break
		fi
	else
		break
	fi
done

./install_pkg.sh pkg_list.lst

### WORKING HERE YET !!!

install_pkgs() {
	echo -e "${green}[*] Installing packages with pacman.${no_color}"
	sudo pacman -S --needed --noconfirm ttf-jetbrains-mono-nerd ttf-jetbrains-mono firefox feh xorg-xrandr unzip p7zip net-tools neovim neofetch nasm gcc nemo pacman-contrib openssl zlib xz tk man-db man-pages pkgconf xclip acpi alsa-utils xorg xorg-xinit alacritty btop i3 nemo polybar ranger rofi scrot
}

install_python_with_pyenv() {
	echo -e "${green}[*]  Installing python $py_version with pyenv.${no_color}"

	"$aurhelper" && "$aurhelper" -S ncurses5-compat-libs && "$aurhelper" -S pyenv

	# post-installation steps
	fish -c "
        set -Ux PYENV_ROOT $HOME/.pyenv 
        fish_add_path $PYENV_ROOT/bin
    "
	echo "pyenv init - | source" | tee -a ~/.config/fish/config.fish

	fish -c "pyenv install ${py_version}"
	fish -c "pyenv global ${py_version}"

	currentpython=$(which python)

	if [ "$currentpython" == "~/.pyenv/shims/python" ]; then
		echo ""
		echo -e "${green}[*]  Everything's with pyenv, installing pip now.${no_color}"
		fish -c "pip3 install --upgrade pip"
	else
		echo ""
		echo -e "${red}[!!] Error: python wasn't installed.${no_color}"
	fi
}

# Another directories will be created using git
create_default_directories() {
	echo -e "${green}[*] Creating default directories.${no_color}"
	mkdir -p "$HOME"/.config
	mkdir -p "$HOME"/pics/wallpapers
	mkdir -p "$HOME"/downloads
	mkdir -p "$HOME"/projects
}

copy_configs() {
	echo -e "${green}[*] Copying configs to $config_directory.${no_color}"
	cd ~
	git clone https://github.com/moraeskkj/dotfiles.git
	cd dotfiles
	sudo rm -rf arch-ricing.png qtile/ picom/
	mv -f ~/dotfiles/* $config_directory && mv ~/dotfiles/fish/* ~/.config/fish
	sudo systemctl enable paccache.timer
}

git_config() {
	echo -e "${green}[*]  Pushing your directories and doing simple git config.${no_color}"
	git config --global init.defaultBranch main
	git config --global user.name "moraeskkj"
	git config --global user.email "mooraesz123@gmail.com"

	cd ~
	git clone https://github.com/moraeskkj/all-ctfs my-ctfs
	git clone https://github.com/moraeskkj/learning-c-assignments

	mv ~/learning-c-assignments ~/projects
}

finishing() {
	echo -e "${green}[*] Setting fish as default shell.${no_color}"
	echo "/usr/bin/fish" | sudo tee -a /etc/shells
	sudo chsh -s /usr/bin/fish $USER
	"$aurhelper -Sc"
	fc-cache -fv
	source ~/.config/scripts/resizeResolution.sh
}

select_aur_helper() {
	cmd=(dialog --clear --title "Aur helper" --menu "Firstly, select the aur helper you want to install (or have already installed)." 10 50 16)
	options=(1 "yay" 2 "paru")
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

	case $choices in
	1) aurhelper="yay" ;;
	2) aurhelper="paru" ;;
	*) echo -e "${red}[!!] Invalid choice.${no_color}" ;;
	esac

}

select_text_editor() {
	cmd=(dialog --clear --title "Text Editor" --menu "Select the text editor you want to install." 10 50 16)
	options=(1 "sublime text" 2 "vscode" 3 "Boths")
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

	case $choices in
	1) install_sublime_text ;;
	2) install_vscode ;;
	3) {
		install_sublime_text
		install_vscode
	} ;;
	*) echo -e "${red}[!!] Invalid choice.${no_color}" ;;
	esac
}

select_python() {
	cmd=(dialog --clear --title "Python Version" --menu "Select Python version:" 10 50 16)
	options=(1 "Python 3" 2 "Python 3 + Python 2")
	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

	case $choices in
	1) py_version="3.12.0" ;;
	2) py_version="3.12.0 2.7.18" ;;
	*) echo -e "${red}[!!] Invalid choice.${no_color}" ;;
	esac

	# Prompt user for pyenv usage
	cmd=(dialog --clear --title "Pyenv Usage" --yesno "Do you want to use pyenv for managing Python versions?" 7 50)
	"${cmd[@]}" 2>&1 >/dev/tty

	case $? in
	0) install_python_with_pyenv ;;
	1) install_python ;;
	*) echo -e "${red}[!!] Invalid choice.${no_color}" ;;
	esac
}

# install_vsc(){
#    echo -e "${green}[*] Installing vsc extensions.${no_color}"
#    code --install-extension zhuangtongfa.Material-theme
#    echo -e "${green}[*] Copying vsc configs.${no_color}"
#    cp ./vsc/settings.json "$HOME"/.config/Code\ -\ OSS/User
# }

# Run the functions
system_checkings
system_update
system_config
create_default_directories
select_aur_helper
install_aur_helper
select_python
select_text_editor
copy_configs
git_config
install_pkgs
finishing

echo -e "${green}[*] Script execution complete. You may reboot now.${no_color}"
