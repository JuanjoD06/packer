# Configuración básica
$computerName = "WS2022"
$adminUsername = "Administrador"
$adminPassword = "Windowsserver2022"

# Configuración de red
$interfaceIndex = (Get-NetAdapter).InterfaceIndex[0]
New-NetIPAddress -AddressFamily IPv4 -IPAddress 192.168.1.100 -PrefixLength 24 -InterfaceIndex $interfaceIndex
Set-DNSClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses 8.8.8.8, 8.8.4.4

# Activar la característica de Hyper-V
Enable-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V -All -Online

# Reiniciar la máquina virtual
Restart-Computer -Force