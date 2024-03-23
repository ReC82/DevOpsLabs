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
vagrant box list

```
PS E:\Projects\DevOpsLabs\vagrant\lab01> vagrant box list 
bento/centos-8             (virtualbox, 202112.19.0)
bento/centos-stream-9      (virtualbox, 202304.28.0)
bento/ubuntu-20.04         (virtualbox, 202309.09.0)
bento/ubuntu-22.04         (virtualbox, 202309.08.0)
centos/7                   (virtualbox, 2004.01)
centos/8                   (virtualbox, 2011.0)
debian/bookworm64          (virtualbox, 12.20231211.1)
debian/bullseye64          (virtualbox, 11.20231211.1)
debian/jessie64            (virtualbox, 8.11.1)
envimation/ubuntu-xenial   (virtualbox, 1.0.3-1516241473)
geerlingguy/centos7        (virtualbox, 1.2.27)
generic/centos8            (virtualbox, 4.3.2)
opensuse/Leap-15.2.x86_64  (virtualbox, 15.2.31.632)
opensuse/Tumbleweed.x86_64 (virtualbox, 1.0.20240111)
ubuntu/bionic64            (virtualbox, 20230607.0.0)
ubuntu/focal64             (virtualbox, 20231207.0.0)
ubuntu/jammy64             (virtualbox, 20240207.0.0)
ubuntu/trusty64            (virtualbox, 20190514.0.0)
```

# Stop the VM
vagrant halt

# Destroy the VM [Don't delete the box image]
vagrant destroy

# Delete the box
vagrant box remove opensuse/Tumbleweed.x86_64