Docker installation:
-----------------

sudo apt update -y

sudo apt install docker.io -y

sudo systemctl status docker

docker run hello-world 
      - will not work now
      
sudo usermod -aG docker ubuntu
    - adds ubuntu to docker group
    
***Need to refresh to instance or exit & relogin***
docker run hello-world

git clone https://github.com/devopsmails/devops.git
      - cloning to private repo: Githubusername: devopsmails
                                 Pwd: Token
cd devops
cd docker
cd dockerfiles/python/basic1/

docker build -t devopsmails/gabby-python:latest . 
      - Builds a customize using Dockerfile using the current directory as an image tag as ""devopsmails/gabby-python:latest""

docker run -it devopsmails/gabby-python:latest
      - runs & execution of the code as container




