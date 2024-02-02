YT: https://youtu.be/FllcHYsBm78?si=vKEbLYnedG_sHpGu

What is Secrets Management? 
-----------------------

Secret management is a practice that allows developers to securely store sensitive data such as passwords, keys, and tokens,   
in a secure environment with strict access controls.For small software projects, secret management can be simple to achieve.  

Types:
-----

  * System Manager(AWS)  
    > suitable for info which  is not that secret(Docker hub name, Registry URL...), Low comparatively with secret Manager
  * Secret Manager(AWS)  
    > Suitable for info which is highly secret(passwords, certifications). It has ""auto Rotate"" facility with high cost  
  * Hashicorp Vault(TF)  
    > Suitable for Centralized info if using for ""Multiple clouds"", Open Source, Community Driven + frequent fetures, Best Encryption than AWS.
