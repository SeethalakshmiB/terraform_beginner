resource "aws_s3_bucket" "example" {
  count = 0
    //if var.env is dev --> 1 (non zero), else 0
    // 
  bucket = "my-tf-test-bucket"
}


# condition yes/no
# dev, qa,...
# only in dev, any other envs --> no s3

# iteration 
# create n number of s3 only name can vary 

variable "list_buckets" {
    type = list(string)
    description = "list of buckets for website or logs"
    default = [ "bucket-1", "bucket-2", "bucket-3", "bucket-4" ]
}

resource "aws_s3_bucket" "bucket1" {
    name = "bucket-1"
}

resource "aws_s3_bucket" "bucket2" {
    name = "bucket-2"
}

resource "aws_s3_bucket" "bucket3" {
    name = "bucket-3"
}

resource "aws_s3_bucket" "buckets" {
     # lenge of list_buckets is 3 here
    count = length(var.list_buckets)  
    name = var.list_buckets[count]
}
count --> 0, 1, 2