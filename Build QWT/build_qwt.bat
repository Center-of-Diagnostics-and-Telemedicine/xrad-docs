@echo off

rem Нужно модифицировать в документе sources\qwtconfig.pri параметр QWT_INSTALL_PREFIX:
rem В зависимости от платформы и версии Visual Studio следующие значения:
rem QWT_INSTALL_PREFIX = C:/Qwt/$$QWT_VERSION/Qt$$QT_VERSION/x86/VS2019
rem QWT_INSTALL_PREFIX = C:/Qwt/$$QWT_VERSION/Qt$$QT_VERSION/x64/VS2019
rem QWT_INSTALL_PREFIX = C:/Qwt/$$QWT_VERSION/Qt$$QT_VERSION/x64/VS2015

rem 
rem Все изменения уже внесены в файлы, находящиеся в каталоге platform_configurations,
rem скрипт должен скопировать правильный вариант в каталог, откуда устанавливаем
rem


@echo on
@echo copy /Y platform_configurations\%1\qwtconfig_%2%3.pri %1\qwtconfig.pri
copy /Y platform_configurations\%1\qwtconfig_%2%3.pri %1\qwtconfig.pri

@echo goto l_%2_%3
goto l_%2_%3

:l__

	@echo call syntax:
	@echo build first second third
	@echo where first argument = qwt directory path
	@echo  first argument = VS version
	@echo third argument = Build platform
	@echo example: build qwt-6.1.5 VS2015 x64

	goto l_end

:l_VS2015_x64
	rem     ------------------------------      MSVS2015x64     ------------------------------      
	call "c:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64\vcvars64.bat" 
	goto l_install

:l_VS2019_x64
	rem     ------------------------------      MSVS2019x64     ------------------------------      
	call "c:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat" 
	goto l_install

:l_VS2019_x86
	rem     ------------------------------      MSVS2019x86     ------------------------------      
	call "c:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars32.bat"
	goto l_install

:l_install
	md temp
	cd temp

	call qmake ..\%1\qwt.pro 


	call nmake
	call nmake install
	cd ..
	RD /S /Q temp 

:l_end
pause