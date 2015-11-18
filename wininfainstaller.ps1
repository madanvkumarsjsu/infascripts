
Param(
  [string]$domainName,
  [string]$domainUser,
  [string]$domainPassword,
  [string]$nodeName,
  [int]$nodePort,

  [string]$dbType,
  [string]$dbName,
  [string]$dbUser,
  [string]$dbPassword,
  [string]$dbHost,
  [int]$dbPort,

  [string]$sitekeyKeyword,

  [string]$isMaster = 0,

  [string]$masterNodeHost,
  [int]$masterNodePort
)

$CLOUD_SUPPORT_ENABLE = "1"

$domainHost = $env:COMPUTERNAME

$infaHome = $env:SystemDrive + "\Informatica\9.6.1"
$installerHome = $env:SystemDrive + "\Informatica\Archive\961HF3_Server_Installer_winem-64t"

echo $infaHome
echo $installerHome


# DB Configurations if required

$dbAddress = $dbHost + ":" + $nodePort
$userInstallDir = $infaHome
$defaultKeyLocation = $infaHome + "\isp\config\keys"


$propertyFile = $installerHome + "\SilentInput.properties"

(gc $propertyFile | %{$_ -replace '^CREATE_DOMAIN=.*$',"CREATE_DOMAIN=1"  `
`
-replace '^JOIN_DOMAIN=.*$',"JOIN_DOMAIN=$isMaster"  `
`
-replace '^CLOUD_SUPPORT_ENABLE=.*$',"CLOUD_SUPPORT_ENABLE=$CLOUD_SUPPORT_ENABLE"  `
`
-replace '^ENABLE_USAGE_COLLECTION=.*$',"ENABLE_USAGE_COLLECTION=1"  `
`
-replace '^USER_INSTALL_DIR=.*$',"USER_INSTALL_DIR=$userInstallDir"  `
`
-replace '^KEY_DEST_LOCATION=.*$',"KEY_DEST_LOCATION=$defaultKeyLocation"  `
`
-replace '^PASS_PHRASE_PASSWD=.*$',"PASS_PHRASE_PASSWD=$sitekeyKeyword"  `
`
-replace '^SERVES_AS_GATEWAY=.*$',"SERVES_AS_GATEWAY=0" `
`
-replace '^DB_TYPE=.*$',"DB_TYPE=$dbTYPE" `
`
-replace '^DB_UNAME=.*$',"DB_UNAME=$dbUser" `
`
-replace '^DB_SERVICENAME=.*$',"DB_SERVICENAME=$dbName" `
`
-replace '^DB_ADDRESS=.*$',"DB_ADDRESS=$dbAddress" `
`
-replace '^DOMAIN_NAME=.*$',"DOMAIN_NAME=$env:domainName" `
`
-replace '^NODE_NAME=.*$',"NODE_NAME=$env:nodeName" `
`
-replace '^DOMAIN_PORT=.*$',"DOMAIN_PORT=$masterNodePort" `
`
-replace '^JOIN_NODE_NAME=.*$',"JOIN_NODE_NAME=$nodeName" `
`
-replace '^JOIN_HOST_NAME=.*$',"JOIN_HOST_NAME=$masterNodeHost" `
`
-replace '^JOIN_DOMAIN_PORT=.*$',"JOIN_DOMAIN_PORT=$masterNodePort" `
`
-replace '^DOMAIN_USER=.*$',"DOMAIN_USER=$domainUser" `
`
-replace '^DOMAIN_HOST_NAME=.*$',"DOMAIN_HOST_NAME=$domainHost" `
`
-replace '^DOMAIN_PSSWD=.*$',"DOMAIN_PSSWD=$domainPassword" `
`
-replace '^DOMAIN_CNFRM_PSSWD=.*$',"DOMAIN_CNFRM_PSSWD=$domainPassword" `
`
-replace '^DB_PASSWD=.*$',"DB_PASSWD=$dbPassword" 

}) | sc $propertyFile

cd $installerHome

$installCmd = $installerHome + "\silentInstall.bat"
<<<<<<< HEAD:winInfaInstaller.ps1
Start-Process $installCmd | Out-Null
=======
Start-Process $installCmd | Out-Null
>>>>>>> origin/master:wininfainstaller.ps1