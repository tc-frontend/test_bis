echo off


ECHO =============
ECHO git add .
git add .
set VAR=%errorlevel%
if %VAR%==1 (GOTO END)
ECHO =============	 

ECHO git commit --amend
git commit --amend
set VAR=%errorlevel%
if %VAR%==1 (GOTO END)
ECHO =============

ECHO git checkout master
git checkout master
set VAR=%errorlevel%
if %VAR%==1 (GOTO END)
ECHO =============

ECHO git rebase --abort
git rebase --abort
ECHO =============

ECHO git rebase --onto temp root
powershell -command "git rebase --onto temp root | Out-File %TEMP%\temp.txt"
powershell -command "$F =Select-String -Path %TEMP%\temp.txt -pattern CONFLICT; if ($F.count -gt 0) { Out-File %TEMP%\do-rebase.error }"

set VAR=%errorlevel%
if %VAR%==1 (GOTO END)

if exist %TEMP%\do-rebase.error (
    ECHO CONFLICTs in merge. You must edit all merge conflicts and then mark them as resolved using git add
    GOTO END
)

ECHO =============

ECHO git branch -d temp
git branch -d temp
set VAR=%errorlevel%
if %VAR%==1 (GOTO END)
ECHO =============

ECHO git tag -d root
git tag -d root
set VAR=%errorlevel%
if %VAR%==1 (GOTO END)
ECHO =============

ECHO git push -f origin master
git push -f origin master
set VAR=%errorlevel%
if %VAR%==1 (GOTO END)
ECHO =============

FOR /F "tokens=* USEBACKQ" %%F IN (`git rev-list HEAD`) DO (
SET first=%%F
)



ECHO git tag -d init
git tag -d init
set VAR=%errorlevel%
if %VAR%==1 ECHO Warning! 
ECHO =============

ECHO git tag init %first%
git tag init %first%
set VAR=%errorlevel%
if %VAR%==1 ECHO Warning! 
ECHO =============

ECHO git push -f --tags
git push -f --tags
set VAR=%errorlevel%
if %VAR%==1  ECHO Warning!
ECHO =============


:END
IF EXIST %TEMP%\do-rebase.error del /F %TEMP%\do-rebase.error
IF EXIST %TEMP%\temp.txt del /F %TEMP%\temp.txt

ECHO End


