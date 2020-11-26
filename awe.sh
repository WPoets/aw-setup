#!/bin/bash
#
#color codes
CYANBG='\033[0;96m'
ORANGE='\033[0;36m'
GREEN='\033[0;92m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

apt-get install unzip
apt-get install awscli
echo 'Setting update date to IST'
dpkg-reconfigure tzdata

echo "Downloading WordOps"
wget -qO wo wops.cc && bash wo

echo 'Installing WordOps Stack'
wo stack install

wo stack status


echo 'Setting up Redis Server';
add-apt-repository ppa:chris-lea/redis-server
apt-get update
apt-get install redis-server php-redis

service redis-server start

printf "${CYANBG}Please enter GITHUB API Access Token for composer ( get from https://github.com/settings/tokens ) :${NC}\n"
read access_token
composer config --global github-oauth.github.com $access_token

echo 'Installing Awesome Enterprise Composer Package';
cd /var/www/ && composer create-project wpoets/awesome-enterprise --no-interaction
cd awesome-enterprise 

echo 'Installing Extra Handlers for Awesome Enterprise';
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
echo 'Environment is ready. Use aw3.sh to setup awesome for the site.';