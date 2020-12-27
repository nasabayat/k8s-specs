# metrics-srver
``` commandline
cd cluster
kubectl apply -f metrics-server.yaml
```

# kubelet
The following configuration should be added to kubelet config on each master and worker node (if kubelet is running as diamond).

https://github.com/kubernetes/kops/issues/5706

```commandline
# vim /etc/sysconfig/kubelet 
--authentication-token-webhook=true  --authorization-mode=Webhook

# systemctl restart kubelet
```
```commandline
$ kubectl top node 
```
or change the inventory regarding your cluster IPs and then run playbook
```commandline
$ kubectl get nodes -o wide 
$ cd ansible
$ ansible-playbook playbook.yml -u ubuntu --key-file "~/Documents/devops23.pem"
```
# Useful commands
```commandline
kops edit cluster --name devops23.k8s.local 
```
# How to shutdown a kops Kubernetes cluster on AWS
https://perrohunter.com/how-to-shutdown-a-kops-kubernetes-cluster-on-aws/
For the nodes
```commandline
kops edit ig nodes
```
set maxSize and minSize to 0

for the master,
```commandline
 kops get ig
 kops edit ig master-eu-west-1a   
```
set maxSize and minSize to 0
```commandline
kops update cluster --yes
kops rolling-update cluster
```
If you wanted to turn your cluster back on, rever the settings, changing your master to at least 1, and your nodes to your liking