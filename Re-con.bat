@echo off
echo       ############################
echo .                  Hi 		            . 
echo .                                      . 
echo .            How you doin ?            . 
echo       ############################
echo ----------------------------------------
set year=%date:~-4%
set month=%date:~4,2%
set day=%date:~7,2%
set rootpath=R:\Richard\lab\Recon\result\
set aquatonepath=R:\Richard\Files\Tools\aquatone\
set amasspath=R:\Richard\lab\Tools\amass\
set dirsearchpath=R:\Richard\Files\Tools\dirsearch\
set chromiumpath=R:\Richard\Files\Tools\aquatone\chromium\bin\chrome.exe
set /p domain="Domain to enumerate : "
cls
echo Creating Folder for %domain% 
set saveresult=%rootpath%%domain%-%year%-%month%-%day%
mkdir %saveresult%
echo Enumerate %domain%
echo Amass is running...
%amasspath%amass -d %domain% -o %saveresult%\%domain%.txt --passive
echo Amass Done
echo Aquatone Enumerate %domain%
echo Starting Aquatone...
type "%saveresult%\%domain%.txt" | %aquatonepath%aquatone -out %saveresult%\aquatone-report\ -chrome-path %chromiumpath%
echo Aquatone Done
echo Performing Dirsearch...
python3 %dirsearchpath%dirsearch.py -L %saveresult%\aquatone-report\aquatone_urls.txt -e *
echo Done ! Save every result in %saveresult%
