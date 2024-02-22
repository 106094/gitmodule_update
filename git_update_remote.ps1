Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force;

#https://woshub.com/using-psremoting-winrm-non-domain-workgroup/

#check target device connecting
#Test-NetConnection 192.168.60.59 -Port 5985
#Test-WsMan 192.168.60.59

#Set-Item wsman:\localhost\client\TrustedHosts -Value 192.168.60.59 -Force 
#or
#Set-Item wsman:\localhost\Client\TrustedHosts -value * -Force 

Invoke-Command -ComputerName 192.168.60.59 -Credential 192.168.60.59\1111  -ScriptBlock {&"C:\gitmodule_update\git_update.bat"}