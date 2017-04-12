@REM RGBDS_PATH is the path to rgbasm, rgblink and rgbfix
@SET RGBDS_PATH=%~dp0\requirements\rgbds-0.2.4\
@REM BGB_PATH is the path to bgb.exe
@SET BGB_PATH=%~dp0\requirements\bgb\

@PATH=%RGBDS_PATH%;%BGB_PATH%;%PATH%


@echo Creating build folder...
@if not exist "build/" mkdir build


@echo Compiling...
rgbasm.exe -o build/main.o main.z80
@if errorlevel 1 goto error

rgbasm.exe -o build/header.o header.z80
@if errorlevel 1 goto error

@echo Linking...
rgblink.exe -n build/example.sym -m build/example.map -o example.gb build/*.o
@if errorlevel 1 goto error


@echo Fixing...
rgbfix.exe -p0 -v example.gb
@if errorlevel 1 goto error


@goto ready

:error
@echo An error occurred!
@pause
@goto ending

:ready
echo Starting emulator...
bgb.exe example.gb

:ending
@echo Cleaning up...
del build\*.o
