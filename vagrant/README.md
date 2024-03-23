# Common Vagrant Commands

Vagrant is a powerful tool for managing development environments. Below are some of the most commonly used commands:

## vagrant init

The `vagrant init` command is used to initialize a new Vagrant configuration file in a project directory. This configuration file, called `Vagrantfile`, specifies the details of the virtual machine configuration.

## vagrant up

`vagrant up` is used to start or provision a virtual machine based on the `Vagrantfile` present in the directory. If the virtual machine is not already running, this command will start it.

## vagrant ssh

The `vagrant ssh` command allows you to connect to the virtual machine via SSH. This will open an SSH session to the virtual machine using the credentials configured in the `Vagrantfile`.

## vagrant halt

`vagrant halt` is used to gracefully stop a virtual machine. This cleanly shuts down any running processes on the virtual machine and powers it off.

## vagrant destroy

The `vagrant destroy` command is used to completely remove a virtual machine. This will delete all traces of the virtual machine from the host system.

These basic commands should get you started with Vagrant and effectively manage your development environments.
