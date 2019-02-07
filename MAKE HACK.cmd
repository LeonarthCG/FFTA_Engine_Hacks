cd %~dp0

copy FFTA_clean.gba FFTA_hack.gba

cd "%~dp0Event Assembler"

Core A FE8 "-output:%~dp0FFTA_hack.gba" "-input:%~dp0ROM Buildfile.event"

cd "%~dp0ups"

ups diff -b "%~dp0FFTA_clean.gba" -m "%~dp0FFTA_hack.gba" -o "%~dp0FFTA_hack.ups"

pause
