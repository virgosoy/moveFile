@echo off

Title ����һ������

@echo --------
@echo - ��� -
@echo --------

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
	if not exist %%i (
		echo ���ļ������ڣ�"%%i"
		echo ���ļ������ڣ�"%%i" >> result.txt
	) else (
		set target=%bakDir%!origin::=!
		set targetDir=%bakDir%!originDir::=!
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