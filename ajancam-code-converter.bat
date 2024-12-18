@echo off
chcp 65001
cls

if exist "%~1" (
	shift
	set InputFile="%~1"
	set NewFileName="%CD%"\new_"%~nx1"
	
>nul find "G40 G91.1" "%~1" && ( call :cikis ) || ( call :degistir )
	
) else ( exit )

pause


:degistir

echo Lütfen gerekliyse kesme hızını girip Enter'a basın, gerek yoksa boş bırakıp Enter'a basın. 
set /p feedrate= "Hız mm/min :" 

echo Çalışıyor, Lütfen Bekleyin!
echo:

set TempFile=temp.dat

setlocal disabledelayedexpansion

set "arabul=G90"
set "degistir="

set "arabul2=G41"
set "degistir2="

set "arabul3=M03"
set "degistir3=G53 G90 G40 G91.1"

set "arabul4=M07"
set "degistir4=M03"

set "arabul5=M08"
set "degistir5=M05"

set "arabul6=M05"
set "degistir6=M05 M30"

>%TempFile% (
  for /f "usebackq delims=" %%a in (%InputFile%) do (
    if "%%a" equ "%arabul%" (
		if not "%degistir%"=="" ( echo %degistir% )
		if not "%feedrate%"=="" ( echo F%feedrate% )
	) else if "%%a" equ "%arabul2%" (
		if not "%degistir2%"=="" ( echo %degistir2% )
	) else if "%%a" equ "%arabul3%" (
		echo %degistir3%
	) else if "%%a" equ "%arabul4%" (
		echo %degistir4%
	) else if "%%a" equ "%arabul5%" (
		echo %degistir5%
	) else if "%%a" equ "%arabul6%" (
		echo %degistir6%
	) else (
		echo %%a
	)
  )
)


MOVE %TempFile% %NewFileName% >nul
endlocal

echo   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo   @                                                         @
echo   @      Dosyada gerekli değişiklikler yapılmıştır....      @
echo   @                                                         @
echo   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo:
echo Çıkış için herhangi bir tuşa basın.
pause

exit


:cikis

echo   ###############################################
echo   #                                             #
echo   #      Dosya daha once değiştirilmiş....      #
echo   #                                             #
echo   ###############################################
echo:
echo Çıkış için herhangi bir tuşa basın.
pause

exit