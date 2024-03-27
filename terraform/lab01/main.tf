# Configure the Azure provider
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
terraform {

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # https://developer.hashicorp.com/terraform/language/expressions/version-constraints
      version = "3.95.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }

  #https://developer.hashicorp.com/terraform/language/settings
  required_version = ">= 1.1.0"
}

resource "azurerm_resource_group" "ansible_group" {
  name = var.group_name
  # Where find those location ? https://github.com/claranet/terraform-azurerm-regions/blob/master/REGIONS.md 
  location = var.group_location
}

resource "azurerm_virtual_network" "vnet_ansible" {
  name                = "vnet_ansible"
  resource_group_name = var.group_name
  address_space       = ["10.0.0.0/16"]
  location            = var.group_location
  depends_on          = [azurerm_resource_group.ansible_group]
}

resource "azurerm_subnet" "subnet_ansible" {
  name                 = "subnet_ansible_internal"
  resource_group_name  = var.group_name
  virtual_network_name = azurerm_virtual_network.vnet_ansible.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on           = [azurerm_resource_group.ansible_group]
}

resource "azurerm_network_interface" "nic_ansible_node" {
  count               = var.node_count
  name                = "nic_ansible_node_${count.index}"
  resource_group_name = var.group_name
  location            = var.group_location
  ip_configuration {
    name                          = "nic_node_${count.index}_config"
    subnet_id                     = azurerm_subnet.subnet_ansible.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pubip_node_serve[count.index].id
  }
  depends_on = [azurerm_resource_group.ansible_group]
}

resource "azurerm_public_ip" "pubip_node_serve" {
  count               = var.node_count
  name                = "pubip_node_${count.index}"
  resource_group_name = var.group_name
  location            = var.group_location
  allocation_method   = "Static"

  tags = {
    environment = "Lab01"
  }
  depends_on = [azurerm_resource_group.ansible_group]
}

resource "azurerm_network_interface" "nic_ansible_controller" {
  name                = "nic_ansible_controller"
  resource_group_name = var.group_name
  location            = var.group_location
  ip_configuration {
    name                          = "nic_controller_config"
    subnet_id                     = azurerm_subnet.subnet_ansible.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pubip_controller.id
  }
}



resource "azurerm_public_ip" "pubip_controller" {
  name                = "pubip_controller"
  resource_group_name = var.group_name
  location            = var.group_location
  allocation_method   = "Static"

  tags = {
    environment = "Lab01"
  }
  depends_on = [azurerm_resource_group.ansible_group]
}

#####################
# SSH KEY
#####################
resource "tls_private_key" "ssh_key_linux_openssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#####################
# SSH KEY - EXPORT
#####################
resource "local_file" "export_private_key" {
  content    = tls_private_key.ssh_key_linux_openssh.private_key_pem
  filename   = "priv.pem"
  depends_on = [tls_private_key.ssh_key_linux_openssh]
}

resource "local_file" "export_public_key" {
  content    = tls_private_key.ssh_key_linux_openssh.public_key_openssh
  filename   = "public.pub"
  depends_on = [tls_private_key.ssh_key_linux_openssh]
}

resource "azurerm_linux_virtual_machine" "nodecontroller" {
  name                = "nodecontroller"
  resource_group_name = var.group_name
  location            = var.group_location
  size                = "Standard_DS1_v2"
  admin_username      = "rooty"
  admin_password      = "P@ssw0rd!123"
  #disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.nic_ansible_controller.id
  ]

  os_disk {
    name                 = "NodeControlDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "rooty"
    public_key = tls_private_key.ssh_key_linux_openssh.public_key_openssh
  }
}

resource "azurerm_linux_virtual_machine" "nodes" {
  count                           = var.node_count
  name                            = "node-${var.node_names[count.index]}${format("%02d", count.index + 1)}"
  resource_group_name             = var.group_name
  location                        = var.group_location
  size                            = "Standard_DS1_v2"
  admin_username                  = "rooty"
  admin_password                  = "P@ssw0rd!123"
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.nic_ansible_node[count.index].id
  ]

  os_disk {
    name                 = "node${count.index}Disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "rooty"
    public_key = tls_private_key.ssh_key_linux_openssh.public_key_openssh
  }
}

#########################
# Ansible SecGroup
#########################
resource "azurerm_network_security_group" "ansible_security_group" {
  name                = "ansible_security_group"
  location            = var.group_location
  resource_group_name = var.group_name
  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = azurerm_subnet.subnet_ansible.address_prefixes[0]
  }
  security_rule {
    name                       = "HTTP"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    env = "prod"
  }
  depends_on = [azurerm_resource_group.ansible_group]
}

resource "azurerm_network_interface_security_group_association" "ansible_sga_controller" {
  network_interface_id      = azurerm_network_interface.nic_ansible_controller.id
  network_security_group_id = azurerm_network_security_group.ansible_security_group.id
}

resource "azurerm_network_interface_security_group_association" "ansible_sga_nodes" {
  for_each = { for idx, nic in azurerm_network_interface.nic_ansible_node : idx => nic }

  network_interface_id      = each.value.id
  network_security_group_id = azurerm_network_security_group.ansible_security_group.id
}




