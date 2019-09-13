Connect-AzAccount


# Get details of the virtual machine
$VM = Get-AzVM -ResourceGroupName "Test-RG" -Name "Test-VM"

Write-Output $VM