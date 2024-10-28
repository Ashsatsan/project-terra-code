resource "kubernetes_service_account" "kasten_k10_sa" {
  metadata {
    name      = "kasten-k10-sa"
    namespace = "kasten-io"  # Default namespace for Kasten
  }

  automount_service_account_token = true

  depends_on = [
    helm_release.kasten_k10
  ]
}

resource "kubernetes_role_binding" "kasten_k10_binding" {
  metadata {
    name      = "kasten-k10-binding"
    namespace = "kasten-io"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.kasten_k10_sa.metadata[0].name
    namespace = "kasten-io"
  }
}
