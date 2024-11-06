resource "aws_db_instance" "infra_rds" {
    allocated_storage = var.db_storage_size
    engine = var.db_engine
    engine_version = var.db_engine_version
    instance_class = var.db_instance_type
    db_subnet_group_name = "rds_main"
    iops = "1000"
    vpc_security_group_ids = [data.terraform_remote_state.security_group.outputs.rds_sg_id]
    multi_az = true

    db_name = var.db_name
    username = var.db_user
    password = var.db_password
    skip_final_snapshot = true
    identifier = var.identifier
    
    depends_on = [aws_db_subnet_group.rds_subnet_group]
}

resource "aws_db_subnet_group" "rds_subnet_group" {
    name = "rds_main"
    subnet_ids = [for i in [4,5] : data.terraform_remote_state.vpc.outputs.private_subnet_ids[i]]
    description = "3 tier infra RDS subnet group"

    tags = {
        Name = "rds-subnet-group"
    }
}