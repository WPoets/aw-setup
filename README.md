<p align="center">
	<a href="https://www.wpoets.com/" target="_blank"><img width="200"src="https://www.wpoets.com/wp-content/uploads/2018/05/WPoets-logo-1.svg"></a>
</p>

# Awesome Enterprise Site Setup using WordOps

shell scripts to setup Awesome Enterprise platform on a new WordPress website
Use this bash file to create the enterprise site in one command for Easyengine V3 and above

### Prerequisites

We need 

1. Ubuntu 18.04 + server

This will setup following items

1. Change the Timezone to Aisa/Kolkata
2. Install WordOps 
3. Change the conf files for Nginx
4. Installs aws-cli
5. Install aw3.sh script.

### Installing WO setup Script

Download this script, It will setup the WordOps on the server, along with other dependecies.

```
wget -qO awe.sh https://www.wpoets.com/awe && bash awe.sh

```
Alternativley 
```
wget "https://raw.githubusercontent.com/WPoets/aw-setup/master/awe.sh" && bash awe.sh

```

### Create the Site

Create the wordpress site by using WordOps

```
wo site create example.com --wpfc
```

## Running the Script

Use below command to configure any wordpress site with Awesome Enterprise

```
./aw3.sh example.com

```

After running this command this script will ask the redis database no.
enter the appropriate database no.

### Adding new WP user

To add new WP user this script will promt you to register new user.
enter y to add new user and follow the procedure.


## We're Hiring!

<p align="center">
<a href="https://www.wpoets.com/careers/"><img src="https://www.wpoets.com/wp-content/uploads/2020/11/work-with-us_1776x312.png" alt="Join us at WPoets, We specialize in designing, building and maintaining complex enterprise websites and portals in WordPress."></a>
</p>