@REM -----------------------------------------------------------------------------
@REM DOT Startup Script for windows
@REM   Allows to run valet from calling 'dot' command in the windows command prompt.
@REM
@REM Environment Variable Prerequisites
@REM
@REM   VALET_HOME        Must point to the Valet installation directory with unix path (e.g. /c/Users/jcaillon/.local/valet.
@REM   VALET_BIN_BASH    Must point to bash executable (defaults to C:\Program Files\Git\bin\bash.exe).
@REM -----------------------------------------------------------------------------
@REM Begin all REM lines with '@' for safety
@echo off

@setlocal

set ERROR_CODE=0

@REM Try to find the path to bash.exe or fail
if not "%VALET_BIN_BASH%"=="" goto GotBinBash
set "VALET_BIN_BASH=C:\Program Files\Git\bin\bash.exe"
if exist "%VALET_BIN_BASH%" goto GotBinBash
set "VALET_BIN_BASH=%LOCALAPPDATA%\Programs\Git\bin\bash.exe"
if exist "%VALET_BIN_BASH%" goto GotBinBash
for %%i in (bash.exe) do set "VALET_BIN_BASH=%%~$PATH:i"
if exist "%VALET_BIN_BASH%" goto chkMHome
echo The VALET_BIN_BASH environment variable is not defined correctly, >&2
echo this environment variable is needed to run this program. >&2
goto error

:GotBinBash
@REM echo On windows, VALET_BIN_BASH was %VALET_BIN_BASH% >&2

@REM Try to find the path to valet
if not "%VALET_HOME%"=="" goto GotValetHome
set "VALET_HOME_WIN=%USERPROFILE%\.local\valet"
if exist "%VALET_HOME_WIN%\valet" goto DefineValetHome

echo The VALET_HOME environment variable is not defined correctly, >&2
echo this environment variable is needed to run this program. >&2
goto error

:DefineValetHome
set "VALET_HOME=/c/Users/%USERNAME%/.local/valet"

:GotValetHome
@REM echo On windows, VALET_HOME was %VALET_HOME% >&2

"%VALET_BIN_BASH%" -c "%VALET_HOME%/valet %*"

if ERRORLEVEL 1 goto error
goto end

:error
set ERROR_CODE=1

:end
@endlocal & set ERROR_CODE=%ERROR_CODE%

