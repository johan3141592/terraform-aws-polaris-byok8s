resource "aws_autoscaling_group" "cluster" {
  name                = "${var.name_prefix}-autoscaling-group"
  min_size            = 1
  max_size            = var.autoscaling_max_size
  desired_capacity    = 1
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.worker.id
    version = "$Latest"
  }
}
