# Running Elastic Search on Minishift Locally

### Starting Minishift 
```bash
christian-mbp15:elasticsearch cjavellana$ minishift start --vm-driver=xhyve --insecure-registry 172.30.0.0/16 --insecure-registry docker-registry-default.172.16.166.138.xip.io --insecure-registry minishift --memory 6144
```

### Enabling elastic search to run in PROD mode
```bash
$ vi /var/lib/boot2docker/profile
```

insert the line: 
sysctl -w vm.max_map_count=262144

```bash
$ vi /etc/init.d/docker
```

Before the start() function, insert:
ulimit -l unlimited

Restart docker:
```bash
$ /etc/init.d/docker restart
```

Note:
Have to do this everytime until we can persist boot2docker vm changes.

### Pushing docker images to minishift registry
```bash
christian-mbp15:elasticsearch cjavellana$ oc login -u admin -p admin
christian-mbp15:elasticsearch cjavellana$ oc get svc
NAME              CLUSTER-IP       EXTERNAL-IP   PORT(S)                 AGE
docker-registry   172.30.241.226   <nodes>       5000/TCP                6h
kubernetes        172.30.0.1       <none>        443/TCP,53/UDP,53/TCP   6h
```