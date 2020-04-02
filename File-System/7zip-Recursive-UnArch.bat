REM cd to the dir you want to extract to
FOR /R "E:\WHDLoad\Commodore Amiga - WHDLoad - Magazines" %I IN (*.lha) DO "C:\Program Files\7-Zip\7z.exe" x "%I" -aou
