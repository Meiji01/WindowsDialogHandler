@echo off
REM ============================================================================
REM Windows Dialog Handler - Sample Batch File
REM This batch file demonstrates how to use WindowsDialogHandler.exe
REM Author: Meij Racpan
REM ============================================================================

REM Set the path to the executable
SET HANDLER_EXE=.\x64\Release\WindowsDialogHandler.exe

REM Check if the executable exists
IF NOT EXIST "%HANDLER_EXE%" (
    echo Error: WindowsDialogHandler.exe not found at %HANDLER_EXE%
    echo Please build the project in Release mode for x64 platform.
    pause
    exit /b 1
)

echo.
echo ============================================================================
echo Windows Dialog Handler - Sample Usage
echo ============================================================================
echo.

REM Example 1: Using Default Values
echo Example 1: Using Default Values
echo Command: %HANDLER_EXE%
echo This will use the built-in default values:
echo   - Window Class: #32770
echo   - Window Title: Choose File to Upload
echo   - Edit Box ID: 0x47C
echo   - File Path: C:\WorkingFolder\Programming\IE2\ForUpload.txt
echo   - Delay: 500ms
echo.
REM Uncomment to run:
REM "%HANDLER_EXE%"

echo.
echo ============================================================================
echo.

REM Example 2: Custom Window Class and Title
echo Example 2: Custom Dialog Parameters
echo Command: %HANDLER_EXE% #32770 "Choose File to Upload" 1148 "C:\Users\Username\Desktop\file.txt" 1000
echo This specifies custom parameters for a specific dialog window.
echo.
REM Uncomment to run:
REM "%HANDLER_EXE%" #32770 "Choose File to Upload" 1148 "C:\Users\Username\Desktop\file.txt" 1000

echo.
echo ============================================================================
echo.

REM Example 3: File Upload Dialog with Custom Delay
echo Example 3: Using Variables for File Path
setlocal enabledelayedexpansion
set "FILE_TO_UPLOAD=C:\MyDocuments\report.pdf"
set "DIALOG_TITLE=Upload File"
set "DIALOG_CLASS=#32770"
set "CONTROL_ID=1148"
set "DELAY_MS=500"

echo Command: %HANDLER_EXE% "%DIALOG_CLASS%" "%DIALOG_TITLE%" %CONTROL_ID% "%FILE_TO_UPLOAD%" %DELAY_MS%
echo.
REM Uncomment to run:
REM "%HANDLER_EXE%" "%DIALOG_CLASS%" "%DIALOG_TITLE%" %CONTROL_ID% "%FILE_TO_UPLOAD%" %DELAY_MS%

echo.
echo ============================================================================
echo.

REM Example 4: Batch Processing Multiple Files
echo Example 4: Processing Multiple Files (Advanced)
echo This example shows how to process multiple files:
echo.

setlocal enabledelayedexpansion
set "DIALOG_CLASS=#32770"
set "DIALOG_TITLE=Choose File to Upload"
set "CONTROL_ID=1148"
set "DELAY_MS=1000"

REM Uncomment and modify the file list to process multiple files
REM for %%F in (C:\Files\*.txt) do (
REM     echo Processing: %%F
REM     "%HANDLER_EXE%" "%DIALOG_CLASS%" "%DIALOG_TITLE%" %CONTROL_ID% "%%F" %DELAY_MS%
REM     timeout /t 2
REM )

echo Example commented out to prevent accidental execution.
echo Uncomment the FOR loop in the batch file to enable batch processing.

echo.
echo ============================================================================
echo.

REM Example 5: Error Handling
echo Example 5: With Error Handling
echo.
echo set "FILE_PATH=C:\Path\To\File.txt"
echo if exist "!FILE_PATH!" (
echo     "%HANDLER_EXE%" #32770 "Choose File to Upload" 1148 "!FILE_PATH!" 500
echo     if errorlevel 0 (
echo         echo File upload initiated successfully
echo     ) else (
echo         echo Error occurred during file upload
echo     )
echo ) else (
echo     echo Error: File not found at !FILE_PATH!
echo )
echo.

echo ============================================================================
echo.
echo NOTES:
echo - Replace file paths with your actual file paths
echo - Dialog title and window class must match exactly
echo - Control ID can be in decimal (e.g., 1148) or hexadecimal (e.g., 0x47C)
echo - Delay is in milliseconds (1000ms = 1 second)
echo - The dialog window must be already open when the command runs
echo - Administrator privileges may be required for some operations
echo.
echo For more information, see README.md
echo ============================================================================

pause
