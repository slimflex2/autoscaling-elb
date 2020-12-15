resource "aws_autoscaling_group" "asg" {
  desired_capacity = 1
  max_size         = 5
  min_size         = 1

  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = "${aws_launch_template.launch.id}"
      }

      override {
        instance_type     = "t2.micro"
        weighted_capacity = "3"
      }

      override {
        instance_type     = "t3.micro"
        weighted_capacity = "2"
      }
    }
  }
}
