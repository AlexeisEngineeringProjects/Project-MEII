@echo off
color 2

title ME2_Solver Terminal

echo ===============================================================
echo                    ## ME2_Solver Utility ##
echo         codet by Crivcianschi Alexei, TUCN, march 2025
echo.
echo ---------------------------------------------------------------
echo.
echo            Starting your script... Please wait!
echo            Date: %date%    Time: %time%
echo ===============================================================
echo.

:ask
set /p mypath=Insert the Project Folder Path: 

set /p answer=Do you want to continue? [Y/N]: 

if /i "%answer%"=="Y" goto execution

if /i "%answer%"=="N" goto end
    
:execution
matlab.exe -nosplash -nodesktop -r "cd('%mypath%'); HomeDirectory='%mypath%'; run('src\main.m'); exit;"
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
