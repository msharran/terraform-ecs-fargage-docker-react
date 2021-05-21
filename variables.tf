#AWS
variable "domain" {
  description = "Domain name of the app"
  default     = "example.com"
}

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "ap-south-1"
}

variable "aws_az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "aws_credentials_profile" {
  description = "The Profile of AWS credentials file"
  default     = "sharran"
}

variable "aws_cidr" {
  description = "Cidr block"
  default     = "10.0.0.0/16"
}

variable "aws_public_subnets" {
  description = "List of all public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "lb_target_type" {
  description = "Target type of ALB"
  default     = "ip"
}

#ECS
variable "ecs_launch_type" {
  description = "Default ECS launch type: EC2/Fargate"
  default     = "FARGATE"
}

variable "ecs_container_def_path" {
  description = "Container definitions template file path"
  default     = "./templates/ecs/container-def.json.tpl"
}

variable "ecs_network_mode" {
  description = "Default network mode for ECS Fargate"
  default     = "awsvpc"
}

variable "ecs_container_name" {
  description = "Name of ECS Task Definition"
  default     = "admin"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_desired_count" {
  description = "Number of docker containers to run"
  default     = 1
}

#Fargate
variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

#Fargate vCPU & Memory Table
//CPU value	Memory value (MiB)
//256 (.25 vCPU)	512 (0.5GB), 1024 (1GB), 2048 (2GB)
//512 (.5 vCPU)	1024 (1GB), 2048 (2GB), 3072 (3GB), 4096 (4GB)
//1024 (1 vCPU)	2048 (2GB), 3072 (3GB), 4096 (4GB), 5120 (5GB), 6144 (6GB), 7168 (7GB), 8192 (8GB)
//2048 (2 vCPU)	Between 4096 (4GB) and 16384 (16GB) in increments of 1024 (1GB)
//4096 (4 vCPU)	Between 8192 (8GB) and 30720 (30GB) in increments of 1024 (1GB)