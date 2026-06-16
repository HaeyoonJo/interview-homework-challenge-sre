# Challenge Extra 3: Test Helm Chart

## Requirements
- Using [helm-unittest](https://github.com/helm-unittest/helm-unittest) or [chart-testing](https://github.com/helm/chart-testing) to write tests for the `challenge-5` helm chart.
- Write tests that verify the Deployment and Service are rendered correctly with expected values.

## Testing tool
We use chart-testing tool to test the Helm chart. chart-testing is a simple tool that helps you to test either Remote repo or Local repo. 

- Installation  
The tool requires only installing it through `brew`, binary or using Docker image as following [document](https://github.com/helm/chart-testing#installation).

We will proceed the installation using `brew` simply.
  - `brew` installation  
  > `brew install chart-testing`

## Conducting chart tests
### Create `config.yaml`
- Create `config.yaml` file for local repo   
Since we need to conduct the test on local, we will test for "Local Repo" and the command is following:
I used the helm chart from the `challenge-5` directory, so I set the `chart-dirs` and `charts` to point to the local path of the chart.
```bash
ct install --chart-dirs . --charts ../challenge-5/server-chart/
```
This command line can be templated to be either `config.yaml` or `ct.yaml` file, and I created `config.yaml` file for this purpose. The original `config.yaml` or `ct.yaml` file can be found as a reference in the official github [page](https://github.com/helm/charts-repo-actions-demo/blob/main/ct.yaml). The content of the `config.yaml` is as follows:
```bash
chart-dirs:     # path where the chart is located and it's required for local repo
  - ../challenge-5/
charts:         # path to the chart to be tested
  - ../challenge-5/server-chart/
helm-extra-args: --timeout 600s
```
For more details about chart testing with `config.yaml`, please refer to 
    - https://github.com/helm/chart-testing#configuration
    - https://github.com/helm/charts-repo-actions-demo/blob/main/ct.yaml


### Conduct the chart installation and testing using `ct`
- conduct the installation and testing   
The test yaml files are located in the `server-chart/templates/tests/` [directory](../challenge-5/server-chart/templates/tests/), and they are automatically detected by the `ct` command.
We can run the command to install the chart and run the tests defined in the chart:
```bash
$ ct install --config config.yaml
Installing charts...
Version increment checking disabled.

------------------------------------------------------------------------------------------------------------------------
 Charts to be processed:
------------------------------------------------------------------------------------------------------------------------
 server-chart => (version: "0.1.0", path: "../challenge-5/server-chart/")
------------------------------------------------------------------------------------------------------------------------

Installing chart "server-chart => (version: \"0.1.0\", path: \"../challenge-5/server-chart/\")"...
Creating namespace "server-chart-hvhpm1qn87"...
namespace/server-chart-hvhpm1qn87 created
NAME: server-chart-hvhpm1qn87
LAST DEPLOYED: Tue Jun 16 10:24:23 2026
NAMESPACE: server-chart-hvhpm1qn87
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
deployment "server-chart-hvhpm1qn87" successfully rolled out
NAME: server-chart-hvhpm1qn87
LAST DEPLOYED: Tue Jun 16 10:24:23 2026
NAMESPACE: server-chart-hvhpm1qn87
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
TEST SUITE:     server-chart-hvhpm1qn87-test-deployment
Last Started:   Tue Jun 16 10:24:24 2026
Last Completed: Tue Jun 16 10:24:28 2026
Phase:          Succeeded
TEST SUITE:     server-chart-hvhpm1qn87-test-service
Last Started:   Tue Jun 16 10:24:28 2026
Last Completed: Tue Jun 16 10:24:32 2026
Phase:          Succeeded
========================================================================================================================
........................................................................................................................
==> Events of namespace server-chart-hvhpm1qn87
........................................................................................................................
LAST SEEN   TYPE     REASON              OBJECT                                          SUBOBJECT                       SOURCE                  MESSAGE                                                                                                                     FIRST SEEN   COUNT   NAME
9s          Normal   Scheduled           pod/server-chart-hvhpm1qn87-6544fccbd7-gtk7v                                    default-scheduler       Successfully assigned server-chart-hvhpm1qn87/server-chart-hvhpm1qn87-6544fccbd7-gtk7v to minikube                          9s           1       server-chart-hvhpm1qn87-6544fccbd7-gtk7v.18b9822e5593b61c
9s          Normal   Pulled              pod/server-chart-hvhpm1qn87-6544fccbd7-gtk7v    spec.containers{server-chart}   kubelet, minikube       Container image "orcahaeyoon/sre-interview-homwork:challenge-3" already present on machine and can be accessed by the pod   9s           1       server-chart-hvhpm1qn87-6544fccbd7-gtk7v.18b9822e7f29a529
9s          Normal   Created             pod/server-chart-hvhpm1qn87-6544fccbd7-gtk7v    spec.containers{server-chart}   kubelet, minikube       Container created                                                                                                           9s           1       server-chart-hvhpm1qn87-6544fccbd7-gtk7v.18b9822e8001261b
9s          Normal   Started             pod/server-chart-hvhpm1qn87-6544fccbd7-gtk7v    spec.containers{server-chart}   kubelet, minikube       Container started                                                                                                           9s           1       server-chart-hvhpm1qn87-6544fccbd7-gtk7v.18b9822e81d7116c
9s          Normal   SuccessfulCreate    replicaset/server-chart-hvhpm1qn87-6544fccbd7                                   replicaset-controller   Created pod: server-chart-hvhpm1qn87-6544fccbd7-gtk7v                                                                       9s           1       server-chart-hvhpm1qn87-6544fccbd7.18b9822e556c4832
9s          Normal   ScalingReplicaSet   deployment/server-chart-hvhpm1qn87                                              deployment-controller   Scaled up replica set server-chart-hvhpm1qn87-6544fccbd7 from 0 to 1                                                        9s           1       server-chart-hvhpm1qn87.18b9822e5533cc66
8s          Normal   Scheduled           pod/server-chart-hvhpm1qn87-test-deployment                                     default-scheduler       Successfully assigned server-chart-hvhpm1qn87/server-chart-hvhpm1qn87-test-deployment to minikube                           8s           1       server-chart-hvhpm1qn87-test-deployment.18b9822ea6009f81
8s          Normal   Pulling             pod/server-chart-hvhpm1qn87-test-deployment     spec.containers{curl}           kubelet, minikube       Pulling image "curlimages/curl"                                                                                             8s           1       server-chart-hvhpm1qn87-test-deployment.18b9822ebd782161
6s          Normal   Created             pod/server-chart-hvhpm1qn87-test-deployment     spec.containers{curl}           kubelet, minikube       Container created                                                                                                           6s           1       server-chart-hvhpm1qn87-test-deployment.18b9822f0a3573b1
6s          Normal   Started             pod/server-chart-hvhpm1qn87-test-deployment     spec.containers{curl}           kubelet, minikube       Container started                                                                                                           6s           1       server-chart-hvhpm1qn87-test-deployment.18b9822f0c7f3ad7
6s          Normal   Pulled              pod/server-chart-hvhpm1qn87-test-deployment     spec.containers{curl}           kubelet, minikube       Successfully pulled image "curlimages/curl" in 1.266s (1.266s including waiting). Image size: 25717508 bytes.               6s           1       server-chart-hvhpm1qn87-test-deployment.18b9822f08f9355c
4s          Normal   Scheduled           pod/server-chart-hvhpm1qn87-test-service                                        default-scheduler       Successfully assigned server-chart-hvhpm1qn87/server-chart-hvhpm1qn87-test-service to minikube                              4s           1       server-chart-hvhpm1qn87-test-service.18b9822f9a186236
4s          Normal   Pulling             pod/server-chart-hvhpm1qn87-test-service        spec.containers{curl}           kubelet, minikube       Pulling image "curlimages/curl"                                                                                             4s           1       server-chart-hvhpm1qn87-test-service.18b9822fb1b7c31e
2s          Normal   Pulled              pod/server-chart-hvhpm1qn87-test-service        spec.containers{curl}           kubelet, minikube       Successfully pulled image "curlimages/curl" in 1.29s (1.29s including waiting). Image size: 25717508 bytes.                 2s           1       server-chart-hvhpm1qn87-test-service.18b9822ffea35b9f
2s          Normal   Created             pod/server-chart-hvhpm1qn87-test-service        spec.containers{curl}           kubelet, minikube       Container created                                                                                                           2s           1       server-chart-hvhpm1qn87-test-service.18b9822fffcc2817
2s          Normal   Started             pod/server-chart-hvhpm1qn87-test-service        spec.containers{curl}           kubelet, minikube       Container started                                                                                                           2s           1       server-chart-hvhpm1qn87-test-service.18b982300200d6af
........................................................................................................................
<== Events of namespace server-chart-hvhpm1qn87
........................................................................................................................
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
==> Description of pod server-chart-hvhpm1qn87-6544fccbd7-gtk7v
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Name:             server-chart-hvhpm1qn87-6544fccbd7-gtk7v
Namespace:        server-chart-hvhpm1qn87
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Tue, 16 Jun 2026 10:24:23 +0200
Labels:           app.kubernetes.io/instance=server-chart-hvhpm1qn87
                  app.kubernetes.io/managed-by=Helm
                  app.kubernetes.io/name=server-chart
                  app.kubernetes.io/version=1.0.0
                  helm.sh/chart=server-chart-0.1.0
                  pod-template-hash=6544fccbd7
Annotations:      <none>
Status:           Running
IP:               10.244.0.83
IPs:
  IP:           10.244.0.83
Controlled By:  ReplicaSet/server-chart-hvhpm1qn87-6544fccbd7
Containers:
  server-chart:
    Container ID:   docker://c2e97b23d2a67b55522fbfcca270a698a429f526fe55dd58d4564fae0110eb49
    Image:          orcahaeyoon/sre-interview-homwork:challenge-3
    Image ID:       docker-pullable://orcahaeyoon/sre-interview-homwork@sha256:996d48815bbd34618bf86a511f5f264207222edb8a590fa2115e6c61e41bcdb5
    Port:           8080/TCP (http)
    Host Port:      0/TCP (http)
    State:          Running
      Started:      Tue, 16 Jun 2026 10:24:23 +0200
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
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-6zv57 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-6zv57:
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
  Normal  Scheduled  9s    default-scheduler  Successfully assigned server-chart-hvhpm1qn87/server-chart-hvhpm1qn87-6544fccbd7-gtk7v to minikube
  Normal  Pulled     9s    kubelet            spec.containers{server-chart}: Container image "orcahaeyoon/sre-interview-homwork:challenge-3" already present on machine and can be accessed by the pod
  Normal  Created    9s    kubelet            spec.containers{server-chart}: Container created
  Normal  Started    9s    kubelet            spec.containers{server-chart}: Container started
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<== Description of pod server-chart-hvhpm1qn87-6544fccbd7-gtk7v
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
------------------------------------------------------------------------------------------------------------------------
==> Logs of container server-chart-hvhpm1qn87-6544fccbd7-gtk7v
------------------------------------------------------------------------------------------------------------------------
INFO:root:Listening on 8080...

INFO:root:Host: server-chart-hvhpm1qn87
User-Agent: curl/8.20.0
Accept: */*
Challenge: orcrist.org


10.244.0.84 - - [16/Jun/2026 08:24:26] "GET / HTTP/1.1" 200 -
INFO:root:Host: server-chart-hvhpm1qn87
User-Agent: curl/8.20.0
Accept: */*
Challenge: orcrist.org


10.244.0.85 - - [16/Jun/2026 08:24:30] "GET / HTTP/1.1" 200 -
------------------------------------------------------------------------------------------------------------------------
<== Logs of container server-chart-hvhpm1qn87-6544fccbd7-gtk7v
------------------------------------------------------------------------------------------------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
==> Description of pod server-chart-hvhpm1qn87-test-deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Name:             server-chart-hvhpm1qn87-test-deployment
Namespace:        server-chart-hvhpm1qn87
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Tue, 16 Jun 2026 10:24:24 +0200
Labels:           app.kubernetes.io/instance=server-chart-hvhpm1qn87
                  app.kubernetes.io/managed-by=Helm
                  app.kubernetes.io/name=server-chart
                  app.kubernetes.io/version=1.0.0
                  helm.sh/chart=server-chart-0.1.0
Annotations:      helm.sh/hook: test-success
Status:           Succeeded
IP:               10.244.0.84
IPs:
  IP:  10.244.0.84
Containers:
  curl:
    Container ID:  docker://9f4fb84087e6f2b4b92afbaecc111df294f4ae394463110fcda679a91bf37283
    Image:         curlimages/curl
    Image ID:      docker-pullable://curlimages/curl@sha256:b3f1fb2a51d923260350d21b8654bbc607164a987e2f7c84a0ac199a67df812a
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/sh
      -c
    Args:
      curl -H 'Challenge: orcrist.org' http://server-chart-hvhpm1qn87:80 \
        && echo \
        && echo "==== test deployment success ===="
      
    State:          Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Tue, 16 Jun 2026 10:24:26 +0200
      Finished:     Tue, 16 Jun 2026 10:24:26 +0200
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-ffz4n (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   False 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-api-access-ffz4n:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  8s    default-scheduler  Successfully assigned server-chart-hvhpm1qn87/server-chart-hvhpm1qn87-test-deployment to minikube
  Normal  Pulling    8s    kubelet            spec.containers{curl}: Pulling image "curlimages/curl"
  Normal  Pulled     6s    kubelet            spec.containers{curl}: Successfully pulled image "curlimages/curl" in 1.266s (1.266s including waiting). Image size: 25717508 bytes.
  Normal  Created    6s    kubelet            spec.containers{curl}: Container created
  Normal  Started    6s    kubelet            spec.containers{curl}: Container started
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<== Description of pod server-chart-hvhpm1qn87-test-deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
------------------------------------------------------------------------------------------------------------------------
==> Logs of container server-chart-hvhpm1qn87-test-deployment
------------------------------------------------------------------------------------------------------------------------
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed
100     17   0     17   0      0   6011      0                              0
Everything works!
==== test deployment success ====
------------------------------------------------------------------------------------------------------------------------
<== Logs of container server-chart-hvhpm1qn87-test-deployment
------------------------------------------------------------------------------------------------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
==> Description of pod server-chart-hvhpm1qn87-test-service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Name:             server-chart-hvhpm1qn87-test-service
Namespace:        server-chart-hvhpm1qn87
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Tue, 16 Jun 2026 10:24:28 +0200
Labels:           app.kubernetes.io/instance=server-chart-hvhpm1qn87
                  app.kubernetes.io/managed-by=Helm
                  app.kubernetes.io/name=server-chart
                  app.kubernetes.io/version=1.0.0
                  helm.sh/chart=server-chart-0.1.0
Annotations:      helm.sh/hook: test-success
Status:           Succeeded
IP:               10.244.0.85
IPs:
  IP:  10.244.0.85
Containers:
  curl:
    Container ID:  docker://e347500a536b4b56f104f36664f4d199d2ec3d41d2fcbe426f7ae361da78de55
    Image:         curlimages/curl
    Image ID:      docker-pullable://curlimages/curl@sha256:b3f1fb2a51d923260350d21b8654bbc607164a987e2f7c84a0ac199a67df812a
    Port:          <none>
    Host Port:     <none>
    Command:
      /bin/sh
      -c
    Args:
      curl -H 'Challenge: orcrist.org' http://server-chart-hvhpm1qn87:80 \
        && echo \
        && echo "==== test service success ===="
      
    State:          Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Tue, 16 Jun 2026 10:24:30 +0200
      Finished:     Tue, 16 Jun 2026 10:24:30 +0200
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vngh2 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   False 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-api-access-vngh2:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  4s    default-scheduler  Successfully assigned server-chart-hvhpm1qn87/server-chart-hvhpm1qn87-test-service to minikube
  Normal  Pulling    4s    kubelet            spec.containers{curl}: Pulling image "curlimages/curl"
  Normal  Pulled     2s    kubelet            spec.containers{curl}: Successfully pulled image "curlimages/curl" in 1.29s (1.29s including waiting). Image size: 25717508 bytes.
  Normal  Created    2s    kubelet            spec.containers{curl}: Container created
  Normal  Started    2s    kubelet            spec.containers{curl}: Container started
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<== Description of pod server-chart-hvhpm1qn87-test-service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
------------------------------------------------------------------------------------------------------------------------
==> Logs of container server-chart-hvhpm1qn87-test-service
------------------------------------------------------------------------------------------------------------------------
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed
100     17   0     17   0      0  13709      0                              0
Everything works!
==== test service success ====
------------------------------------------------------------------------------------------------------------------------
<== Logs of container server-chart-hvhpm1qn87-test-service
------------------------------------------------------------------------------------------------------------------------
========================================================================================================================
Deleting release "server-chart-hvhpm1qn87"...
release "server-chart-hvhpm1qn87" uninstalled
Deleting namespace "server-chart-hvhpm1qn87"...
namespace "server-chart-hvhpm1qn87" deleted

------------------------------------------------------------------------------------------------------------------------
 ✔︎ server-chart => (version: "0.1.0", path: "../challenge-5/server-chart/")
------------------------------------------------------------------------------------------------------------------------
All charts installed successfully
```

## Conclusion
As you can see that the testing deployment and service were successfully tested as shown below, and the chart was successfully installed and uninstalled. 
The test suite ran successfully and the logs of the test container show that the expected output "Everything works!" was returned, which means that the Helm chart is working as expected and the tests are passing.

- Test verified the Deployment that is rendered with the value.  
```bash
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<== Description of pod server-chart-hvhpm1qn87-test-deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
------------------------------------------------------------------------------------------------------------------------
==> Logs of container server-chart-hvhpm1qn87-test-deployment
------------------------------------------------------------------------------------------------------------------------
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed
100     17   0     17   0      0   6011      0                              0
Everything works!
==== test deployment success ====
```

- Test verified the Service that is rendered with the value.  
```bash
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<== Description of pod server-chart-hvhpm1qn87-test-service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
------------------------------------------------------------------------------------------------------------------------
==> Logs of container server-chart-hvhpm1qn87-test-service
------------------------------------------------------------------------------------------------------------------------
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed
100     17   0     17   0      0  13709      0                              0
Everything works!
==== test service success ====
```