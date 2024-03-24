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
> You should see how to create a seconde one, right ?

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