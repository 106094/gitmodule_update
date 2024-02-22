@echo off & setlocal
set batchPath=%~dp0
PowerShell.exe -ExecutionPolicy Bypass -File "%batchPath%git_update.ps1"
PowerShell.exe -ExecutionPolicy Bypass -File "%batchPath%pcaisync.ps1"
