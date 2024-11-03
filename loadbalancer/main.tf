module "seoul_lb" {
    source = "../modules/loadbalancer"

    region = "ap-northeast-2"
    health_path = "/index.html"
}