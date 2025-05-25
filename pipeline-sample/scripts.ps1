$resourceGroupName = "tf-backend-rg"
$location = "West Europe"
$storageAccountName = "tfazbackendstore2709" # Must be globally unique
$containerName = "tf-backend"

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location 
# Create a storage account
New-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName `
-Location $location -SkuName Standard_LRS -Kind StorageV2 
New-AzStorageContainer -Name $containerName -Context (Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName).Context

