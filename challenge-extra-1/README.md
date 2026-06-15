# Challenge Extra 1: get Kubernetes resources

### Apply manifests
```bash
$ kubectl apply -f manifests/
namespace/collector unchanged
namespace/integration unchanged
namespace/orcrist unchanged
namespace/monitoring unchanged
namespace/tools unchanged
deployment.apps/nginx-deployment unchanged
service/nginx-service unchanged
pod/pod-example-orcrist unchanged
pod/pod-nginx-tools unchanged
pod/pod-example-integration unchanged
pod/pod-example-monitoring unchanged
```

### Get info
- Get all namespaces.
```bash
$ kubectl get ns
NAME              STATUS   AGE
collector         Active   6h54m
default           Active   7h20m
integration       Active   6h54m
kube-node-lease   Active   7h20m
kube-public       Active   7h20m
kube-system       Active   7h20m
monitoring        Active   6h54m
orcrist           Active   6h54m
tools             Active   6h54m
```
- Get all pods from all namespaces.
```bash
$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                  READY   STATUS    RESTARTS   AGE
default       server-server-chart-5dd744499-xmx8k   1/1     Running   0          9m58s
integration   pod-example-integration               1/1     Running   0          6h54m
kube-system   coredns-7d764666f9-94pmk              1/1     Running   0          7h21m
kube-system   etcd-minikube                         1/1     Running   0          7h21m
kube-system   kube-apiserver-minikube               1/1     Running   0          7h21m
kube-system   kube-controller-manager-minikube      1/1     Running   0          7h21m
kube-system   kube-proxy-9nh8q                      1/1     Running   0          7h21m
kube-system   kube-scheduler-minikube               1/1     Running   0          7h21m
kube-system   storage-provisioner                   1/1     Running   0          7h21m
monitoring    pod-example-monitoring                1/1     Running   0          6h54m
orcrist       nginx-deployment-59f86b59ff-g5b8m     1/1     Running   0          6h54m
orcrist       nginx-deployment-59f86b59ff-kqr6f     1/1     Running   0          6h54m
orcrist       nginx-deployment-59f86b59ff-xvglf     1/1     Running   0          6h54m
orcrist       pod-example-orcrist                   1/1     Running   0          6h54m
tools         pod-nginx-tools                       1/1     Running   0          6h54m
``` 
- Get all resources from all namespaces.
```bash
$ kubectl get all --all-namespaces
NAMESPACE     NAME                                      READY   STATUS    RESTARTS   AGE
default       pod/server-server-chart-5dd744499-xmx8k   1/1     Running   0          10m
integration   pod/pod-example-integration               1/1     Running   0          6h55m
kube-system   pod/coredns-7d764666f9-94pmk              1/1     Running   0          7h21m
kube-system   pod/etcd-minikube                         1/1     Running   0          7h21m
kube-system   pod/kube-apiserver-minikube               1/1     Running   0          7h21m
kube-system   pod/kube-controller-manager-minikube      1/1     Running   0          7h21m
kube-system   pod/kube-proxy-9nh8q                      1/1     Running   0          7h21m
kube-system   pod/kube-scheduler-minikube               1/1     Running   0          7h21m
kube-system   pod/storage-provisioner                   1/1     Running   0          7h21m
monitoring    pod/pod-example-monitoring                1/1     Running   0          6h55m
orcrist       pod/nginx-deployment-59f86b59ff-g5b8m     1/1     Running   0          6h55m
orcrist       pod/nginx-deployment-59f86b59ff-kqr6f     1/1     Running   0          6h55m
orcrist       pod/nginx-deployment-59f86b59ff-xvglf     1/1     Running   0          6h55m
orcrist       pod/pod-example-orcrist                   1/1     Running   0          6h55m
tools         pod/pod-nginx-tools                       1/1     Running   0          6h55m

NAMESPACE     NAME                          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes            ClusterIP   10.96.0.1       <none>        443/TCP                  7h21m
default       service/server-server-chart   ClusterIP   10.98.40.215    <none>        80/TCP                   10m
kube-system   service/kube-dns              ClusterIP   10.96.0.10      <none>        53/UDP,53/TCP,9153/TCP   7h21m
orcrist       service/nginx-service         ClusterIP   10.104.207.53   <none>        80/TCP                   6h55m

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   daemonset.apps/kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   7h21m

NAMESPACE     NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
default       deployment.apps/server-server-chart   1/1     1            1           10m
kube-system   deployment.apps/coredns               1/1     1            1           7h21m
orcrist       deployment.apps/nginx-deployment      3/3     3            3           6h55m

NAMESPACE     NAME                                            DESIRED   CURRENT   READY   AGE
default       replicaset.apps/server-server-chart-5dd744499   1         1         1       10m
kube-system   replicaset.apps/coredns-7d764666f9              1         1         1       7h21m
orcrist       replicaset.apps/nginx-deployment-59f86b59ff     3         3         3       6h55m
```

- Get all services from namespace `orcrist`.
```bash
$ kubectl get svc -n orcrist
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
nginx-service   ClusterIP   10.104.207.53   <none>        80/TCP    6h55m
```

- Get all deployments from `tools`.
```bash
$ kubectl get deployments -n tools
No resources found in tools namespace.
```

- Get image from `nginx` deployment on `orcrist` namespace.
```bash
$ kubectl get deployment nginx-deployment -n orcrist -o jsonpath='{.spec.template.spec.containers[*].image}'
> nginx:latest
```

- Create a `port-forward` to access `nginx` pod on `orcrist` namespace.
```bash
$ export POD_NAME=$(kubectl get pods -n orcrist -l app=nginx -o jsonpath="{.items[0].metadata.name}")
$ kubectl port-forward -n orcrist $POD_NAME 8080:80
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
```
