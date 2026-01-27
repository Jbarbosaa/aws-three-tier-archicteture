module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.17.0"

  name = "${var.environment}-alb"
  vpc_id = module.vpc.vpc_id
  load_balancer_type = "application"

  #ALB Subnets and Security Groups
  subnets = module.vpc.public_subnets
  security_groups = [module.alb_security_group.security_group_id]
  internal = false
  
  enable_deletion_protection = false

  #Target group configuration
  target_groups = {

    app = {

      name_prefix = "app-tg"
      port        = 80
      protocol    = "HTTP"
      target_type = "instance"

      health_check = {
        path                = "/app1/index.html"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200-399"
      }

      stickiness = {
        enabled = false
        type = "lb_cookie"
      }

      create_attachment = false
    }
  }

# Listeners for the ALB
# If ACM certificate ARN is not provided, create an HTTP listener only
  listeners = merge(
    {
      http = {
        port     = 80
        protocol = "HTTP"
        redirect = var.acm_certificate_arn != null ? {
          port        = "443"
          protocol    = "HTTPS"
          status_code = "HTTP_301"
        } : null

        forward = var.acm_certificate_arn == null ? {
          target_group_key = "app"
        } : null
      }
    },
    var.acm_certificate_arn != null ? {
      https = {
        port            = 443
        protocol        = "HTTPS"
        certificate_arn = var.acm_certificate_arn
        ssl_policy      = "ELBSecurityPolicy-2016-08"
        forward         = { target_group_key = "app" }
      }
    } : {}
  )
  
#Attach all ec2 instances to the target group
  additional_target_group_attachments = {
    for id in local.app_instance_ids : "app-${id}" => {
      target_group_key = "app"
      target_id        = id
      port             = 80
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-alb"
    }
  )
}
