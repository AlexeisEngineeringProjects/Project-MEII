@echo off

color 2

title ME2_Solver

echo.
echo __/\\\\____________/\\\\__/\\\\\\\\\\\\\\\____/\\\\\\\\\______     
echo  _\/\\\\\\________/\\\\\\_\/\\\///////////___/\\\///////\\\____     
echo   _\/\\\//\\\____/\\\//\\\_\/\\\_____________\///______\//\\\___
echo    _\/\\\\///\\\/\\\/_\/\\\_\/\\\\\\\\\\\_______________/\\\/____
echo     _\/\\\__\///\\\/___\/\\\_\/\\\///////_____________/\\\//______
echo      _\/\\\____\///_____\/\\\_\/\\\_________________/\\\//_________
echo       _\/\\\_____________\/\\\_\/\\\_______________/\\\/____________
echo        _\/\\\_____________\/\\\_\/\\\\\\\\\\\\\\\__/\\\\\\\\\\\\\\\__
echo         _\///______________\///__\///////////////__\///////////////___  

echo.
echo.
echo    ===============================================================
echo                           ME 2  Solver Utility
echo            codet by Crivcianschi Alexei, TUCN, march 2025
echo.
echo    ---------------------------------------------------------------
echo.
echo               Starting your script... Please wait!
echo               Date: %date%    Time: %time%
echo    ===============================================================
echo.

:ask
set /p mypath=Insert the Project Folder Path: 

set /p answer=Do you want to continue? [Y/N]: 

if /i "%answer%"=="Y" goto execution

if /i "%answer%"=="N" goto end
    
:execution
matlab.exe -nosplash -nodesktop -r "cd('%mypath%'); HomeDirectory='%mypath%'; start_method=0; run('src\main.m'); " rem exit;
echo.
echo Launching the Matlab Terminal ...
pause > nul

echo.
set /p answer=Do you want to repeat script execution? [Y/N]: 

if /i "%answer%"=="Y" goto execution

if /i "%answer%"=="N" goto end

:end

echo.   
echo press any key to exit
pause > nul 