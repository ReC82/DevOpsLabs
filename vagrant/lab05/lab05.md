# Lab05
## Add some Logic & Create a small project
Create a new folder "**lab05**"

### Create an array of hash
<details><summary>show variables creation</summary><p>

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

</p><details>

### Create the VM but add a config in a particular case

<details><summary>show</summary><p>

```ruby
Vagrant.configure("2") do |config|
  servers.each do |server|
    
    config.vm.define server[:server_hostname] do |srv|
      srv.vm.box = server[:server_box]
      srv.vm.hostname = server[:server_hostname]
      srv.vm.network "private_network", ip: server[:server_ip]
      # IF the server is the Web server Create a port forwarding
      if server[:server_function] == "PHP"
        srv.vm.network "forwarded_port", guest: 80, host: 8888, id: "http"
        srv.vm.provider :virtualbox do |vbox|
          vbox.customize ["modifyvm", :id, "--memory", 512]
          vbox.customize ["modifyvm", :id, "--cpu", 1]
        end
      elsif server[:server_function] == "MYSQL"
      # If Database then other limitations
        srv.vm.provider :virtualbox do |vbox|
          vbox.customize ["modifyvm", :id, "--memory", 512]
          vbox.customize ["modifyvm", :id, "--cpu", 1]
        end
      end
    end
  end
end
```

</p><details>

### Start the VM and install some softwares

### On WEB01

```bash
vagrant@WEB01:~$ sudo apt-get update
vagrant@WEB01:~$ sudo apt-get install -y apache2 nano git
vagrant@WEB01:~$ sudo apt-get install -y php libapache2-mod-php php-mysql mysql-client iputils-ping
vagrant@WEB01:~$ sudo service apache2 restart
```

### On DATABASE01

```bash
vagrant@DATABASE01:~$ sudo apt-get update
vagrant@DATABASE01:~$ sudo apt-get install -y mysql-server
```

### Create a DB user
```bash
vagrant@DATABASE01:~$ sudo mysql
```

```sql
mysql> CREATE USER 'vagrant'@'10.0.5.10' IDENTIFIED WITH mysql_native_password BY 'vagrant';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'10.0.5.10' WITH GRANT OPTION;
mysql> quit
```

### Edit the /etc/mysql/mysql.conf.d/mysqld.cnf
``` bash
# [mysqld]
# default_authentication_plugin= mysql_native_password
sudo sed -i '/^user\s*=\s*mysql/a default_authentication_plugin = mysql_native_password' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo sed -i 's/^bind-address\s*=\s*127\.0\.0\.1$/bind-address = 10.0.5.20/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql.service
```

### Get PHP/Mysql Website from Github
https://github.com/ReC82/TinyPhpMysqlExample.git

on WEB01 : 
```bash
vagrant@WEB01:/var/www/html$ cd /var/www/html
vagrant@WEB01:/var/www/html$ sudo git clone https://github.com/ReC82/TinyPhpMysqlExample.git
vagrant@WEB01:/var/www/html$ sudo cp -r TinyPhpMysqlExample/* .
vagrant@WEB01:/var/www/html$ sudo sed -i 's/your_database/lab05/g' db.sql
vagrant@WEB01:/var/www/html$ mysql -h 10.0.5.20 -u vagrant -pvagrant < db.sql
```