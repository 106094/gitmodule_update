
$nowhour=(get-date).Hour
$nowmin=(get-date).minute

if($nowhour -ge 1 -and $nowhour -lt 2 -and $nowmin -ge 20 -and $nowmin -le 30){
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force;
$desfolders5="\\192.168.20.20\sto\EO\2_AutoTool\ALL\103.Dell_AITest\AITest\pcai"
$soufolder2="\\192.168.60.16\srvprj\Inventec\Dell\Matagorda\07.Tool\_AutoTool\pcai\*"

remove-Item  "$desfolders5\main\" -Recurse -Force
Copy-Item "$soufolder2" "$desfolders5" -Recurse -Force
}