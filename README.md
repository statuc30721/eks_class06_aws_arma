# Class 6 AWS

Purpose: For educational purposes only. This is based on an assignment to demonstrate academic progress in learning cloud based Information Technologies.

# Assignment
Create an Amazon Web Services EKS cluster leveraging various references and workflows.

There are three separate sections in this repository. They are in separate folders to make it easier to navigate the repository.

This repository supports manual and autmated deployment of applications on Amazon Web Service Elastic Kubernetes Cluster (EKS).

The default setup will deploy a Virtual Private Cloud (VPC), kubernetes cluster, a EC2 instance as a bastion, Envoy, Prometheus and Grafana.

[CAUTION] This repository is not intended for production use and requries additional work to properly secure and optimize the cluster and applications.

## Section I - Deploy EKS cluster and applications
There are two options in the deployment. Option (1) is automated and Option (2) is manual.

The instructions for manual installation of Envoy, Grafana and Prometheus are in the following files:
- Envoy

    envoy-deplpyment/envoy-notes.md

- Prometheus

    prometheus-deployment/prometheus-notes.md

- Grafana

    grafana-deployment/grafana-notes.md

[NOTE] The default configuration is for terraform to deploy the cluster with services automatically. The only service that is not automatically deployed is Envoy.

Each service is deployed with a load balancer automatically.

[BASTION_EC2] Depending on your requirements a EC2 instance was added that can automatically deploy in your VPC. The EC2 instance is commeneted out so it will not deploy by default. 

The instructioons for automated installation of the EC2 instance is in the following file:
ec2-bastion-deployment/ec2-bastion-notes.md

[SCREENSHOTS]

Below are examples of deployed assets:

- EKS deplpoyment with EC2 Instance, Prometheus and Grafana

![Deployed Bastion, AWS EKS console, Grafana and Prometheus ](/graphics/deployment-screenshot.jpg)


- EKS VPC Network 

![VPC Network Map](/graphics/eks-vpc-resource-map.png)


- EKS Cluster Automatic Scaling Group

![EKS ASG](/graphics/eks-cluster-auto-scaling-group.png)

- Envoy Deployment

![Envoy Deployed](/graphics/eks-envoy-deployment.png)

- Grafana and Prometheus Stack Deployed

![EKS-Prom-Stack](/graphics/eks-prom-grafana-stack.png)


## Section II - Deploy applications to EKS using Docker

This provides instruction for deploying containerized applications built using Docker and deploying them into a EKS cluster. In this section AWS ECR is leveraged. 

You can also modify the code and workflow to use a different repository where the container images will be stored (e.g. Sonatype Nexus, Docker Hub, Quay.io)


## Section III - Streamline User Access

This provides a workflow leveraging Terraform for creation of a IAM group that has read-only access to a Amazon S3 bucket and administrator access to AWS Bedrock.

It also allows for creation of IAM users and adds them to the previously created IAM group.

Variables are incorporated to allow for changes (as needed).


References: 

https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks

https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html

https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html

https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
