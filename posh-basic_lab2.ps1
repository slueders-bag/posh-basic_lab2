# Software Inventory

# Variables
$allApps = @()

# call WMI Software packages
$win32_product = @(get-wmiobject -class 'Win32_Product' -computer $env:COMPUTERNAME)

#store properties to object and add it to array
foreach ($app in $win32_product){
    $applications = New-Object PSObject -Property @{
        Name = $app.Name
        Version = $app.Version
    }
    $allApps +=$applications
}
# sort and export
$allApps | select name,version | sort name
$allApps | select name,version | sort name | ConvertTo-Html -Fragment -As Table -PreContent “<h1>Installed Software Report</h1>” | Out-File C:\temp\softwareInventory.html
