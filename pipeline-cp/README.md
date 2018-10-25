

#### Using persistent disk for acme
Create GKE Persistent Disk
```
gcloud compute disks create --size=1GB --zone=us-central1-a acme-cert
```

Enable persistence in traefik
```
traefik:
  persistence:
    enabled: true
```




