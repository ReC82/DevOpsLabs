variable "group_name" {
  description = "group name of the lab"
  default     = "ansible_group"
}

variable "group_location" {
  default = "centralus"
}

variable "node_count" {
  default = 2
}

variable "node_names" {
  description = "Map of node names"
  type        = map(string)
  default = {
    0 = "web"
    1 = "db"
    2 = "api"
  }
}

variable "security_groups" {
  description = "Map of Security Groups"
  type        = map(string)
  default = {
    0 = "web"
    1 = "database"
    2 = "control"
  }
}

#variable "lab_ansible_01" {
#  description = "group name of the lab"
#  default     = file("sublab_ansible/lab01/pb2.yaml")
#}

