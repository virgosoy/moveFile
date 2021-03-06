@echo off

Title 这是一个标题

@echo --------
@echo - 你好 -
@echo --------

choice /c YN /M "是否保留目录层级？若选择N则所有文件都在同一个文件夹内"
if errorlevel==1 ( set keepLevel=Y )
if errorlevel==2 ( set keepLevel=N )

choice /c YN /M "已经准备好要开始了吗？"
if errorlevel==2 ( goto doEnd )
if errorlevel==1 ( goto doRun )

:doRun
::注释
rem 注释
:: 备份目录
set bakDir=backup\
set origin=''
setlocal enabledelayedexpansion
echo ======程序开始====== >> result.txt
for /f "delims=" %%i in (filePath.txt) do (
	set origin=%%i
	set originDir=%%~dpi
	set originName=%%~nxi
	echo %%~nxi
	
	if not exist %%i (
		echo ●文件不存在："%%i"
		echo ●文件不存在："%%i" >> result.txt
	) else (
		if %keepLevel%==Y (
			set target=%bakDir%!origin::=!
			set targetDir=%bakDir%!originDir::=!
		) else (
			set target=%bakDir%!originName!
			set targetDir=%bakDir%
		)
		::复制文件
		rem echo f | xcopy !origin! !target! /F
		::创建目录
		if not exist !targetDir! (
			mkdir "!targetDir!"
		)
		echo ●准备移动："!origin!"-^>"!target!"
		::移动文件
		move /-Y "!origin!" "!target!"
		if not exist %%i (
			if exist !target! (
				echo ●移动成功："!origin!"移动到"!target!" >> result.txt
			) else (
				echo ●移动失败："!origin!"移动到"!target!" >> result.txt
			)
		) else (
			echo ●移动失败："!origin!"移动到"!target!" >> result.txt
		)
		
	)
)
echo ======程序结束====== >> result.txt
pause
:doEnd