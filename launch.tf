resource "aws_launch_template" "launch" {
  name_prefix                   = "launch"
  image_id               = "${data.aws_ami.centos.id}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.security.id}"]
  user_data = "${base64encode(data.template_file.init.rendered)}"
}