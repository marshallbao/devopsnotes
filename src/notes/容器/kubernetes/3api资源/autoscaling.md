autoscale

```
# kubectl -n irita autoscale deployment irita-home --cpu-percent=50 --min=1 --max=10

#
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: irita-home
  namespace: irita
spec:
  maxReplicas: 10
  metrics:
  - resource:
      name: cpu
      target:
        averageUtilization: 50
        type: Utilization
    type: Resource
  minReplicas: 1
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: irita-home

```

