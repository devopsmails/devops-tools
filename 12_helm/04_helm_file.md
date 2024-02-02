What is HELM FILE?
----------
```
Helmfile is a tool used in Kubernetes deployments. 
It's essentially a declarative specification wrapper for deploying distributions of Helm charts.
```
Why HELM FILE?

```
Simplify complex deployments
Increase modularity and reusability
Improved version control and collaboration
CI/CD integration
Dependency management
Secret management
Environment-specific configuration
```

PRE-REQUISITES TO INSTALL HELM FILE

```
Helm charts 
```

HELM FILE INSTALLATION
------------------
```
DOCS:  https://github.com/roboll/helmfile/releases   >> copy amd64 link addr

wget https://github.com/roboll/helmfile/releases/download/v0.144.0/helmfile_linux_amd64
ls
mv helmfile_linux_amd64 helmfile
ls -lart
chmod 777 helmfile

sudo mv helmfile /usr/local/bin         - to run from anywhere in the terminal
ls -lart /usr/local/bin
helmfile version

helm create helloworld

vi helmfile.yaml
----------
INSERT BELOW
---
releases:

  - name: helloworldrelease
    chart: ./helloworld
    installed: true
---- >> SAVE

*****helmfile.yaml & helloworld chart should be on the same directory to execute helmfile sync cmd**
helmfile sync           - It performs actions as per helmfile.yaml(Here it installed)
helm list -a
kubectl get pods
kubectl get svc
    > We can check on dashboard

vi helmfile.yaml
----------
installed: false
>> save

helmfile sync           - It performs actions as per helmfile.yaml(Here it DELETES)
```

INSTALL USING REMOTE HELM CHART ON GITHUB  

```
INSTALL HELM-GIT PLUGIN
----------
Docs: https://github.com/aslafy-z/helm-git

helm plugin install https://github.com/aslafy-z/helm-git --version 0.15.1   
    > installs helm-git plugin

space > helmfile.yaml       - clears the complete file info if already exists
cat helmfile.yaml
vi helmfile.yaml
------
---
repositories:
  - name: helloworld
    url: git+https://github.com/rahulwagh/helmchart@helloworld?ref=master&sparse=0 

releases:
  - name: helloworldreleasedev
    chart: helloworld/helloworld
    installed: true
-------------

helmfile sync
helm list -a

vi helmfile.yaml
----------
installed: false

helmfile sync - deletes
helm list -a
```

DEPLOY MULTIPLE HELMCHARTS USING HELMFILE

```
space > helmfile.yaml

vi helmfile.yaml
---------------
---
releases:
  - name: helloworld1
    chart: ./helloworld1
    installed: true

  - name: helloworld2
    chart: ./helloworld2
    installed: true

helmfile sync
helm list -a

vi helmfile.yaml
---------
installed: false

helmfile sync     - deletes helmcharts
helm list -a
```
HOW TO USE HELM REPO (OPEN SOURCE PRE-CREATED HELM CHARTS):
---------
```
helm search hub wordpress       - wordpress = helmchart repo name
  > list the pre-defined helm charts related with name
  > We can used version we want

helm search hub wordpress --max-col-width=0   - shows the complete url of a repo

helm repo list                  - shows the used repos list
helm repo add bitnami https://charts.bitnami.com/bitnami    - add the bitnami repo
helm repo list

helm show readme bitnami/wordpress --version 15.2.13      
  > shows the complete instructions of repo how to install
 
helm show values bitnami/wordpress --version 10.0.3
```
