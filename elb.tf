resource "aws_elb" "load" {
  name               = "load"
  availability_zones = ["us-east-1a"]

  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "tcp:80"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 20
  connection_draining         = true
  connection_draining_timeout = 20

  tags = {
    Name = "foobar-terraform-elb"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.asg.id}"
  elb                    = "${aws_elb.load.id}"
}
