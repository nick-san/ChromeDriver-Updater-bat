@echo off
@rem find Chrome Version
FOR /F %%i in ('dir /B /O-N "C:\Users\yuki\AppData\Local\Google\Chrome\Application" ^| findstr "^[0-9].*\>"') do set chrome_version=%%i

setlocal

set chromedriver_path="%CD%/chromedriver.exe"
echo %chromedriver_path%

rem chromedriverのバージョンを取得して出力
for /f "tokens=2 delims= " %%v in ('%chromedriver_path% --version') do set "chromedriver_version=%%v"
echo ChromeDriver: %chromedriver_version%
echo Chrome: %chrome_version%
PAUSE

@if "%chromedriver_version%" EQU "%chrome_version%" (
    echo バージョンは最新です。更新は必要ありません。
    PAUSE
) else if "%chrome_version%" EQU "" (
    echo;
    echo Chrome Version Not Found
    PAUSE
    exit /b
) else if "%chrome_version%" NEQ "%chromedriver_version" (
    echo "ChromeDriverを更新します。"
    curl https://storage.googleapis.com/chrome-for-testing-public/%chrome_version%/win64/chromedriver-win64.zip --output ./chrome-win64.zip
    tar -xf ./chrome-win64.zip
    del chrome-win64.zip
    move .\chromedriver-win64\chromedriver.exe .\
    rmdir /s /q chromedriver-win64
    PAUSE
) 
