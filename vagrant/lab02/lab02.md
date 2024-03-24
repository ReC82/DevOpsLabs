# Lab02

* Create a folder named "Lab02"

## Create a vagrant file from scratch

* Create a new file named "Vagrantfile"
* Copy the of the Vagrantfile part from Vagrant Cloud : https://app.vagrantup.com/ubuntu/boxes/trusty64
* Stay with ubuntu for now
```
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
end
```
* Start the VM

## Share a folder between Host and Guest
* Create a new folder named "shared_folder" (or something else)
* Add the line below under the "config_vm_box" :
```
config.vm.synced_folder "./shared_folder", "/home/vagrant/"
```
  * The first argument is the local folder on your host
  * The second argument is the folder which will be mounted on your guest

more info : https://developer.hashicorp.com/vagrant/docs/synced-folders/basic_usage

## Connect to the VM
* Do a "vagrant ssh"
* Check that you are in the correct folder with "pwd"
* Create a file or a folder in /home/vagrant
* Go back to your host and check that the file is there

## 1st Clean Up
* Just delete the file just created

## Change the box to CentOs
* Choose CentOS7 - https://app.vagrantup.com/centos/boxes/7
```
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
end
```
* The shared folder line should still be there, if not, create it.
* Boot the vm and try to create a file or a folder
* Check on the host and the guest
* The file or the folder shouldn't be there




