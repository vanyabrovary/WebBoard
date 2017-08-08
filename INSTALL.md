# Installing WebBoard

This is the installation documentation for WebBoard

### Requirements

* Unix, Linux, Mac, Mac Server, Windows systems as long as perl is available.
* Perl > 5.20
* Apache 2.4 / mod_perl 2.0.9
* Nginx
* MariaDB > 10.0 or MySQL

### Step 1. Dependencies installation

#### Step 1.1. Installing modules from CPAN.

<pre>
DBI
Template
Moose
Email::Valid;
reCAPTCHA
String::Clean::XSS
Config::Tiny
Geo::IP
Mojolicious
Captcha::reCAPTCHA
Plack::Handler::Apache2
</pre>

#### Step 1.2. Installing modules using apt-get.

<pre>
apt-get install libapache2-mod-perl2 apache2 apache2-utils nginx mariadb-server-10.1
</pre>

### Step 2. Installing project libs

#### Step 2.1. Get last version

<pre>
cd /var/www
git clone https://github.com/vanyabrovary/WebBoard.git
</pre>

#### Step 2.2. MySQL database import

<pre>
mysql -e 'CREATE DATABASE web_board /*!40100 DEFAULT CHARACTER SET utf8 */'
mysql -e "GRANT ALL ON web_board.* TO 'web_board' IDENTIFIED BY 'web_board'"
mysql shop < /var/www/WebBoard/etc/conf/web_board.sql
</pre>

#### Step 2.3. Configure apache.

_Change config values for apache2.conf:_

<pre>
vim /etc/apache2/apache2.conf
</pre>

_Add the following lines to apache2.conf:_

<pre>
Include /var/www/WebBoard/etc/conf/apache.conf
</pre>

#### Step 2.4. Configure nginx.

_Change config values for nginx.conf:_

<pre>
vim /etc/nginx/nginx.conf
</pre>

_Add the following line to nginx.conf:_

<pre>
include /var/www/WebBoard/etc/conf/nginx.conf;
</pre>

#### Step 2.5. Change WebBoard config file.

_Edit this file in order to configure your project settings_

<pre>
vim /var/www/WebBoard/etc/my.ini
</pre>

### Step 3. Restarting services.

* /etc/init.d/apache2 restart
* /etc/init.d/nginx restart

### Debugging during installation

#### Error logs.

<pre>
tail -f /var/www/WebBoard/log/error.log
</pre>

#### Debug logs.

<pre>
tail -f /var/www/WebBoard/log/production.log
</pre>
