resource "aws_iam_policy" "bucket_policy" {
  name        = "s3-bucket-policy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:ListBucket",
        ],
        "Resource" : "*"      
      }
    ]
  })
}

resource "aws_iam_role" "iam_role" {
  name = "s3_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_bucket_policy" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

resource "aws_iam_instance_profile" "some_profile" {
  name = "ec2-profile"
  role = aws_iam_role.iam_role.name
}
