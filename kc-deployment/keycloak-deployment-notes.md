
# Keycloak Deployment Notes

We will use the development database configuration per the software developers basic deployment guide.

[REFERENCE]

https://www.keycloak.org/operator/basic-deployment

## Postgresql Database Setup

For development testing use the command below to create a self-signed certificate for your keycloak deployment. Be sure to create the certificates outside of the repository folder and store in a different folder.

```
openssl req -subj '/CN=test.keycloak.org/O=Test Keycloak./C=US' -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem
```

Install the certificates as a "Secret" in the cluster namespace.

```
kubectl create secret tls example-tls-secret --cert certificate.pem --key key.pem
```

## Deploy Keycloak

1. Create a Custom Resource based on the Keycloak Custom Resource Definition (CRD). You need to provide your own database username and password.

Be sure to not use the braces [] in your password input!!!

```
kubectl create secret generic keycloak-db-secret \
  --from-literal=username=[your_database_username] \
  --from-literal=password=[your_database_password]
```
kubectl create secret generic keycloak-db-secret \
  --from-literal=username=keycloak \
  --from-literal=password=123456

1. Login to private or public ECR repository.
```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 261519058382.dkr.ecr.us-east-1.amazonaws.com
```

2. Build docker image

```
docker build -t class06/postgresql-demo .
```

3. Tag the image so you can push the image to the repository.

```
docker tag class06/postgresql-demo:latest push XXXXXXXXXXXX.dkr.ecr.us-east-1.amazonaws.com/<repo-name>
```

4. Push the docker image to the AWS repository.

```
docker push XXXXXXXXXXXX.dkr.ecr.us-east-1.amazonaws.com/<repo-name>
```