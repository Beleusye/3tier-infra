module "seoul_rds" {
    source = "../modules/rds"

    region = "ap-northeast-2"
    db_instance_type = "db.t3.micro"
    db_engine = "mysql"
    db_engine_version = "8.0"
    db_storage_size = "200"
    db_name = "petclinic"
    db_user = "petclinic"
    db_password = "petclinic"
}