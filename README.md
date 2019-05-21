# aw-setup
shell scripts to setup Awesome Enterprise platform on a new WordPress website

# EE4 Enterprise Site Setup

Use this bash file to create the enterprise site in one command for Easyengine V4

### Prerequisites

EasyEngine v4 or above

### Installing

Create the wordpress site by using EasyEngine V4
```
ee site create example.com --type=wp --cache
```
Download this script

```
wget "https://raw.githubusercontent.com/WPoets/aw-setup/master/ee4-setup.sh"
```
Make it executeble

```
chmod u+x ee4-setup.sh

```

## Running the Script

Use below command to configure any wordpress site with Awesome Enterprise

```
./ee4-setup.sh example.com

```
After running this command this script will ask the redis database no.
enter the appropriate database no.

### Adding new WP user

To add new WP user this script will promt you to register new user.
enter y to add new user and follow the procedure.

### Enabling the EE Admin-Tools

To enable the admin tools enter y when this script ask to enable the admin tools.