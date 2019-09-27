#Declare the variables with the values for the different parameters to be passed. Only the values here needs to be changed.
#######################

$templatefile= './wa-template.json'    	    #path to template file
$parameterfile= './wa-parameters.json' 	    #path to parameter file
$rg= 'test'                                                                  #resource group name
$loc= 'West Europe'                                                        #location
$name= 'app001'                                                            #name of notification namespaceName

$sku= 'S1' 
$siteName = 'RANDOM-WEBSITE123'                        					    #Web-App Name
$hostingPlanName = 'RANDOM-WEBSITE-HOSTING123'								#hostingPlanName

########################
Write-host ("Collected all parameters for " +$name)
#Set the context to the current subscription where the resource group deployment should be done.

#Select-Azsubscription -Subscription $subs
#Write-Host ("subscription context is now set to: " +$subs)

#if resource exists, print that it exists and do not create new resource
    if((Get-AzResource -Name $name -ResourceType Microsoft.Web/serverfarms).Name -eq $name){
        Write-Host ("Resource with the given name exists: "+$name)
     }

#else if resource does not exist, run the loop
    else{
        Get-AzResourceGroup -Name $rg -ErrorVariable notPresent -ErrorAction SilentlyContinue
        if ($notPresent)
        {
    
        # Do resource group deployment if resource group does not exist by creating new resource group and then create the resource
        Write-Host ("Resource group does not exist. Creating new resource group: " +$rg)
         New-AzResourceGroup -Name $rg -Location $loc
         Write-Host("Successfully created new resource group: " +$rg)
         New-AzResourceGroupDeployment -ResourceGroupName $rg -sku $sku -siteName $siteName -hostingPlanName $hostingPlanName -TemplateFile $templatefile -TemplateParameterFile $parameterfile
         Write-Host ("Resource created: " +$name)
         break
        }

        else
        {
        # Do resource deployment only
        
         New-AzResourceGroupDeployment -ResourceGroupName $rg -sku $sku -siteName $siteName -hostingPlanName $hostingPlanName -TemplateFile $templatefile -TemplateParameterFile $parameterfile
            Write-Host ("Resource created: " +$name)
        }
    }
