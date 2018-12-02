# ubuntuFiles
My Ubuntu dotfiles, configfiles and other stuff

##Bash Prompt
PS1='${debian_chroot:+($debian_chroot)}\n\[\033[0;36m\][\[\033[0;33m\]\u\[\033[0;36m\]@\[\033[0;33m\]\h\[\033[00m\]\[\033[0;36m\]] \[\033[0;36m\$

## Programs
sudo apt install git
sudo apt install maven
VSCode => .deb
Groovy => local + PATH
Gradle => local + PATH 
## Eclipse
sudo add-apt-repository ppa:mmk2410/eclipse-ide-java
sudo apt-get update
sudo apt install eclipse-ide

## Intellij
sudo add-apt-repository ppa:mmk2410/intellij-idea
sudo apt-get update
sudo apt install intellij-ide...

## Terminal
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp .zshrc  ~/.zshrc
cp davidgdd.zsh-theme ~/.oh-my-zsh/themes/davidgdd.zsh-theme

sudo add-apt-repository ppa:webupd8team/terminix
sudo apt-get update
apt install tilix
sudo update-alternatives --config x-terminal-emulator

## NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

## JAVA
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt install oracle-java8-installer
sudo apt install oracle-java9-installer
sudo update-alternatives --config java

