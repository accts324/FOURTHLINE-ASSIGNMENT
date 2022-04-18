locals {

  ingress = {
    controller = {
      service = {
        externalTrafficPolicy    = "Local"
        type                     = "LoadBalancer"
        loadBalancerSourceRanges = ["10.0.0.0/8", "100.65.0.0/16", "172.16.0.0/12"]
        enableHttps              = true
        enableHttp               = true
      }
      config = {
        "server-name-hash-bucket-size" = "256"
        "server-tokens"                = "false"
        "use-proxy-protocol"           = "false"
        "use-forwarded-headers"        = "true"
        "proxy-real-ip-cidr"           = join(",", ["10.0.0.0/8"])
      }

      proxySetHeaders = {
        "Referrer-Policy" = "strict-origin-when-cross-origin"
      }

      extraArgs = {
        "enable-ssl-chain-completion" = "false"
        "default-ssl-certificate"     = "cert-manager/internal-ingress-wildcard-cert"
      }

      nodeSelector = {
        "lnrs.io/tier" = "ingress"
      }
      tolerations = [
        {
          key      = "ingress"
          operator = "Equal"
          value    = "true"
          effect   = "NoSchedule"
        }
      ]
    }
  }
}
