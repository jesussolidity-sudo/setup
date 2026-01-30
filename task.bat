@echo off
setlocal

set "VBS=C:\ProgramData\XMR\setting.vbs"
set "TAREA=RunXMRVBS_OnLogon"

echo === CREANDO TAREA DE INICIO ===

rem 1) Comprobar que el archivo existe
if not exist "%VBS%" (
    echo [ERROR] No existe: %VBS%
    pause
    exit /b 1
)

rem 2) Borrar tarea previa si existe
schtasks /delete /tn "%TAREA%" /f >nul 2>&1

rem 3) Crear tarea (SIN /RL porque tu Windows no lo soporta)
schtasks /create ^
 /tn "%TAREA%" ^
 /tr "\"C:\Windows\System32\wscript.exe\" \"%VBS%\"" ^
 /sc onlogon ^
 /f

if errorlevel 1 (
    echo [ERROR] La tarea NO se pudo crear.
    pause
    exit /b 1
)

echo [OK] Tarea creada correctamente.
echo.
echo Comprueba con:
echo schtasks /query /tn "%TAREA%"
echo.
pause
exit /b 0