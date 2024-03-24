# Lab04
## Create Multiple VM
Create a new folder "**lab04**"

> [!NOTE]
> Now we will go a bit deeper in the **VagrantFile**.
> The programming language of Vagrant is **Ruby**.
> **Ruby** is quite easy to learn but may look confusing at first.
> A great resource that I use often : https://github.com/ThibaultJanBeyer/cheatsheets/blob/master/Ruby-Cheatsheet.md

### Create a Vagrantfile
* First we will create some variables
<details><summary>show variables creation</summary>
<p>

```ruby
# SERVER 1
HOST1_NAME = "Server1"
HOST1_BOX = "envimation/ubuntu-xenial"
HOST1_IP = "10.0.5.10"
```
</p></details>

* Create the VM "**Server1**" based on the variables and try it
<details><summary>show VM creation</summary>
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
* You can check the **hostname** with ssh

```bash
vagrant@Server1:~$ hostname
Server1
```
</p></details>

> [!NOTE]
> You should see how to create a second one, right ? :wink:

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
> vagrant ssh **Server1**
> ```

### Create more VM's
Ok, it works.  But suppose you have 5 VM to create.
Managing this becomes progressively challenging.
In the event that you need to modify the IP range, you'll be required to edit each declaration individually.

> [!NOTE]
> We are going to take small steps here.
> The Vagrantfile in this directory contains the entire code.

> [!IMPORTANT]
> The aim here is not to learn Ruby or Programming.
> However, explanations will come with accompanying links.

> [!CAUTION]
> Do not set the variable to 10 initially.
> Instead, adjust it to 3 for observation.
> However, please be aware that this may impact your host's resources.

### Create a variable to define the numbers of VM

```ruby
NUM_SERVERS = 10
```

> [!NOTE]
> This is not an ordinary variable as it is in uppercase; rather, it is a CONSTANT.
> Constants are values that remain unchanged throughout the program's execution. 
> In contrast, the variable 'servers' introduced below is mutable and will have its content modified later in the program.

### Create (Initialize) an array

```
servers = []
```

### Loop to fill the array
<details><summary>Check how here</summary>
<p>

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
</p></details>

### Create the VM
<details><summary>Check how here</summary>
<p>

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

</p></details>

> [!NOTE]
> You can now attempt to establish connections to each server, verify their hostname, IP, etc.
> Additionally, verify if they can successfully ping each other.

<details><summary>## FULL Vagrant File</summary>
<p>

```ruby
# Define the number of servers
num_servers = 3

# Initialize an empty array to store server configurations
servers = []

# Loop through to create server configurations
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

</p></details>