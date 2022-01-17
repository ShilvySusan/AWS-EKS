# AWS-EKS
Basic terraform code for creating AWS EKS Cluster
-------------------------------------------------
Pre-requisites:
===============
1. Install 
    a. Terraform
    b. AWS_CLI
    c. AWS_IAM_Authenticator
    d. Kubectl
2. Create AWS account
3. Create IAM user and attach permissions 
____________________________________________________

Providers:
========
AWS	3.72.0
Kubernetes	2.7.0

Modules:
========
eks 18.2.0
vpc 3.11.3

Data Sources:
=============
aws_availability_zones : 
aws_eks_cluster :
aws_eks_cluster_auth :

Inputs:
=======
provider aws:-
region : AWS Region in which EKS Cluster is planned create.
module eks:-
1 cluster_name:	Name of the EKS cluster
2 cluster_version: 	Kubernetes <major>.<minor> version to use for the EKS cluster (i.e.: 1.21)
3 eks_managed_node_groups: 	Map of EKS managed node group definitions to create
4 subnet_ids:	A list of subnet IDs where the EKS cluster (ENIs) will be provisioned along with the nodes/node groups.
5 vpc_id:	ID of the VPC where the cluster and its nodes will be provisioned  
module vpc:-
1. azs:	A list of availability zones names or ids in the region
2. cidr:	The CIDR block for the VPC
3. enable_nat_gateway:	Should be true if you want to provision NAT Gateways for each of your private networks
4. enable_vpn_gateway:	Should be true if you want to create a new VPN Gateway resource and attach it to the VPC
5. enable_dns_hostnames:	Should be true to enable DNS hostnames in the VPC
6. private_subnets:	A list of private subnets inside the VPC  
7. public_subnets:	A list of public subnets inside the VPC
provider kubernetes:-
host - The hostname (in form of URI) of the Kubernetes API. 
cluster_ca_certificate -  PEM-encoded root certificates bundle for TLS authentication. 
token - Token of your service account.

  
  Readings:
  =========
  1. https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html
  2. https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
  3. https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
  4. https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html
  5. https://www.terraform.io/language
  6. https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#credentials-config
  7. https://learn.hashicorp.com/terraform
