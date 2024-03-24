# Lab03
Create a new folder "lab03"

## Create a VM from scratch
```
config.vm.box = "ubuntu/trusty64"
```

## Redirect the port 80 from host to guest
```
config.vm.network "forwarded_port", guest: 80, host: 80
```

## Install apache manually (ssh)
```
vagrant@vagrant-ubuntu-trusty-64:~$ sudo apt-get update
vagrant@vagrant-ubuntu-trusty-64:~$ sudo apt-get install apache2
vagrant@vagrant-ubuntu-trusty-64:~$ sudo service apache2 status
 * apache2 is running
```

## Test it
http://localhost:80

## Add a share to the root folder of the website
```
config.vm.synced_folder "./shared_folder", "/var/www/html"
```

## Change the port to 8888 and reload the VM
```
config.vm.network "forwarded_port", guest: 80, host: 8888
```
```
E:\Projects\DevOpsLabs\vagrant\lab03> vagrant reload
```

# Create a simple html file 
```
E:\Projects\DevOpsLabs\vagrant\lab03\shared_folder> echo "This is my website" > index.html
PS E:\Projects\DevOpsLabs\vagrant\lab03\shared_folder> cat .\index.html
This is my website
```

# Test it 
http://localhost:8888/



