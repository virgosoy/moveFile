@echo off

Title ����һ������

@echo --------
@echo - ��� -
@echo --------

choice /c YN /M "�Ƿ���Ŀ¼�㼶����ѡ��N�������ļ�����ͬһ���ļ�����"
if errorlevel==1 ( set keepLevel=Y )
if errorlevel==2 ( set keepLevel=N )

choice /c YN /M "�Ѿ�׼����Ҫ��ʼ����"
if errorlevel==2 ( goto doEnd )
if errorlevel==1 ( goto doRun )

:doRun
::ע��
rem ע��
:: ����Ŀ¼
set bakDir=backup\
set origin=''
setlocal enabledelayedexpansion
echo ======����ʼ====== >> result.txt
for /f "delims=" %%i in (filePath.txt) do (
	set origin=%%i
	set originDir=%%~dpi
	set originName=%%~nxi
	echo %%~nxi
	
	if not exist %%i (
		echo ���ļ������ڣ�"%%i"
		echo ���ļ������ڣ�"%%i" >> result.txt
	) else (
		if %keepLevel%==Y (
			set target=%bakDir%!origin::=!
			set targetDir=%bakDir%!originDir::=!
		) else (
			set target=%bakDir%!originName!
			set targetDir=%bakDir%
		)
		::�����ļ�
		rem echo f | xcopy !origin! !target! /F
		::����Ŀ¼
		if not exist !targetDir! (
			mkdir "!targetDir!"
		)
		echo ��׼���ƶ���"!origin!"-^>"!target!"
		::�ƶ��ļ�
		move /-Y "!origin!" "!target!"
		if not exist %%i (
			if exist !target! (
				echo ���ƶ��ɹ���"!origin!"�ƶ���"!target!" >> result.txt
			) else (
				echo ���ƶ�ʧ�ܣ�"!origin!"�ƶ���"!target!" >> result.txt
			)
		) else (
			echo ���ƶ�ʧ�ܣ�"!origin!"�ƶ���"!target!" >> result.txt
		)
		
	)
)
echo ======�������====== >> result.txt
pause
:doEnd