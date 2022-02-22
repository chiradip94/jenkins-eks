# Jenkins on EKS

Terraform code that deploys EKS and installs Jenkins server using helm charts.

## Folder structure
```
 |___ terraform
 |      |___ modules
 |
 |___ helm
        |__ templates
```

## Prerequisites
- VPC
- subnets (public or private with nat gateways in case deployed from server within VPC).
- workstation/server having terraform and helm installed

## Features
- Deploys EKS with configurable version in a VPC and subnets provided.
- Deploys EKS managed linux Node Group.
- Deploys Jenkins server using helm chart.

## Usage
To deploy EKS cluster and Jenkins the following command is to be executed:

1. ```
   cd terraform
   terraform init
   ```

2. ```
   terraform plan \
   -var 'vpc_id=vpc-xxxxxx' \
   -var 'subnet_ids=["subnet-xxxxx", "subnet-yyyyy", "subnet-zzzzz"]' \
   -out terraform.tfplan
   ``` 
   - Validate the resources which will be created.

3. ``` 
    terraform apply "terraform.tfplan"
   ```

4. Access the Jenkins server using the loadbalancer created with port 8080.<br>
   Get the admin password using the following command.
   > kubectl exec --namespace tools -it svc/jenkins-server -c jenkins -- /bin/cat /run/secrets/chart-admin-password

   Replace the namespace if you used a different namespace.<br>
   Use admin as user and the password from the above command.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | Indicates whether or not the Amazon EKS private API server endpoint is enabled | `bool` | `true` | no | 
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | Indicates whether or not the Amazon EKS public API server endpoint is enabled | `bool` | `true` | no |     
| <a name="input_cluster_endpoint_public_access_cidrs"></a> [cluster\_endpoint\_public\_access\_cidrs](#input\_cluster\_endpoint\_public\_access\_cidrs) | List of CIDR blocks which can access the Amazon EKS public API server endpoint | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | `"tools-cluster"` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.21`) | `string` | `"1.21"` | no |
| <a name="input_jenkins_namespace"></a> [jenkins\_namespace](#input\_jenkins\_namespace) | K8s Namespace for jenkins deployment | `string` | `"tools"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region for the resources | `string` | `"us-east-1"` | no |      
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnets for eks | `list(string)` | `[]` | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC where eks is to be deployed | `string` | `null` | yes |    

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | The name of the cluster |  
