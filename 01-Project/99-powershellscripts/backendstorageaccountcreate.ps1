$ResourceGroupName = "tf-backend-project1"
$location = "North Europe"
$StorageAccName = "tfbckndstatestore01"
$ContainerName = "tfstatefile01"

#Creating the Storage Account
New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Location $location `
-Name $StorageAccName -Kind StorageV2 -SkuName Standard_LRS -Verbose 

#Creating the container
$storagecontext = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccName
$context = $storagecontext.Context
New-AzStorageContainer -Name $ContainerName -Context $context

#Enable Blob versioning when storing state files!