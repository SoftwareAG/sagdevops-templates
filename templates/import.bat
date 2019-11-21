@ECHO OFF

WHERE sagcc >nul 2>nul
IF %ERRORLEVEL% NEQ 0 ECHO Error: sagcc is not installed.

set template=template.yaml
for /D %%D in (*) do (    
    ECHO "Uploading %%D\%template%"
    cmd /c sagcc exec templates composite import -i %%D\%template% overwrite=true
)

ECHO "Register layer definitions"
cmd /c sagcc exec templates composite apply sag-cc-layer-defs --wait-for-cc 120 --sync-job -w 3600


