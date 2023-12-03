resource "aws_iam_user_login_profile" "DB_user" {
  count                   = length(var.username)
  user                    = aws_iam_user.eks_user[count.index].name
  password_reset_required = true
  # pgp_key                = "keybase:my"  # PGP key can be uncommented and configured if needed
}


resource "aws_iam_user" "eks_user" {
  count         = length(var.username)
  name          = element(var.username, count.index)
  force_destroy = true

  tags = {
    Department = "eks-user"
  }
}


# master group ( this how to create group && add users in the group )
resource "aws_iam_group" "eks_masters" {
  name = "masters"
}


resource "aws_iam_group" "eks_developer" {
  name = "Developer"

}
resource "aws_iam_group_policy" "masters_policy" {
  name   = "masters"
  group  = aws_iam_group.eks_masters.name
  policy = data.aws_iam_policy_document.masters.json
}

resource "aws_iam_group_membership" "masters_team" {
  name  = "masters-group-membership"
  users = /*[for user in aws_iam_user.eks_user : user.name]*/ [aws_iam_user.eks_user[0].name, aws_iam_user.eks_user[1].name, aws_iam_user.eks_user[2].name]
  group = aws_iam_group.eks_masters.name
}



resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true

}


# The role to be assumed only by the group called masters ## this the group am attaching as the principle on assume_role ... 
resource "aws_iam_role" "masters" {
  name               = "masters-eks-Role"
  assume_role_policy = data.aws_iam_policy_document.masters_assume_role.json # this the policy
}


resource "aws_iam_role_policy_attachment" "admin_policy" {
  role       = aws_iam_role.masters.name
  policy_arn = aws_iam_policy.eks_admin.arn
}

resource "aws_iam_policy" "eks_admin" {
  name   = "eks-masters"
  policy = data.aws_iam_policy_document.masters.json
}

#resource "aws_iam_role_policy_attachment" "admin_policy_detach" {
  #role       = aws_iam_role.masters.name
 # policy_arn = "YOUR_POLICY_ARN_HERE" # Replace with the ARN of the policy you want to detach
#}
