# Challenge Extra 2: Terraform-based Kubernetes Cluster Deployment

## Overview

This project demonstrates the deployment of a Kubernetes cluster using Terraform. It includes the creation of namespaces, deployments, services, and sample pods.

## Prerequisites

- Terraform v1.15+
- `kubectl` and `minikube` installed: `minikube` is running on docker driver

## Review configuration
- The example configuration in this repository creates a minikube Kubernetes cluster instance through resources and local and modules that deploys namespaces, deployments, services, and sample pods within 5 namespaces.
```bash
$ cd challenge-extra-2/terraform/

$ tree
.
├── environments
│   ├── dev
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   └── prod
│       ├── main.tf
│       ├── outputs.tf
│       ├── terraform.tfvars
│       └── variables.tf
├── main.tf
├── modules
│   ├── backend
│   │   ├── deployment.tf
│   │   ├── locals.tf
│   │   ├── output.tf
│   │   ├── pod.tf
│   │   ├── service.tf
│   │   └── variables.tf
│   ├── minikube
│   │   ├── main.tf
│   │   ├── output.tf
│   │   ├── providers.tf
│   │   └── variables.tf
│   └── namespaces
│       ├── ns.tf
│       ├── output.tf
│       └── variables.tf
├── output.tf
├── terraform.tfstate
└── variables.tf
```

### Initialize your configuration
- To generate our execution plan, we need to initialize the Terraform configuration. This will download the necessary provider plugins and set up the backend for state management.
```bash
terraform init
Initializing modules...
Initializing provider plugins found in the configuration...
- Reusing previous version of hashicorp/kubernetes from the dependency lock file
- Using previously-installed hashicorp/kubernetes v2.38.0

Initializing the backend...

Initializing provider plugins found in the state...
- Reusing previous version of hashicorp/kubernetes
- Using previously-installed hashicorp/kubernetes v2.38.0


Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### Create a plan
- To create an execution plan, run the following command:  
    As terraform plan generates the execution plan to the `tfplan` file, you can review the plan before applying it.

```terraform
$ terraform plan -out=tfplan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.backend.kubernetes_deployment.nginx will be created
  + resource "kubernetes_deployment" "nginx" {
      + id               = (known after apply)
      + wait_for_rollout = true

      + metadata {
          + generation       = (known after apply)
          + labels           = {
              + "app"        = "nginx"
              + "managed-by" = "terraform"
            }
          + name             = "nginx-deployment"
          + namespace        = "orcrist"
          + resource_version = (known after apply)
          + uid              = (known after apply)
        }
...
...
```

- Review the plan
Through the `tfplan` file, you can perform a detailed review of the proposed changes before applying them. This allows you to ensure that the changes align with your expectations and requirements.
As an example, you can use the following command to view the plan in a human-readable format:
```bash
$ terraform show tfplan
```
or using `jq`, you can filter specific information from the plan file.
```bash
jq '.terraform_version, .format_version' tfplan.json
"1.12.0"
"1.2"
```

### Apply the plan
- To apply the execution plan and create the resources, run the following command:
```terraform
$ terraform apply tfplan
module.namespaces.kubernetes_namespace.this["integration"]: Creating...
module.namespaces.kubernetes_namespace.this["orcrist"]: Creating...
module.namespaces.kubernetes_namespace.this["collector"]: Creating...
module.namespaces.kubernetes_namespace.this["tools"]: Creating...
module.namespaces.kubernetes_namespace.this["monitoring"]: Creating...
module.namespaces.kubernetes_namespace.this["tools"]: Creation complete after 0s [id=tools]
module.namespaces.kubernetes_namespace.this["orcrist"]: Creation complete after 0s [id=orcrist]
module.namespaces.kubernetes_namespace.this["collector"]: Creation complete after 0s [id=collector]
module.namespaces.kubernetes_namespace.this["integration"]: Creation complete after 0s [id=integration]
module.namespaces.kubernetes_namespace.this["monitoring"]: Creation complete after 0s [id=monitoring]
module.backend.kubernetes_service.nginx: Creating...
module.backend.kubernetes_pod.example_integration: Creating...
module.backend.kubernetes_pod.example_monitoring: Creating...
module.backend.kubernetes_pod.nginx_tools: Creating...
module.backend.kubernetes_pod.example_orcrist: Creating...
module.backend.kubernetes_service.nginx: Creation complete after 0s [id=orcrist/nginx-service]
module.backend.kubernetes_deployment.nginx: Creating...
module.backend.kubernetes_pod.example_orcrist: Creation complete after 6s [id=orcrist/pod-example-orcrist]
module.backend.kubernetes_pod.example_integration: Creation complete after 6s [id=integration/pod-example-integration]
module.backend.kubernetes_pod.example_monitoring: Still creating... [00m10s elapsed]
module.backend.kubernetes_pod.nginx_tools: Still creating... [00m10s elapsed]
module.backend.kubernetes_deployment.nginx: Still creating... [00m10s elapsed]
module.backend.kubernetes_pod.nginx_tools: Creation complete after 12s [id=tools/pod-nginx-tools]
module.backend.kubernetes_pod.example_monitoring: Creation complete after 12s [id=monitoring/pod-example-monitoring]
jmodule.backend.kubernetes_deployment.nginx: Creation complete after 15s [id=orcrist/nginx-deployment]

Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

Outputs:

deployment_name = "nginx-deployment"
namespaces = [
  "collector",
  "integration",
  "monitoring",
  "orcrist",
  "tools",
]
pod_names = [
  "pod-example-orcrist",
  "pod-nginx-tools",
  "pod-example-integration",
  "pod-example-monitoring",
]
service_name = "nginx-service"
```

### Verify the deployment
To verify the deployment, let's check the all resources.
As we can see, the pods are running in their respective namespaces, and the nginx service is created in the `orcrist` namespace.
```bash
kubectl get all --all-namespaces
NAMESPACE     NAME                                    READY   STATUS    RESTARTS   AGE
integration   pod/pod-example-integration             1/1     Running   0          69s
kube-system   pod/coredns-7d764666f9-94pmk            1/1     Running   0          11h
kube-system   pod/etcd-minikube                       1/1     Running   0          11h
kube-system   pod/kube-apiserver-minikube             1/1     Running   0          11h
kube-system   pod/kube-controller-manager-minikube    1/1     Running   0          11h
kube-system   pod/kube-proxy-9nh8q                    1/1     Running   0          11h
kube-system   pod/kube-scheduler-minikube             1/1     Running   0          11h
kube-system   pod/storage-provisioner                 1/1     Running   0          11h
monitoring    pod/pod-example-monitoring              1/1     Running   0          69s
orcrist       pod/nginx-deployment-78df899b6f-dck6v   1/1     Running   0          69s
orcrist       pod/nginx-deployment-78df899b6f-gnb2l   1/1     Running   0          69s
orcrist       pod/nginx-deployment-78df899b6f-k9d5v   1/1     Running   0          69s
orcrist       pod/pod-example-orcrist                 1/1     Running   0          69s
tools         pod/pod-nginx-tools                     1/1     Running   0          69s

NAMESPACE     NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP                  11h
kube-system   service/kube-dns        ClusterIP   10.96.0.10     <none>        53/UDP,53/TCP,9153/TCP   11h
orcrist       service/nginx-service   ClusterIP   10.102.206.0   <none>        80/TCP                   69s

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   daemonset.apps/kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   11h

NAMESPACE     NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/coredns            1/1     1            1           11h
orcrist       deployment.apps/nginx-deployment   3/3     3            3           69s

NAMESPACE     NAME                                          DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/coredns-7d764666f9            1         1         1       11h
orcrist       replicaset.apps/nginx-deployment-78df899b6f   3         3         3       69s
```

### Clean up resources
- To destroy the resources created by Terraform, run the following command:
```bash
$ terraform destroy

# Remove the local state files and backup files
rm -f terraform.tfstate terraform.tfstate.backup

# Remove the hidden .terraform directory and lock file
rm -rf .terraform .terraform.lock.hcl
```
