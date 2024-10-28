/*resource "helm_release" "kasten_k10" {
  name       = "kasten-io"
  repository = "https://charts.kasten.io/stable"
  chart      = "k10"

  set {
    name  = "global.k10.kasten.io"
    value = "enabled"
  }

  set {
    name  = "global.k10.kasten.io.storage"
    value = "s3"
  }

  set {
    name  = "global.k10.kasten.io.s3.bucket"
    value = var.s3
  }

  set {
    name  = "global.k10.kasten.io.s3.region"
    value = var.region
  }

  set {
    name  = "global.k10.kasten.io.k8sServiceAccount"
    value = "kasten-k10-sa"
  }

  depends_on = [
    aws_eks_cluster.my_eks,
    aws_iam_role.kasten_k10_role
  ]
}*/