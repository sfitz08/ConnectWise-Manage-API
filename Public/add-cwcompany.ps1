<#
.Synopsis
	#creates company in connectwise. Calls add-cwstandardcontacts as well
.DESCRIPTION
	Creates a new company (store) in connectwise
.EXAMPLE
	add-cwcompany
.EXAMPLE
	
.INPUTS
	company identifier (store number)
  company name
  address1
  address2
  city
  statecode (MO, OH, TX, etc)
  zipcode
  countryid (1 for US, 2 for Canada, 4 for UK)
  phonenumber
.OUTPUTS
	
.NOTES
	
#>

function add-cwcompany {
  [CmdletBinding()]
  Param
  (
    #3 digits for US, 4 for UK
    [Parameter(Mandatory = $true)][string]$companyidentifier,
    [Parameter(Mandatory = $true)][string]$companyname,
    [Parameter(Mandatory = $true)][string]$Address1,
    [Parameter(Mandatory = $false)][string]$Address2,
    [Parameter(Mandatory = $true)][string]$city,
    [Parameter(Mandatory = $true)][string]$state,
    [Parameter(Mandatory = $true)][string]$zip,
    #(1 for US, 2 for Canada, 4 for UK)
    [Parameter(Mandatory = $true)][string]$countryid,
    [Parameter(Mandatory = $true)][string]$phonenumber

  )
  #standard headers required for REST API calls to CW  
  $headers = @{
    'authorization' = "basic $global:auth"
    'clientID'      = $global:clientID
    'content-type'  = 'application/json'
  }
  
  #Stores data in variable and converts to hash table for manipulation in powershell
  $global:companydata = '{
      "id": 0,
      "identifier": "string",
      "name": "string",
      "status": {
        "id": 1,
        "name": "string",
        "_info": {
          "additionalProp1": "string",
          "additionalProp2": "string",
          "additionalProp3": "string"
        }
      },
      "addressLine1": "string",
      "addressLine2": "string",
      "city": "string",
      "state": "string",
      "zip": "string",
      "country": {
        "id": 0,
        "identifier": "string",
        "name": "string",
        "_info": {
          "additionalProp1": "string",
          "additionalProp2": "string",
          "additionalProp3": "string"
        }
      },
      "phoneNumber": "string",
      "faxNumber": "string",
      "website": "string",
    
      "market": {
        "id": 0,
        "name": "string",
        "_info": {
          "additionalProp1": "string",
          "additionalProp2": "string",
          "additionalProp3": "string"
        }
      },
      "accountNumber": "string",
      "defaultContact": {
        "id": 0,
        "name": "string",
        "_info": {
          "additionalProp1": "string",
          "additionalProp2": "string",
          "additionalProp3": "string"
        }
      },
      "dateAcquired": "2023-08-23T17:07:56Z",
      "sicCode": {
        "id": 0,
        "name": "string",
        "_info": {
          "additionalProp1": "string",
          "additionalProp2": "string",
          "additionalProp3": "string"
        }
      },
    
      "annualRevenue": 0,
      "numberOfEmployees": 0,
      
    
    
      "leadSource": "string",
      "leadFlag": false,
      "unsubscribeFlag": true,
     
      "userDefinedField1": "string",
      "userDefinedField2": "string",
      "userDefinedField3": "string",
      "userDefinedField4": "string",
      "userDefinedField5": "string",
      "userDefinedField6": "string",
      "userDefinedField7": "string",
      "userDefinedField8": "string",
      "userDefinedField9": "string",
      "userDefinedField10": "string",
      "vendorIdentifier": "string",
      "taxIdentifier": "string",
      "taxCode": {
        "id": 0,
        "name": "string",
        "_info": {
          "additionalProp1": "string",
          "additionalProp2": "string",
          "additionalProp3": "string"
        }
      },
    
        "billingContact": {
        "id": 0,
        "name": "string",
        "_info": {
          "additionalProp1": "string",
          "additionalProp2": "string",
          "additionalProp3": "string"
        }
      },
    
      "invoiceToEmailAddress": "string",
      "invoiceCCEmailAddress": "string",
      "deletedFlag": false,
      "dateDeleted": "2023-08-23T17:07:56Z",
      "deletedBy": "string",
      "mobileGuid": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "facebookUrl": "string",
      "twitterUrl": "string",
      "linkedInUrl": "string",
      "currency": {
        "id": 0,
        "symbol": "string",
        "currencyCode": "string",
        "decimalSeparator": "string",
        "numberOfDecimals": 0,
        "thousandsSeparator": "string",
        "negativeParenthesesFlag": true,
        "displaySymbolFlag": true,
        "currencyIdentifier": "string",
        "displayIdFlag": true,
        "rightAlign": true,
        "name": "string",
        "_info": {
          "additionalProp1": "string",
          "additionalProp2": "string",
          "additionalProp3": "string"
        }
      },
      "territoryManager": {
        "id": 0,
        "identifier": "string",
        "name": "string",
        "_info": {
          "additionalProp1": "string",
          "additionalProp2": "string",
          "additionalProp3": "string"
        }
      },
      "resellerIdentifier": "string",
      "isVendorFlag": false,
      "types": [
        {
          "id": 1,
          "name": "string",
          "_info": {
            "additionalProp1": "string",
            "additionalProp2": "string",
            "additionalProp3": "string"
          }
        }
      ],
      "site": {
        "id": 0,
        "name": "Main",
        "_info": {
          "additionalProp1": "string",
          "additionalProp2": "string",
          "additionalProp3": "string"
        }
      },
      "integratorTags": [
        "string"
      ],
      "_info": {
        "additionalProp1": "string",
        "additionalProp2": "string",
        "additionalProp3": "string"
      }
    
    }' | convertfrom-json
     
  #gets data from parameters to create company
  $global:companydata.identifier = $companyidentifier
  $global:companydata.name = $companyname
  $global:companydata.addressLine1 = $address1
  $global:companydata.addressLine2 = $address2
  $Global:companydata.city = $city
  $global:companydata.state = $statecode
  $global:companydata.zip = $zipcode
  $global:companydata.country.id = $countryid
  $global:companydata.phoneNumber = $phonenumber
     
     
  Invoke-RestMethod -uri https://api-na.myconnectwise.net/v2022_2/apis/3.0/company/companies -Method post -Headers $headers -Body ($global:companydata | ConvertTo-Json -Depth 10)
    
  #calls separate funtion to add DM and "ticket managers" to the new company
  add-cwstandardcontacts
  
    
}