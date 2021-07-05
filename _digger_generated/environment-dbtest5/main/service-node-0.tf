

  module "service-node-0" {
    source = "git::https://github.com/diggerhq/module-fargate-service.git?ref=v1.0.8"

    ecs_cluster = aws_ecs_cluster.app
    service_name = "node-0"
    region = var.region
    service_vpc = local.vpc
    service_security_groups = [aws_security_group.ecs_service_sg.id]
    # image_tag_mutability
    lb_subnet_a = aws_subnet.public_subnet_a
    lb_subnet_b = aws_subnet.public_subnet_b
    # lb_port
    # lb_protocol
    internal = false
    # deregistration_delay
    health_check = "/"
    # health_check_interval
    # health_check_timeout
    # health_check_matcher
    # lb_access_logs_expiration_days
    container_port = "8080"
    # replicas
    container_name = "buildtest0-dbtest5-node-0"
    launch_type = "FARGATE"
    # ecs_autoscale_min_instances
    # ecs_autoscale_max_instances
    default_backend_image = "quay.io/turner/turner-defaultbackend:0.2.0"
    tags = var.tags

    


    # for *.dggr.app listeners
    
      dggr_acm_certificate_arn = "arn:aws:acm:us-east-1:682903345738:certificate/253ba372-8836-4078-a447-5fdd57518e6a"
    


    task_cpu = "256" 
    task_memory = "512" 
  }

  


  # *.dggr.app domains
   
    resource "aws_route53_record" "node-0_dggr_r53" {
      provider = aws.digger
      zone_id = "Z01023802GBWXW1MRJGTO"
      name    = "buildtest0-dbtest5-node-0.dggr.app"
      type    = "A"

      alias {
        name                   = module.service-node-0.lb_dns
        zone_id                = module.service-node-0.lb_zone_id
        evaluate_target_health = false
      }
    }

    output "node-0_dggr_domain" {
        value = aws_route53_record.node-0_dggr_r53.fqdn
    }
  

  output "node-0_docker_registry" {
    value = module.service-node-0.docker_registry
  }

  output "node-0_lb_dns" {
    value = module.service-node-0.lb_dns
  }

  output "node-0" {
    value = ""
  }


