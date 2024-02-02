What is docker volume? 
------------- 
Docker volumes are a way to persist data in Docker containers.  
They are separate from the container filesystem and are not deleted when the container is stopped or deleted.   
This makes them ideal for storing data that needs to be shared between containers or that needs to be preserved over multiple container runs.  

docker volume ls  

docker volume create #vol-name  

docker volume inspect #suresh-vol   
          - shows name, mountpoint or path  

docker volume rm suresh-vol
          - Removes the volume #sureh-vole

docker volume rm suresh-vol suresh-vol2
          - Removes the multiple volumes as well

docker volume ls

docker run -d --mount source=vol-suresh,target=/app nginx:latest
          - pulling an image from hub & running the container & mounting the volume to container

docker ps

docker volume ls

docker volume rm vol-suresh
          - Error: if Volume is attached to any container not possible to remove. first stop the contianer & remove the volumes & then start the container.

