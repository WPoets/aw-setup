#!/bin/bash
#
#color codes
CYANBG='\033[0;96m'
GREEN='\033[0;92m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

function getReleaseVersion() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'
}

function installAw2(){
    printf "${GREEN}Info:${YELLOW} Installing Monomyth Enterprise latest version\n${NC}";
    #aw2_theme_version=$(getReleaseVersion 'WPoets/awesome-enterprise');
    #ee shell $1 --command="wp theme install https://github.com/WPoets/monomyth-enterprise/archive/$aw2_theme_version.zip --activate"
    ee shell $1 --command="wp theme install https://github.com/WPoets/monomyth-enterprise/archive/master.zip --activate"

    aw2_plugin_version=$(getReleaseVersion 'WPoets/awesome-enterprise');
    printf "${GREEN}Info:${YELLOW} Installing Awesome Enterprise version $aw2_plugin_version${NC}\n";

    ee shell $1 --command="wp plugin install https://github.com/WPoets/awesome-enterprise/archive/$(getReleaseVersion 'WPoets/awesome-enterprise').zip --activate"
    printf "${CYANBG}Please enter REDIS_DATABASE_GLOBAL_CACHE number.${NC}\n"
    read redis_db_no
    ee shell $1 --command='wp config set REDIS_DATABASE_GLOBAL_CACHE '$redis_db_no' --add=true --type=constant'
    
    printf "${CYANBG}Please enter REDIS_DATABASE_SESSION_CACHE number.${NC}\n"
    read redis_db_no
    ee shell $1 --command='wp config set REDIS_DATABASE_SESSION_CACHE '$redis_db_no' --add=true --type=constant'
    ee shell $1 --command='wp config set REDIS_HOST global-redis --add=true --type=constant'
    ee shell $1 --command='wp config set REDIS_PORT 6379 --add=true --type=constant'
    ee shell $1 --command='wp plugin install advanced-custom-fields --activate'
    ee shell $1 --command='wp plugin install custom-post-type-ui --activate'
    ee shell $1 --command='wp plugin install wordpress-importer --activate'
    ee shell $1 --command='wp plugin install classic-editor --activate'
    ee shell $1 --command='wp plugin install wp-google-authenticator'
    ee shell $1 --command='wp plugin install google-apps-login'
    
    ee shell $1 --command="wp rewrite structure '/%postname%/'"
}

function createWpUser(){
    read -p "Please provide user-login = " ul
    read -p "Please provide user-email = " ue
    read -p "Please provide user-pass = " up
    echo "creating wp user"
    if op=$(! ee shell $1 --command="wp user create '$ul' '$ue' --role=administrator --user_pass='$up'"); then
        while true; do
            read -p "Failed to create new user do you want to create it again.[y/n]" yn
            case $yn in
                [Yy]* ) createWpUser $1; break;;
                [Nn]* ) break;;
                * ) echo "Please answer y or n.";;
            esac
        done
    fi
    
    printf "${GREEN}Info:${YELLOW} Adding capablility for Developer Awesome UI${NC}\n";
    ee shell $1 --command='wp user add-cap '$ul' develop_for_awesomeui'
}

function createWpUserPrompt(){
    while true; do
        read -p "Do you wish to create new admin user? [y/n]" yn
        case $yn in
            [Yy]* ) createWpUser $1; break;;
            [Nn]* ) break;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

function enableAdminToolsPromt(){
    while true; do
        read -p "Do you wish enable admin tools for '$1'? [y/n]" yn
        case $yn in
            [Yy]* ) ee admin-tools enable $1; break;;
            [Nn]* ) break;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

if [ -z "$1" ]; then
    echo "Please mention site name!!!"
    exit
fi

echo 'Checking ee...'
if op=$(! ee); then
    printf 'EasyEngine not installed!!!'
    exit
fi

echo 'Checking site...'
if op=$(! ee site info $1); then
    echo "Site does not exists"
    exit
else
    installAw2 $1
    createWpUserPrompt $1
    enableAdminToolsPromt $1
fi

printf "${GREEN}Site Successfully configured...\n${NC}"