# WebApp Blue-Green Deployment Project
This project demonstrates a blue-green deployment strategy for an Azure Web App, managed through Terraform. 

## Project Overview
The goal of this project is to set up a web application with two deployment slots (blue and green) to enable seamless, zero-downtime deployments.

## Architecture
**Azure Resource Group**: Contains all the resources for the deployment.
**Azure App Service Plan**: Defines the hosting plan for the web app.
**Azure Linux Web App**: The main web application instance.
**Deployment Slots**: Two slots (blue and green) for blue-green deployment.
**Source Control Integration**: Automatically deploys code from a GitHub repository to the web app slots.


