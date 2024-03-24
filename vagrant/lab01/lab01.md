# Create A Basic Linux VM from scratch

# Initialisation of Vagrantfile
```
vagrant init envimation/ubuntu-xenial
```
```
PS E:\Projects\DevOpsLabs\Scripts> vagrant init envimation/ubuntu-xenial
A `Vagrantfile` has been placed in this directory. You are now   
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
```

# Start the VM
```
vagrant up
```
```
PS E:\Projects\DevOpsLabs\vagrant\lab01> vagrant up      
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> default: flag to force provisioning. Provisioners marked to run always will still run.

```

# List the boxes on your computer
```
vagrant box list
```

```
PS E:\Projects\DevOpsLabs\vagrant\lab01> vagrant box list 
envimation/ubuntu-xenial (virtualbox, 1.0.3-1516241473)
```

# Connect to the VM via ssh
```
vagrant ssh
```
```
PS E:\Projects\DevOpsLabs\vagrant\lab01> vagrant ssh
Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.4.0-109-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
vagrant@base-debootstrap:~$
```

# Or directly from the VM in VirtualBox
# Default User : vagrant
# Default Password : vagrant
![Screenshot VirtualBox - vagrant user](https://github.com/ReC82/DevOpsLabs/blob/main/vagrant/lab01/images/vbox_screenshot_1.png)

# Stop the VM
```
vagrant halt
```
```
PS E:\Projects\DevOpsLabs\vagrant\lab01> vagrant halt
==> default: Attempting graceful shutdown of VM...
```

# Destroy the VM with confirmation
```
vagrant destroy
```
```
PS E:\Projects\DevOpsLabs\vagrant\lab01> vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] n
==> default: The VM 'default' will not be destroyed, since the confirmation
==> default: was declined.
```

# Destroy the VM without confirmation
```
vagrant destroy
```
```
PS E:\Projects\DevOpsLabs\vagrant\lab01> vagrant destroy --force
==> default: Destroying VM and associated drives...
```

# Delete the box
```
vagrant box remove envimation/ubuntu-xenial
```
```
PS E:\Projects\DevOpsLabs\vagrant\lab01> vagrant box remove envimation/ubuntu-xenial
Removing box 'envimation/ubuntu-xenial' (v1.0.3-1516241473) with provider 'virtualbox'...
```

# See that the box is not in the list anymore
```
vagrant box list
```

```
PS E:\Projects\DevOpsLabs\vagrant\lab01> vagrant box list
There are no installed boxes! Use `vagrant box add` to add some
```