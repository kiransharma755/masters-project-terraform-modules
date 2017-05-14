data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_ec2" {
  name               = "${var.name}-${var.env}-ecs-for-ec2"
  assume_role_policy = "${data.aws_iam_policy_document.ecs_assume_role.json}"
}

data "aws_iam_policy_document" "ecs-ec2" {
  statement {
    actions = [
      "ecs:CreateCluster",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:Submit*",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "ecs-ec2" {
  name   = "${var.name}-${var.env}-ecs-for-ec2-policy"
  role   = "${aws_iam_role.ecs_ec2.id}"
  policy = "${data.aws_iam_policy_document.ecs-ec2.json}"
}
