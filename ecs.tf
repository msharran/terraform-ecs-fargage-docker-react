resource "aws_ecs_cluster" "admin_cluster" {
  name = var.ecs_cluster_name
}

data "template_file" "container_definitions" {
  template = file(var.ecs_container_def_path)

  vars = {
    ecs_network_mode      = var.ecs_network_mode
    cloud_watch_log_group = var.cloud_watch_log_group_path
    ecs_container_name    = var.ecs_container_name
    app_image             = var.app_image
    app_port              = var.app_port
    fargate_cpu           = var.fargate_cpu
    fargate_memory        = var.fargate_memory
    aws_region            = var.aws_region
  }
}

resource "aws_ecs_task_definition" "admin_task_def" {
  family                   = var.ecs_task_def_name
  network_mode             = var.ecs_network_mode
  requires_compatibilities = [var.ecs_launch_type]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.container_definitions.rendered
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "admin-service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.admin_cluster.id
  task_definition = aws_ecs_task_definition.admin_task_def.arn
  desired_count   = var.app_desired_count
  launch_type     = var.ecs_launch_type

  network_configuration {
    security_groups  = [aws_security_group.admin_tasks_sg.id]
    subnets          = aws_default_subnet.default_azs.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.admin_lb_target_grp.arn
    container_name   = var.ecs_container_name
    container_port   = var.app_port
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role, aws_lb_listener.admin_lb_listener]
}