O-doc: https://helm.sh/docs/topics/charts_hooks/  

<img width="492" alt="chrome_SuyiUOhZXe" src="https://github.com/devopsmails/devops/assets/119680288/496d30af-238b-4c2b-93f4-b394efbb2830">

What is helm hooks?
```
 Helm hooks are a mechanism for running operations at specific points during the Helm chart's lifecycle. 
 Helm hooks allow you to define and execute actions before or after certain events, such as before installing or upgrading a release.

```
WHEN TO USE HELM HOOKS?
```
Loading secrets or configuration maps
Backing up and restoring data
Cleaning up resources
Graceful rolling deployments
```

COMMON TYPES OF HELM HOOKS:
------------------
```
pre-install:
Runs before the installation of the chart.

post-install:
Runs after the installation of the chart.

pre-delete:
Runs before the deletion of the release.

post-delete:
Runs after the deletion of the release.

pre-upgrade:
Runs before an upgrade to a new version of the chart.

post-upgrade:
Runs after the upgrade to a new version of the chart.

pre-rollback:
Runs before rolling back to a previous version of the release.

post-rollback:
Runs after rolling back to a previous version of the release.
```
******** HELM HOOK CAN BE USED ON K8'S RESOURCE(pods, services, deployments)*******  
*** SHOULD CREATE HOOKS DIR IN TEMPLATES & SHOULD CREATE FILE "PRE/POST-INSTALL.YAML******
```
mkdir helloworld/templates/hooks
cd helloworld/templates/hooks
vi pre/post-install/upgrade.yaml
-----------------
ex:
apiVersion: batch/v1
kind: Job
metadata:
  name: "{{ .Release.Name }}"
  labels:
    app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
    app.kubernetes.io/instance: {{ .Release.Name | quote }}
    app.kubernetes.io/version: {{ .Chart.AppVersion }}
    helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
  annotations:
    # This is what defines this resource as a hook. Without this line, the
    # job is considered part of the release.
    "helm.sh/hook": post-install
    "helm.sh/hook-weight": "-5"
    "helm.sh/hook-delete-policy": hook-succeeded
spec:
  template:
    metadata:
      name: "{{ .Release.Name }}"
      labels:
        app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
        app.kubernetes.io/instance: {{ .Release.Name | quote }}
        helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
    spec:
      restartPolicy: Never
      containers:
      - name: post-install-job
        image: "alpine:3.3"
        command: ["/bin/sleep","{{ default "10" .Values.sleepyTime }}"]

---------

Duplicate server tab:
--------
kubectl get pods --watch -o wide        
    - once the below cmd is executed we can see current happenings

noramal server tab:
-------------
helm install myrelease helloworld

****SIMILERLY WE CAN DO IT FOR ALL HELM HOOKS TYPES*****
```
