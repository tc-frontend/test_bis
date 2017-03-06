echo off
SET sha1=%1

if "%1"=="" (GOTO DEFAULT)
if NOT "%1"== "" (GOTO USERDATA)
:DEFAULT
FOR /F "tokens=* USEBACKQ" %%F IN (`git rev-list HEAD`) DO (
	SET sha1=%%F
)
ECHO The target is first commit: %sha1%
GOTO END
:USERDATA
ECHO The target is the commit: %sha1%
GOTO END
:END
ECHO =============

ECHO git stash -u
git stash -u
ECHO =============

ECHO git checkout master
git checkout master
ECHO =============

ECHO git tag -d root
git tag -d root
ECHO =============

ECHO git branch -D temp
git branch -D temp
ECHO =============

ECHO git tag root %sha1%
git tag root %sha1%
ECHO =============

ECHO git checkout -b temp root
git checkout -b temp root
ECHO =============


ECHO You can make changes...and after execute "do-rebase"
ECHO =============