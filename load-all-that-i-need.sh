#!/bin/bash

# Get the original (non-root) username
original_user=$SUDO_USER

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Set environment variables for the desired user
export USER=$original_user
export HOME="/home/$original_user/"

# Function to display colorful banners
banner()
{
  echo -e "+------------------------------------------+"
  printf "| %-40s |\n" "$(date)"
  echo -e "|                                          |"
  printf "| \e[1m%-40s\e[0m |\n" "$@"
  echo -e "+------------------------------------------+"
}

# Display banner for updating and upgrading packages
banner "Updating and upgrading your packages"
sudo pacman -Syyu

#check if pyenv is already installed, checking if pyenvroot is not a empty string
if [ -z "$PYENV_ROOT" ]; then
    if [ -z "$HOME" ]; then
        echo -e "${RED}There is some erros with your variables $PYENV_ROOT and $HOME.${NC}"
        exit 1
    fi
    export PYENV_ROOT="${HOME}/.pyenv"
fi

if [ -d "${PYENV_ROOT}" ]; then
    echo -e "${GREEN} You already have pyenv, skipping the installation.${NC}"
else
    banner "Installing pyenv, python, and pip3"

    curl https://pyenv.run | bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
    
    source ~/.bash_profile
    pyenv install 3.12.0
    pyenv global 3.12.0
    source ~/.bash_profile

    currentpython=$(which python)
    if [ "$currentpython" == "${HOME}/.pyenv/shims/python" ]; then
        echo -e "${GREEN}Python was installed correctly.${NC}"
        pip3 install --upgrade pip
    else
        echo -e "${RED}Installation of Pyenv failed, please check it later.${NC}"
    fi
fi

# Display banner for installing i3, alacritty, and fish
banner "${YELLOW}Installing i3, alacritty, and fish.${NC}"
sudo pacman -S --noconfirm i3
sudo pacman -S --noconfirm alacritty 
sudo pacman -S --noconfirm fish
sudo pacman -S --noconfirm feh
fish 
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# Set environment variables for the desired user again (in case they changed)
export USER=$original_user
export HOME="/home/$original_user"
 

banner "${YELLOW}cloning dot files and copying my tools.${NC}"

mkdir -p $HOME/scripts
mkdir -p $HOME/tools 

# Clone dotfiles and copy scripts
cd $HOME/.config
sudo rm -rf $HOME/.config/fish
git clone https://github.com/moraeskkj/dotfiles.git
cp $HOME/.config/dotfiles/scripts/* $HOME/scripts
rm -rf $HOME/.config/dotfiles/arch-ricing.png $HOME/.config/dotfiles/picom $HOME/.config/dotfiles/qtile $HOME/.config/dotfiles/README.md $HOME/.config/dotfiles/.gitignore
mv -f $HOME/.config/dotfiles/* $HOME/.config/

# xinitrc
sudo cp /etc/X11/xinit/xinitrc $HOME/.xinitrc

for ((i=1;i<=5;i++)); do
    sed -i '$d' $HOME/.xinitrc
done

echo "exec i3" >> $HOME/.xinitrc

# Display informational message
banner "${YELLOW} Please check if everything is correctly :)"


