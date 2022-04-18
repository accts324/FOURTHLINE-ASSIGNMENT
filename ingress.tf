

module "nginx-controller" {
  depends_on = [
    module.eks
  ]
  source             = "terraform-iaac/nginx-controller/helm"
  version            = "2.0.2"
  ingress_class_name = "ingress-public"
  additional_set = [
    {
      name  = "ingress"
      value = "true"
      type  = "string"
    }
  ]
}



/*
resource "helm_release" "nginx" {
  name             = var.helm_release_name
  namespace        = var.kubernetes_namespace
  repository       = var.helm_repository
  chart            = "ingress-nginx"
  version          = var.helm_chart_version
  verify           = false
  create_namespace = var.kubernetes_create_namespace

  values = [
    yamlencode({
      controller = {
        replicaCount = var.replica_count
        ingressClass = var.ingress_class
        publishService = {
          enabled      = true
          pathOverride = "${var.kubernetes_namespace}/${var.helm_release_name}-ingress-nginx-controller"
        }
        config = {
          ssl-redirect = var.enable_default_tls
        }
        service = {
          loadBalancerIP = var.load_balancer_ip
          annotations = var.ingress_type == "Internal" ? {
            "service.beta.kubernetes.io/azure-load-balancer-internal" : "true"
          } : {}
        }
      }
    }),
    yamlencode(local.ingress)
  ]
}

*/