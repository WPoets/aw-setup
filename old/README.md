<p align="center">
<a href="https://www.wpoets.com/" target="_blank"><img width="200"src="https://www.wpoets.com/wp-content/uploads/2018/05/WPoets-logo-1.svg"></a>
</p>

# Enterprise Site Setup with Easyengine and WordOps

shell scripts to setup Awesome Enterprise platform on a new WordPress website
Use this bash file to create the enterprise site in one command for Easyengine V3 and above

### Prerequisites

Either EasyEngine v3 and above OR WordOps 

### Installing Setup Script

Create the wordpress site by using EasyEngine

for EE3
```
ee site create example.com --wpfc --php7 --letsencrypt
```
for EE4
```
ee site create example.com --type=wp --cache
```
for wo
```
wo site create example.com --wpfc
```

Download this script

for EE3
```
wget "https://raw.githubusercontent.com/WPoets/aw-setup/master/ee3-setup.sh" && chmod u+x ee3-setup.sh
```

for EE4
```
wget "https://raw.githubusercontent.com/WPoets/aw-setup/master/ee4-setup.sh" && chmod u+x ee4-setup.sh
```

for WO
```
wget "https://raw.githubusercontent.com/WPoets/aw-setup/master/wo-setup.sh" && chmod u+x wo-setup.sh
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

for WO
```
./wo-setup.sh example.com

```
After running this command this script will ask the redis database no.
enter the appropriate database no.

### Adding new WP user

To add new WP user this script will promt you to register new user.
enter y to add new user and follow the procedure.

### Enabling the EE Admin-Tools(Only available in EE4)

To enable the admin tools enter y when this script ask to enable the admin tools.

### Installing WO setup Script
```
wget -qO awe.sh https://www.wpoets.com/awe && bash awe.sh

```
Alternativley 
```
wget "https://raw.githubusercontent.com/WPoets/aw-setup/master/awe.sh" && bash awe.sh

```


## We're Hiring!

<p align="center">
<a href="https://www.wpoets.com/careers/"><img src="https://www.wpoets.com/wp-content/uploads/2020/11/work-with-us_1776x312.png" alt="Join us at WPoets, We specialize in designing, building and maintaining complex enterprise websites and portals in WordPress."></a>
</p>