#module "ec2_instance" {
#  source        = "../aws/ec2"
#  ami           = "ami-05edb7c94b324f73c"
#  name          = "Rodriguezec2Module"
#  instance_type = "t3.micro"
#  subnet_id     = "subnet-02dbf55cf4ab64fc4"
#  env_type      = "PROD"
#  port          = 8080
#}

resource "aws_instance" "ec2" {
  #  ami           = "ami-05edb7c94b324f73c"
  #  instance_type = "t3.micro"
  #  subnet_id     = "subnet-02dbf55cf4ab64fc4"

  count = 3
  ami   = element(var.amis, count.index)

  instance_type = "t3.micro"
  tags          = { Name = "${var.name}-${count.index}" }
  subnet_id     = "subnet-02dbf55cf4ab64fc4"
}
#  tags = {
#    Name        = each.value
#    environment = "DEV"
#  }
#  for_each = toset(var.names)
#}

#variable "names" {
#  type    = list(string)
#  default = ["Rodwebapp_1", "Rodwebapp_2", "Rodwebapp_3"]
#}

variable "name" {
  type        = string
  description = "Le nom de l'instance EC2"
  default     = "ec2RodriguezTerraform"
}

variable "instance_type" {
  type        = string
  description = "Le type de l'instance"
  default     = "t3.micro"
}

variable "subnet_id" {
  type        = string
  description = "Le subnet"
  default     = "subnet-02dbf55cf4ab64fc4"
}

variable "env_type" {
  type        = string
  description = "L'environnement"
  default     = "dev"
}

variable "port" {
  type        = number
  description = "Numéro de port"
  default     = "80"
}

terraform {
backend "s3" {
bucket = "terraform-remote-state-form-rod"
key = "tfstate/my_terraform.tfstate"
region = "eu-north-1"
encrypt = true
dynamodb_table = "terraform-rod-lock"
}
}

variable "amis" {
  description = "amis des instances EC2"
  type        = list(any)
  default     = ["ami-05edb7c94b324f73c", "ami-05edb7c94b324f73c", "ami-05edb7c94b324f73c"]
}


