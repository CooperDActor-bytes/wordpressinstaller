#!/bin/bash
# copyright salty media  
# whilst listening to elise uckland 
# and watching Layze 
# GNU license
# use with anything  
# bye enjoy x 

sudo apt update
sudo apt install apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip

sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www
cd /etc/apache2/sites-available/
wget https://salty.cool/ect/wordpress.conf
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default
sudo service apache2 reload

sudo mysql -u root
CREATE DATABASE wordpress
CREATE USER wordpress@localhost IDENTIFIED BY '<12345678>'
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
    -> ON wordpress.*
    -> TO wordpress@localhost;
    FLUSH PRIVILEGES;
quit


sudo service mysql start
sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/database_name_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/password_here/<your-password>/' /srv/www/wordpress/wp-config.php


echo Finally, in a terminal session open the configuration file in nano:

echo sudo -u www-data nano /srv/www/wordpress/wp-config.php
echo Find the following:

echo define( 'AUTH_KEY',         'put your unique phrase here' );
echo define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );
echo define( 'LOGGED_IN_KEY',    'put your unique phrase here' );
echo define( 'NONCE_KEY',        'put your unique phrase here' );
echo define( 'AUTH_SALT',        'put your unique phrase here' );
echo define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );
echo define( 'LOGGED_IN_SALT',   'put your unique phrase here' );
echo define( 'NONCE_SALT',       'put your unique phrase here' );
echo Delete those lines (ctrl+k will delete a line each time you press the sequence). Then replace with the content of https://api.wordpress.org/secret-key/1.1/salt/. (This address is a randomiser that returns completely random keys each time it is opened.) This step is important to ensure that your site is not vulnerable to “known secrets” attacks.

echo Save and close the configuration file by typing ctrl+x followed by y then enter


echo DO THAT!
echo
echo
echo Cheers Cooper

