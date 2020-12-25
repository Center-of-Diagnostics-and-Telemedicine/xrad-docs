@rem System environment variables setup for XRAD library
@choice /M "Setup XRAD core variables?"
@if %errorlevel%==1 call :SetupXRAD
@choice /M "Setup XRAD Qt/Qwt variables?"
@if %errorlevel%==1 call :SetupQt

@echo Please, restart the console (cmd) for the changes to take an effect.
@goto :EOF



:ImportantNote
@echo Important!
@echo This script doesn't support symbols "^|<> in directory path.
@echo Please, don't use them here. Use system environment variable settings dialog to setup them.
@echo .
@goto :EOF



:SetupXRAD
@setlocal
@set _xrad_root=%XRADRoot%
@if NOT DEFINED _xrad_root set _xrad_root=Q:\XRAD
@set _xrad_install=%XRADInstall%
@if NOT DEFINED _xrad_install set _xrad_install=Q:\XRADInstall
@set _xrad_third_party=%XRADThirdParty%
@if NOT DEFINED _xrad_third_party set _xrad_third_party=Q:\XRADThirdParty

:lRepeatXRAD
@call :ImportantNote

@echo Default value for XRADRoot: "%_xrad_root%".
@set _xrad_root_default=%_xrad_root%
@echo Enter XRADRoot directory full path (no quotes, empty for default):
@set /P _xrad_root=
@if "%_xrad_root%"=="" set _xrad_root=%_xrad_root_default%

@echo Default value for XRADInstall: "%_xrad_install%".
@set _xrad_install_default=%_xrad_install%
@echo Enter XRADInstall directory full path (no quotes, empty for default):
@set /P _xrad_install=
@if "%_xrad_install%"=="" set _xrad_install=%_xrad_install_default%

@echo Default value for XRADThirdParty: "%_xrad_third_party%".
@set _xrad_third_party_default=%_xrad_third_party%
@echo Enter XRADThirdParty directory full path (no quotes, empty for default):
@set /P _xrad_third_party=
@if "%_xrad_third_party%"=="" set _xrad_third_party=%_xrad_third_party_default%

@echo XRADRoot=%_xrad_root%
@echo XRADInstall=%_xrad_install%
@echo XRADThirdParty=%_xrad_third_party%
@choice /C YNQ /M "Is it correct?"
@if %errorlevel%==3 exit 0
@if not %errorlevel%==1 goto lRepeatXRAD

@if not exist "%_xrad_root%" mkdir "%_xrad_root%"
@if not exist "%_xrad_install%" mkdir "%_xrad_install%"
@if not exist "%_xrad_third_party%" mkdir "%_xrad_third_party%"

@setx XRADRoot "%_xrad_root%"
@setx XRADInstall "%_xrad_install%"
@setx XRADThirdParty "%_xrad_third_party%"
@endlocal
@goto :EOF



:SetupQt
@setlocal
@set _QTDIR5x86=%QTDIR5x86%
@if NOT DEFINED QTDIR5x86 set _QTDIR5x86=c:\Qt\5.15.2\msvc2019
@set _QTDIR5x64=%QTDIR5x64%
@if NOT DEFINED QTDIR5x64 set _QTDIR5x64=C:\Qt\5.15.2\msvc2015_64
@set _QWTDIR5x86=%QWTDIR5x86%
@if NOT DEFINED QWTDIR5x86 @set _QWTDIR5x86=C:\QWT\6.1.5\VS2019\Qt5.15.2-x86
@set _QWTDIR5x64=%QWTDIR5x64%
@if NOT DEFINED QWTDIR5x64 set _QWTDIR5x64=C:\QWT\6.1.5\VS2015\Qt5.15.2-x64

:lRepeatQt
@call :ImportantNote

@echo Default value for QTDIR5x86: "%_QTDIR5x86%".
@set _QTDIR5x86_default=%_QTDIR5x86%
@echo Enter QTDIR5x86 directory full path (no quotes, empty for default, - to delete):
@set /P _QTDIR5x86=
@if "%_QTDIR5x86%"=="" set _xrad_third_party=%_QTDIR5x86_default%

@echo Default value for QTDIR5x64: "%_QTDIR5x64%".
@set _QTDIR5x64_default=%_QTDIR5x64%
@echo Enter QTDIR5x64 directory full path (no quotes, empty for default, - to delete):
@set /P _QTDIR5x64=
@if "%_QTDIR5x64%"=="" set _xrad_third_party=%_QTDIR5x64_default%

@echo Default value for QWTDIR5x86: "%_QWTDIR5x86%".
@set _QWTDIR5x86_default=%_QWTDIR5x86%
@echo Enter QWTDIR5x86 directory full path (no quotes, empty for default, - to delete):
@set /P _QWTDIR5x86=
@if "%_QWTDIR5x86%"=="" set _xrad_third_party=%_QWTDIR5x86_default%

@echo Default value for QWTDIR5x64: "%_QWTDIR5x64%".
@set _QWTDIR5x64_default=%_QWTDIR5x64%
@echo Enter QWTDIR5x64 directory full path (no quotes, empty for default, - to delete):
@set /P _QWTDIR5x64=
@if "%_QWTDIR5x64%"=="" set _xrad_third_party=%_QWTDIR5x64_default%

@echo QTDIR5x86=%_QTDIR5x86%
@echo QTDIR5x64=%_QTDIR5x64%
@echo QWTDIR5x86=%_QWTDIR5x86%
@echo QWTDIR5x64=%_QWTDIR5x64%
@choice /C YNQ /M "Is it correct?"
@if %errorlevel%==3 exit 0
@if not %errorlevel%==1 goto lRepeatQt

@rem Don't create Qt/Qwt directories.

@if "%_QTDIR5x86%"=="-" set _QTDIR5x86=
@setx QTDIR5x86 "%_QTDIR5x86%"
@if "%_QTDIR5x64%"=="-" set _QTDIR5x64=
@setx QTDIR5x64 "%_QTDIR5x64%"
@if "%_QWTDIR5x86%"=="-" set _QWTDIR5x86=
@setx QWTDIR5x86 "%_QWTDIR5x86%"
@if "%_QWTDIR5x64%"=="-" set _QWTDIR5x64=
@setx QWTDIR5x64 "%_QWTDIR5x64%"
@endlocal
@goto :EOF
