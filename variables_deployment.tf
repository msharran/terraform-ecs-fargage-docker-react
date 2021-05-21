//Inputs
variable "sub_domain" {
  description = "Required sub-domain"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
}

//Names or tags
variable "ecs_cluster_name" {
  description = "Name of ECS Cluster"
  default     = "dev-cluster"
}

variable "ecs_service_name" {
  description = "Name of ECS Service"
  default     = "dev-admin-service"
}

variable "ecs_task_def_name" {
  description = "Name of ECS Task"
  default     = "dev-admin-task-def"
}

variable "cloud_watch_log_group_path" {
  description = "Path of log group"
  default     = "/ecs/dev-admin"
}

variable "cloud_watch_log_group_tag" {
  description = "Name of log group"
  default     = "dev-admin-log-group"
}

variable "cloud_watch_log_stream_name" {
  description = "Name of log stream"
  default     = "dev-admin-log-stream"
}

variable "sg-alb" {
  default = "dev_admin_alb_sg"
}

variable "sg-ecs-tasks" {
  default = "dev_admin_tasks_sg"
}

variable "alb" {
  default = "dev-admin-ecs-lb"
}

variable "target-grp" {
  default = "dev-admin-target-grp"
}