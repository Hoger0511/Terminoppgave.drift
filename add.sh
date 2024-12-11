# Importer Active Directory-modulen
Import-Module ActiveDirectory
 
# Definer stien til CSV-filen
$csvPath = "C:\Users\Administrator\Documents\brukere.csv"
 
# Les CSV-filen
$users = Import-Csv -Path $csvPath
foreach ($user in $users) {
    # Definer brukerkontoegenskapene
    $firstName = $user.FirstName
    $lastName = $user.LastName
    $userName = $user.UserName
    $password = $user.Password
    $ou = $user.OU
   
    # Opprett brukerkontoen
    New-ADUser -GivenName $firstName `
               -Surname $lastName `
               -Name "$firstName $lastName" `
               -SamAccountName $userName `
               -UserPrincipalname "$userName@example.com" `
               -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
               -Path $ou `
               -Enabled $true `
               -PassThru
}