#!/bin/bash
#
#color codes
CYANBG='\033[0;96m'
ORANGE='\033[38;5;208m'
GREEN='\033[0;92m'
YELLOW='\033[0;33m'
ULINE='\033[4m'
NC='\033[0m' # No Color

printf "${ORANGE}        [aw]        \n\n\n\n${NC}\n";
apt-get -qq update && apt-get dist-upgrade -y && apt-get autoremove --purge -y && apt-get clean
apt-get -qq install unzip pigz
apt-get -qq install awscli
printf "${ORANGE}Setting update date to IST ${NC}\n";
timedatectl set-timezone 'Asia/Kolkata'
dpkg-reconfigure --frontend noninteractive tzdata

printf "${ORANGE}Downloading WordOps ${NC}\n";
wget -qO wo wops.cc && bash wo

printf "${ORANGE} ---Installing WordOps Stack--- ${NC}\n";

wo stack install

printf "${ORANGE}Setting up Redis Server ${NC}\n";
add-apt-repository ppa:redislabs/redis -y
apt-get update
apt-get install redis-server php-redis -y

service redis-server start
systemctl enable redis-server --quiet

wo stack install --php74

update-alternatives --set php /usr/bin/php7.4
service nginx restart

printf "${ORANGE} Updating conf files ${NC}\n";
git clone https://github.com/WPoets/conf.git $HOME/wpoets-conf
touch /etc/nginx/conf.d/map-wp-fastcgi-cache.conf.custom
cp -f $HOME/wpoets-conf/nginx/fastcgi.conf /etc/nginx/conf.d/fastcgi.conf
cp -f $HOME/wpoets-conf/nginx/map-wp-fastcgi-cache.conf /etc/nginx/conf.d/map-wp-fastcgi-cache.conf
cp -f $HOME/wpoets-conf/nginx/locations-wo.conf /etc/nginx/common/locations-wo.conf

printf "${CYANBG}Please enter GITHUB API Access Token for composer (get from https://github.com/settings/tokens ) :${NC}\n";
read access_token

composer config --global github-oauth.github.com $access_token --no-interaction

printf "${ORANGE}Installing Awesome Enterprise Composer Package ${NC}\n";
cd /var/www/ && composer create-project wpoets/awesome-enterprise --no-interaction --quiet
cd awesome-enterprise 

printf "${ORANGE}Installing Extra Handlers for Awesome Enterprise ${NC}\n";

composer require wpoets/communication-handler --no-interaction --quiet
composer require wpoets/docx-handler --no-interaction --quiet
composer require wpoets/google-handler --no-interaction --quiet
composer require wpoets/facebook-handler --no-interaction --quiet
composer require wpoets/linkedin-handler --no-interaction --quiet
composer require wpoets/payments-handler --no-interaction --quiet
composer require wpoets/pdf-handler --no-interaction --quiet
composer require wpoets/woocommerce-handler --no-interaction --quiet

wp package install git@github.com:wp-cli/profile-command.git  --allow-root
wp package install git@github.com:10up/wpcli-vulnerability-scanner.git  --allow-root

printf "${ORANGE} Downloading Backup Script ${NC}\n";
wget -qO /usr/local/sbin/backup.sh "https://raw.githubusercontent.com/WPoets/aw-setup/master/wo-backup.sh" && chmod u+x /usr/local/sbin/backup.sh

cd ~
#crontab -l > mycron
#echo "#0 2 * * * /usr/local/sbin/backup.sh  > /dev/null 2>&1 #backup setup for s3" >> mycron
#crontab mycron
#rm mycron
(crontab -l ; echo "#0 2 * * * /usr/local/sbin/backup.sh  > /dev/null 2>&1 #backup setup for s3") | sort - | uniq - | crontab -
printf "${YELLOW} Remember to configure backup script ${ULINE}wo-backup.sh & CRON Schedule ${NC}\n";

# need to update the conf file in etc/nginx with support for vsession as well as cache control

wget -qO /usr/local/bin/aw3 "https://raw.githubusercontent.com/WPoets/aw-setup/master/aw3-setup.sh" && chmod u+x /usr/local/bin/aw3

wo stack status
printf "${ORANGE}Environment is ready. Use ${ULINE}aw3${NC} ${ORANGE} to setup awesome for the site. ${NC}\n";
