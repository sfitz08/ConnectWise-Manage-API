`   <#
.Synopsis
	#used to set parameters for the headers of the HTTP call
.DESCRIPTION
Sets the variables needed for making https calls to the ConnectWise API.
.EXAMPLE
	set-cwparams
.EXAMPLE
	
.INPUTS
	Company ID,  Public API Key, Private API Key, and Client ID
.OUTPUTS
	Global variables needed for header info on HTTP Calls
.NOTES
	
#>
function Set-CWparams {
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory = $true)][string]$companyid,
        [Parameter(Mandatory = $true)][string]$PubKey,
        [Parameter(Mandatory = $true)][string]$prikey,
        [Parameter(Mandatory = $true)][string]$global:clientID
    )
       
    $add = "+" 
    $colon = ":"
      
    #combines above elements into format to be encoded
    $toEncode = "$CompanyID$add$pubkey$colon$prikey"
    
    $by = [System.Text.Encoding]::UTF8.GetBytes($toencode)
    $global:auth = [Convert]::ToBase64String($By)
    
}