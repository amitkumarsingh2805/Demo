#Login to Azure using powershell
$password = ConvertTo-SecureString '20@Amit04' -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ('amitkumar_sin@hcl.com', $password)
Login-AzureRmAccount -Credential $Credential

#Setting up location
$location="West Europe"  

#Create a resource group.  
New-AzureRmResourceGroup -Name $(rgname) -Location $location  

#Create an App Service plan in Free tier.  
New-AzureRmAppServicePlan -Name $(asp) -Location $location -ResourceGroupName $(rgname) -Tier Free  


#Create a web app.   
New-AzureRmWebApp -Name $(app) -Location $location -AppServicePlan $(asp) -ResourceGroupName $(rgname)