# Lab05
## Add some Logic & Create a small project
Create a new folder "**lab05**"

> [!NOTE]
> This one takes a bit of times.  But that's the point.
> In the next Lab, we'll put some automation in this.
> But first, we get's our hands dirty :wink:

### Create an array of hash

> [!NOTE]
> The difference between hash and array ? here :
> https://medium.com/@kamalovotash/arrays-and-hashes-in-ruby-29e3476e03da

<details><summary>Create an array of x Servers</summary><p>

```ruby
# Create a array of hash for 2 servers
servers = [
  {
    :server_hostname => "WEB01",
    :server_ip => "10.0.5.10",
    :server_function => "PHP",
    :server_box => "envimation/ubuntu-xenial"
  },
  {
    :server_hostname => "DATABASE01",
    :server_ip => "10.0.5.20",
    :server_function => "MYSQL",
    :server_box => "ubuntu/focal64"
  }
]
```

</p></details>

### Create the VM but add some conditions

<details><summary>Show the code</summary><p>

```ruby
Vagrant.configure("2") do |config|
  servers.each do |server|
    
    config.vm.define server[:server_hostname] do |srv|
      srv.vm.box = server[:server_box]
      srv.vm.hostname = server[:server_hostname]
      srv.vm.network "private_network", ip: server[:server_ip]
      # IF the server is the Web server Create a port forwarding
      # and put some hardware limitations
      if server[:server_function] == "PHP"
        srv.vm.network "forwarded_port", guest: 80, host: 8888, id: "http"
        srv.vm.provider :virtualbox do |vbox|
          vbox.customize ["modifyvm", :id, "--memory", 512]
          vbox.customize ["modifyvm", :id, "--cpu", 1]
        end
      elsif server[:server_function] == "MYSQL"
      # If Database then other limitations
        srv.vm.provider :virtualbox do |vbox|
          vbox.customize ["modifyvm", :id, "--memory", 1024]
          vbox.customize ["modifyvm", :id, "--cpu", 1]
        end
      end
    end
  end
end
```

</p></details>

> [!NOTE]
> I'm not going through all the code as it's quite explicit.
> here you'll find more info about cutomization :
> https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/configuration


### Start the VM and install some softwares

> [!TIP]
> Remember ? As there are more than one VM, you have to give the name :
> ``` vagrant ssh WEB01 ```

### On WEB01

> [!NOTE]
> You don't need to understand all of this.
> Basically, it install a webserver, php, and a mysql-client.

```bash
vagrant@WEB01:~$ sudo apt-get update
vagrant@WEB01:~$ sudo apt-get install -y apache2 nano git
vagrant@WEB01:~$ sudo apt-get install -y php libapache2-mod-php php-mysql mysql-client iputils-ping
vagrant@WEB01:~$ sudo service apache2 restart
```

### On DATABASE01 - Install Mysql Server

```bash
vagrant@DATABASE01:~$ sudo apt-get update
vagrant@DATABASE01:~$ sudo apt-get install -y mysql-server
```

### Create a DB user on mysql

> [!TIP]
> To allow the web server to connect to the database.  We will need a user.
> That's what we are going to do below

> [!WARNING]
> While it works.  It is not intended to be use in production.
> I'm really not an expert and it's not my intention :wink:
> The first idea, is to have a working environment to test.

```bash
vagrant@DATABASE01:~$ sudo mysql
```

```sql
mysql> CREATE USER 'vagrant'@'10.0.5.10' IDENTIFIED WITH mysql_native_password BY 'vagrant';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'10.0.5.10' WITH GRANT OPTION;
mysql> quit
```

### Edit the /etc/mysql/mysql.conf.d/mysqld.cnf

> [!TIP]
> :shushing_face: don't ask ... do it.
> You want to know more about sed : https://quickref.me/sed.html
> How to install mysql on Ubuntu : https://ubuntu.com/server/docs/databases-mysql
> I give you this : https://mariadb.com/kb/en/authentication-plugin-mysql_native_password/
> But, seriously, it's completely off topic.

``` bash
# [mysqld]
# default_authentication_plugin= mysql_native_password
sudo sed -i '/^user\s*=\s*mysql/a default_authentication_plugin = mysql_native_password' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/^bind-address\s*=\s*127\.0\.0\.1$/bind-address = 10.0.5.20/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql.service
```

### Get PHP/Mysql Website from Github
> [!NOTE]
> I've created this mysql/php website for the occasion :wink:
> https://github.com/ReC82/TinyPhpMysqlExample.git

on WEB01 : 
```bash
vagrant@WEB01:/var/www/html$ cd /var/www/html
vagrant@WEB01:/var/www/html$ sudo git clone https://github.com/ReC82/TinyPhpMysqlExample.git
vagrant@WEB01:/var/www/html$ sudo cp -r TinyPhpMysqlExample/* .
vagrant@WEB01:/var/www/html$ sudo sed -i 's/your_database/lab05/g' db.sql
vagrant@WEB01:/var/www/html$ mysql -h 10.0.5.20 -u vagrant -pvagrant < db.sql
```

> [!IMPORTANT]
> And voilà ! Got to : http://localhost:8888/index.php

