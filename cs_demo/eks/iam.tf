resource "aws_iam_role" "this_eks" {
  name_prefix = "${var.name}-"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCurrentUser"
        Effect = "Allow"
        Principal = {
          AWS = tolist(data.aws_iam_roles.this.arns)[0]
        }
        Action = "sts:AssumeRole"
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = [
            "eks.amazonaws.com",
            "pods.eks.amazonaws.com"
          ]
        }
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "this_eks" {
  role       = aws_iam_role.this_eks.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}