resource "aws_iam_role" "magento-instance-role" {
  name               = "magento-instance-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_instance_profile" "magento-instance-role-instanceprofile" {
  name = "magento-instance-role"
  role = aws_iam_role.magento-instance-role.name
}

resource "aws_iam_role_policy" "magento-instance-policy" {
  name   = "magento-instance-policy"
  role   = aws_iam_role.magento-instance-role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
         "Effect":"Allow",
         "Action":[
            "s3:ListBucket"
         ],
         "Resource":["${aws_s3_bucket.media-bucket.arn}","${aws_s3_bucket.static-bucket.arn}"]
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:PutObject",
            "s3:GetObject",
            "s3:DeleteObject"
         ],
         "Resource":["${aws_s3_bucket.media-bucket.arn}","${aws_s3_bucket.static-bucket.arn}"]
      }
    ]
}
EOF

}
