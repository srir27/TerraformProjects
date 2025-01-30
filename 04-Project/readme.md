# Terraform Provisioners
This project demonstrates the use of various provisioners available in Terraform: `file`, `local-exec`, and `remote-exec`.

## Project Overview 
The primary goal of this project is to showcase the deployment of Terraform provisioners to configure a Linux VM.

### PowerShell Scripts
PowerShell scripts are used to:
- Create the Resource Group
- Set up the Storage Account
- Create a Blob container to store the Terraform state file

### Shell Script
A simple shell script is used to:
- Install Nginx
- Enable and start Nginx
- Deploy a custom webpage

### Provisioners
`local-exec` : create log files for vm creation start time and the actual deployment after configurations.
`file` : to copy the setup (configuration) file from local to the virtual machine.
`remote-exec`: responsible for configuring the vm, installs nginx.

## Architecture 
**Azure Storage Account**: Acts as a remote backend to store the Terraform state files.
**Azure VM**: Utilized to deploy the `remote-exec` provisioner for configurations.
**Azure VNET, Subnet, PublicIP**: Provide the essential network setup for the virtual machine, allowing HTTP and SSH connections.
