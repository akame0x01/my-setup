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
if [ $currentpython="/home/akame/.pyenv/shims/python"
then
    echo "Python is sucessfuly installed"
    pacman -S python-pip
else
    echo "Please check your pyenv installation after"

sudo pacman -S i3
sudo pacman -S alacritty 
sudo pacman -S fish
fish 
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin


i3 -> alacritty -> fish shell -> reconfigure pyenv in fish -> curl all your config files -> obsidian ->


mkdir /akame/scripts
mkdir /akame/tools

#echo
#echo 'INSTALANDO O GOLANG'
#Acessar a URL https://go.dev/doc/install e verificara versao mais atualizada
#wget https://go.dev/dl/go1.18.4.linux-amd64.tar.gz
#rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.4.linux-amd64.tar.gz
#export PATH=$PATH:/usr/local/go/bin
#go version
#apt install -y golang-go

#pip3
echo
echo 'INSTALANDO O PIP3'
apt-get install -y python3-pip
pip3 --version
echo

#snapd
echo 'INSTALANDO O SNAP'
apt install -y snapd
echo

########################################################################


echo '##############################################'
echo '#                                            #'
echo '#         INSTALANDO AS FERRAMENTAS                  #'
echo '#                                            #'
echo '##############################################'
echo


#sqlmap
echo 'INSTALANDO SQLMAP'
apt install sqlmap -y
echo

#Nmap
echo 'INSTALANDO Nmap'
sudo apt-get install nmap
echo

#dirb
echo 'INSTALANDO DIRB'
sudo apt install dirb
echo

#gobuster
echo 'INSTALANDO GOBUSTER'
sudo apt install gobuster
echo

#wAFW00F
echo 'INSTALANDO WAFW00F'
sudo apt install wafw00f
echo

#hashcat
echo 'INSTALANDO HASHCAT'
sudo apt install hashcat
echo

####################################################################

echo '##############################################'
echo '#                                            #'
echo '#          FERRAMENTAS UTILIZANDO O GIT          #'
echo '#                                            #'
echo '##############################################'
echo

#sublist3r
echo 'INSTALANDO SUBLISTER'
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r
pip3 install -r requirements.txt
cd /root/
echo

#testssl

echo 'INSTALANDO TOOL TEST/SSL'
git clone https://github.com/drwetter/testssl.sh.git
echo

#clickjacking
echo 'INSTALANDO TOOL CLICKJACKING'
git clone https://github.com/sensepost/jack.git
echo

################################################################

echo '##############################################'
echo '#                                            #'
echo '#             FERRAMENTAS UTILIZANDO GO          #'
echo '#                                            #'
echo '##############################################'
echo

#ffuf
echo 'INSTALANDO FFUF'
go install github.com/ffuf/ffuf/v2@latest
mv /root/go/bin/* /usr/bin
echo

###########################################################################

echo '##############################################'
echo '#                                            #'
echo '#                BAIXANDO WORDLIST               #'
echo '#                                            #'
echo '##############################################'
echo

#WORDLIST
cd /root/Wordlist
wget https://wordlists-cdn.assetnote.io/data/manual/raft-large-extensions.txt
wget https://wordlists-cdn.assetnote.io/data/manual/raft-large-directories.txt
wget https://wordlists-cdn.assetnote.io/data/automated/httparchive_apiroutes_2022_05_28.txt

cd /root

#SecList
cd /root/Wordlist
wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip \
  && unzip SecList.zip \
  && rm -f SecList.zip
 cd /root

echo '####### INSTALAÇÃO REALIZADA COM SUCESSO #######'
date
