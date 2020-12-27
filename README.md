# metrics-srver
``` bash
cd cluster
kubectl apply -f metrics-server.yaml
```

# kubelet
The following configuration should be added to kubelet config on each master and worker node (if kubelet is running as diamond).

https://github.com/kubernetes/kops/issues/5706

```
# vim /etc/sysconfig/kubelet 
--authentication-token-webhook=true  --authorization-mode=Webhook

# systemctl restart kubelet
```
```nashorn js
$ kubectl top node 
```
or change the inventory regarding your cluster IPs and then run playbook
```nashorn js
$ kubectl get nodes -o wide 
$ cd ansible
$ ansible-playbook playbook.yml -u ubuntu --key-file "~/Documents/devops23.pem"
```
