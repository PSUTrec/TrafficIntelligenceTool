::opencv traffic intelligence virtual machine for windows program installation scripts
::Install Chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
::Packages
choco install git.install -y
choco install vagrant -y
choco install virtualbox -y
choco install mobaxterm -y

:: Get current directory where batch script is located
SET CWD=%~dp0
echo %CWD%
call %CWD%refreshEnv
if not exist %CWD%..\cvtivm mkdir %CWD%..\cvtivm
copy %CWD%..\etc\Vagrantfile %CWD%..\cvtivm
copy %CWD%..\etc\bootstrap-cvti-compile.sh %CWD%..\cvtivm
echo d|xcopy %CWD%..\etc\jupyter %CWD%..\cvtivm\jupyter
echo d|xcopy %CWD%..\etc\release %CWD%..\cvtivm\release
echo d|xcopy %CWD%..\etc\test %CWD%..\cvtivm\test
echo d|xcopy %CWD%..\etc\jupyter %CWD%..\cvtivm\release\jupyter
echo d|xcopy %CWD%..\etc\test %CWD%..\cvtivm\release\test
icacls %CWD%..\cvtivm /t /grant Everyone:M
cd /d %CWD%..\cvtivm
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-disksize
vagrant up  2>&1 > vagrantup.log
vagrant ssh-config > vagrant-ssh
:: update hosts file to point to jupyter site for traffic intelligence testing
FIND /C /I "cvti.example.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO 10.0.15.45 cvti.example.com>>%WINDIR%\System32\drivers\etc\hosts
FIND /C /I "ti.example.com" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO 10.0.15.50 ti.example.com>>%WINDIR%\System32\drivers\etc\hosts
