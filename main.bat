::menu principal
:menu
cls
echo Bienvenue sur batel pets
echo.
echo vouler vous cree un pet ou en choisir un ? utiliser l outil d edition avencer en python naviguer dans les option ou juste quiter ?
set /p rep=
cls
if "%rep:~0,4%" equ "cree" goto:new
if "%rep:~0,7%" equ "choisir" goto:load
if "%rep:~0,8%" equ "utiliser" python creator.py
if "%rep:~0,6%" equ "option" goto:option
if "%rep:~0,8%" equ "naviguer" goto:option
if "%rep:~0,6%" equ "quiter" exit
goto:menu


::createur de pet
:new
cd pets
echo quel sera le nom du pet ?
set /p rep=
mkdir %rep%
cd %rep%
cls

echo si vous vouler une image veuiller mensionner sont lien en inversant les slash et en metant entre guimet le nom avec l extension en exterieur si espacer appuyer juste sur entre si vous voulez passer
set /p rep=
set rep=_%rep%
if %rep% equ _ goto:end
set rep=%rep:~1,99%
copy %rep% %cd%\image.png
:end
cls

echo si vous vouler un cri veuiller mensionner sont lien en inversant les slash et en metant entre guimet le nom avec l extension en exterieur si espacer appuyer juste sur entre si vous voulez passer
set /p rep=
set rep=_%rep%
if %rep% equ _ goto:end
set rep=%rep:~1,99%
copy %rep% %cd%\cri.mp3
:end
cls

echo quelle sera le type de votre pet ? O pour organic S pour sintetic O-S pour cyborg et eviter les espaces
set /p rep=
echo creation des stats veuiller patienter
(echo %rep%)>type
if "%rep%" equ "O" goto:organic
if "%rep%" equ "S" goto:sintetic
if "%rep%" equ "O-S" goto:cyborg
mkdir pv\20
mkdir mana\20
mkdir atk\5
mkdir pr\1
goto:end
:organic
mkdir pv\30
mkdir mana\10
mkdir atk\10
mkdir pr\0
goto:end
:sintetic
mkdir pv\10
mkdir mana\30
mkdir atk\2
mkdir pr\5
goto:end
:cyborg
mkdir pv\5
mkdir mana\12
mkdir atk\12
mkdir pr\2
:end
mkdir xp\0
mkdir level\1
cls

echo votre pet est terminer appuyer sur entrer pour revenir au menu
pause>nul
cd..\..
goto:menu


::utilisee un pet
:load
cd pets
dir
echo.
echo veuillier selectionner un pet
set /p rep=
cls
echo chargement du pet veuille patienter
set name=%rep%
cd "%rep%"

for /f %%i in (type) do set type=%%i

:cl
if exist pv\%cl% goto:end
set /a cl=%cl%+1
goto:cl
:end
set MAXpv=%cl%
set cl=0

:cl0
if exist mana\%cl% goto:end
set /a cl=%cl%+1
if %cl% equ 4294967295 exit
goto:cl0
:end
set MAXmana=%cl%
set cl=0

:cl1
if exist atk\%cl% goto:end
set /a cl=%cl%+1
if %cl% equ 4294967295 exit
goto:cl1
:end
set MAXatk=%cl%
set cl=0

:cl2
if exist pr\%cl% goto:end
set /a cl=%cl%+1
if %cl% equ 4294967295 exit
goto:cl2
:end
set MAXpr=%cl%
set cl=0

:cl3
if exist xp\%cl% goto:end
set /a cl=%cl%+1
if %cl% equ 4294967295 exit
goto:cl3
:end
set xp=%cl%
set cl=0

:cl4
if exist level\%cl% goto:end
set /a cl=%cl%+1
if %cl% equ 4294967295 exit
goto:cl4
:end
set level=%cl%
set cl=0

set pv=%MAXpv%
set mana=%MAXmana%
set atk=%MAXatk%
set pr=%MAXpr%

if %level% gtr 2 set /a MAXxp=(%level%-1)*2*10 & goto:end
if %level% equ 2 set MAXxp=20 & goto:end
set MAXxp=10
:end

cd..
if exist "%name%"\image.png start "%name%"\image.png
timeout /t 1 /nobreak>nul
if exist "%name%"\cri.mp3 start "%name%"\cri.mp3
cd..
:mypet
cls
echo %name% est pret
echo.
echo que voulez vous faire ?
echo consulter
echo explorer un donjon
echo retour au menu principal
set /p rep=
if "%rep:~0,9%" equ "consulter" cls & goto:stats
if "%rep:~0,8%" equ "explorer" cls & goto:donjon
if "%rep:~0,6%" equ "retour" goto:menu
goto:mypet


::stastistics du pet
:stats
echo %name%
echo type %type%
echo niveau %level%
echo.
echo pv %pv%
echo energie %mana%
echo attake %atk%
echo protection %pr%
echo.
echo experience %xp% sur %MAXxp%
echo.
echo appuyer sur entre pour continuer
pause>nul
goto:mypet


::les donjons
:donjon
cd donjon
:CHD
dir
echo.
echo quelle donjon choisir ?
set /p rep=
cls
cd %rep% & goto:end
goto:CHD
:end

call lvl0\script
:exploration
if %ret:~0,4% equ next goto:suivant
if %ret:~0,5% equ batel goto:fight
if %ret:~0,4% equ dead goto:game_over
echo fin du donjon
pause>nul
cd..\..
goto:mypet

:suivant
if exist lvl%ret:~4,1%\script.bat call lvl%ret:~4,1%\script.bat & goto:exploration
echo erreur niveau introuvable
pause>nul
cd..\..
goto:mypet


::combat
:fight
echo vous entre en duel avec %E_name% appuyer sur entre pour continuer
if exist %E_name%.png start %E_name%.png
timeout /t 1 /nobreak>nul
if exist %E_name%.mp3 start %E_name%.mp3
pause>nul
cls

if %pr% gtr %E_pr% set turn=P & goto:end
if %pr% lss %E_pr% set turn=E & goto:end
if %random:~0,1% geq 4 set turn=P & goto:end
set turn=E
:end
if %turn% equ P echo le jouer commence
if %turn% equ E echo l ennemie commence
timeout /t 3 /nobreak>nul

:VS
cls
if %pv% leq 0 goto:game_over
if %E_pv% leq 0 goto:victoire
if %turn% equ P goto:P_turn
if %turn% equ E goto:E_turn
echo erreur imposible de determiner le tour
pause>nul
exit
:P_turn
dir..\..\spell
echo.
echo %name%
echo.
echo pv %pv%
echo energie %mana%
echo attack %atk%
echo protection %pr%
echo effet %effect%
echo.
echo veuiller choisir une action
set /p rep=
cls
echo %name% utilise %rep%
call ..\..\spell\"%rep%".bat
if exist ..\..\effect\"%effect%".bat call ..\..\effect\"%effect%".bat
timeout /t 3 /nobreak>nul
cls
set turn=E
goto:VS
:E_turn
echo tour de l enemie
echo.
echo %E_name%
echo.
echo pv %E_pv%
echo energie %E_mana%
echo attack %E_atk%
echo protection %E_pr%
echo effet %E_effect%
echo.
timeout /t 3 /nobreak>nul
cls
if exist %E_name% call %E_name%.bat
echo %E_name% utilise %rep%
timeout /t 2 /nobreak>nul
call ..\..\spell\"%rep%".bat
if exist ..\..\effect\"%E_effect%".bat call ..\..\effect\"%E_effect%".bat
timeout /t 3 /nobreak>nul
cls
set turn=P
goto:VS

:victoire
echo vous aves gagne
echo.
set /a xp=%xp%+%E_level%*2
echo xp %xp% sur %MAXxp%
if %xp% lss %MAXxp% goto:end
set xp=0
set level=%level%+1
if %level% gtr 2 set /a MAXxp=(%level%-1)*2*10
if %level% equ 2 set MAXxp=20
echo level up %level%
echo.
set /a %MAXpv%=(%MAXpv%+1)+%MAXpv%*(%random:~0,1%/2)
set /a %MAXmana%=(%MAXmana%+1)+%MAXmana%*(%random:~0,1%/2)
set /a %MAXatk%=(%MAXatk%+1)+%MAXatk%*(%random:~0,1%/2)
set /a %MAXpr%=(%MAXpr%+1)+%MAXpr%*(%random:~0,1%/2)
set pv=%MAXpv%
set mana=%MAXmana%
set atk=%MAXatk%
set pr=%MAXpr%
echo point de vie %pv%
echo energie %mana%
echo attake %atk%
echo protection %pr%
:end
rmdir /q /s ..\..\pets\"%name%"\lvl & mkdir ..\..\pets\"%name%"\lvl
rmdir /q /s ..\..\pets\"%name%"\pv & mkdir ..\..\pets\"%name%"\pv
rmdir /q /s ..\..\pets\"%name%"\mana & mkdir ..\..\pets\"%name%"\mana
rmdir /q /s ..\..\pets\"%name%"\pv & mkdir ..\..\pets\"%name%"\pr
rmdir /q /s ..\..\pets\"%name%"\atk & mkdir ..\..\pets\"%name%"\atk
rmdir /q /s ..\..\pets\"%name%"\xp & mkdir ..\..\pets\"%name%"\xp
mkdir ..\..\pets\"%name%"\lvl\%lvl%
mkdir ..\..\pets\"%name%"\pv\%MAXpv%
mkdir ..\..\pets\"%name%"\mana\%MAXmana%
mkdir ..\..\pets\"%name%"\pr\%MAXpr%
mkdir ..\..\pets\"%name%"\atk\%MAXatk%
mkdir ..\..\pets\"%name%"\xp\%xp%
pause>nul
if %ret:~0,5% equ batel set ret=next%ret:~5,1%
goto:exploration


::game over
:game_over
color 04
title Tmort
echo game over
set /t 5 /nobreak>nul
exit


::parametre
:option
echo 1_changer de couleur
echo 2_difinir un tag aux titre
echo 3_mode usine
echo 4_menu principal
echo.
echo que choisir ?
choice /c 1234 /n
cls
if %errorlevel%==1 goto:option_1
if %errorlevel%==2 goto:option_2
if %errorlevel%==3 goto:option_3
goto:menu

:option_1
help color
echo.
echo veuiller mentionner une couleur
set /p rep=
cls
if %rep% equ 04 echo sauf 04 utiliser pour le gameover appuyer sur entre pour continuer & set rep=01 & pause>nul
if %rep:~0,1% equ %rep:~1,1% echo attention les couleurs se chevauche appuyer sur entre pour confirmer votre choix & pause>nul
color %rep%
cls
del /q color.txt
(echo %rep%)>color.txt
goto:option

:option_2
echo definir un tag
echo note se parametre sera appliquer uniquement sur cette session
set /p rep=
cls
title batel pets %rep%
goto:option

:option_3
echo mode usine
echo attention tout vous donjon est pets  et autre contenu non relier au code source seront suprimer dans le prossesus
echo sela ne changera pas les parametre graphique pour les renitialise juste redemaree
echo voulez vous continuer ?
choice
cls
if %errorlevel%==2 goto:option
rmdir /s /q donjon
rmdir /s /q effect
rmdir /s /q pets
rmdir /s /q spell
del /q color.txt
del /f /q aide.txt
echo nettoyage terminee
timeout /t 2 /nobreak>nul
exit