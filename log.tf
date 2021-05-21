resource "aws_cloudwatch_log_group" "admin_log_group" {
  name              = var.cloud_watch_log_group_path
  retention_in_days = 30

  tags = {
    Name = var.cloud_watch_log_group_tag
  }
}

resource "aws_cloudwatch_log_stream" "admin_log_stream" {
  name           = var.cloud_watch_log_stream_name
  log_group_name = aws_cloudwatch_log_group.admin_log_group.name
}