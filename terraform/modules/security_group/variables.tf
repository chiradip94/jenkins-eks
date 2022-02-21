variable "sg_name" {
  description = "Name of the SG"
  type        = string
  default     = ""
}

variable "security_group_description" {
  description = "Description of the SG"
  type        = string
  default     = ""
}

variable "vpc_id" {
  type        = string
  default     = ""
}

variable "security_group_rules" {
  type        = map(map(string))
  default     = {}
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {}
}
