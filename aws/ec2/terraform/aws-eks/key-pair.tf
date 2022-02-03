resource "aws_key_pair" "access_key" {
  key_name = "zsapkagy-ec2-key"
  public_key = file(var.aws_key_pair_public_key_file_path)
}