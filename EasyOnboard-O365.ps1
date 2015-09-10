# EasyOnboard-O365
# by David Hernandez

# Tested on Powershell v3 and Server 2008R2

# This script can be used to quickly create users and assign them to the appropriate
# group, but it was designed with Office 365 in mind. This script forces the onboarder
# to enter all the information required for DirSync to successfully add the new user, 
# without generating an '.onmicrosoft.com' alias or causing other headaches. This script
# was writtin with functionality in mind for a multi-domain environment.

# Before running in your environment, please do the following:
# 1. Customize $OUHier to match your AD structure. This is the PARENT folder that your department OUs are in. $OUDefault is the default child folder within $Ouhier
# 2. Customize the Department names and quantity. Modify the menu that prompts the user and the amount of if(choice -eq #) loops appropriately

$OUhier = #"OU=Location Users,OU=Office,dc=Company,dc=tld"
$OUdefault = #"OU=Unassigned Users"

$dept0 = #"Department 0"
$dept1 = #"Department 1"
$dept2 = #"Department 2"
$dept3 = #"Department 3"
$dept4 = #"Department 4"
$dept5 = #"Department 5"
$dept6 = #"Department 6"
$dept7 = #"Department 7"
$dept8 = #"Department 8"
$dept9 = #"Department 9"
$dept10 = #"Department 10"
$dept11 = #"Department 11"

Write-Host 
"EasyOnboard-O365
=================

PRESS CTRL-C AT ANY POINT TO EXIT.

No data is committed to AD until you
receive the final prompt to Create User

Please enter the following information for the new user:"

$firstname = Read-Host "The User's FIRST name" 
$lastname = Read-Host "The User's LAST name"
$email = Read-Host "The User's EMAIL ADDRESS"

$pass = Read-Host "The User's PASSWORD"
$pass1 = Read-Host "Confirm PASSWORD"
    $check = $pass.CompareTo($pass1)
    if($check -ne 0)
       {
       Read-Host "`nPasswords do not match. Script has shut down. Press 'Enter' to exit"
       Exit
    }

Write-Host `
"`nSelect the user's department:
 0. $dept0
 1. $dept1
 2. $dept2
 3. $dept3
 4. $dept4
 5. $dept5
 6. $dept6
 7. $dept7
 8. $dept8
 9. $dept9
10. $dept10
11. $dept11"

$choice = Read-Host "`nMake Selection (0-11)"

Write-Host "`nThe user is about to be created.`nVerify all entries are correct.`n`nTo exit, press CTRL-C."
Read-Host "To create user, press ENTER"

New-ADUser `
    -Name "$firstname $lastname" `
    -GivenName $firstname `
    -Surname $lastname `
    -UserPrincipalName $email `
    -EmailAddress $email `
    -OtherAttributes @{'proxyAddresses'="STMP:$email"} `
    -AccountPassword (ConvertTo-SecureString $pass -AsPlainText -Force) `
    -ChangePasswordAtLogon $FALSE `
    -Path "$OUDefault,$OUhier"

Set-ADUser -Identity "$firstname $lastname" -Enabled  $TRUE

    if($choice -eq 0){$choice = $dept0
    Get-ADUser -Identity "$firstname $lastname" | Move-ADObject -TargetPath "OU=$dept0,$OUhier"
    }
        
    if($choice -eq 1){$choice = $dept1
    Get-ADUser -Identity "$firstname $lastname" | Move-ADObject -TargetPath "OU=$dept1,$OUhier"
    }
    
    if($choice -eq 2){$choice = $dept2
    Get-ADUser -Identity "$firstname $lastname" | Move-ADObject -TargetPath "OU=$dept2,$OUhier"
    }

    if($choice -eq 3){$choice = $dept3
    Get-ADUser -Identity "$firstname $lastname" | Move-ADObject -TargetPath "OU=$dept3,$OUhier"
    }

    if($choice -eq 4){$choice = $dept4
    Get-ADUser -Identity "$firstname $lastname" | Move-ADObject -TargetPath "OU=$dept4,$OUhier"
    }

    if($choice -eq 5){$choice = $dept5
    Get-ADUser -Identity "$firstname $lastname" | Move-ADObject -TargetPath "OU=$dept5,$OUhier"
    }

    if($choice -eq 6){$choice = $dept6
    Get-ADUser -Identity "$firstname $lastname" | Move-ADObject -TargetPath "OU=$dept6,$OUhier"
    }

    if($choice -eq 7){$choice = $dept7
    Get-ADUser -Identity "$firstname $lastname" | Move-ADObject -TargetPath "OU=$dept7,$OUhier"
    }

    if($choice -eq 8){$choice = $dept8
    Get-ADUser -Identity "$firstname $lastname" | Move-ADObject -TargetPath "OU=$dept8,$OUhier"
    }

    if($choice -eq 9){$choice = $dept9
    Get-ADUser -Identity "$firstname $lastname" | Move-ADObject -TargetPath "OU=$dept9,$OUhier"
    }

    if($choice -eq 10){$choice = $dept10
    Get-ADUser -Identity "$firstname $lastname" | Move-ADObject -TargetPath "OU=$dept10,$OUhier"
    }

    if($choice -eq 11){$choice = $dept11
    Get-ADUser -Identity "$firstname $lastname" | Move-ADObject -TargetPath "OU=$dept11,$OUhier"
    }

Write-Host "User Created successfully! Press any key to exit."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")