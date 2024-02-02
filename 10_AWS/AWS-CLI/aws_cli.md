YT: https://youtu.be/TiDSwf8gydk?si=U5A0ucj0H5NZ9ulg    

What is AWS CLI?     
-------------  
The AWS Command Line Interface (AWS CLI) is a unified tool to manage your AWS services.     
With just one tool to download and configure, you can control multiple AWS services from the command line and automate them through scripts.    

Use of AWS cli?    
--------------- 
Quick access to AWS   
The AWS CLI provides direct access to the public APIs of AWS services. You can explore a service's capabilities with the AWS CLI, and develop shell scripts to manage your   
resources. In addition to the low-level, API-equivalent commands, several AWS services provide customizations for the AWS CLI.    
 


pre-requisites AWS CLI  
-------------------  

aws-cli  
python3  
aws access & secret keys    


How to install AWS CLI?  
------------------

On any linux flavour :  

aws cli: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html    
 -------------Commands from the above link---------  
 ```
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"  
  sudo apt install unzip
  unzip awscliv2.zip  
  sudo ./aws/install
```
  ------------------------------
 aws --version (shows the aws cli version & python version if it's installed)  


How to create AWS Access & Secret access Key?  

aws console >> aws account name(top right hand corner) >> security Credentials:    

  * Access keys:  
      *Create access key:  
         If using root access key Preferred to use IAM user:  
           * ck: Continue to create access key?  
              * ck: Create access key  
                 * Download the .csv file(file has access & secret key)  
---------------------   

How to connect with AWS cli of particulor account?  

aws configure   
AWS Access Key ID [None]: #copy paste access key AKIAZQWRNK45FWZJ3M5C  
AWS Secret Access Key [None]: #copy paste secret access keymPAiNEoRpRzLhkO2v7SN7nh3/CFukqEwkkOkZhG8  
Default region name [None]: Enter any reigon or just Enter  
Default output format [None]: Enter any format or just Enter(it gives json format)  

------------------Basic AWS CLI COMMANDS----------  
AWS CLI Commnads ref link:  https://docs.aws.amazon.com/cli/latest/  

aws s3 ls  
aws s3api create-bucket --bucket kops-suresh-storage --region us-west-1  

