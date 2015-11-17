Param(
  [string]$dbUserName,
  [string]$dbPassword
)

$newLoginQuery = "CREATE LOGIN " + $dbUserName +  " WITH PASSWORD = '" + $dbPassword + "'"
$newUserQuery = "CREATE USER " + $dbUserName + " FOR LOGIN " + $dbUserName + " WITH DEFAULT_SCHEMA = " + $dbUserName + ";"
$updateUserRoleQuery = "ALTER ROLE db_datareader ADD MEMBER " + $dbUserName + ";" + 
                        "ALTER ROLE db_datawriter ADD MEMBER " + $dbUserName + ";" + 
                        "ALTER ROLE db_ddladmin ADD MEMBER " + $dbUserName + ";"
$newSchemaQuery = "CREATE SCHEMA " + $dbUserName + " AUTHORIZATION " + $dbUserName

Invoke-Sqlcmd -ServerInstance '(local)' -Database 'Model' -Query $newLoginQuery | Out-File -Append C:\Informatica\Archive\scripts\createdbusers.log
Invoke-Sqlcmd -ServerInstance '(local)' -Database 'Model' -Query $newUserQuery | Out-File -Append C:\Informatica\Archive\scripts\createdbusers.log
Invoke-Sqlcmd -ServerInstance '(local)' -Database 'Model' -Query $updateUserRoleQuery | Out-File -Append C:\Informatica\Archive\scripts\createdbusers.log
Invoke-Sqlcmd -ServerInstance '(local)' -Database 'Model' -Query $newSchemaQuery | Out-File -Append C:\Informatica\Archive\scripts\createdbusers.log