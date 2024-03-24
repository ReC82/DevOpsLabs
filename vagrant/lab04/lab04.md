# Lab04
## Create Multiple VM
Create a new folder "lab04"

> [!NOTE]
> Now we will go a bit deeper in the VagrantFile.
> The programming language of Vagrant is Ruby.
> Ruby is quite easy to learn but may look confusing at first.
> A great resource that I like to use : https://github.com/ThibaultJanBeyer/cheatsheets/blob/master/Ruby-Cheatsheet.md

### Create a Vagrantfile
* First we will create some variables
<details><summary>show</summary>
<p>

```ruby
# SERVER 1
HOST1_NAME = "Server1"
HOST1_BOX = "envimation/ubuntu-xenial"
HOST1_IP = "10.0.5.10"
```
</p></details>

* Create the vm "Server1" based on the variables and try it
<details><summary>show</summary>
<p>

```ruby
Vagrant.configure("2") do |config|
  # SERVER 1
  config.vm.define HOST1_NAME do |host1|
    host1.vm.box = HOST1_BOX
    host1.vm.hostname = HOST1_NAME
    host1.vm.network "private_network", ip: HOST1_IP
  end
end
```
* You can check the hostname with ssh

```bash
vagrant@Server1:~$ hostname
Server1
```
</p></details>

> [!NOTE]
> You should see how to create a second one, right ?

<details><summary>Check how here</summary>
<p>

```ruby
# SERVER 1
HOST1_NAME = "Server1"
HOST1_BOX = "envimation/ubuntu-xenial"
HOST1_IP = "10.0.5.10"

# SERVER 2
HOST2_NAME = "Server2"
HOST2_BOX = "envimation/ubuntu-xenial"
HOST2_IP = "10.0.5.11"

Vagrant.configure("2") do |config|
  # SERVER 1
  config.vm.define HOST1_NAME do |host1|
    host1.vm.box = HOST1_BOX
    host1.vm.hostname = HOST1_NAME
    host1.vm.network "private_network", ip: HOST1_IP
  end

  # SERVER 2
  config.vm.define HOST2_NAME do |host2|
    host2.vm.box = HOST2_BOX
    host2.vm.hostname = HOST2_NAME
    host2.vm.network "private_network", ip: HOST2_IP
  end
end
```

</p></details>

> [!TIP]
> To connect through SSH now you have to specify the Server
> ```
> vagrant ssh Server1
> ```

### Create more VM's
Ok, it works.  But image you have 5 VM to create.
That starts to become quite hard to maintain.
If you have to change the IP range for example, you will have to go through each declaration.

> ![NOTE]
> We are going to do baby steps here.
> the Vagranfile in this directory contains the whole code

> [!IMPORTANT]
> The goal here is not to learn Ruby or Programming.
> There will be link to some explaitions

> [!CAUTION]
> Don't start this file with the variable set to 10 !
> Change it to 3 to see how it works.  
> But keep in mind that it consumes your hosts resources.

### Create a variable to define the numbers of VM

```ruby
NUM_SERVERS = 10
```

### Create (Initialize) an array

```
servers = []
```

### Loop to fill the array
```ruby
num_servers.times do |i|
  server_name = "Server#{i + 1}"
  server_ip = "10.0.5.#{i + 10}"  # Starting IP address from 10.0.5.10
  server_config = {
    name: server_name,
    box: "envimation/ubuntu-xenial",
    ip: server_ip
  }
  servers << server_config  # Add server configuration to the array
end
```

### Create the VM
```ruby
Vagrant.configure("2") do |config|
  servers.each do |server|
    config.vm.define server[:name] do |srv|
      srv.vm.box = server[:box]
      srv.vm.hostname = server[:name]
      srv.vm.network "private_network", ip: server[:ip]
    end
  end
end
```