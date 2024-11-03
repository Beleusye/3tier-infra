module "seoul_lb" {
    source = "../modules/loadbalancer"

    region = "ap-northeast-2"
    http_port = 80
    https_port = 443
    was_port = 8080
    alb_health_path = "/health"
    nlb_health_path = "/health"
}