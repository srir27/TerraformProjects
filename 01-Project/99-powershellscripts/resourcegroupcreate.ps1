$ResourceGroupName = "tf-backend-project1"
$location = "North Europe"
$tags = @{
    "owner" = "rsb"
    "deployment" = "powershell"
    "created_on" = (Get-Date).ToString('MM-dd-yyyy') 
}

#Creating the resource group
New-AzResourceGroup -Name $ResourceGroupName -Location $location -Tag $tags -Verbose

