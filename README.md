# Enterprise Site Setup with Easyengine

shell scripts to setup Awesome Enterprise platform on a new WordPress website
Use this bash file to create the enterprise site in one command for Easyengine V3 and above

### Prerequisites

EasyEngine v3 or above

### Installing

Create the wordpress site by using EasyEngine
```
ee site create example.com --type=wp --cache
```
Download this script

for EE3
```
wget "https://raw.githubusercontent.com/WPoets/aw-setup/master/ee3-setup.sh"
```

for EE4
```
wget "https://raw.githubusercontent.com/WPoets/aw-setup/master/ee4-setup.sh"
```

Make it executeble

for EE3
```
chmod u+x ee3-setup.sh

```
for EE4
```
chmod u+x ee4-setup.sh

```

## Running the Script

Use below command to configure any wordpress site with Awesome Enterprise

for EE3
```
./ee3-setup.sh example.com

```

for EE4
```
./ee4-setup.sh example.com

```
After running this command this script will ask the redis database no.
enter the appropriate database no.

### Adding new WP user

To add new WP user this script will promt you to register new user.
enter y to add new user and follow the procedure.

### Enabling the EE Admin-Tools(Only available in EE4)

To enable the admin tools enter y when this script ask to enable the admin tools.