Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force;

 function netdisk_connect([string]$webpath,[string]$username,[string]$passwd,[string]$diskid){
    
     if($diskid.length -ne 0){
        $diskpath=$diskid+":"
         $checkdisk=net use

         if($checkdisk -match $diskpath){
            net use $diskpath /delete
            }
           }

     $checkdisk=net use

     if($checkdisk -like "*$webpath*"){
       net use $webpath /delete
       }

      net use $webpath /user:$username $passwd /PERSISTENT:yes
      net use $webpath /SAVECRED 

      if($diskid.length -ne 0){
         net use $diskpath $webpath          
      }

      }

netdisk_connect -webpath \\192.168.60.16\srvprj\Inventec\Dell -username pctest -passwd pctest -diskid Y
netdisk_connect -webpath \\192.168.20.20\sto\EO\2_AutoTool\ALL -username stoai -passwd 4%r4B+ZB -diskid Z

remove-item C:\modules\* -r -Force

Start-Process -FilePath "C:\Windows\System32\cmd.exe" -verb runas -ArgumentList {/c git clone https://github.com/106094/modules --local C:\modules }

$pathd20="Z:\103.Dell_AITest\AITest\modules"
$pathd60="Y:\Matagorda\07.Tool\_AutoTool\modules"

$pathdet=@($pathd20,$pathd60)

Start-Sleep -s 10
#gci C:\modules\* | ?{$_.psiscontainer}|remove-item -Recurse -Force -ErrorAction SilentlyContinue

Get-ChildItem C:\modules -filter *.psm1|%{
$fnamefull=$_.FullName
$fnmae=$_.Name
$fhash=(Get-FileHash $fnamefull).hash
foreach($pathdetf in $pathdet){
if (test-path $pathdetf){
$fdet=gci $pathdetf |?{$_.name -eq $fnmae}
if($fdet){
$fhashdet=(Get-FileHash ((gci $pathdetf |?{$_.name -eq $fnmae}).fullname)).hash
    if($fhash -ne $fhashdet){
    Copy-Item $fnamefull -Destination $pathdetf -Force
    add-content -path C:\Logs\Backup.log -Value "$(get-date) : Update $($fnmae) to $pathdetf"
    }
    }
else{
Copy-Item $fnamefull -Destination $pathdetf -Force
add-content -path C:\Logs\Backup.log -Value "$(get-date) : New $($fnmae) to $pathdetf"

}
}
else{
echo "fail to connect $($pathdetf) "
}
}
}

foreach($pathdetf in $pathdet){
if (test-path $pathdetf){
Get-ChildItem $pathdetf -filter *.psm1|%{
$fdnamefull=$_.fullname
$fdnmae=$_.Name
$checksource=(Get-ChildItem C:\modules |?{$_.name -eq $fdnmae}).count
if($checksource -eq 0){
remove-item $fdnamefull -Force
add-content -path C:\Logs\Backup.log -Value "$(get-date) : remove $($fdnamefull) in $pathdetf"
}
}
}
else{
echo "fail to connect $($pathdetf) "
}
}

$recont=get-content C:\Logs\Backup.log
$recont|?{$recont.indexof($_) -gt 1000}|set-content C:\Logs\Backup.log

<#
try{
robocopy C:\modules\ $path20  /MIR /R:2 /W:5 /LOG+:C:\Logs\Backup.log
robocopy C:\modules\ $path60  /MIR /R:2 /W:5 /LOG+:C:\Logs\Backup.log
}catch{
 Write-Output "fail to sync moduels"
}

$recont=get-content C:\Logs\Backup.log
$recont|?{$recont.indexof($_) -gt 1000}|set-content C:\Logs\Backup.log
#>