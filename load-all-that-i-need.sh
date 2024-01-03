#!/bin/bash

banner()
{
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                          |"
  printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+------------------------------------------+"
}

banner "Updating and upgrading your packages"
sudo pacman -Syyu

banner "Installing pyenv, python and pip3"
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
exec $SHELL
pyenv install 3.12.0
pyenv global 3.12.0
exec $SHELL
currentpython=$(which python)
if [ $currentpython="/home/akame/.pyenv/shims/python" ]
then
    echo "Python was installed correctly"
    pacman -S python-pip
    pip3 install --upgrade pip
else
    echo "Please check your pyenv installation after"

banner "Installing i3, alacritty and fish"
sudo pacman -S i3
sudo pacman -S alacritty 
sudo pacman -S fish
sudo pacman -S feh
fish 
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

cd /akame/home/
mkdir .config
cd .config
git clone https://github.com/moraeskkj/dotfiles.git
cp scripts/* ~/scripts
rm -rf arch-ricing.png picom qtile README.md .gitignore


echo "Please don't forget to make sure that all config are correctly"

mkdir /akame/scripts
mkdir /akame/tools

