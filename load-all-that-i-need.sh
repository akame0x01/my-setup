#!/bin/bash

# Get the original (non-root) username
original_user=$SUDO_USER

# Set environment variables for the desired user
export USER=$original_user
export HOME="/home/$original_user"

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

# Display banner for installing pyenv, python, and pip3
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
if [ "$currentpython" = "/home/$original_user/.pyenv/shims/python" ]; then
    echo -e "\e[92mPython was installed correctly\e[0m"
    pip3 install --upgrade pip
else
    echo -e "\e[91mPlease check your pyenv installation\e[0m"
fi

# Display banner for installing i3, alacritty, and fish
banner "Installing i3, alacritty, and fish"
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

# Clone dotfiles and copy scripts
cd $HOME
mkdir -p .config
cd .config
git clone https://github.com/moraeskkj/dotfiles.git
cp $HOME/.config/dotfiles/scripts/* $HOME/scripts
rm -rf $HOME/.config/dotfiles/arch-ricing.png $HOME/.config/dotfiles/picom $HOME/.config/dotfiles/qtile $HOME/.config/dotfiles/README.md $HOME/.config/dotfiles/.gitignore

# Display informational message
echo -e "Please don't forget to make sure that all configurations are correct"

# Create directories
mkdir -p $HOME/scripts
mkdir -p $HOME/tools
