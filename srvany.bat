@ECHO OFF
SET /p FUNCTION="Do you want to create or delete a srvany service (1=CREATE/2=DELETE)? "
IF %FUNCTION%==1 GOTO CREATE
IF %FUNCTION%==2 GOTO DELETE

:CREATE
SET /p APPPATH="Enter the FULL PATH AND EXECUTABLE for the application you want to run as a service: "
COPY srvany.exe C:\WINDOWS\System32\srvany.exe
SC create "srvany" binPath="C:\WINDOWS\System32\srvany.exe"
REG add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\srvany\Parameters /v Application /t Reg_Sz /d %APPPATH%
SC start srvany
GOTO END

:DELETE
SC stop srvany
SC delete "srvany" binPath="C:\WINDOWS\System32\srvany.exe"
DEL C:\WINDOWS\System32\srvany.exe
GOTO END

:END
PAUSE