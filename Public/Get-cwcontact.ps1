<#
.Synopsis
Pull contact info from CW
.DESCRIPTION
As is, will pull all contacts in ConnectWise. To see all you, this will require pagination (https://developer.connectwise.com/Best_Practices/PSA_Pagination?mt-learningpath=manage).EXAMPLE
.EXAMPLE
	Write-error "Error Updating OsdStatusMessages Database, Zero records were updated, Clear-OSDImageStatus"
.INPUTS
	None
.OUTPUTS
	Returns the number of records updated
.NOTES
	
#>

#As is, will pull all contacts in ConnectWise. To see all you, this will require pagination (https://developer.connectwise.com/Best_Practices/PSA_Pagination?mt-learningpath=manage)
function get-cwcontact {
  
  #this checks to see if you ran set-cwparams yet and prompts you to do so if not. Goal was to save time so you do not manually enter the info for it to fail on authorization  
  if ($null -eq $global:auth) {
    write-host "Please run set-cwparams before running any POST commands " -ForegroundColor red
    return
  }
    
  #standard headers required for REST API calls to CW
  $headers = @{
    'authorization' = "basic $global:auth"
    'clientID'      = $global:clientID
    'content-type'  = 'application/json'
  }
  Invoke-RestMethod -uri https://api-na.myconnectwise.net/v2022_2/apis/3.0/company/contacts -Method get -Headers $headers   
    
}
  
