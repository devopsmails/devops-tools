AV:  
Agenda:
------
```
1.Create 3 eks clusters
2.install argocd on hub cluster
3.Verify login
4.Add clusters to argo cd cluster
```
What hub spoke deployment type?  

Centralized Management with Distributed Deployments:
```
Hub: A single Argo CD instance serves as the central control point for managing multiple Kubernetes 
     clusters.
Spokes: Individual Kubernetes clusters act as spokes, connecting to the central hub.
```
```
Instance: ubuntu >> t3.large(2 cpu 8 ram, memo 20, alltraffic)
prerequisites:

kubectl – A command line tool for working with Kubernetes clusters. For more information, see Installing or updating kubectl. 
https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

```
```
eksctl – A command line tool for working with EKS clusters that automates many individual tasks. For more information, see Installing or updating. 
https://docs.aws.amazon.com/emr/latest/EMR-on-EKS-DevelopmentGuide/setting-up-eksctl.html
```
```
AWS CLI – A command line tool for working with AWS services, including Amazon EKS. For more information, see Installing, updating, and uninstalling the AWS CLI https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html in the AWS Command Line Interface User Guide.
```
```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv /tmp/eksctl /usr/local/bin
eksctl version

```
```
aws cli:
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install
aws --version 

aws configure
access key:
secret access key:
```
EKS Setup:
--------------  
EKS Clusters Creation

```
eksctl create cluster --name hub-cluster --region us-west-1

eksctl create cluster --name spoke-cluster-1 --region us-west-1

eksctl create cluster --name spoke-cluster-2 --region us-west-1

Clusters successfully created

```
on same ec2 server(not on any clusters):

```
kubectl config get-contexts | grep us-west-1
     - CONTEXT = cluster
     - list all of the Kubernetes contexts that are currently configured in your kubeconfig file.
     iam-root-account@hub-cluster.us-west-1.eksctl.io
     iam-root-account@spoke-cluster-2.us-west-1.eksctl.io
     
kubectl config use-context iam-root-account@hub-cluster.us-west-1.eksctl.io
     - Switched to hub-cluster 
kubectl config current-context
     - Shows current cluster  
```
Argo CD on Hub Cluster:
===================
```
Argo CD with Kubernetes YAML files -https://argo-cd.readthedocs.io/en/stable/getting_started/
#installation

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

------
kubectl get pods -n argocd
```


Access argo cd UI unsecurely for demo(not for prod):
------------------------------
```
kubectl get cm -n argocd
     - cm = config maps
     - list configmaps in argocd namespace

kubectl edit cm argocd-cmd-params-cm -n argocd
     - argocd-cmd-params-cm = name of configmap
     - need to edit in this to access unsecurely
     - go to this github:
     https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/argocd-cmd-params-cm.yaml
          > search:#insecure
               > copy: server.insecure: "false" make to true
               > after line: uid: ef57c41c-eae1-48d0-9268-466edd68d8bb
                    add:
                    data:  server.insecure: "true" >> save

kubectl edit deploy/argocd-server -n argocd
     - /insecure(search in the file & what ever changed configs maps changed in deployment file as well)>> leave(:!)
kubectl get pods -n argocd
kubectl get svc argocd-server -n argocd
     - shows service also up & running
kubectl edit svc argocd-server -n argocd
     - Change default: type: Cluster ip to >> type: NodePort >> save
kubectl get svc argocd-server -n argocd
     - we can see now argocd-server service changed from cluster ip to nodeport
     - ex: 
          NAME            TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
          argocd-server   NodePort   10.100.137.216   <none>        80:32605/TCP,443:31738/TCP   32m
          80:32605/TCP = http(unsecure)
          443:31738/TCP = https(secured)
Note:
Every cluster would have n number of nodes
to connect with argocd ui you can take any one of cluster node pub ip: port enabled will be accessed
shouold enable port in security groups
ex: cluster hub: https://18.144.66.68:32605/

now we view ui interface auth page
USERNAME: admin
PASSWORD:
kubectl get secrets -n argocd
     > argocd-initial-admin-secret
kubectl edit secrets argocd-initial-admin-secret -n argocd
     > password: dWFnandld0FjdUp1MjQwOQ== 
echo dWFnandld0FjdUp1MjQwOQ== | base64 --decode
     > copy: uagjwewAcuJu2409
PASSWORD: uagjwewAcuJu2409
```

Add spoke clusters to hub cluster:
----------------------
```
argocd ui >> settings >> clusters (we can see only one cluster)>> no option for adding but for deleting
Using argocd UI it's not possible add spoke clusters to hub clusters but possible through 
''ARGOCD CLI""

INSTALL ARGO CD CLI ON HUB CLUSTER:
------------------
O_docs: https://argo-cd.readthedocs.io/en/stable/cli_installation/

---
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64
---

ARGO CD CLI LOGIN:
-----
argocd login 18.144.66.68:32605(hubcluster nodeip:port)
y
username: admin
password: uagjwewAcuJu2409
will be logged in successfully

kubectl config get-contexts
     > copy context = cluster which we wannt to addded to hub cluster

ADD SPOKE CLUSTER TO HUB CLUSTER:  
(Same proceedure to deploy app on any number of clusters only >> apps >> Destination >> Cluster URL changes.
Then every thing same)
---------------
argocd cluster add iam-root-account@spoke-cluster-2.us-west-1.eksctl.io --server 18.144.66.68:32605
     > iam-root-account@spoke-cluster-2.us-west-1.eksctl.io = context or cluster 
     > --server 18.144.66.68:32605 = Hub cluster UI address(because we want to add to hub custer)
     y
```

ARGOCD UI:  
--------  
settigns >> clusters >> we can now see added spoke clusters as well

DEPLOY APPLICATION TO ALL THE CLUSTERS:
---------------
```
argo cd ui:
     >> application:
          > app name: Dev-app
          >Project Name: default
          > SYNC POLICY: Automatic
          > SOURCE: 
               > Repository URL: https://github.com/iam-veeramalla/argocd-hub-spoke-demo.git
               > Revision: HEAD
               > Path: manifests/guest-book(in the above repo this file path)
          > DESTINATION:
               > Cluster URL: https://B4B329136F8C1A328ABFE2D55FA87280.gr7.us-west-1.eks.amazonaws.com
               (on which cluster you want to deploy)
               > Namespace: default(for now & custom ns should be created earlier before deploy)
               >> Crate

CHECK THE DEPLOY ON SPOKE CLUSTER:
--------------
kubectl config get-contexts
kubectl config use-context iam-root-account@spoke-cluster-2.us-west-1.eksctl.io
kubectl get all
     can see services , deployment, replica sets running on spoke cluster

```

EKS Clusters Deletion if it's demo
```
eksctl delete cluster --name hub-cluster --region us-west-1

eksctl delete cluster --name spoke-cluster-1 --region us-west-1

eksctl delete cluster --name spoke-cluster-2 --region us-west-1
```
