- Provision C0 instance of the Azure Redis Cache Service
- Click on **New** => **Web + Mobile** => **Wordpress**  => **Create** and Enter desired App name, and other details. Select a free Clear DB database *Pricing tier: Mercury*. Create S1 **App Service plan** in the same **Location** as your Redis cache. Click on **Create**.

**Enable the Web Apps Memcache shim:**

Save http://windows.php.net/downloads/pecl/releases/memcache/3.0.8/php_memcache-3.0.8-5.6-nts-vc11-x86.zip

Open your **App Service** page and set ftp credentials on **Deployment credentials** tab.

Connect to repository using ftp and copy *php_memcache.dll* from downloaded zip file to *site\wwwroot\bin\ext*. You can find FTP connection information on **Properties** tab.

Navigate to **App setting** tab and set these **App settings**:

PHP_EXTENSIONS bin\ext\php_memcache.dll

MEMCACHESHIM_REDIS_ENABLE true

REDIS_KEY *primary key from redis cache*

REDIS_HOST *hostname from redis cache*

**Install Memcached Object Cache WordPress plugin using wp-admin**:

Navigate to your Wordpress page and complete install instructions. Navigate to Plugins tab and search for new *Memcached Object Cache* Plugin.
Using FTP add following lines to wp-config.php:
```
$memcached_servers = array(
    'default' => array('localhost:' . getenv("MEMCACHESHIM_PORT"))
);
```

Using ftp move *object-cache.php* from *wp-content/plugins/memcached* folder to the *wp-content* folder.

Verify the Memcache Object Cache plugin is functioning by executing *keys \** in your Redis console.
