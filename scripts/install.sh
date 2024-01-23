#!/bin/bash

# To do list
# 1. use your system a little to customize your new polybar and i3 configs, after all, you need to set them here
# 2.

source global_fn.sh
if [ $? -ne 0 ]; then
	echo -e "${red}[!!]${no_color} Error: Unable to access global_fn.sh, must be in the same directory"
	exit 1
fi

echo -e "${cyan}[*]${no_color}  Wait just an second"
echo ""
chk_basic

cat <<"EOF"
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣶⣶⣶⣶⣶⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢿⣿⣿⡿⣿⣿⣿⣿⣿⣿⣿⣿⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⡇⣿⣷⣿⣿⣿⣿⣿⣿⣯⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⣿⣿⣿⣇⣿⣀⠸⡟⢹⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢡⣿⣿⣿⡇⠝⠋⠀⠀⠀⢿⢿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⢸⠸⣿⣿⣇⠀⠀⠀⠀⠀⠀⠊⣽⣿⣿⣿⠁⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣷⣄⠀⠀⠀⢠⣴⣿⣿⣿⠋⣠⡏⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠾⣿⣟⡻⠉⠀⠀⠀⠈⢿⠋⣿⡿⠚⠋⠁⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣶⣾⣿⣿⡄⠀⣳⡶⡦⡀⣿⣿⣷⣶⣤⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⡆⠀⡇⡿⠉⣺⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣯⠽⢲⠇⠣⠐⠚⢻⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⡐⣾⡏⣷⠀⠀⣼⣷⡧⣿⣿⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣻⣿⣿⣿⣿⣿⣮⠳⣿⣇⢈⣿⠟⣬⣿⣿⣿⣿⣿⡦⢄⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢄⣾⣿⣿⣿⣿⣿⣿⣿⣷⣜⢿⣼⢏⣾⣿⣿⣿⢻⣿⣝⣿⣦⡑⢄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣠⣶⣷⣿⣿⠃⠘⣿⣿⣿⣿⣿⣿⣿⡷⣥⣿⣿⣿⣿⣿⠀⠹⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣇⣤⣾⣿⣿⡿⠻⡏⠀⠀⠸⣿⣿⣿⣿⣿⣿⣮⣾⣿⣿⣿⣿⡇⠀⠀⠙⣿⣿⡿⡇⠀⠀⠀⠀⠀
⠀⠀⢀⡴⣫⣿⣿⣿⠋⠀⠀⡇⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⢘⣿⣿⣟⢦⡸⠀⠀⠀
⠀⡰⠋⣴⣿⣟⣿⠃⠀⠀⠀⠈⠀⠀⣸⣿⣿⣿⣿⣿⣿⣇⣽⣿⣿⣿⣿⣇⠀⠀⠀⠁⠸⣿⢻⣦⠉⢆⠀⠀
⢠⠇⡔⣿⠏⠏⠙⠆⠀⠀⠀⠀⢀⣜⣛⡻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⡀⠀⠀⠀⠀⡇⡇⠹⣷⡈⡄⠀
⠀⡸⣴⡏⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⡇⡇⠀⢻⡿⡇⠀
⠀⣿⣿⣆⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⣰⠿⠤⠒⡛⢹⣿⠄
⠀⣿⣷⡆⠁⠀⠀⠀⠀⢠⣿⣿⠟⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠻⢷⡀⠀⠀⠀⠀⠀⣸⣿⠀
⠀⠈⠿⢿⣄⠀⠀⠀⢞⠌⡹⠁⠀⠀⢻⡇⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⢳⠀⠀⠁⠀⠀⠀⠀⢠⣿⡏⠀
⠀⠀⠀⠈⠂⠀⠀⠀⠈⣿⠁⠀⠀⠀⡇⠁⠀⠘⢿⣿⣿⠿⠟⠋⠛⠛⠛⠀⢸⠀⠀⡀⠂⠀⠀⠐⠛⠉⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠕⣠⡄⣰⡇⠀⠀⠀⢸⣧⠀⠀⠀⠀⠀⠀⠀⢀⣸⠠⡪⠊⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢫⣽⡋⠭⠶⠮⢽⣿⣆⠀⠀⠀⠀⢠⣿⣓⣽⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⢹⣶⣦⣾⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
EOF
echo -e "${green}[*]${no_color} Sometimes you'll be ask to import keys or install some dependency packages, make sure to don't refuse them..."
echo ""
read -n 1 -s -r -p "Press any key to continue..."

# Grub theme
if pkg_installed grub && [ -f /boot/grub/grub.cfg ]; then
	echo -e "${green}[*]${no_color} Grub detected..."

	echo ""
	while true; do
		read -p "[*]  Apply grub theme: [Y/N] : " grubtheme
		case $grubtheme in
		[Yy])
			echo ""
			echo -e "${green}[*]${no_color}  Changing grub theme..."
			sudo tar -xzf ${CloneDir}/grub_theme/Hanya.tar.gz
			sudo mv Hanya ${CloneDir}/grub_theme/
			sudo cp -r ${CloneDir}/grub_theme/Hanya /usr/share/grub/themes
			sudo sed -i '$a\GRUB_THEME="/usr/share/grub/themes/Hanya/theme.txt"' /etc/default/grub
			break
			;;

		[Nn])
			echo ""
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
if ! pkg_installed curl; then
	sudo pacman -S curl
fi

mkdir -p "$HOME"/.config/i3
curl -s https://raw.githubusercontent.com/sainathadapa/i3-wm-config/master/i3-default-config-backup -o "$HOME"/.config/i3/config
sed -i '30s/.*/bindsym $mod+Return exec alacritty/' ~/.config/i3/config

# Select Shell
while true; do
	if ! pkg_installed zsh && ! pkg_installed fish; then
		echo -e "${green}[*]${no_color} Select shell:\n1) zsh\n2) fish"
		read -p "[*] Enter option number : " gsh

		case $gsh in
		1) export getShell="zsh" ;;
		2) export getShell="fish" ;;
		*) echo -e "${red}[*]${no_color} Invalid option selected. Please enter a valid option." ;;
		esac

		if [[ -n "$getShell" ]]; then
			echo "${getShell}" >>pkg_list.lst
			break
		fi
	else
		break
	fi
done

# Select text editor
while true; do
	if ! pkg_installed code && ! pkg_installed sublime-text-4; then
		echo -e "${green}[*]${no_color} Select TextEditor:\n1) vscode\n2) sublime"
		read -p "[*]  Enter option number : " gte

		case $gte in
		1) export getTextEd="code" ;;
		2) export getTextEd="sublime-text-4" ;;
		*) echo -e "${red}[*]${no_color} Invalid option selected. Please enter a valid option." ;;
		esac

		if [[ -n "$getTextEd" ]]; then
			echo "${getTextEd}" >>pkg_list.lst
			break
		fi
	else
		break
	fi
done

./install_pkg.sh pkg_list.lst

echo -e "${green}[*]$no_color  Installing python 3.12.0 with pyenv..."

if [ "$getShell" == "fish" ]; then
	# post-installation steps
	fish -c "
    set -Ux PYENV_ROOT $HOME/.pyenv 
    fish_add_path $PYENV_ROOT/bin
    "
	echo "pyenv init - | source" | tee -a ~/.config/fish/config.fish

	fish -c "pyenv install 3.12.0"

	if [ $? -eq 0 ]; then
		fish -c "pyenv global 3.12.0"
		echo -e "${green}[*]$no_color  Pyenv and python installed, updating pip now...."
		fish -c "pip3 install --upgrade pip"
	else
		echo -e "${red}[!!]$no_color Error: python wasn't installed..."
		exit 1
	fi

else
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >>~/.zshrc
	echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >>~/.zshrc
	echo 'eval "$(pyenv init -)"' >>~/.zshrc

	zsh -c "pyenv install 3.12.0"
	if [ $? -eq 0 ]; then
		zsh -c "pyenv global 3.12.0"
		echo -e "${green}[*]$no_color  Pyenv and python installed, updating pip now...."
		zsh -c "pip3 install --upgrade pip"
	else
		echo -e "${red}[!!]$no_color Error: python wasn't installed..."
		exit 1
	fi
fi

# Another directories will be created using git
echo -e "${green}[*]$no_color Creating default directories..."
echo ""
mkdir -p "$HOME"/.config
mkdir -p "$HOME"/pics/wallpapers
mkdir -p "$HOME"/downloads
mkdir -p "$HOME"/projects

echo -e "${green}[*]$no_color Copying configs to $config_directory..."
echo ""
git clone https://github.com/moraeskkj/dotfiles.git ~/dotfiles
sudo rm -rf ~/dotfiles/arch-ricing.png ~/dotfiles/qtile/ ~/dotfiles/picom/ ~/dotfiles/nvim/

if [ -f "$HOME/.config/fish/config.fish" ]; then
	sudo rm -rf ~/.config/fish/config.fish
fi
mv -f ~/dotfiles/* ~/.config/

echo -e "${green}[*]${no_color}  Pushing your directories and doing simple git config..."
echo ""
git config --global init.defaultBranch main
git config --global user.name "moraeskkj"
git config --global user.email "mooraesz123@gmail.com"

git clone https://github.com/moraeskkj/all-ctfs ~/my-ctfs
git clone https://github.com/moraeskkj/learning-c-assignments ~/learning-c-assignments
mv ~/learning-c-assignments ~/projects

echo -e "${green}[*]$no_color Setting $getShell as default shell..."
echo ""

echo "/usr/bin/${getShell}" | sudo tee -a /etc/shells
sudo chsh -s /usr/bin/$getShell $USER

fc-cache -fv
sudo systemctl enable paccache.timer

# source ~/.config/scripts/resizeResolution.sh

echo -e "${green}[*]$no_color Installing vsc extensions..."
echo ""
code --install-extension zhuangtongfa.Material-theme
cp ./vsc/settings.json "$HOME"/.config/Code\ -\ OSS/User

if [ -f "$HOME/pkgs.log" ]; then
	echo "${red}[*]${no_color}"
	cat ~/pkgs.log
fi

echo -e "${green}[*]$no_color Script execution complete. You may reboot now.${no_color}"
echo ""