provider "ibm" {
  region           = var.region
  ibmcloud_timeout = 60
}

// resource group
resource "ibm_resource_group" resource_group {
  name = var.resource_group
  tags = var.tags
}

//vpc
resource "ibm_is_vpc" "vnf_vpc" {
  name           = "${var.prefix}-vpc"
  resource_group = ibm_resource_group.resource_group.id
  tags           = var.tags
}

//security group
resource "ibm_is_security_group" "vnf_security_group" {
  name           = "${var.prefix}-vpc-sg"
  vpc            = ibm_is_vpc.vnf_vpc.id
  resource_group = ibm_resource_group.resource_group.id
}

//security group rule to allow ssh all for management
resource "ibm_is_security_group_rule" "vnf_sg_allow_ssh" {
  depends_on = [ibm_is_security_group.vnf_security_group]
  group      = ibm_is_security_group.vnf_security_group.id
  direction  = "inbound"
  remote     = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}

//security group rule to allow https all for management
resource "ibm_is_security_group_rule" "vnf_sg_rule_in_all" {
  depends_on = [ibm_is_security_group_rule.vnf_sg_allow_ssh]
  group      = ibm_is_security_group.vnf_security_group.id
  direction  = "inbound"
  remote     = "0.0.0.0/0"
  tcp {
    port_min = 443
    port_max = 443
  }
}
