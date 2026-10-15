@echo off
setlocal
rem ---------------------------------------------------------------
rem  Publishes the Follow-Ups website (home, privacy policy, support)
rem  to GitHub Pages: https://eddeveloped.github.io
rem  Needs a PUBLIC repository named eddeveloped.github.io under the
rem  EDDEVELOPED account. Run again after any change to the pages.
rem ---------------------------------------------------------------
cd /d "%~dp0"
set "REPO=https://EDDEVELOPED@github.com/EDDEVELOPED/eddeveloped.github.io.git"

findstr /m /c:"SUPPORT_EMAIL_HERE" *.html >nul 2>&1
if not errorlevel 1 (
  echo.
  echo  The support email isn't filled in yet. Tell Claude the address to use,
  echo  then run this again.
  goto end
)

if not exist ".git" git init -b main >nul
rem This repository is public, so commits use a no-reply identity (never a
rem personal email address).
git config user.name "EDDEVELOPED"
git config user.email "EDDEVELOPED@users.noreply.github.com"
git remote get-url origin >nul 2>&1
if errorlevel 1 (git remote add origin %REPO%) else (git remote set-url origin %REPO%)
git add -A
git commit -q -m "Update site" >nul 2>&1
echo  Uploading. If a window opens, sign in to GitHub as EDDEVELOPED...
git push -u origin main
if errorlevel 1 (
  echo.
  echo  Upload FAILED. Check that the public repository eddeveloped.github.io
  echo  exists under EDDEVELOPED, then run this again.
) else (
  echo.
  echo  Done. In a minute or two the pages will be live at:
  echo    https://eddeveloped.github.io/privacy.html
  echo    https://eddeveloped.github.io/support.html
  echo  Tell Claude "site done".
)
:end
echo.
pause
