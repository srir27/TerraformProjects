# Web Game Hosted on Azure VMSS and Load Balancer 
This project showcases a simple web game developed in php, hosted using Azure Virtual Machine Scale Set (VMSS) and a Load Balancer, managed through Terraform modules. 

## Project Overview 
The goal of this project is to demonstrate the deployment of a web game on a scalable infrastructure using Azure VMSS and a Load Balancer to ensure high availability and load distribution. 

### Powershell Scripts
Used PS scripts to create the Resource Group, Storage Account and Blob container to store the terraform state file.

## Architecture - 
**Azure Storage Account**: Remote Backene to store the terraform state files.
**Azure VMSS**: Automatically scales the number of VM instances based on demand. 
**Azure Load Balancer**: Distributes incoming traffic across the VM instances to ensure even load distribution and availability.
**Azure NAT Gateway**: To provide outbound connectivity to the backend vmss.
**Azure VNET, Subnet, PubicIP**: Basic network setup