@echo off
chcp 65001 >nul
title Gestione Turni

echo.
echo   ╔══════════════════════════════════════╗
echo   ║        GESTIONE TURNI  v1.0          ║
echo   ╚══════════════════════════════════════╝
echo.

:: Trova Java: prima il JDK bundled, poi JAVA_HOME, poi PATH
set "JAVA_CMD="
if exist "%~dp0jdk\bin\java.exe" (
    set "JAVA_CMD=%~dp0jdk\bin\java.exe"
) else if defined JAVA_HOME (
    if exist "%JAVA_HOME%\bin\java.exe" set "JAVA_CMD=%JAVA_HOME%\bin\java.exe"
)
if not defined JAVA_CMD (
    where java >nul 2>&1
    if %errorlevel%==0 (
        set "JAVA_CMD=java"
    ) else (
        echo [ERRORE] Java non trovato.
        echo Installare Java 17 da: https://adoptium.net
        pause
        exit /b 1
    )
)

:: Trova il JAR
set "JAR=%~dp0turni.jar"
if not exist "%JAR%" (
    echo [ERRORE] turni.jar non trovato nella cartella corrente.
    pause
    exit /b 1
)

echo   Avvio server in corso...
echo   (prima apertura: attendere 20-30 secondi)
echo.

:: Apri il browser dopo 3 secondi
start /b "" cmd /c "timeout /t 3 /nobreak >nul && start http://localhost:8080"

:: Avvia il server (resta in primo piano)
"%JAVA_CMD%" -jar "%JAR%"

:: Se arriviamo qui, il server si e' chiuso
echo.
echo   Server terminato. Premere un tasto per chiudere.
pause >nul
