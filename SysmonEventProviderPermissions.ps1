# https://community.spiceworks.com/topic/415037-replace-all-child-object-permissions-powershell
# https://powertoe.wordpress.com/2010/08/28/controlling-registry-acl-permissions-with-powershell/
function GetAcl{
    param(
        [Parameter(Mandatory=$true)] $IdentityReference
    )

    $acl = New-Object System.Security.AccessControl.RegistrySecurity

    $acl.AddAccessRule((New-Object System.Security.AccessControl.RegistryAccessRule ("SYSTEM", "FullControl", 'ContainerInherit,ObjectInherit', 'None', 'Allow')))
    
    $acl.AddAccessRule((New-Object System.Security.AccessControl.RegistryAccessRule ($IdentityReference, "FullControl", 'ContainerInherit,ObjectInherit', 'None', 'Allow')))

    $acl.AddAccessRule((New-Object System.Security.AccessControl.RegistryAccessRule ("Authenticated Users", "ReadKey", 'ContainerInherit,ObjectInherit', 'None', 'Allow')))

    $acl.SetAccessRuleProtection($true, $false) # Make sure that the key doesn't inherit permissions from its parent

    return $acl;

}

$Acl = GetAcl -IdentityReference 'bob'

$Acl | Set-Acl -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Publishers\{5770385f-c22a-43e0-bf4c-06f5698ffbd9}"