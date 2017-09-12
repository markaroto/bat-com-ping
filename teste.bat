@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set /A x=-1
for /F %%A in (maquinas.txt) do (
	set /A x+=1
	set ip[!x!].name=%%A
	set ip[!x!].status=fazer
)
rem contandor
set /A p=-1
rem quantidade maquinas feito.
set /A b=-1
:while	
        set /A p+=1		
		if "!ip[%p%].status!" == "fazer" (			
			call :ping	!p!	
			echo "!ip[%p%].status!"
			if "!ip[%p%].status!" EQU "ok" (
				set /A b+=1
			)
		)		
		if "%x%" == "%p%" (
			set /A p=-1
			TIMEOUT /T 10
		)
		echo "%x%" 
		echo "%b%"
		if "%x%" EQU "%b%" (
			goto :sair
		) ELSE (
			goto :while
		)
        
    
:ping
set cont=%1
ping -l 1 !ip[%cont%].name!% 
if %errorlevel% NEQ 0 (
	echo !ip[%cont%].name! >> maquina_desligada.txt
) ELSE (
	echo !ip[%cont%].name! >> maquina_enviar.txt
	::robocopy
	dir c:\cmd
	if %errorlevel% EQU 0 (
		set ip[!cont!].status=ok
		echo !ip[%cont%].name! >> maquina_copiado.txt
	)
)
exit /b 0

:sair
pause
exit /b 0