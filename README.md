# Infrastructure
Infrastructure is using Terraform to manage Azure resources.

## Features
- IaC: Infrastructure as code 
- Replicable infrastructure (Teams interested on using IaC can take this repo and adapt it to their requirements)
- Centralized and easy to maintain with peer review for increased visiblity regarding changes.
- State aware (Which means that it can be run automatically in pipelines without worrying of the existent recources being duplicated) 
- These terraform scripts create 2 AKS clusters in westus2 and eastus2
    - ![Pipeline](https://user-images.githubusercontent.com/21299688/128250610-8e829836-1da8-474b-b23e-e13d86c24c4f.PNG)

## Main Commands

- Init (Needs to be ran every time we add a new provider)
```bash
terraform init
```
- Plan (Describe all the actions that will take place, it is recommended to have an output file)
```bash
terraform plan -out tf.plan
```
- Apply ()
```bash
terraform apply tf.plan
```
## Getting Started
### Source Code
![SourceCode](https://user-images.githubusercontent.com/21299688/128255088-d9a4536b-9990-43db-91ab-1309ffcbfca2.PNG)

- Scripts in `aks-shared-resources` folder create common azure resources for AKS
    - Resource Group for AKS clusters
    - Azure Container Registry
    - Front Door
    - Log Analytics Workspace
    - Application Insights
- Scripts in `aks-cluster` folder create various AKS resources
    - AKS Cluster
    - Public Ip
    - Namespaces
    - AKS Dashboard
    - Cert Manager
    - Ingress Controller
    - Ingress Rules
    - Horizontal Pod Autoscaler
    - Keyvault AKS Access Policy 
    - ACR AKS Role Assignment

### Azure resources prerequisite
1. Resource group with name `terraform-storage-rg`
    1. Storage account
        1. Storage account with name `terraformstate12` in the above resource group
        2. Container within the above storage account with name `tfstatefiles`
    2. Key vault
        1. Key vault with name `terraform-integration-1` in the above resource group

### Terraform Script variables 
- In `terraform-manifests/aks-shared-resources/variable.tf`, change the following variables default values to unique names.
    1. log_analytics_workspace_name
    2. acr_prefix 
    3. application_insights_name
    4. proj_id
    

- In `terraform-manifests/aks-cluster/variable.tf`, change the following variables default values to unique names.
    1. proj_id
    2. aks->resource_group
    3. aks->cluster_name    
       ![AksVar](https://user-images.githubusercontent.com/21299688/128260795-eba5a7fe-77d3-4269-9b6b-09959caabdc7.PNG)

    
### Azure DevOps Pipeline Setup
- Provide access to a Service Principal Name which would be used to run the pipeline to create azure resources
    - ![ServiceConnection](https://user-images.githubusercontent.com/21299688/128252318-77077aad-9122-4d74-b550-284b97cd3a86.PNG)
    

- Replace `aadGroupId` in the `azure-pipelines.yml` which is required to integrate Azure Active Directory with Azure Kubernetes Service.
    - ![aadgroup](https://user-images.githubusercontent.com/21299688/128251634-b1ea9e5f-2bf5-4746-b9b1-d606d4044500.PNG)

-  Create a CI/CD pipeline with `azure-pipelines.yml` file. Run this pipeline to create multiple aks clusters as configured in the scripts.

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft 
trademarks or logos is subject to and must follow 
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
