<p align="center">
    <img src="https://static.magento.com/sites/all/themes/magento/logo.svg" width="300px" alt="Magento Commerce" />
</p>

#  Magento 2 Docker to Development

### Features

- Magento 2.x
- Apache
- PHP PHP 7.4
- Xdebug 2.9.8
- MySQL 8.0.27
- Elasticsearch 7.6
- Varnish 6.4
- Redis
- MailHog
- n98-magerun

| PHP Version  | Composer  | [hirak/prestissimo](https://github.com/hirak/prestissimo) |
|---|---|---|
|7.4|2.*|No|

### Requirements

**Linux (Ubuntu 20.04 recommended):**
Docker Install
```
$ curl -fsSL https://get.docker.com/ | sh
$ sudo systemctl start docker
$ sudo systemctl enable docker
```

Docker-Compose Install
```
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
$ sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

Docker Stack Install
```
[TBD]
```

**Windows:**
[Docker Desktop](https://www.docker.com/products/docker-desktop)

### Before start
Note that for Elasticsearch you need at least 262144 memory. 

**Linux:**

To check:
```
more /proc/sys/vm/max_map_count
```

The vm.max_map_count setting should be set permanently in `/etc/sysctl.conf`:
```
vm.max_map_count=262144
```
After set run:
```
sudo sysctl -p
```

**Windows:**
To check:
```
$ wsl --list # Get default machine name. Usually docker-desktop
$ wsl -d docker-desktop
$ cat /proc/sys/vm/max_map_count

```
Continue to run the following command to set `vm.max_map_count` setting:
```
$ sysctl -w vm.max_map_count=262144
```


### How to use
1. Start all containers with command
```
$ sudo docker-compose up -d
```

2. Grant execute permission to shell scripts
```
$ sudo chmod +x bin/*
```

3. Download. You need to sign up and [get the access keys](https://marketplace.magento.com/customer/accessKeys/), You will receive a private (Password) and public (Username) key that we will use to download Magento
```
$ sudo bin/shell
$ rm .gitkeep

# Second arg is the magento's version
$ install-magento2 2.4.3-p1
```

4. Setup. You must change the base url to your domain and server ip but keeps the others. You can change the administrator credentials as you want.
```
$ bin/magento setup:install --base-url=http://<your-domain-or-ip-or-localhost> --db-host=db --db-name=magento --db-user=magento --db-password=magento --admin-firstname=Administrator --admin-lastname=Administrator --admin-email=administrator@admin.com --admin-user=administrator --admin-password=administrator@123 --language=en_US --currency=USD --timezone=America/Chicago --use-rewrites=1 --elasticsearch-host=elasticsearch
```

5. Restart. Refresh everything
```
$ sudo docker-compose down
$ sudo docker-compose up -d
$ sudo bin/composer dumpautoload
```

5. Enable Varnish Caching
- Go to Store > Configuration > Advanced > System > Full Page Cache > uncheck `use system value` of Caching Application then set to `Varnish Cache`
- Run the following command from your host to correct caching host in docker `$ sudo bin/magento setup:config:set --http-cache-hosts=varnish`
- How to use Varnish in CLI:
```
# Purge all cache manually
$ sudo bin/shell
$ curl -H "X-Magento-Tags-Pattern: .*" -X PURGE http://varnish
```

### Panels
#### Magento
**Web server:** http://localhost/

**Local emails:** http://localhost:8025

#### Operation
**Grafana:** http://localhost:3000 (admin/admin)

**Kibana:** http://localhost:5601 (elastic/changeme)

**Prometheus:** http://localhost:9090

```
Ports

5044: Logstash Beats input
5000: Logstash TCP input
9600: Logstash monitoring API
9200: Elasticsearch HTTP
9300: Elasticsearch TCP transport
5601: Kibana
```


### Features commands

| Commands  | Description  | Options & Examples |
|---|---|---|
| `bin/init`  | If you didn't use the CURL setup command above, please use this command changing the name of the project.  | `./init MYMAGENTO2` |
| `bin/start`  | If you continuing not using the CURL you can start your container manually  | |
| `bin/stop`  | Stop your project containers  | |
| `bin/kill`  | Stops containers and removes containers, networks, volumes, and images created to the specific project  | |
| `bin/shell`  | Access your container  | `./shell root` | |
| `bin/magento`  | Use the power of the Magento CLI  | |
| `bin/magento-basic`  | All basic Magento CLI commands (setup:upgrade, setup:di:compile, setup:static-content:deploy -f, cache:clean, cache:flush)  | |
| `bin/n98`  | Use the Magerun commands as you want | |
| `bin/grunt-init`  | Prepare to use Grunt  | |
| `bin/grunt`  | Use Grunt specifically in your theme or completely, it'll do the deploy and the watcher.  | `./grunt luma` |
| `bin/xdebug`  |  Enable / Disable the XDebug | |
| `bin/composer`  |  Use Composer commands | `./composer update` |

### TODO
- Grafana
  - Varnish
  - MySQL
  - Apache
- Kibana
- Load Balancers
- Docker Stack

## TroubleShooting
> Warning: include(/var/www/html/vendor/composer/../../generated/code/Magento/Framework/App/ResourceConnection/Proxy.php): failed to open stream: No such file or directory in /var/www/html/vendor/composer/ClassLoader.php on line 571

Run the following command: `$ sudo bin/composer dumpautoload`

> There has been an error processing your request

```
$ sudo bin/magento setup:upgrade
$ sudo bin/magento setup:di:compile
$ sudo bin/magento setup:static-content:deploy
$ sudo bin/magento cache:clean
$ sudo bin/magento cache:flush
```

> The directory "/var/www/html/generated/code/Magento" cannot be deleted Warning!rmdir(/var/www/html/generated/code/Magento): Directory not empty

```
$ sudo bin/magento cache:clean
$ sudo bin/magento cache:flush
```

> CSS file return 404 after enable merging

```
$ bin/magento config:set dev/css/merge_css_files 0
$ sudo bin/magento config:set dev/css/minify_files 0
$ bin/magento setup:static-content:deploy
$ bin/magento cache:clean config
```

### Useful Commands:
**Refresh**
```
# Development Mode
$ sudo bin/magento setup:upgrade && sudo bin/magento setup:di:compile && sudo bin/magento cache:clean && sudo bin/magento cache:flush

# Production Mode
$ sudo bin/magento setup:upgrade && sudo bin/magento setup:di:compile && sudo bin/magento setup:static-content:deploy && sudo bin/magento cache:clean && sudo bin/magento cache:flush
```

**Disable 2FA**
```
$ sudo bin/magento module:disable Magento_TwoFactorAuth
# Then [Refresh]
```

**Set Production Mode**
```
# SSH to container
$ sudo bin/shell

# Remove generated code
$ rm -r generated/*/*

# then exit the SSH with $ exit
# Set Production mode
$ sudo bin/magento deploy:mode:set production

# Then [Refresh]
```

### References
Thanks to following repos, i have success to run Magento 2 in Docker without suffering from setup from scratch.
- Fork from https://github.com/echo-magento/docker-magento2
- https://github.com/tuanpht/magento2-docker
