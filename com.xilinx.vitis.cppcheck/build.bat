@echo off
setlocal enabledelayedexpansion

REM ========================================
REM Vitis Cppcheck Plugin - Complete Build and Package Script
REM ========================================

echo.
echo ========================================
echo   Vitis Cppcheck Plugin
echo   Build and Distribution Package
echo ========================================
echo.

REM ========================================
REM Configuration - Modify according to your environment
REM ========================================

REM Java installation path
if not defined JAVA_HOME (
    set "JAVA_HOME=D:\Xilinx2021\Vitis\2021.1\tps\win64\jre11.0.2"
)

REM Maven installation path (optional, if not in PATH)
REM set "MAVEN_HOME=D:\Soft\apache-maven-3.9.12"

REM ========================================

REM Verify Java
echo [1/7] Checking Java environment...
if not exist "%JAVA_HOME%\bin\java.exe" (
    echo.
    echo Error: Java not found
    echo JAVA_HOME: %JAVA_HOME%
    echo.
    echo Please edit this script and modify JAVA_HOME variable
    echo.
    echo Common path examples:
    echo   D:\Xilinx2021\Vitis\2021.1\tps\win64\jre11.0.2
    echo   C:\Program Files\Java\jdk-11
    echo.
    pause
    exit /b 1
)

for /f "tokens=3" %%i in ('"%JAVA_HOME%\bin\java.exe" -version 2^>^&1 ^| findstr /i "version"') do set "JAVA_VER=%%i"
echo [OK] Java: %JAVA_HOME%
echo      %JAVA_VER%
echo.

REM Verify Maven
echo [2/7] Checking Maven environment...
set "MVN_CMD=mvn"
where mvn >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    if defined MAVEN_HOME (
        if exist "%MAVEN_HOME%\bin\mvn.cmd" (
            set "PATH=%MAVEN_HOME%\bin;%PATH%"
            echo [OK] Maven: %MAVEN_HOME%
        ) else (
            echo Maven not found, please install or set MAVEN_HOME
            echo.
            pause
            exit /b 1
        )
    ) else (
        echo Maven not found, please install or set MAVEN_HOME
        echo Download: https://maven.apache.org/download.cgi
        echo.
        pause
        exit /b 1
    )
) else (
    for /f "tokens=3" %%i in ('mvn -version 2^>^&1 ^| findstr "Apache Maven"') do set "MVN_VER=%%i"
    echo [OK] Maven ready
)
echo.

REM Get version info
set VERSION=1.0.0
set DATE=%date:~0,4%-%date:~5,2%-%date:~8,2%
set PACKAGE_NAME=vitis-cppcheck-plugin-%VERSION%-%DATE%

echo Build Configuration:
echo   Version: %VERSION%
echo   Date: %DATE%
echo   Package: %PACKAGE_NAME%
echo.

REM Maven Build
echo [3/7] Building with Maven...
echo ========================================
echo.

cd %~dp0com.xilinx.vitis.cppcheck.parent
call mvn clean package -DskipTests

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ========================================
    echo Build FAILED!
    echo ========================================
    echo.
    pause
    exit /b 1
)

echo.
echo [OK] Build successful!
echo.

REM Create offline package
echo [4/7] Creating offline installation package...
echo ========================================

set "REPOSITORY_DIR=%~dp0com.xilinx.vitis.cppcheck.repository\target\repository"
set "OUTPUT_DIR=%~dp0offline-package"
set "PLUGINS_DIR=%OUTPUT_DIR%\plugins"
set "FEATURES_DIR=%OUTPUT_DIR%\features"

if exist "%OUTPUT_DIR%" rd /s /q "%OUTPUT_DIR%"
mkdir "%PLUGINS_DIR%"
mkdir "%FEATURES_DIR%"

echo Copying plugin files...
copy /Y "%REPOSITORY_DIR%\plugins\com.xilinx.vitis.cppcheck.core_*.jar" "%PLUGINS_DIR%\" >nul 2>&1
copy /Y "%REPOSITORY_DIR%\plugins\com.xilinx.vitis.cppcheck.ui_*.jar" "%PLUGINS_DIR%\" >nul 2>&1
copy /Y "%REPOSITORY_DIR%\plugins\com.xilinx.vitis.cppcheck.builder_*.jar" "%PLUGINS_DIR%\" >nul 2>&1
copy /Y "%REPOSITORY_DIR%\features\com.xilinx.vitis.cppcheck.feature_*.jar" "%FEATURES_DIR%\" >nul 2>&1

echo.
echo [OK] Offline package created!
echo.

REM Create distribution package structure
echo [5/7] Creating distribution package structure...
echo ========================================

set "DIST_DIR=%~dp0dist-package\%PACKAGE_NAME%"
set "FINAL_ZIP=%~dp0dist-package\%PACKAGE_NAME%.zip"

REM Clean old package
if exist "%DIST_DIR%" rd /s /q "%DIST_DIR%"
if exist "%FINAL_ZIP%" del /f /q "%FINAL_ZIP%"

REM Create directories
mkdir "%DIST_DIR%\p2-update-site"
mkdir "%DIST_DIR%\dropins\cppcheck\plugins"
mkdir "%DIST_DIR%\dropins\cppcheck\features"

echo Copying p2 update site files...
xcopy /s /q "%REPOSITORY_DIR%\*" "%DIST_DIR%\p2-update-site\" >nul

echo Copying dropins files...
copy /y "%PLUGINS_DIR%\*.jar" "%DIST_DIR%\dropins\cppcheck\plugins\" >nul
copy /y "%FEATURES_DIR%\*.jar" "%DIST_DIR%\dropins\cppcheck\features\" >nul

echo.
echo [OK] Distribution structure created!
echo.

REM Copy documentation
echo [6/7] Copying documentation...
echo ========================================

copy /y "%~dp0dist-package\README.md" "%DIST_DIR%\" >nul 2>&1
copy /y "%~dp0dist-package\INSTALLATION_GUIDE.md" "%DIST_DIR%\" >nul 2>&1
copy /y "%~dp0dist-package\USER_GUIDE.md" "%DIST_DIR%\" >nul 2>&1
copy /y "%~dp0dist-package\RELEASE_NOTES.md" "%DIST_DIR%\" >nul 2>&1

echo.
echo [OK] Documentation copied!
echo.

REM Create final ZIP
echo [7/7] Creating final distribution ZIP...
echo ========================================
echo.

cd %~dp0dist-package

REM Try PowerShell first
where powershell >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Using PowerShell to create ZIP...
    powershell -Command "Compress-Archive -Path '%PACKAGE_NAME%' -DestinationPath '%PACKAGE_NAME%.zip' -Force"
    if %ERRORLEVEL% EQU 0 (
        echo [OK] ZIP created using PowerShell
        goto :success
    )
)

REM Try 7-Zip
where 7z >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Using 7-Zip to create ZIP...
    7z a -tzip "%PACKAGE_NAME%.zip" "%PACKAGE_NAME%" -y >nul
    if %ERRORLEVEL% EQU 0 (
        echo [OK] ZIP created using 7-Zip
        goto :success
    )
)

REM Failed
echo ERROR: Could not create ZIP file
echo Package directory is ready at: %DIST_DIR%
echo Please manually create a ZIP from this directory
pause
exit /b 1

:success
echo.
echo ========================================
echo ALL COMPLETE!
echo ========================================
echo.
echo Output Files:
echo.
echo 1. Distribution Package:
echo    %FINAL_ZIP%
for %%F in ("%FINAL_ZIP%") do echo    Size: %%~zF bytes
echo.
echo 2. Offline Package:
echo    %OUTPUT_DIR%
echo.
echo 3. Maven Artifacts:
echo    %~dp0com.xilinx.vitis.cppcheck.repository\target\repository
echo.
echo Package Contents:
echo   - README.md (Quick Start Guide)
echo   - INSTALLATION_GUIDE.md (Detailed Installation)
echo   - USER_GUIDE.md (Complete User Manual)
echo   - RELEASE_NOTES.md (Release Information)
echo   - p2-update-site/ (For Install Software method)
echo   - dropins/cppcheck/ (For manual installation)
echo.
echo This package is ready for distribution!
echo.
echo ========================================
pause
