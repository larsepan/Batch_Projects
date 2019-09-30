:: Move all of a file type in this folder to another
:: by Larsepan

@ECHO OFF
CLS

:SETUP
SET location=
SET choice=

:MENU
CLS
ECHO.
ECHO ...............................................
ECHO  Cleanup Desktop
ECHO ...............................................
ECHO. 
ECHO.
ECHO 1 - Select Destination Folder
ECHO 2 - Cleanup Desktop
ECHO 3 - Readme
ECHO 4 - EXIT
ECHO.

:CURRENTPATH
SetLocal EnableDelayedExpansion
if not exist MoveFilePath.txt GOTO NOPATHSET
FOR /F "delims=" %%i in (MoveFilePath.txt) do set location=!location! %%i
ECHO Your current destination path is . . .  %location%
EndLocal
GOTO PROMPTUSER

:NOPATHSET
ECHO You have not yet set a destination folder.

:PROMPTUSER
ECHO.
SET /P choice=Type a selection then press ENTER:
IF %choice%==1 GOTO DESTINATION
IF %choice%==2 GOTO MOVEFILES
IF %choice%==3 GOTO README
IF %choice%==4 GOTO EOF
IF %choice%=="" GOTO SETUP

:INVALID
CLS
ECHO "Invalid selection:" %choice%
PAUSE
GOTO SETUP

:DESTINATION
CLS
ECHO Type out the complete folder path:
ECHO Example: C:\Users\someUser\Desktop\SomeFolder
SET /P Path=Path: 
@echo %Path% > TempPath.txt
ECHO You typed %Path%
:: If the path's last folder does not exist, ask whether to create it
if not exist %Path% GOTO PATHPROMPT
@echo %Path% > MoveFilePath.txt
ECHO Process Complete.
ECHO.
PAUSE
GOTO SETUP

:PATHPROMPT
ECHO That path does not exist.
ECHO Create that path?
SET /P Create=Yes\No: 
IF /i %Create%==Yes GOTO CREATEPATH
IF /i %Create%==No GOTO DESTINATION
IF /i %Create%==Y GOTO CREATEPATH
IF /i %Create%==N GOTO DESTINATION

:INVALIDPATHA
CLS
ECHO "Invalid selection:" %Create%
PAUSE
SET Create=
GOTO DESTINATION

:CREATEPATH
SetLocal EnableDelayedExpansion
FOR /F "delims=" %%i in (TempPath.txt) do set location=!location! %%i
mkdir %location%
@echo %location% > MoveFilePath.txt
EndLocal
ECHO Process Complete.
ECHO.
PAUSE
GOTO SETUP

:MOVEFILES
CLS
SetLocal EnableDelayedExpansion
if not exist MoveFilePath.txt GOTO NOTEXIST
FOR /F "delims=" %%i in (MoveFilePath.txt) do set location=!location! %%i
ECHO Moving files...
::DESIGNATED FILE TYPES LIST
::For any other filetypes you want moved, just add to/edit the list below 
MOVE %userprofile%\Desktop\*.png %location%
MOVE %userprofile%\Desktop\*.jpg %location%
MOVE %userprofile%\Desktop\*.msg %location%
::END DESGINATED FILE TYPES LIST
EndLocal
ECHO Process Complete.
ECHO.
PAUSE
GOTO SETUP

:NOTEXIST
CLS
ECHO That path does not exist.  Please set a destination path first.
PAUSE
GOTO SETUP

:README
CLS
ECHO.
ECHO - This program targets designated file types on the Desktop.  The eSolution Center does not
ECHO - offer support for this program.  Please be mindful of its location and use.
ECHO.
ECHO ...............................................
ECHO 1 - Place the Cleanup Desktop.bat file in a folder.  It will generate txt files for its own use.
ECHO 2 - Right click on the Cleanup Desktop.bat file and send to the Desktop (or somewhere else)
ECHO 3 - Choose the "select destination folder" option.
ECHO 4 - Copy\paste or type your destination path.
ECHO 5 - Make sure the path is correct and always backup your files.
ECHO 6 - Choose the move files to destination folder.
ECHO.
PAUSE
GOTO SETUP