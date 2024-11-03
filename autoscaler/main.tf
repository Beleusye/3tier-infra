module "seoul_autoscale" {
    source = "../modules/autoscaler"

    region = "ap-northeast-2"
    max_size = 3
    min_size = 0
    capacity = 2

}