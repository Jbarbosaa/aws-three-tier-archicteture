variable "acm_certificate_arn" {
  type        = string
  description = "ARN do certificado ACM usado pelo listener HTTPS do ALB"
  default     = null
}