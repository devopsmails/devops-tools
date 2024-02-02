Probes:
By regularly performing health checks on your containers, probes help ensure only healthy pods are serving traffic and unhealthy ones are quickly restarted or scaled down.
features:
  Detecting pod crashes or malfunctions
  Controlling pod lifecycle
  Scaling efficiently
  Improved service reliability
Probes types:
Liveness probes:
  Check if a container is actually running and can handle requests.
  Unresponsive pods based on liveness probe failures are automatically restarted.
Readiness probes:
  Verify if a container is fully initialized and ready to receive traffic.
  Pods failing readiness probes are marked as unhealthy and removed from the service endpoint, preventing         users from encountering unresponsive application instances.
Startup probes:
  For slow-starting applications, these probes delay pod readiness until the application is fully ready and functioning, preventing premature exposure to traffic.
ex:
spec:
      containers:
      - name: my-web-container
        image: my-web-image:latest
        ports:
        - containerPort: 8080
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8080
          initialDelaySeconds: 15
          periodSeconds: 20
          failureThreshold: 3
        readinessProbe:
          httpGet:
            path: /readyz
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 10
          successThreshold: 1
          failureThreshold: 3
