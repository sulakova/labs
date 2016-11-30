- Provision an instance of the Azure Redis Cache Service
- Provision free instance of Mysql from Cleardb
- Deploy a WordPress site in Azure

#Enable the Web Apps Memcache shim:
http://windows.php.net/downloads/pecl/releases/memcache/3.0.8/php_memcache-3.0.8-5.6-nts-vc11-x86.zip
Open your **App Service** page and set ftp credentials on **Deployment credentials** tab.
Connect to repository using ftp and copy *php_memcache.dll* to *site\wwwroot\bin\ext*. You can find FTP connection information on **Properties** tab.

Navigate to **App setting** tab and set these **App settings**:

PHP_EXTENSIONS bin\ext\php_memcache.dll
MEMCACHESHIM_REDIS_ENABLE true
REDIS_KEY *primary key from redis cache*
REDIS_HOST *hostname from redis cache*

#Install Memcached Object Cache WordPress plugin using wp-admin:

add to wp-config.php:

$memcached_servers = array(
    'default' => array('localhost:' . getenv("MEMCACHESHIM_PORT"))
);

ftp move object-cache.php from wp-content/plugins/memcached folder to the wp-content folder 

#Verify the Memcache Object Cache plugin is functioning by executing "keys *" in redis console

define('WP_REDIS_HOST',   'alargodis.redis.cache.windows.net');
define('WP_REDIS_PASSWORD',       '0v0noOjmVLbpFiaAMJxEO8ERfLUbz2hKAKPKUfGIELs=');
define('WP_REDIS_SCHEME',       'tls');
define('WP_REDIS_PORT',       '6380');
