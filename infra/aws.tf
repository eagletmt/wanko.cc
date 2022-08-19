provider "aws" {
  region = "ap-northeast-1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "use1"
}

terraform {
  backend "s3" {
    bucket = "terraform-wanko-cc"
    key    = "wanko.cc.tfstate"
    region = "ap-northeast-1"
  }
}
