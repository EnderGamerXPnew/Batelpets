@echo off
setlocal enabledelayedexpansion
chcp 850
title batel pets

::generation de la couleur
if exist color.txt goto:true
(echo 01)>color.txt
color 01
goto:next
:true
for /f %%i in (color.txt) do if %%i neq 04 color %%i
:next

::generation des variables
set cl=0
set rep=
set turn=P-E
set ret=

set name=
set type=O-S
set effect=
set xp=0
set MAXxp=0
set level=0
set pv=0
set MAXpv=0
set mana=0
set MAXmana=0
set atk=0
set MAXatk=0
set pr=0
set MAXpr=0

set E_name=
set E_type=O-S
set E_effect=
set E_level=0
set E_pv=0
set E_MAXpv=0
set E_mana=0
set E_MAXmana=0
set E_atk=0
set E_MAXatk=0
set E_pr=0
set E_MAXpr=0


::pre-chargement de la variable aleatoire en utilisant le retour comme outil
:cl
set ret=%random%
set /a cl=%cl%+1
if %cl% lss 10 goto:cl
set ret=
set cl=0


::creation des dossiers et du fichier d aide
if exist donjon mkdir donjon
if exist pets mkdir pets
if exist spell mkdir spell
if exist effect mkdir effect
if exist aide.txt goto:end
(
echo les variables par defaut
echo.
echo name le nom du pet
echo effect l effect appliquer a chaque tour au pet
echo xp l experience du pet a sa limite gagne un niveau
echo level le niveau du pet repartie les stats quand un niveau est gagne
echo pv la vie du pet
echo mana le system de magie par defaut quantifier automatiquement pour le pet
echo type le system de type definie par O organic S sintetic O-S cyborg par defaut sur O-S impact les stats du pets en monter de niveau mais peut etre redefine sur un type customiser cependant le pet ne beneficira pas de ses aventages
echo atk l attake du pet
echo pr l escive et la defense du pet
echo rep variable d action peut etre utilise par l utilisateur ou l enemie pendant les action ou les combats
echo cl variable utilise comme increment ou decrement dans les cloaks
echo turn booleun customisee definisant le tour dans un combat P pour le jouer E pour l entite par defaut P-E
echo ret variable utilise comme retour dans un module batch dans le cas des script de niveau il sert pour difinir le niveau suivant next ou la mise en combat batel suivi du caractere du niveau mais encore la fin de niveau si vide il est aussi possible de faire une game_over avec le parametre dead
echo MAX adjectif utiliser pour servir de limiteur a un stat exemple MAXpv
echo E_ adjectif mensionner une entiter enemie peut etre combiner avec MAX exemple E_MAXpv mais aussi les variables non stastique E_level E_name E_effect E_type peuve etre utilise exeptionnelement
echo.
echo les fonctions par defaut
echo.
echo cl au debut d un block de 0 a 9 peut aller au dela mais non recommender pour la memoire fonction indiquand un boucle while
echo end a la fin d un block indicateur de fin de fonction peut etre utilise comme un else dans une condition ou pour interompre une boucle while
echo.
echo pour apprend le langague batch il est recommender d utiliser la documentation help dans l application cmd l interpreteur du language la langue est echo definie par celle de votre os
echo attention l extension batch n est pas active dans cmd certaine commande ne peuve donc pas fonction bien que mensionner par help il faut aussi eviter les caractere spetiaux non suporter par le language comme la ponctuation sauf _-
echo note le caractere @ permet de ne pas afficher un command sans desactiver le retour de command
echo.
echo la command cachee choice permet de choisir un bouton est a un retour sur la variable errorlevel en double pourcentage voir avec l outil d aide avencer pour + d info
echo.
echo attention les phrase avec des espace doivent etre entre guimet quand t elle sont mentionee en tant que variable dans le language batch
)>aide.txt
:end


::fin

call main

