<#
.Synopsis
	pulls ticket info after being provided a ticket number 
.DESCRIPTION
	If you skip /$ticketnumber from the end of the URL it will pull all tickets. This will require pagination (https://developer.connectwise.com/Best_Practices/PSA_Pagination?mt-learningpath=manage)
.EXAMPLE
	Get-Cwticket
.EXAMPLE
	
.INPUTS
	Ticketnumber
.OUTPUTS
	
.NOTES
	
#>
function  get-cwticket {
  
  Param
  (
    # Param1 help description
    [Parameter(Mandatory = $false)][string]$ticketnumber
  )
  #this checks to see if you ran set-cwparams yet and prompts you to do so if not. Goal was to save time so you do not manually enter the info for it to fail on authorization
  if ($null -eq $global:auth) {
    write-host "Please run set-cwparams before running any GET commands " -ForegroundColor red
    return
  }
    
  #standard headers required for REST API calls to CW
  $headers = @{
    'authorization' = "basic $global:auth"
    'clientID'      = $global:clientID
    'content-type'  = 'application/json'
  }
  #this should be the 6-8 digit ticket number in connectwise.  
         
  Invoke-RestMethod -uri https://api-na.myconnectwise.net/v2022_2/apis/3.0/service/tickets/$ticketnumber -Method Get -Headers $headers
}
  