resource "aws_autoscaling_group" "xl_asg" {
    name = "xl-autoscaling"
    min_size = 2
    max_size = 4
    health_check_type = "EC2"
    vpc_zone_identifier = [aws_subnet.public_subnet.id, aws_subnet.public_subnet1.id]
    target_group_arns =  [aws_alb_target_group.alb_tg.arn]

    launch_template {
      id = aws_launch_template.launchtemp.id
    }
}

resource "aws_autoscaling_policy" "xl_asg_policy" {
    autoscaling_group_name = aws_autoscaling_group.xl_asg.id
    name = "xl-asg-policy"
    scaling_adjustment = 1 
    adjustment_type = "ChangeInCapacity"
}

resource "aws_launch_template" "launchtemp" {
    name_prefix = "launchtemp"
    image_id = "ami-0df24e148fdb9f1d8"
    instance_type = "t3.micro"
}