resource "aws_key_pair" "proj1" {
  key_name   = "project1"
  public_key = file(var.Pub_key_path)
}
