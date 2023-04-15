variable "App" {
  type    = string
  default = "Trender"
}

variable "Environment" {
  type    = string
}

variable "EnbaleThreeAzs" {
  type        = bool
  description = "If this set to true, the scrip will create 3 availablity zones and related components"
  default     = false
}
variable "CidrBlock" {
  type = string
}

variable "PublicSubnet1_Block" {
  type = string
}

variable "AzPublicSubnet1" {
  type = string
}

variable "PublicSubnet2_Block" {
  type = string
}

variable "AzPublicSubnet2" {
  type = string
}

variable "PublicSubnet3_Block" {
  type = string
  default = null
}

variable "AzPublicSubnet3" {
  type = string
  default = null
}

variable "PrivateSubnet1_Block" {
  type = string
}

variable "AzPrivateSubnet1" {
  type = string
}

variable "PrivateSubnet2_Block" {
  type = string
}

variable "AzPrivateSubnet2" {
  type = string
}

variable "PrivateSubnet3_Block" {
  type = string
  default = null
}

variable "AzPrivateSubnet3" {
  type = string
  default = null
}