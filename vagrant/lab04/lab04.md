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

* Create the vm based on the variables and try it
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
