# Challenge Extra 3: Test Helm Chart

## Requirements


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
Creating namespace "server-chart-t5ycoadjph"...
namespace/server-chart-t5ycoadjph created
NAME: server-chart-t5ycoadjph
LAST DEPLOYED: Mon Jun 15 21:42:36 2026
NAMESPACE: server-chart-t5ycoadjph
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
deployment "server-chart-t5ycoadjph" successfully rolled out
NAME: server-chart-t5ycoadjph
LAST DEPLOYED: Mon Jun 15 21:42:36 2026
NAMESPACE: server-chart-t5ycoadjph
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
TEST SUITE:     server-chart-t5ycoadjph-test-connection
Last Started:   Mon Jun 15 21:42:38 2026
Last Completed: Mon Jun 15 21:42:41 2026
Phase:          Succeeded
========================================================================================================================
........................................................................................................................
==> Events of namespace server-chart-t5ycoadjph
........................................................................................................................
LAST SEEN   TYPE     REASON              OBJECT                                        SUBOBJECT                       SOURCE                  MESSAGE                                                                                                                     FIRST SEEN   COUNT   NAME
4s          Normal   Scheduled           pod/server-chart-t5ycoadjph-6756b774-ffvj8                                    default-scheduler       Successfully assigned server-chart-t5ycoadjph/server-chart-t5ycoadjph-6756b774-ffvj8 to minikube                            4s           1       server-chart-t5ycoadjph-6756b774-ffvj8.18b9589c8e3b8891
4s          Normal   Pulled              pod/server-chart-t5ycoadjph-6756b774-ffvj8    spec.containers{server-chart}   kubelet, minikube       Container image "orcahaeyoon/sre-interview-homwork:challenge-3" already present on machine and can be accessed by the pod   4s           1       server-chart-t5ycoadjph-6756b774-ffvj8.18b9589ca64202b3
4s          Normal   Created             pod/server-chart-t5ycoadjph-6756b774-ffvj8    spec.containers{server-chart}   kubelet, minikube       Container created                                                                                                           4s           1       server-chart-t5ycoadjph-6756b774-ffvj8.18b9589ca7110a8a
4s          Normal   Started             pod/server-chart-t5ycoadjph-6756b774-ffvj8    spec.containers{server-chart}   kubelet, minikube       Container started                                                                                                           4s           1       server-chart-t5ycoadjph-6756b774-ffvj8.18b9589ca91b14ca
4s          Normal   SuccessfulCreate    replicaset/server-chart-t5ycoadjph-6756b774                                   replicaset-controller   Created pod: server-chart-t5ycoadjph-6756b774-ffvj8                                                                         4s           1       server-chart-t5ycoadjph-6756b774.18b9589c8e25b4ad
4s          Normal   ScalingReplicaSet   deployment/server-chart-t5ycoadjph                                            deployment-controller   Scaled up replica set server-chart-t5ycoadjph-6756b774 from 0 to 1                                                          4s           1       server-chart-t5ycoadjph.18b9589c8db7cdbf
3s          Normal   Scheduled           pod/server-chart-t5ycoadjph-test-connection                                   default-scheduler       Successfully assigned server-chart-t5ycoadjph/server-chart-t5ycoadjph-test-connection to minikube                           3s           1       server-chart-t5ycoadjph-test-connection.18b9589cf51a8497
2s          Normal   Pulling             pod/server-chart-t5ycoadjph-test-connection   spec.containers{curl}           kubelet, minikube       Pulling image "curlimages/curl"                                                                                             2s           1       server-chart-t5ycoadjph-test-connection.18b9589d0d269ddb
1s          Normal   Pulled              pod/server-chart-t5ycoadjph-test-connection   spec.containers{curl}           kubelet, minikube       Successfully pulled image "curlimages/curl" in 1.07s (1.07s including waiting). Image size: 25717508 bytes.                 1s           1       server-chart-t5ycoadjph-test-connection.18b9589d4cf5d59c
1s          Normal   Created             pod/server-chart-t5ycoadjph-test-connection   spec.containers{curl}           kubelet, minikube       Container created                                                                                                           1s           1       server-chart-t5ycoadjph-test-connection.18b9589d4e4447c6
1s          Normal   Started             pod/server-chart-t5ycoadjph-test-connection   spec.containers{curl}           kubelet, minikube       Container started                                                                                                           1s           1       server-chart-t5ycoadjph-test-connection.18b9589d50f8c424
........................................................................................................................
<== Events of namespace server-chart-t5ycoadjph
........................................................................................................................
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
==> Description of pod server-chart-t5ycoadjph-6756b774-ffvj8
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Name:             server-chart-t5ycoadjph-6756b774-ffvj8
Namespace:        server-chart-t5ycoadjph
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Mon, 15 Jun 2026 21:42:37 +0200
Labels:           app.kubernetes.io/instance=server-chart-t5ycoadjph
                  app.kubernetes.io/managed-by=Helm
                  app.kubernetes.io/name=server-chart
                  app.kubernetes.io/version=1.0.0
                  helm.sh/chart=server-chart-0.1.0
                  pod-template-hash=6756b774
Annotations:      <none>
Status:           Running
IP:               10.244.0.64
IPs:
  IP:           10.244.0.64
Controlled By:  ReplicaSet/server-chart-t5ycoadjph-6756b774
Containers:
  server-chart:
    Container ID:   docker://61661a6cf5293b6e985039d563d907891132f9105e28711c4532480646ae9838
    Image:          orcahaeyoon/sre-interview-homwork:challenge-3
    Image ID:       docker-pullable://orcahaeyoon/sre-interview-homwork@sha256:996d48815bbd34618bf86a511f5f264207222edb8a590fa2115e6c61e41bcdb5
    Port:           8080/TCP (http)
    Host Port:      0/TCP (http)
    State:          Running
      Started:      Mon, 15 Jun 2026 21:42:37 +0200
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
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-5dl77 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-5dl77:
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
  Normal  Scheduled  4s    default-scheduler  Successfully assigned server-chart-t5ycoadjph/server-chart-t5ycoadjph-6756b774-ffvj8 to minikube
  Normal  Pulled     4s    kubelet            spec.containers{server-chart}: Container image "orcahaeyoon/sre-interview-homwork:challenge-3" already present on machine and can be accessed by the pod
  Normal  Created    4s    kubelet            spec.containers{server-chart}: Container created
  Normal  Started    4s    kubelet            spec.containers{server-chart}: Container started
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<== Description of pod server-chart-t5ycoadjph-6756b774-ffvj8
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
------------------------------------------------------------------------------------------------------------------------
==> Logs of container server-chart-t5ycoadjph-6756b774-ffvj8
------------------------------------------------------------------------------------------------------------------------
INFO:root:Listening on 8080...

INFO:root:Host: server-chart-t5ycoadjph
User-Agent: curl/8.20.0
Accept: */*
Challenge: orcrist.org


10.244.0.65 - - [15/Jun/2026 19:42:40] "GET / HTTP/1.1" 200 -
------------------------------------------------------------------------------------------------------------------------
<== Logs of container server-chart-t5ycoadjph-6756b774-ffvj8
------------------------------------------------------------------------------------------------------------------------
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
==> Description of pod server-chart-t5ycoadjph-test-connection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Name:             server-chart-t5ycoadjph-test-connection
Namespace:        server-chart-t5ycoadjph
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Mon, 15 Jun 2026 21:42:38 +0200
Labels:           app.kubernetes.io/instance=server-chart-t5ycoadjph
                  app.kubernetes.io/managed-by=Helm
                  app.kubernetes.io/name=server-chart
                  helm.sh/chart=server-chart-0.1.0
Annotations:      helm.sh/hook: test-success
Status:           Succeeded
IP:               10.244.0.65
IPs:
  IP:  10.244.0.65
Containers:
  curl:
    Container ID:  docker://d2b05b8a1df3ab5947ae140b5493c24980d3367f8aaa49a5d29e269d6ab6eed2
    Image:         curlimages/curl
    Image ID:      docker-pullable://curlimages/curl@sha256:b3f1fb2a51d923260350d21b8654bbc607164a987e2f7c84a0ac199a67df812a
    Port:          <none>
    Host Port:     <none>
    Command:
      curl
    Args:
      -H
      Challenge: orcrist.org
      http://server-chart-t5ycoadjph:80
    State:          Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Mon, 15 Jun 2026 21:42:40 +0200
      Finished:     Mon, 15 Jun 2026 21:42:40 +0200
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-hn2hk (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   False 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  kube-api-access-hn2hk:
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
  Normal  Scheduled  3s    default-scheduler  Successfully assigned server-chart-t5ycoadjph/server-chart-t5ycoadjph-test-connection to minikube
  Normal  Pulling    2s    kubelet            spec.containers{curl}: Pulling image "curlimages/curl"
  Normal  Pulled     1s    kubelet            spec.containers{curl}: Successfully pulled image "curlimages/curl" in 1.07s (1.07s including waiting). Image size: 25717508 bytes.
  Normal  Created    1s    kubelet            spec.containers{curl}: Container created
  Normal  Started    1s    kubelet            spec.containers{curl}: Container started
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<== Description of pod server-chart-t5ycoadjph-test-connection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
------------------------------------------------------------------------------------------------------------------------
==> Logs of container server-chart-t5ycoadjph-test-connection
------------------------------------------------------------------------------------------------------------------------
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed
100     17   0     17   0      0   5268      0                              0
Everything works!
------------------------------------------------------------------------------------------------------------------------
<== Logs of container server-chart-t5ycoadjph-test-connection
------------------------------------------------------------------------------------------------------------------------
========================================================================================================================
Deleting release "server-chart-t5ycoadjph"...
release "server-chart-t5ycoadjph" uninstalled
Deleting namespace "server-chart-t5ycoadjph"...
namespace "server-chart-t5ycoadjph" deleted

------------------------------------------------------------------------------------------------------------------------
 ✔︎ server-chart => (version: "0.1.0", path: "../challenge-5/server-chart/")
------------------------------------------------------------------------------------------------------------------------
All charts installed successfully
```

## Conclusion
As you can see that the test-connection was successfully tested as shown below, and the chart was successfully installed and uninstalled without any issues. The test suite ran successfully and the logs of the test connection container show that the expected output "Everything works!" was returned, which means that the Helm chart is working as expected and the tests are passing.

```bash
<== Description of pod server-chart-t5ycoadjph-test-connection
------------------------------------------------------------------------------------------------------------------------
==> Logs of container server-chart-t5ycoadjph-test-connection
------------------------------------------------------------------------------------------------------------------------
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Current
                                 Dload  Upload  Total   Spent   Left   Speed
100     17   0     17   0      0   5268      0                              0
Everything works!
```