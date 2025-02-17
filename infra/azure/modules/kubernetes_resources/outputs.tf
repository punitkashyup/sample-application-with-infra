output "nginx_ingress_ip" {
  value       = data.kubernetes_service.nginx_ingress.status.0.load_balancer.0.ingress.0.ip
  description = "The IP address of the NGINX ingress controller"
  depends_on  = [helm_release.nginx_ingress]
}

# Data source to get the NGINX Ingress public IP
data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "nginx-ingress-ingress-nginx-controller"
    namespace = "ingress-basic"
  }
  depends_on = [helm_release.nginx_ingress]
}