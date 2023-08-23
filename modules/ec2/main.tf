resource "aws_instance" "this" {
  ami                    = data.aws_ami.amzLinux.id
  instance_type          = var.ec2_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.this.id]
  user_data              = base64encode(data.template_file.user_data.rendered)
  key_name               = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.this.name
  root_block_device {
    encrypted = true
  }
  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "this" {
  name   = "${var.name}-ssh-allowed"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks
  }
  tags = {
    Name = "${var.name}-ssh-allowed"
  }
}

################################################################################
# IAM INSTANCE PROFILE
################################################################################

resource "aws_iam_role" "this" {
  name               = "${var.name}_iam_instance_profile"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.name}_iam_instance_profile"
  role = aws_iam_role.this.name
}

data "aws_iam_policy" "this" {
  name = "AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "jumphost" {
  role       = aws_iam_role.this.name
  policy_arn = data.aws_iam_policy.this.arn
}