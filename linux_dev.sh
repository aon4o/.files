#!/bin/bash

# Updating and Upgrading the system
sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y

# Installing some apps
sudo apt install -y git-all redis-server

# Installing Snap, Snap Store, Caprine, RocketChat
sudo rm /etc/apt/preferences.d/nosnap.pref
sudo apt install snapd
sudo snap install snap-store
sudo snap install caprine
sudo snap install rocketchat-desktop

# Installing 'wget' for downloading packages directly from the web
sudo apt-get install wget
wget -bq -O insomnia.deb https://updates.insomnia.rest/downloads/ubuntu/latest?&app=com.insomnia.app&source=website
wget -bq -O jetbrains_toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.24.12080.tar.gz
wget -bq -O discord.deb https://discord.com/api/download?platform=linux&format=deb
wget -bg -O next_cloud.deb https://github.com/nextcloud/desktop/releases/download/v3.5.1/Nextcloud-3.5.1-x86_64.AppImage
wget -bg -O thunderbird.tar.bz2 https://download.mozilla.org/?product=thunderbird-91.10.0-SSL&os=linux64&lang=en-US

# Installing 'curl' and 'Brave'
sudo apt install apt-transport-https curl

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser -y


# Installing PHP and Composer
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php7.4 -y
sudo apt install libapache2-mod-php8.2 -y
sudo apt install php php-redis php-dompdf php-xml php-http php-zip php-curl -y
sudo systemctl restart apache2

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

echo "Done!"
