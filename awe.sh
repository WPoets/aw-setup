#!/bin/bash
#
#color codes
CYANBG='\033[0;96m'
ORANGE='\033[38;5;208m'
GREEN='\033[0;92m'
YELLOW='\033[0;33m'
ULINE='\033[4m'
NC='\033[0m' # No Color

apt-get install unzip
apt-get install awscli
printf '${ORANGE}Setting update date to IST ${NC}\n';
dpkg-reconfigure tzdata

printf "${ORANGE}Downloading WordOps ${NC}\n";
wget -qO wo wops.cc && bash wo

echo 'Installing WordOps Stack'
wo stack install

wo stack status


printf '${ORANGE}Setting up Redis Server ${NC}\n';
add-apt-repository ppa:chris-lea/redis-server
apt-get update
apt-get install redis-server php-redis

service redis-server start

printf "${CYANBG}Please enter GITHUB API Access Token for composer (get from https://github.com/settings/tokens ) :${NC}\n";
read access_token
composer config --global github-oauth.github.com $access_token

printf '${ORANGE}Installing Awesome Enterprise Composer Package ${NC}\n';
cd /var/www/ && composer create-project wpoets/awesome-enterprise --no-interaction
cd awesome-enterprise 

printf '${ORANGE}Installing Extra Handlers for Awesome Enterprise ${NC}\n';
composer require wpoets/communication-handler
composer require wpoets/docx-handler
composer require wpoets/google-handler
composer require wpoets/facebook-handler
composer require wpoets/linkedin-handler
composer require wpoets/payments-handler
composer require wpoets/pdf-handler
composer require wpoets/woocommerce-handler

cd ~
wget -qO aw3.sh "https://raw.githubusercontent.com/WPoets/aw-setup/master/aw3-setup.sh" && chmod u+x aw3.sh
printf '${ORANGE}Environment is ready. Use ${ULINE}aw3.sh${NC} ${ORANGE} to setup awesome for the site. ${NC}\n';