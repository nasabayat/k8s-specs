#metrics-srver
``` bash
cd cluster
kubectl apply -f metrics-server.yaml
```

# kubelet
The following configuration should be added to kubelet config on each master and worker node (if kubelet is running as diamond).

https://github.com/kubernetes/kops/issues/5706

```
# vim /etc/sysconfig/kubelet 
--authentication-token-webhook=true  --authorization-mode=Webhook```

# systemctl restart kubelet
```
```nashorn js
$ kubectl top node 
```