#!/bin/bash

# 1. add fonts in install_pkgs and configure it in terminal
# 2. create select_terminal, select_WM, select_shell
#
config_directory="$HOME/.config"
fonts_directory="/usr/share/fonts"

green='\033[0;32m'
no_color='\033[0m'
date=$(date +%s)

# Checkings
system_checkings() {
    if [[ "$EUID" -eq 0 ]]; then
        echo "${red}[*]  DO NOT be root!.${no_color}"
        exit 1
    fi

    ping -c 1 -q google.com >&/dev/null

    if [[ $? != 0 ]]; then
        echo "${red}[*]  Must have internet connection!${no_color}"
        exit 1
    fi
}

system_update() {
   echo -e "${green}[*] Doing a system update, cause stuff may break if it's not the latest version...${no_color}"
    sudo pacman -Sy --noconfirm archlinux-keyring
    sudo pacman --noconfirm -Syu
    sudo pacman -S --noconfirm --needed base-devel wget git curl dialog fish
}

system_config() {
    # Pacman config  
    sudo sed -i '33s/.*/Color/' /etc/pacman.conf
    sudo sed -i '37a\ILoveCandy' /etc/pacman.conf 
    sudo sed -i '37s/.*/ParallelDownloads = 5/' /etc/pacman.conf
    
    # Xinitrc file
    cp /etc/X11/xinit/xinitrc ~/.xinitrc
    sed -i '51,55d' ~/.xinitrc
    sed -i '50a\exec i3' ~/.xinitrc
    
    # i3 config
    cd ~/.config && mkdir i3
        
    cd i3 && curl https://raw.githubusercontent.com/sainathadapa/i3-wm-config/master/i3-default-config-backup -o config
        
    sed -i '30s/.*/bindsym $mod+Return exec alacritty/' ~/.config/i3/config
}

install_aur_helper(){ 
    if ! command -v "$aurhelper" &> /dev/null; then
        echo -e "${green}[*] It seems that you don't have $aurhelper installed, I'll install that for you before continuing.${no_color}"
        
        git clone https://aur.archlinux.org/"$aurhelper".git $HOME/.sources/"$aurhelper"
        (cd $HOME/.sources/"$aurhelper"/ && makepkg -si)
    else
        echo -e "${green}[*] It seems that you already have $aurhelper installed, skipping.${no_color}"
    fi
}

install_pkgs(){
    echo -e "${green}[*] Installing packages with pacman.${no_color}"
    sudo pacman -S --needed --noconfirm firefox feh xorg-xrandr unzip p7zip net-tools neovim neofetch nasm gcc nemo pacman-contrib openssl zlib xz tk man-db man-pages pkgconf xclip acpi alsa-utils xorg xorg-xinit alacritty btop i3 nemo polybar ranger rofi scrot 
}

install_sublime_text() {
    if command -v "$aurhelper" &> /dev/null; then
        echo -e "${green} [*] Installing Sublime Text 4.${no_color}"
        "$aurhelper" && "$aurhelper" -S --noconfirm --needed sublime-text-4
    fi

    # add the installation of plugins
}

install_obisidian() {
    echo -e "${green}[*] Installing Obsidian. ${no_color}"
    yay -S obsidian
}


install_vscode() {
    echo -e "${green}[*]  Installing vscode.${no_color}"
    paru -S visual-studio-code-bin   
}

install_python() {
    echo -e "${green}[*]  Installing python without pyenv.${no_color}"
    sudo pacman -Sy --noconfirm python
}

install_python_with_pyenv() {
    echo -e "${green}[*]  Installing python $py_version with pyenv.${no_color}"
    
    yay && yay -S ncurses5-compat-libs && yay -S pyenv

    # post-installation steps
    fish -c "
        set -Ux PYENV_ROOT $HOME/.pyenv 
        fish_add_path $PYENV_ROOT/bin
    "
    echo "pyenv init - | source" | tee -a ~/.config/fish/config.fish

    fish -c "pyenv update"
    fish -c "pyenv install ${py_version}"
    fish -c "pyenv global ${py_version}"

    currentpython=$(which python)

    if [ "$currentpython" == "~/.pyenv/shims/python" ]; then
        echo ""
        echo -e "${green}[*]  Everything's with pyenv, installing pip now.${no_color}"
        pip3 install --upgrade pip
    else
        echo ""
        echo "${red}[!!] Error: python wasn't installed.${no_color}"
    fi
}

# Another directories will be created using git 
create_default_directories(){
    echo -e "${green}[*] Creating default directories.${no_color}"
    mkdir -p "$HOME"/.config
    mkdir -p "$HOME"/pics/wallpapers
    mkdir -p "$HOME"/downloads
    mkdir -p "$HOME"/projects
}   

copy_configs(){
    echo -e "${green}[*] Copying configs to $config_directory.${no_color}"
    cd ~
    git clone https://github.com/moraeskkj/dotfiles.git
    cd dotfiles
    sudo rm -rf arch-ricing.png qtile/ picom/
    mv -f ~/dotfiles/* $config_directory
    sudo systemctl enable paccache.timer
}

git_config() {
    echo -e "${green}[*]  Pushing your directories and doing simple git config.${no_color}"
    git config --global init.defaultBranch main
    git config --global user.name "moraeskkj"
    git config --global user.email "mooraesz123@gmail.com"

    git clone https://github.com/moraeskkj/all-ctfs my-ctfs
    git clone https://github.com/moraeskkj/learning-c-assignments 

    mv ~/learning-c-assignments ~/projects
}

finishing(){
    echo -e "${green}[*] Setting fish as default shell.${no_color}"
    echo "/usr/bin/fish" | sudo tee -a /etc/shells
    sudo chsh -s /usr/bin/fish
}

select_aurhelper() {
    cmd=(dialog --clear --title "Aur helper" --menu "Firstly, select the aur helper you want to install (or have already installed)." 10 50 16)
    options=(1 "yay" 2 "paru")
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    case $choices in
        1) aurhelper="yay";;
        2) aurhelper="paru";;
         *) echo -e "${red}[!!] Invalid choice.${no_color}";;
    esac

}

select_texteditor(){
    cmd=(dialog --clear --title "Text Editor" --menu "Select the text editor you want to install." 10 50 16)
    options=(1 "sublime text" 2 "vscode" 3 "Boths" )
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    case $choices in
        1) install_sublime_text;;
        2) install_vscode;;
        3) { install_sublime_text; install_vscode; };;
        *) echo -e "${red}[!!] Invalid choice.${no_color}";;
    esac
}

select_python(){
    cmd=(dialog --clear --title "Python Version" --menu "Select Python version:" 10 50 16)
    options=(1 "Python 3" 2 "Python 3 + Python 2")
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    case $choices in
        1) py_version="3.12.0";;
        2) py_version="3.12.0 2.7.18"
        *) echo -e "${red}[!!] Invalid choice.${no_color}";;
    esac

    # Prompt user for pyenv usage
    cmd=(dialog --clear --title "Pyenv Usage" --yesno "Do you want to use pyenv for managing Python versions?" 7 50)
    "${cmd[@]}" 2>&1 >/dev/tty

    case $? in
        0) install_python_with_pyenv;;
        1) install_python;;
        *) echo -e "${red}[!!] Invalid choice.${no_color}";;
    esac
}

# Run the functions
system_checkings
system_update
system_config
create_default_directories
select_aurhelper
install_aurhelper
select_python
select_texteditor
copy_configs
git_config
install_pkgs
finishing

echo -e "${green}[*] Script execution complete.${no_color}"
