terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
  }
}

# NGINX Ingress Controller
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-basic"
  create_namespace = true
  
  set {
    name  = "controller.replicaCount"
    value = var.nginx_replicas
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
    value = "/healthz"
  }
}

# Cert Manager
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "cert-manager"
  create_namespace = true
  version    = var.cert_manager_version

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [helm_release.nginx_ingress]
}

# ClusterIssuer for Let's Encrypt
resource "kubectl_manifest" "cluster_issuer" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    server: ${var.acme_server}
    email: ${var.acme_email}
    privateKeySecretRef:
      name: letsencrypt
    solvers:
    - http01:
        ingress:
          class: nginx
YAML

  depends_on = [helm_release.cert_manager]
}

# Create custom namespace
resource "kubernetes_namespace" "custom_namespace" {
  metadata {
    name = var.namespace_name
    labels = {
      environment = var.environment
      managed-by  = "terraform"
    }
  }
}

# MongoDB Helm Release
resource "helm_release" "mongodb" {
  name             = "mongodb"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "mongodb"
  namespace        = kubernetes_namespace.custom_namespace.metadata[0].name
  version          = var.mongodb_chart_version
  create_namespace = false

  values = [
    <<-EOT
    architecture: standalone
    auth:
      enabled: true
      rootPassword: "${var.mongodb_root_password}"
      username: "${var.mongodb_username}"
      password: "${var.mongodb_password}"
      database: "${var.mongodb_database}"
    
    persistence:
      enabled: true
      size: ${var.mongodb_storage_size}
    
    resources:
      requests:
        memory: "${var.mongodb_memory_request}"
        cpu: "${var.mongodb_cpu_request}"
      limits:
        memory: "${var.mongodb_memory_limit}"
        cpu: "${var.mongodb_cpu_limit}"
    
    metrics:
      enabled: true
    
    nodeSelector: {}
    tolerations: []
    affinity: {}
    EOT
  ]
}