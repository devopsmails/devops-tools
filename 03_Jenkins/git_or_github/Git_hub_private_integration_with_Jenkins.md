Git Hub integration with Jenkins by Access Token

Git Hub:
======
Should create a Private repo >> ex:sureshprivate
github Profile settings >> Developers settings >> create acceess Token >>classic:
  generate classic token:
  token name: Git_hub_Token
  token expiration: 6 months
  Select the scope suitable(repo privilliages)
  Click:Generate token
  Copy paste safely as it will not be available again
--------

on Jenkins:
=======
Manage Jenkins>> credentials >> Globals>> create creadentials >>
username & password 
username: githubusername
pwd: Copied access token from github 
id: Git_hub_access_Token
description: Git_hub_access_Token
save & apply
-----------
Jenkins DashBoard:
===========
new item:
=======
name: private_git_hub_cloning:
pipeline
create:

pipeline Script:
================
pipeline {
    agent any
    
    stages {
        stage ('Git Cloning'){
            steps{
                script {
###generated from pipeline syntax: git####
                        git branch: 'main', credentialsId: 'GitHub_Access_Token', url: 'https://github.com/devopsmails/devops.git'    
                }
            }
        }
        
        stage ('Success cloning'){
            steps {
                script {
                    sh '''
                    echo "Cloning succeeded"
                    '''
                }
            }
        }
    }
}









