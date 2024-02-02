Pre-requisites:
Jenkins on Master node
Same version Java on Both Master & node servers

Agent creation:
=============
Jenkins DashBoard >> nodes & clouds >> new node >>
node name: java_agent
check: copy from existing >> to copy config from other existing nodes
                     or
check: Permanent >> to customize the node configurations >>
name: #nodename
Descriptions: purpose of the agent
Number of executors: 3 (how many pipelines can run at a time)
Remote root directory: /home/jenkins(in which dir it should work on)
Labels: java_agent_dev(label used to call agent in pipeline building)careful
usage: choice: as much as possible/only when called
Launch method: by controller:
Custom WorkDir path: /home/jenkins
Availability:choice: Keep This agent online always/come online when called
save
  ----------
after saving it we get some configuration commands to execute on agent server:
on Agent server:
=========
cd /home
mkdir /home/jenkins
chmod 777 jenkins
**************copy paste the below type of commands on the path one by one*****************

curl -sO http://54.197.73.238:8080/jnlpJars/agent.jar
java -jar agent.jar -jnlpUrl http://54.197.73.238:8080/computer/agent2/jenkins-agent.
jnlp -secret 722b9521453499468916408b3c49c5be84dc325896d7956ffcdd87304236513c -workDir "/home/jenkins"
**************************end it states connected***************

We can manage jenkins>> nodes & clouds
The agent is online(=no cross red mark)
===================
pipeline script:
================

pipeline {
####################
    agent {
        label 'java_agent'
    }
#################### 
    stages {
        stage ('Git Cloning'){
            steps{
                script {
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

