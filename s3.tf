resource "aws_s3_bucket" "my_bucket" {
    bucket = "charu-tf-bucket"
    tags = {
      name = "charu-tf-bucket"
    }
  
}