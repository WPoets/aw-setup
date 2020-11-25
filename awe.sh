#!/bin/bash
#

echo 'Setting update date to IST'
dpkg-reconfigure tzdata

echo "Downloading WordOps"
wget -qO wo wops.cc && bash wo

echo 'Installing WordOps Stack'
wo stack install

wo stack status

echo 'Setting up Awesome Enterprise';
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

wget "https://raw.githubusercontent.com/WPoets/aw-setup/master/aw3-setup.sh" && chmod u+x aw3-setup.sh
echo 'Environment is ready. Use aw3-setup.sh to setup awesome for the site.';