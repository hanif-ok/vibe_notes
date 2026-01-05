@echo off
REM Vibe Notes Development Helper Script for Windows

setlocal enabledelayedexpansion

REM Check if Flutter is installed
where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Flutter is not installed. Please install Flutter first.
    exit /b 1
)

REM Load environment variables from .env file
if exist .env (
    for /f "usebackq tokens=1,2 delims==" %%a in (".env") do (
        if not "%%a"=="" if not "%%a:~0,1%"=="#" (
            set %%a=%%b
        )
    )
    echo [SUCCESS] Loaded environment variables from .env
) else (
    echo [WARNING] No .env file found
    if exist .env.example (
        copy .env.example .env
        echo [INFO] Created .env file from .env.example
        echo [WARNING] Please edit .env and add your Supabase credentials
        exit /b 0
    )
)

REM Parse command
set COMMAND=%1

if "%COMMAND%"=="setup" goto setup
if "%COMMAND%"=="run" goto run
if "%COMMAND%"=="test" goto test
if "%COMMAND%"=="analyze" goto analyze
if "%COMMAND%"=="format" goto format
if "%COMMAND%"=="build" goto build
if "%COMMAND%"=="check" goto check
if "%COMMAND%"=="help" goto help
goto help

:setup
echo [INFO] Installing dependencies...
call flutter pub get
if %errorlevel% equ 0 (
    echo [SUCCESS] Setup complete! You can now run: dev.bat run
) else (
    echo [ERROR] Failed to install dependencies
    exit /b 1
)
goto end

:run
echo [INFO] Running app...
if "%SUPABASE_URL%"=="" (
    echo [ERROR] SUPABASE_URL is not set. Please edit .env file.
    exit /b 1
)
if "%SUPABASE_ANON_KEY%"=="" (
    echo [ERROR] SUPABASE_ANON_KEY is not set. Please edit .env file.
    exit /b 1
)
set DEVICE=%2
if "%DEVICE%"=="" (
    call flutter run --dart-define=SUPABASE_URL=%SUPABASE_URL% --dart-define=SUPABASE_ANON_KEY=%SUPABASE_ANON_KEY%
) else (
    call flutter run -d %DEVICE% --dart-define=SUPABASE_URL=%SUPABASE_URL% --dart-define=SUPABASE_ANON_KEY=%SUPABASE_ANON_KEY%
)
goto end

:test
echo [INFO] Running tests...
call flutter test
if %errorlevel% equ 0 (
    echo [SUCCESS] Tests passed
) else (
    echo [ERROR] Tests failed
    exit /b 1
)
goto end

:analyze
echo [INFO] Analyzing code...
call flutter analyze
if %errorlevel% equ 0 (
    echo [SUCCESS] Code analysis passed
) else (
    echo [ERROR] Code analysis failed
    exit /b 1
)
goto end

:format
echo [INFO] Formatting code...
call dart format lib\ test\
echo [SUCCESS] Code formatted
goto end

:build
set PLATFORM=%2
if "%PLATFORM%"=="" set PLATFORM=apk
echo [INFO] Building app for %PLATFORM%...
if "%SUPABASE_URL%"=="" (
    echo [ERROR] SUPABASE_URL is not set. Please edit .env file.
    exit /b 1
)
if "%SUPABASE_ANON_KEY%"=="" (
    echo [ERROR] SUPABASE_ANON_KEY is not set. Please edit .env file.
    exit /b 1
)
if "%PLATFORM%"=="apk" (
    call flutter build apk --release --dart-define=SUPABASE_URL=%SUPABASE_URL% --dart-define=SUPABASE_ANON_KEY=%SUPABASE_ANON_KEY%
) else if "%PLATFORM%"=="web" (
    call flutter build web --release --dart-define=SUPABASE_URL=%SUPABASE_URL% --dart-define=SUPABASE_ANON_KEY=%SUPABASE_ANON_KEY%
) else if "%PLATFORM%"=="windows" (
    call flutter build windows --release --dart-define=SUPABASE_URL=%SUPABASE_URL% --dart-define=SUPABASE_ANON_KEY=%SUPABASE_ANON_KEY%
) else (
    echo [ERROR] Unknown platform: %PLATFORM%
    echo Available platforms: apk, web, windows
    exit /b 1
)
echo [SUCCESS] Build completed
goto end

:check
call :test
if %errorlevel% neq 0 exit /b 1
call :analyze
if %errorlevel% neq 0 exit /b 1
echo [SUCCESS] All checks passed!
goto end

:help
echo Vibe Notes Development Helper for Windows
echo.
echo Usage: dev.bat [command] [options]
echo.
echo Commands:
echo   setup              - Set up environment and install dependencies
echo   run [device]       - Run the app on specified device (or default)
echo   test               - Run tests
echo   analyze            - Analyze code
echo   format             - Format code
echo   build [platform]   - Build app (apk, web, windows)
echo   check              - Run tests and analyze code
echo   help               - Show this help message
echo.
echo Examples:
echo   dev.bat setup
echo   dev.bat run
echo   dev.bat run chrome
echo   dev.bat build apk
echo   dev.bat check
goto end

:end
endlocal
