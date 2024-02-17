What is Artifact?
----------
```
An artifact is a piece of data or code generated during the software development process. 
like compiled code, documentation, configuration files, test results, or deployment packages.
```
What is Artifactory?
----
```
An Artifactory is a tool used in software development and DevOps practices for managing binary artifacts.
Artifactory serves as a repository manager, providing a centralized location for storing and managing these artifacts.  
It allows developers to easily store, retrieve, version, and distribute artifacts across different stages of the software development lifecycle.
```
Types of Artifactories?
```
Jfrog
Nexus
AWS code artifactory
```
What is Jfrog Artifactory?
```
JFrog Artifactory is a universal artifact repository manager developed by JFrog. 
    > Helps with versioning for rollback when needed
It acts as a central hub for storing, managing, and distributing various software artifacts used throughout the development process. 
It is a secure library for all software building blocks.
```
Jfrog Benefits?
```
Store a wide range of artifacts:
Provide secure access:
Automate workflows: CI/CD
Scale to your needs: Handle large volume of artificats 
```
Types Jforg Artifactory storing?

```
1.Local Repository
    Phiscically resides on the same machines 
    Accessable with in artifactory instance
2.Remote Repository
    Located on a separate machine, potentially another Artifactory instance.
    You cannot directly deploy or modify artifacts; you configure Artifactory to act as a cache or proxy for the remote repository.
     Useful for sharing artifacts externally,
3.Virtual Repository
    Not a physical location; it's a logical entity.
    Accessed through a single URL, hiding the complexity of the underlying repositories.
```