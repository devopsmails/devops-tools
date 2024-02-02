
GH: https://github.com/iam-veeramalla/Docker-Zero-to-Hero/blob/main/networking.md  

What is networking on Docker?  
----------------------------

Docker networking allows containers to communicate with each other and the host machine.  
It is done by creating and connecting networks.  
There are different types of networks, each with its own purpose.  

Docker networking types:   
------------------- 

Bridge networks:   
----------
      The default type of network in Docker.   
      They are created automatically when you create a container.   
      Bridge networks provide isolation between containers, but they also allow containers to communicate with each other.  
      
Example: docker network create my-network    

Host networks:  
--------------
    Allow containers to share the host's network stack.  
    This means that containers connected to a host network can communicate with each other and with the host machine   
    as if they were all running on the same physical machine.

Example: docker network create --driver host my-network    

Overlay networks:   
---------------
    More complex than bridge networks, but they offer more flexibility.   
    Overlay networks can span multiple Docker hosts, allowing containers to communicate with each other even if they  
    are running on different machines.  
    
Example: docker network create --driver overlay my-network  

Macvlan networks:   
----------------
    Allow containers to be connected to physical network interfaces on the host machine.   
    This can be useful for containers that need to have direct access to the network, such as containers that are   
    running network monitoring or security applications.  

Example: docker network create --driver macvlan my-network  

docker networking commands:
---------------------------

docker network ls

docker network create #dev_network
        - creates ""custom bridge network"" for isolation
        
docker network create --driver host #host-net-name
        - creates ""Host network""
docker network create --driver overlay #overlay-net-name
        - Creates ""Overlay network name""

docker network rm #dev_network

docker run -d --name #login-cont-name nginx: latest     
      - Creates a container with default ""Bridge network""

docker network ls

docker network connect #dev-netowrk #login-cont
      - connects an existing container to an existing network
      - this container will have 2 networks: 1. when they created default ""bridge network""
                                             2. The connected network
                                             
docker network disconnect #dev-netowrk #login-cont
      - disconnect a network connected to the container. 

docker inspect #container-name
      - shows IP, Networks, volumes attached to container

docker exec -it #container-name /bin/bash
      - allows to login to container & perfom actions like apt update && apt-get install iputils-ping -y =   
      for pining ip to check the connection
      ping #ip address
            If they are in the same network communicates else will not communicate.

docker attach #conatiner_name
      - to see any input, output, or error details on a running container. 

docker run -d --name host-demo-cont --network=host nginx:latest
      - running a container on a ""Host network""
      - network - Host
      - Ip - "" Empty as it is using Host network directly.
      
docker ps
docker network prune 
      - removes all the networks which are unused.
      
