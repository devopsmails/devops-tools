What is & why secrets used in K8's?  
--------------------------
Secrets in Kubernetes are objects that store sensitive data such as passwords, tokens, and keys.   
They are similar to ConfigMaps, but they are encrypted at rest and in transit.   
This makes them ideal for storing sensitive data that should not be exposed to users or other applications.   

Creating a Secret:   
----------------
Type1:  
-----
To create a Secret, you can use the """kubectl create secret """ command.   
For example, the following command creates a Secret called """ my-secret""" with two key-value pairs:  

kubectl create secret generic my-secret --from-literal=key1=value1 --from-literal=key2=value2  
 
Type2:    
------    
You can also create a Secret from a file or directory of files.   
For example, the following command creates a Secret called """my-secret""" from the contents of the directory """/path/to/secret/files:"""  

kubectl create secret generic my-secret --from-file=/path/to/secret/files  

------------------------

How it protects the sensitive info:
---------------------------------
 => By using Strong RBAC(with least Privilliages)
 => secrets saves the data in encryption format. 


CLI:
kubectl create secret generic test-secret --from-literal=db-password="suresh"         #GENERIC= GENERAL way  
kubectl describe secret test-secret  

Secret Types:  
===========
type: Opaque:   
----------
This Secret can be used to store any type of arbitrary data, such as passwords, tokens, and keys. It is encrypted at rest and in transit, which protects it from  
 unauthorized access.  
```
apiVersion: v1
kind: Secret
metadata:
  name: my-opaque-secret
type: Opaque
data:
  username: YWRtaW4= # This is the base64 encoded value of the string "admin".
  password: MWYyZDFlMmU2N2Rm # This is the base64 encoded value of the string "password".
```


2.Docker Registry Secret:  
--------------------
This Secret can be used to store the credentials for accessing a Docker registry. This allows Kubernetes to pull images from the registry without requiring users to  
 provide their credentials manually. The Secret data is encrypted at rest and in transit, which protects it from unauthorized access.  
```
apiVersion: v1
kind: Secret
metadata:
  name: my-docker-registry-secret
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: |
    {
      "auths": {
        "https://index.docker.io/v1/": {
          "username": "my-username",
          "password": "my-password"
        }
      }
    }
```

3.Service Account Token Secret:
=============================
This Secret can be used to store the token for a service account. This allows service accounts to authenticate to Kubernetes and other services. The Secret data is  
 encrypted at rest and in transit, which protects it from unauthorized access.  

```
apiVersion: v1
kind: Secret
metadata:
  name: my-service-account-token-secret
type: kubernetes.io/service-account-token
data:
  token: my-service-account-token
```

4.TLS Secret:
==============
This Secret can be used to store a TLS certificate and key. This allows Kubernetes to establish secure connections to other services. The Secret data is encrypted at rest  
 and in transit, which protects it from unauthorized access.  
```
apiVersion: v1
kind: Secret
metadata:
  name: my-tls-secret
type: kubernetes.io/tls
data:
  tls.crt: |
    -----BEGIN CERTIFICATE-----
    MIIE6DCCA9ACCQEmr4/l37Z33h4w+b3/43
    -----END CERTIFICATE-----
  tls.key: |
    -----BEGIN RSA PRIVATE KEY-----
    MIIEpgIBAAKCAQEAx96u163/1t+fX/63/1t+fX/
    -----END RSA PRIVATE KEY-----
```
Bootstrap Token Secret:
=======================
```
apiVersion: v1
kind: Secret
metadata:
  name: my-bootstrap-token-secret
type: bootstrap.kubernetes.io/token
data:
  token: my-bootstrap-token
```
