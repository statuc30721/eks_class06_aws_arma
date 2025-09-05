
# Keycloak Deployment Notes

We will use the development database configuration per the software developers basic deployment guide.

[REFERENCE]

https://www.keycloak.org/operator/basic-deployment

## Postgresql Database Setup

For development testing use the command below to create a self-signed certificate for your keycloak deployment. Be sure to create the certificates outside of the repository folder and store in a different folder.

# Deploy Keycloak


## Create Docker images for Keycloak and PostgreSQL

## Obtain official docker image of Keycloak and PostgreSQL

[REFERENCE]

https://www.keycloak.org/keycloak-benchmark/kubernetes-guide/latest/util/custom-image-for-keycloak


1. Pull official docker image for Keycloak and PostgreSQL

2. Create folder for Keycloak and PostgreSQL on your local build system

3. In each folder create a docker file. In this repository there is an example Dockerfile *specifically* built to match this demonstration. I would recommend following known best practices for building container images that will be used in a kubernetes cluster.

## Create the customized Keycloak demonstration projects container images

Start Docker service

1. Login to private or public ECR repository.
```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 261519058382.dkr.ecr.us-east-1.amazonaws.com
```

2. Build docker image for keycloak and postgresql.

```
docker build -t <image-name> .
```

[NOTE] On a ARM64 based system (e.g. MacOS) you will need to use buildx if using Docker.

```
docker buildx build . --platform=linux/amd64 -t  class06/postgresql-demo:latest --load
```

```
docker buildx build . --platform=linux/amd64 -t  class06/keycloak-demo --load
```


3. Tag the image so you can push the image to the repository. Replace the XXXX block with the information provided in the AWS ECR instructions.

```
docker tag class06/postgresql-demo:latest push XXXXXXXXXXXX.dkr.ecr.us-east-1.amazonaws.com/<repo-name>
```

4. Push the docker image to the AWS repository. Replace the XXXX block with the information provided in the AWS ECR instructions.

```
docker push XXXXXXXXXXXX.dkr.ecr.us-east-1.amazonaws.com/<repo-name>
```

## Deploy PostgreSQL database and Keycloak to EKS
For now we use manual method using kubectl to deploy the database and keycloak containers to the kubernetes cluster.

1. Deploy PostgresQL

```
kubectl apply -f kc-deploymentdb/postgresql-pv.yaml
```
```
kubectl apply -f kc-deploymentdb/postgresql-pv-claim.yaml
```
```
kubectl apply -f kc-deploymentdb/postgresql-deployment.yaml
```
```
kubectl apply -f kc-deployment/db.postgresql-service.yaml
```

Verify postgresql is running and services are up

```
kubectl get deploy,svc,pod -n keycloak-demo
```

![kubectl pgsql info](/graphics/kubectl-get-svc-pod-deployments-pgsql.png)



2. Deploy Keycloak

```
kubectl apply -f kc-deployment/keycloak/kc-deployment.yaml
```

```
kubectl apply -f kc-deployment/keycloak/keycloak-service.yaml
```