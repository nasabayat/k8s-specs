# metrics-srver
``` commandline
export AWS_ACCESS_KEY_ID=$(cat ~/Documents/kops-creds | jq -r '.AccessKey.AccessKeyId');
export AWS_SECRET_ACCESS_KEY=$(cat ~/Documents/kops-creds | jq -r '.AccessKey.SecretAccessKey');
export AWS_DEFAULT_REGION=eu-west-1;
export ZONES=$(aws ec2 describe-availability-zones --region $AWS_DEFAULT_REGION | jq -r '.AvailabilityZones[].ZoneName' | tr '\n' ',' | tr -d ' ');
ZONES=${ZONES%?};
export NAME=devops23.k8s.local;
export BUCKET_NAME=devops23-1608787521;
export KOPS_STATE_STORE=s3://$BUCKET_NAME;
kops create cluster --name $NAME --master-count 3 --node-count 1 --node-size t2.small --master-size t2.small --zones $ZONES --master-zones $ZONES --ssh-public-key ~/Documents/devops23.pub --networking kubenet --kubernetes-version 1.14.8 --yes;

cd cluster
kubectl apply -f ../metrics-server.yaml
```

# kubelet
The following configuration should be added to kubelet config on each master and worker node (if kubelet is running as diamond).

https://github.com/kubernetes/kops/issues/5706

provide the IPs:
```commandline
cd ../ansible
echo "[kops]" > inventory
kubectl get nodes -o wide | awk '{print $7}' |sed '1d' >> inventory
ansible-playbook playbook.yml -u ubuntu --key-file "~/Documents/devops23.pem"
```

```commandline
kubectl top node 
```
or change the inventory regarding your cluster IPs and then run playbook
```commandline
kubectl get nodes -o wide 
cd ansible
ansible-playbook playbook.yml -u ubuntu --key-file "~/Documents/devops23.pem"
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