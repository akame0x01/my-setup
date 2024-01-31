#!/bin/bash

# To do list
# 1. fixing pkgs list
# 2. install polybar and themes
# 3. Vmware things && drivers to xorg

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

echo ""
echo -e "${green}[*]${no_color} Sometimes you'll be ask to import keys or install some dependency packages, make sure to don't refuse them..."
read -n 1 -s -r -p "Press any key to continue..."

# Grub theme
if pkg_installed grub && [ -f /boot/grub/grub.cfg ]; then
	echo ""
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
			echo ""
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

echo ""
echo -e "${green}[*]${no_color} Doing a system update, cause stuff may break if it's not the latest version...${no_color}"
sudo pacman -Syyu
sudo pacman -Fy

# Xinitrc file
if [ ! -f /etc/X11/xinit/xinitrc ]; then
	sudo pacman -Syu xorg
fi

cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i '51,55d' ~/.xinitrc
sed -i '50a\exec i3' ~/.xinitrc

# Select Shell
while true; do
	if ! pkg_installed zsh && ! pkg_installed fish; then
		echo ""
		echo -e "${green}[*]${no_color} Select shell:\n1) zsh\n2) fish"
		echo ""
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

# Vmware things
if ! pkg_installed open-vm-tools; then
	while true; do
		echo ""
		echo -e "${green}[*]${no_color} Do you want additions for Vmware?(Only accept it if you are running arch on Vmware)"
		echo ""
		read -p "[*]  Install Vmware Tools and drivers : [Y/n] " gVM

		case $gVM in
		[yY])
			echo -e "gtkmm3\nopen-vm-tools\nxf86-video-vmware\nxf86-input-vmmouse\nmesa\n" >>pkg_list.lst
			sed -i '50a\vmware-user &' ~/.xinitrc
			break
			;;
		[nN])
			echo ""
			echo -e "${red}[*]${no_color}  Skipping Vmware drivers"
			break
			;;
		*) echo -e "${red}[*]${no_color} Invalid option selected. Please enter a valid option." ;;
		esac
	done
fi

# Pyenv
if ! pkg_installed pyenv && [ ! -d "$HOME/.pyenv" ]; then
	while true; do
		echo ""
		read -p "[*] Install Pyenv to manage python versions? [Y/N] : " pyenvchoice
		case $pyenvchoice in
		[Yy])
			export getPyenv="pyenv"
			echo "pyenv" >>pkg_list.lst
			break
			;;

		[Nn])
			echo ""
			echo -e "${red}[*]${no_color}  Skipping pyenv installation..."
			echo "python" >>pkg_list.lst
			break
			;;
		*)
			echo ""
			echo -e "${green}[*]${no_color} Invalid option selected. Please enter a valid option."
			;;
		esac
	done
fi

./install_pkg.sh pkg_list.lst

if [ -n $getPyenv ]; then
	echo ""
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
fi

git config --global init.defaultBranch main
git config --global user.name "moraeskkj"
git config --global user.email "mooraesz123@gmail.com"

# install polybar
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
cd polybar-themes
chmod +x setup.sh
./setup.sh

# Another directories will be created using git
echo ""
echo -e "${green}[*]$no_color Creating default directories..."
mkdir -p "$HOME"/.config
mkdir -p "$HOME"/pics/wallpapers
mkdir -p "$HOME"/Downloads
mkdir -p "$HOME"/projects
mkdir -p "$HOME"/mystuffs

git clone https://github.com/moraeskkj/dotfiles.git ~/dotfiles
git clone https://github.com/moraeskkj/all-ctfs ~/capture_the_flag
git clone https://github.com/moraeskkj/learning-c-assignments ~/learning-c-assignments

if [ -d "$HOME/.config/fish/" ]; then
	sudo rm -rf ~/.config/fish/
fi

# the code will overwrite it with my config
sudo rm -rf .config/polybar/

mv -f ~/dotfiles/* ~/.config/
mv ~/my-setup/shells ~/mystuffs/
mv ~/learning-c-assignments ~/projects

echo ""
echo -e "${green}[*]$no_color Setting $getShell as default shell..."
echo "/usr/bin/${getShell}" | sudo tee -a /etc/shells
sudo chsh -s /usr/bin/$getShell $USER

sudo systemctl enable paccache.timer
if [ -n $gVM ]; then
	sudo systemctl enable vmtoolsd.service
	sudo systemctl enable vmware-vmblock-fuse.service
fi

nvim

if [ -f "$HOME/pkgs.log" ]; then
	echo "${red}[*]${no_color}"
	cat ~/pkgs.log
fi

sudo rm -rf ~/go
sudo rm -rf ~/dotfiles
fc-cache -fv
$aurhlpr -Sc
echo ""
echo -e "${green}[*]$no_color Script execution complete. You may reboot now.${no_color}"
