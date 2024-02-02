Secure API server :(Transport Layer Security)
    Goto api server pod >> edit >> add TLS file, private key, client key
    Restric the access: trhough RBAC
RBAC (Role Base Access Control) :
  Cluster role
  Role Binding

Network policies:
  Creating network policies & attaching to the namespaces for limiting the access.
  
Encrypted at rest(ETCD):
  Sensitive data in ETCD can be secured using encrypting only who has decrypt KEY ONLY can read the files.
  
Secure container images:
  Scan docker images for vulnerbilities using synk or trivy
  
Cluster monitering:
  using ""Sysdig"" tool we can moniter & get alert and define rules no body should root login execpt, no bobody should reach /etc/shadow..

frequent upgrades: 
  make sure to use updated version so that patches are fixed in the previous versions if were any!

  
