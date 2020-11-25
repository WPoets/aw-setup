#!/bin/bash
#
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

echo 'Environment is ready.';