```
There are 2 ways to deploy artifacts to Jfrog repo:  
1.Jfrog integration with Jenkins(Widely used)  
2.Jfrog integration with Maven:
3.Jfrog Deploy(Jfrog Dashboard >> Deploy >> Upload or Drag & Drop)
(part-2, https://youtu.be/Lh-T1rwdjj0?si=wrZmrstPycXbdXUN)
```
JFROG INTEGRATION WITH JENKINS
```
Jenkins >> manage jenkins >> plugins >> available Plugins >> search: ""Artifactory""
                                                            Install & restart


Jenkins >> manage Jenkins >> systems >> artifactory >> 
Jfrog:
    > add jfrog platform credentials
        JFrog instance details:
            Instance ID: gabby-dev-jfrog
            JFrog Platform URL: http://35.154.20.37:8082/
            Default Deployer Credentials:
                Username: admin(jfrog username)
                Password: Devops@1(jfrog password)
                    Test connection: 



```