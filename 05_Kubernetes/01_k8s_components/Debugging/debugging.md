errors:  

1.Imagepullbackoff
```
   Reasons: Invalid Image / Invalid Tag / Invalid image permissions
```

2. Image pulled but pod is pending

```
ResourceQuota on namespace ?
Request & Limits set?
Node & Node lacks Resources?
Aslo, Check the kubescheule component?

doc: https://kubernetes.io/docs/reference/kubectl/cheatsheet/ 
kubectl get events --sort-by=.metadata.creationTimestamp
      # Verifying differnt logs with timestamp for every action in k8

```

3.CrashLoopBackOff
```
ressons:
--------
  Written dockerfile create an image
  USER 1001 in it but run commnad states to go /etc/path do some action
  here image will be created
  sudo privilliages should be need to access /etc/path
 2. liveness prope failure  
 3.Application failed to start for any reason
```
4.Out of Memory(OOMkilled)
---------------
```
 Memory leakage:
OOMKilled can be caused by a number of things, including:

Running too many processes
Allocating too much memory to a single process
Memory fragmentation
Software bugs

 sol1:
-----
log in container which is showing this error
run: df -ef
shows the PID & copy the thread which is leakeing the meamorey & share it to the developer.

kubectl get events
sol2:
----
The Linux mechanism to kill a process for OOMKilled (Out of Memory Killed) is to send the process a SIGKILL signal.
This signal terminates the process immediately, without giving it the opportunity to save its state.

When the system is running out of memory, the Linux kernel will select a process to kill based on the following criteria:
----------------------------------
The process must be runnable, meaning it is not waiting for I/O or other resources.
The process must be the youngest process in the system, meaning it has been running for the shortest amount of time.
The process must be the process with the lowest priority.
```
