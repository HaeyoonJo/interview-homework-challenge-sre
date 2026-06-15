# Challenge Extra 3: Test Helm Chart

## Requirements

## Conducting tests

```
$ ct install --config config.yaml
Installing charts...
Version increment checking disabled.

------------------------------------------------------------------------------------------------------------------------
 Charts to be processed:
------------------------------------------------------------------------------------------------------------------------
 server-chart => (version: "0.1.0", path: "../challenge-5/server-chart/")
------------------------------------------------------------------------------------------------------------------------

Installing chart "server-chart => (version: \"0.1.0\", path: \"../challenge-5/server-chart/\")"...
Creating namespace "server-chart-hocaxfb2k0"...
namespace/server-chart-hocaxfb2k0 created
NAME: server-chart-hocaxfb2k0
LAST DEPLOYED: Mon Jun 15 17:10:08 2026
NAMESPACE: server-chart-hocaxfb2k0
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
TEST SUITE: None
deployment "server-chart-hocaxfb2k0" successfully rolled out
NAME: server-chart-hocaxfb2k0
LAST DEPLOYED: Mon Jun 15 17:10:08 2026
NAMESPACE: server-chart-hocaxfb2k0
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
TEST SUITE: None
========================================================================================================================
........................................................................................................................
==> Events of namespace server-chart-hocaxfb2k0
........................................................................................................................
LAST SEEN   TYPE     REASON              OBJECT                                          SUBOBJECT                       SOURCE                  MESSAGE                                                                                                                     FIRST SEEN   COUNT   NAME
1s          Normal   Scheduled           pod/server-chart-hocaxfb2k0-65b44f6b4f-b7bcd                                    default-scheduler       Successfully assigned server-chart-hocaxfb2k0/server-chart-hocaxfb2k0-65b44f6b4f-b7bcd to minikube                          1s           1       server-chart-hocaxfb2k0-65b44f6b4f-b7bcd.18b949be0a9518ab
1s          Normal   Pulled              pod/server-chart-hocaxfb2k0-65b44f6b4f-b7bcd    spec.containers{server-chart}   kubelet, minikube       Container image "orcahaeyoon/sre-interview-homwork:challenge-3" already present on machine and can be accessed by the pod   1s           1       server-chart-hocaxfb2k0-65b44f6b4f-b7bcd.18b949be23234375
1s          Normal   Created             pod/server-chart-hocaxfb2k0-65b44f6b4f-b7bcd    spec.containers{server-chart}   kubelet, minikube       Container created                                                                                                           1s           1       server-chart-hocaxfb2k0-65b44f6b4f-b7bcd.18b949be23ee08cd
1s          Normal   Started             pod/server-chart-hocaxfb2k0-65b44f6b4f-b7bcd    spec.containers{server-chart}   kubelet, minikube       Container started                                                                                                           1s           1       server-chart-hocaxfb2k0-65b44f6b4f-b7bcd.18b949be25f56ab7
1s          Normal   SuccessfulCreate    replicaset/server-chart-hocaxfb2k0-65b44f6b4f                                   replicaset-controller   Created pod: server-chart-hocaxfb2k0-65b44f6b4f-b7bcd                                                                       1s           1       server-chart-hocaxfb2k0-65b44f6b4f.18b949be0a1cb361
1s          Normal   ScalingReplicaSet   deployment/server-chart-hocaxfb2k0                                              deployment-controller   Scaled up replica set server-chart-hocaxfb2k0-65b44f6b4f from 0 to 1                                                        1s           1       server-chart-hocaxfb2k0.18b949be09a107b6
........................................................................................................................
<== Events of namespace server-chart-hocaxfb2k0
........................................................................................................................
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
==> Description of pod server-chart-hocaxfb2k0-65b44f6b4f-b7bcd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Name:             server-chart-hocaxfb2k0-65b44f6b4f-b7bcd
Namespace:        server-chart-hocaxfb2k0
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Mon, 15 Jun 2026 17:10:08 +0200
Labels:           app.kubernetes.io/instance=server-chart-hocaxfb2k0
                  app.kubernetes.io/managed-by=Helm
                  app.kubernetes.io/name=server-chart
                  app.kubernetes.io/version=1.0.0
                  helm.sh/chart=server-chart-0.1.0
                  pod-template-hash=65b44f6b4f
Annotations:      <none>
Status:           Running
IP:               10.244.0.48
IPs:
  IP:           10.244.0.48
Controlled By:  ReplicaSet/server-chart-hocaxfb2k0-65b44f6b4f
Containers:
  server-chart:
    Container ID:   docker://a8e6f5b183bd1cffbbf501b5ac9ea9c1188ba12dcc5f129586fcbc04c0d46e64
    Image:          orcahaeyoon/sre-interview-homwork:challenge-3
    Image ID:       docker-pullable://orcahaeyoon/sre-interview-homwork@sha256:996d48815bbd34618bf86a511f5f264207222edb8a590fa2115e6c61e41bcdb5
    Port:           8080/TCP (http)
    Host Port:      0/TCP (http)
    State:          Running
      Started:      Mon, 15 Jun 2026 17:10:08 +0200
    Ready:          True
    Restart Count:  0
    Limits:
      cpu:     200m
      memory:  128Mi
    Requests:
      cpu:        100m
      memory:     64Mi
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-x7ssh (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-x7ssh:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  1s    default-scheduler  Successfully assigned server-chart-hocaxfb2k0/server-chart-hocaxfb2k0-65b44f6b4f-b7bcd to minikube
  Normal  Pulled     1s    kubelet            spec.containers{server-chart}: Container image "orcahaeyoon/sre-interview-homwork:challenge-3" already present on machine and can be accessed by the pod
  Normal  Created    1s    kubelet            spec.containers{server-chart}: Container created
  Normal  Started    1s    kubelet            spec.containers{server-chart}: Container started
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<== Description of pod server-chart-hocaxfb2k0-65b44f6b4f-b7bcd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
------------------------------------------------------------------------------------------------------------------------
==> Logs of container server-chart-hocaxfb2k0-65b44f6b4f-b7bcd
------------------------------------------------------------------------------------------------------------------------
INFO:root:Listening on 8080...

------------------------------------------------------------------------------------------------------------------------
<== Logs of container server-chart-hocaxfb2k0-65b44f6b4f-b7bcd
------------------------------------------------------------------------------------------------------------------------
========================================================================================================================
Deleting release "server-chart-hocaxfb2k0"...
release "server-chart-hocaxfb2k0" uninstalled
Deleting namespace "server-chart-hocaxfb2k0"...
namespace "server-chart-hocaxfb2k0" deleted
```