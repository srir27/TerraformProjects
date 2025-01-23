# Global VNet Connectivity Test Project
This project demonstrates the connectivity between virtual networks (VNets) in different Azure regions, managed through Terraform. 

## Project Overview
The goal of this project is to establish and test the connectivity between two VNets located in different Azure regions to ensure seamless communication and robust infrastructure setup.

## Architecture
**Azure Storage Account**: Used as a remote backend to store the Terraform state files.  
**VNet1**: A virtual network in the first Azure region with defined subnets.  
**VNet2**: A virtual network in the second Azure region with defined subnets.  
**VNet Peering**: Enables connectivity between VNet1 and VNet2, allowing resources in different regions to communicate.  
**Azure VMs**: Deployed in each VNet to test connectivity.  
**Azure NSGs**: Network Security Groups to control inbound and outbound traffic.
