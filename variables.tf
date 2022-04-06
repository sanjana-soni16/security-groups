variable "region" {
  description = "Enter the region"
  type        = string
  default     = "us-south"
}

variable "resource_group" {
  description = "Enter the name of Resource Group"
  type        = string
  default     = "fvt-resources-test-rg"
}

variable prefix {
  description = "A unique identifier need to provision resources. Must begin with a letter"
  type        = string
  default     = "fvt-resources-test"
}

variable "tags" {
  description = "A list of tags to be added to resources"
  type        = list(string)
  default     = ["fvt-test", "ibm-resources"]
}