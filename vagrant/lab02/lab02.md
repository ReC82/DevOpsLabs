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
> [!NOTE]
> Some info on Vagrant.configure("2") : https://developer.hashicorp.com/vagrant/docs/vagrantfile/version
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
```
vagrant@vagrant-ubuntu-trusty-64:~$ pwd
/home/vagrant
```
* Create a file or a folder in /home/vagrant
```
vagrant@vagrant-ubuntu-trusty-64:~$ ls
vagrant@vagrant-ubuntu-trusty-64:~$ touch test.txt
vagrant@vagrant-ubuntu-trusty-64:~$ ls
test.txt
```
* Go back to your host and check that the file is there

## 1st Clean Up
* Just delete the file just created
```
vagrant@vagrant-ubuntu-trusty-64:~$ rm test.txt
```

## Change the box to CentOs
* Choose CentOS7 - https://app.vagrantup.com/centos/boxes/7
```
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
end
```
* The shared folder line should still be there, if not, create it.
* Destroy the previous VM
```
PS E:\Projects\DevOpsLabs\vagrant\lab02> vagrant destroy --force
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
```
* Boot the vm and try to create a file or a folder
  * You will see that there's a bunch of errors
* Check on the host and the guest
* The file or the folder shouldn't be there
```
PS E:\Projects\DevOpsLabs\vagrant\lab02> vagrant ssh
[vagrant@localhost ~]$ pwd
/home/vagrant
[vagrant@localhost ~]$ ls
[vagrant@localhost ~]$ touch test.txt
[vagrant@localhost ~]$ ls
test.txt
[vagrant@localhost ~]$ exit
logout
Connection to 127.0.0.1 closed.
PS E:\Projects\DevOpsLabs\vagrant\lab02> cd .\shared_folder\
PS E:\Projects\DevOpsLabs\vagrant\lab02\shared_folder> ls
```
> [!NOTE]
> * That's because the vbguest addition plugin is not installed by default on this box.
> * Since the Guest Additions are missing, our images are preconfigured to use rsync for synced folders.
> * That a known issue : https://blog.centos.org/2020/05/updated-centos-vagrant-images-available-v2004-01/
> * This guy explain it well : https://www.puppeteers.net/blog/fixing-vagrant-vbguest-for-the-centos-7-base-box/








