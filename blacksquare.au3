#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=Operation BlackSquare
#AutoIt3Wrapper_Res_Description=Operation BlackSquare
#AutoIt3Wrapper_Res_Fileversion=1.0.2.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright Dragonapps.org
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "ReduceMemory.au3"
#Include "menu.au3"
;#include "PureAudio.au3"
;#include "pan.au3"
#include "aikBlack.au3"
#include "Pan_AIK.au3"
#include "kbc.au3"
#include "misc.au3"
#include "ColorConstants.au3"
#include "voiceover.au3"
#include "AIKCommon.au3"
Guicreate("Operation BlackSquare - http://dragonapps.org", @DesktopWidth+100, @DesktopHeight+100)
GuiSetBKColor($Color_black)
GuiSetState()

_AIK_ENGINEStart("bin")
$OneVar = 0
$TwoVar = 0
$ThreeVar = 0
$DuckChance = 0
$SoundsLoaded = 0
$MusicString = 0
$AmbienceString = 0
$CurrLevelRS = 0

$PunchThrown = 0
$PunchThrownTimer = TimerInit()
$HasSniper = 0

$SniperRangeTimer = 0
$AutorangeCheck = 0
$Kills = 0
	$CheckTimer = TimerInit()
$GameMode = 0
$Level3ChangeMusic = 0
$Level3Pass = 0
$WalkingSpeed = 0
$SpeedChanging = 0
$GameTimer = 0
$SpeedChanging = TimerInit()

$TutorialMap = 0
$Reloading = 0
$Reloadingtimer = TimerInit()
$MusicVolume = IniRead("Set.dat", "Settings", "MusicVolume", "0")


$ZombieMode = 0
$MissionMode = 0
$HasCode = 0
$NeedsCode = 1
dim $CodePos[2]
dim $CodeSound[2]
$CurrLevel = 1
$CurrWeapon = 1
$HasGun = 1
$AmmoGun = 100
$AmmoMG = 100
$Clips = 1
$HasMG = 0
$Grenadecount = 5
$CreateMG = 1
$CreatedMG = 0
dim $MGPos[2]
dim $MGSound[2]
$AmbienceToLoad = "level1"
$StepsToLoad = 0
$AmbienceSources = 6
$ShootingDirection = 1
$GrenadeDirection = 1
$IntPanStep = -0.015
$IntVolumeStep = 0.05
$Max_X = 50
$MAX_Y = 50
$MaxEnem = 1
$MaxOBJ = 10
$GunSwitchTimer = TimerInit()
dim $EOLP[50][2]
$YouDuck = 0
dim $StepBuffer[3]
dim $ShootBuffer[20]
dim $yourpos[2]
$SavedPosition = 1
$HealthRestaurations = 1
$HealthRestoring = 0
$HealthRestoringtimer = timerInit()

$LookingThrough = 0
$YourHealth = 100
dim $YourWalkTimer[2]
$Objects = 0
$shooting = 0
$ShootingTimer = 0
$throwgrenade = 0
$ThrowGrenadeTimer = 0
$ThrewGrenade = 0
dim $GrenadePos[2]
$LevelTimer = 0
$TimeForLevel = 180000
$BatteryPower = 0
$YouMadeNoise = 0
$YouMadeNoiseTimer = 0
$YouMadeNoiseTimerRunning = 0
dim $enemypos[50][2]
dim $EnemyShooting[50]
dim $EnemyShootingTimer[50]
dim $EnemyAlert[50]
dim $EnemyDest[50][2]
dim $EnemyRespawn[50]
dim $EnemyRespawnTimer[50]
dim $enemyhealth[50]
dim $enemyspeed[50][2]
dim $EnemyFX[50][12]
dim $EnemyType[50]
dim $EnemyAttack[50][2]
dim $EnemyActive[50]
dim $objectpos[100][2]
dim $ObjectName[100]
dim $objectactive[100]
dim $objectsound[100][2]
dim $ObjectType[100]
dim $AmbiencePos[10][2]
$FXIntro = ""
dim $FXAmbience[7]
dim $FXExplosions[5]
dim $FXEOLS[4]
dim $FXGrenades[6]
dim $FXMisc[3]
$FXMusic = 0
dim $FXPlayer[8]
dim $FXWeapons[20]
dim $FXRicho[8]
dim $FXSteps[12]
ShowLogos()
func ShowLogos()
$FXIntro = _AIK_EnginePlay2DName("fx\misc\logo1.ogg")
LoadSounds()
while _AIK_EngineIsCurrentlyPlayingName("fx\misc\logo1.ogg")

if _ispressed($spacebar) then _Fade($FXIntro)
WEnd
_AIK_SoundDrop($FXIntro)

$FXIntro = _AIK_EnginePlay2DName("fx\misc\logo2.ogg")
while _AIK_EngineIsCurrentlyPlayingName("fx\misc\logo2.ogg")
if _ispressed($spacebar) then _Fade($FXIntro)
WEnd
_aik_SoundDrop($FXIntro)

$FXIntro = _AIK_EnginePlay2DName("fx\misc\logo3.ogg")
while _AIK_EngineIsCurrentlyPlayingName("fx\misc\logo3.ogg")
if _ispressed($spacebar) then _Fade($FXIntro)
WEnd
_aik_SoundDrop($FXIntro)

EndFunc

ShowMenu()
func ShowMenu()

_AIK_EngineStopAllSounds()


_aik_SoundDrop($FXMusic)
$FXMusic = _AIK_EnginePlay2DName("fx\music\menu.ogg", true)
$MusicVolume = IniRead("Set.dat", "Settings", "MusicVolume", "0")
_AIK_SoundSetVolume($FXMusic, $MusicVolume)
$MenuString = "MissionMode|"
$MenuString &= "SurvivalMap|"
$menuString &= "TutorialMap|"
$menuString &= "SurvType|"
$MenuString &= "Speakercallibration|"
$MenuString &= "Terminate"
_ReduceMemory()
$menu = CreateMenu("MainScreen", $MenuString)

select
case $menu = 0
showmenu()
case $menu = -1
_fade($FXMusic)
_AIK_EngineStop()
Exit
case $menu = 1
$GameMode = 1
$TutorialMap = 0
$MissionMode = 1
$ZombieMode = 0
_fade($FXMusic)
StartGame()
case $menu = 2
$GameMode = 2
_fade($FXMusic)
$TutorialMap = 0
$MissionMode = 0
StartGame()
Case $menu = 3
$GameMode = 3
$MissionMode = 0
$ZombieMode = 0
$TutorialMap = 1
_fade($FXMusic)
StartGame()
Case $menu = 4
$Menu = CreateMenu("optionsscreen", "humans|zombies")
if $menu = 0 then showmenu()
if $menu = -1 then
sleep(250)
ShowMenu()
EndIf
if $menu = 1 then IniWrite("set.dat", "settings", "SurvivalType", "Humans")
if $menu = 2 then IniWrite("set.dat", "settings", "SurvivalType", "Zombies")
ShowMenu()

Case $menu = 5
$FXIntro = _SoundPlay("fx\misc\speakers.ogg")
$FXIntroFX = _SoundPlay3DReverb("fx\misc\speakers.ogg")
while _isplaying("fx\misc\speakers.ogg")
if _ispressed($spacebar) then
_fade($FXIntro)
_Fade($FXIntroFX)
EndIf
WEnd
;_SoundDrop($FXIntro)
ShowMenu()
case $menu = 6
_fade($FXMusic)
_AIK_EngineStop()
Exit
EndSelect

EndFunc


func StartGame()
$HasSniper = 0
$Temp = IniRead("set.dat", "settings", "SurvivalType", "humans")
if $tutorialmap = 0 then
if $MissionMode = 0 then
if $Temp = "Humans" then
$ZombieMode = 0
Else
$ZombieMode = 1
EndIf
Else
$ZombieMode = 0
EndIf
Else
$ZombieMode = 0
EndIf

if $MissionMode = 1 then
$GameTimer = TimerInit()
GoToLevel(1)
ElseIf $MissionMode = 0 and $TutorialMap = 0 then
GoToLevel("Survival1")
ElseIf $TutorialMap = 1 then
GoToLevel("Tut1")
EndIf
Main()
EndFunc
func LoadSounds()
#cs
$eolp[0][0] = 0
$eolp[0][1] = 0



$FXEOLS[0] = _SoundPlay("FX\EOLS\l1.ogg")
$FXEOLS[1] = _SoundPlay("FX\EOLS\l2.ogg")
$FXEOLS[2] = _SoundPlay("FX\EOLS\l3.ogg")
for $iload = 0 to 4
$FXExplosions[$iload] = _SoundPlay("FX\explosions\" & $iload+1 & ".ogg")
Next

$FXGrenades[0] = _SoundPlay("FX\Grenades\drop.ogg")
$FXGrenades[1] = _SoundPlay("FX\Grenades\explode.ogg")
$FXGrenades[2] = _SoundPlay("FX\Grenades\pull.ogg")
$FXGrenades[3] = _SoundPlay("FX\Grenades\throw.ogg")
$FXGrenades[4] = _SoundPlay("FX\Grenades\beep.ogg")
$FXGrenades[5] = _SoundPlay("FX\Grenades\bounce.ogg")
$FXmisc[0] = _SoundPlay("fx\misc\alarm.ogg")
$FXmisc[1] = _SoundPlay("fx\misc\Zoom_In.ogg")
$FXmisc[2] = _SoundPlay("fx\misc\Zoom_Out.ogg")

$FXPlayer[0] = _SoundPlay("FX\Player\attack.ogg")
$FXPlayer[1] = _SoundPlay("FX\player\die.ogg")
$FXPlayer[2] = _SoundPlay("FX\Player\hit.ogg")
$FXPlayer[3] = _SoundPlay("FX\Player\hitwall.ogg")
$FXPlayer[4] = _SoundPlay("FX\Player\duck.ogg")
$FXPlayer[5] = _SoundPlay("FX\Player\unduck.ogg")
$FXPlayer[6] = _SoundPlay("FX\Player\turn.ogg")
$FXPlayer[7] = _SoundPlay("FX\Player\inject.ogg")
$FXweapons[0] = _SoundPlay("FX\weapons\gun.ogg")
$FXweapons[1] = _SoundPlay("FX\weapons\mg.ogg")
$FXweapons[2] = _SoundPlay("FX\weapons\switch.ogg")
;$FXweapons[3] = _SoundPlay("FX\weapons\ric.ogg")
$FXweapons[4] = _SoundPlay("FX\weapons\Reload.ogg")
$FXweapons[5] = _SoundPlay("FX\weapons\OOAClick.ogg")
_SoundPlay("FX\weapons\Range.ogg")
$FXWeapons[7] = _SoundPlay("fx\weapons\rangeOBJ.ogg")
$FXWeapons[8] = _SoundPlay("fx\weapons\Sniper.ogg")
$FXWeapons[9] = _SoundPlay("fx\weapons\punch_throw.ogg")
$FXWeapons[10] = _SoundPlay("fx\weapons\punch_impact.ogg")
$FXWeapons[11] = _SoundPlay("fx\weapons\ttp.ogg")
$FXWeapons[12] = _SoundPlay("fx\weapons\SwitchM.ogg")
for $iload = 0 to 7
$fxricho[$iload] = _SoundPlay("fx\weapons\richo" & $iload+1 & ".ogg")
Next
#ce
$yourpos[0] = 2
$yourpos[1] = 2

$yourwalktimer[1] = 250



EndFunc
func GenerateLevel()

$FXAmbience[0] = _SoundPlay("FX\Ambience\" & $AmbienceToLoad & "\1.ogg", true, true)

if $Zombiemode = 0 then

for $iload = 0 to $MaxEnem
$EnemyAlert[$iload] = 0
$EnemyDest[$iload][0] = random(1, $MAX_X, 1)
$EnemyDest[$iload][1] = random(1, $MAX_Y, 1)
$enemyrespawn[$iload] = 1
$EnemyShooting[$iload] = 0
$enemyactive[$iload] = 1
$enemyattack[$iload][0] = TimerInit()
$enemyattack[$iload][1] = random(400, 800, 1)
$enemyspeed[$iload][1] = random(500, 1000, 1)
$enemytype[$iload] = random(0, 2, 1)
$enemypos[$iload][0] = random(0, $max_X, 1)
$enemypos[$iload][1] = random(0, $max_Y, 1)
$Enemyhealth[$iload] = random(50, 100, 1)

Next

if $missionmode = 1 and $currlevel = 4 then
for $isecond = 0 to 11
;_SoundDrop($EnemyFX[$iload][$isecond])
Next
$EnemyAlert[0] = 0
$EnemyDest[0][0] = random(1, $MAX_X, 1)
$EnemyDest[0][1] = random(1, $MAX_Y, 1)
$enemyrespawn[0] = 0
$EnemyShooting[0] = 0
$enemyactive[0] = 1
$enemyattack[0][0] = TimerInit()
$enemyattack[0][1] = random(400, 800, 1)
$enemyspeed[0][1] = 250
$enemytype[0] = "boss"
$enemypos[0][0] = random(0, $max_X, 1)
$enemypos[0][1] = random(0, $max_Y, 1)
$Enemyhealth[0] = 500



EndIf
if $Missionmode = 1 and $CurrLevel = 3 then
$MaxEnem += 1
$EnemyAlert[$maxenem] = 0
$EnemyDest[$maxenem][0] = random(1, $MAX_X, 1)
$EnemyDest[$maxenem][1] = random(1, $MAX_Y, 1)
$enemytype[$MaxEnem] = "EXR"
$enemyrespawn[$maxenem] = 0
$EnemyShooting[$maxenem] = 0
$enemyactive[$maxenem] = 1
$enemyattack[$maxenem][0] = TimerInit()
$enemyattack[$maxenem][1] = random(400, 800, 1)
$enemyspeed[$maxenem][1] = random(500, 1000, 1)
$enemypos[$maxenem][0] = 10
$enemypos[$maxenem][1] = 10
$Enemyhealth[$maxenem] = random(50, 100, 1)


EndIf
ElseIf $Zombiemode = 1 then
for $iload = 0 to $MaxEnem
$EnemyAlert[$iload] = 0
$EnemyDest[$iload][0] = random(1, $MAX_X, 1)
$EnemyDest[$iload][1] = random(1, $MAX_Y, 1)
$enemyrespawn[$iload] = 1
$EnemyShooting[$iload] = 0
$enemyactive[$iload] = 1
$enemyattack[$iload][0] = TimerInit()
$enemyattack[$iload][1] = random(400, 800, 1)
$enemyspeed[$iload][1] = random(500, 700, 1)
$enemytype[$iload] = random(0, 2, 1)
$enemypos[$iload][0] = random(0, $max_X, 1)
$enemypos[$iload][1] = random(0, $max_Y, 1)
$Enemyhealth[$iload] = random(50, 100, 1)


Next
EndIf
for $iload = 0 to 5
;_SoundDrop($FXSteps[$iload])

Next
for $iload = 0 to $MaxOBJ
$objecttype[$iload] = random(1, 4, 1)
$objectpos[$iload][0] = random(0, $MAX_X, 1)
$objectpos[$iload][1] = random(00, $MAX_Y, 1)

$objectactive[$iload] = 1
if $objecttype[$iload] = 1 then $TempObj = "hp"
if $objecttype[$iload] = 2 then $TempObj = "ammo"
if $objecttype[$iload] = 3 then $TempObj = "Ammo"
if $objecttype[$iload] = 4 then $TempObj = "grenade"
$ObjectName[$iload] = $tempobj

$ObjectSound[$iload][0] = _SoundPlay("FX\Objects\" & $TempOBJ & ".ogg", true, true)
_SetVolume($ObjectSound[$iload][0], 0)
_AIK_SoundSetPlaybackSpeed($ObjectSound[$iload][0], random(0.5, 1.5))



Next
if $createMG = 1 and $CreatedMG = 0 then
$CreatedMG = 1
$MGPos[0] = random(1, $Max_X, 1)
$MGPos[1] = random(1, $Max_Y, 1)
$MGSound[0] = _SoundPlay("FX\objects\mg.ogg", true, true)
_SetVolume($MGSound[0], 0)

EndIf
for $iload = 1 to $AmbienceSources
$FXAmbience[$iload] = _SoundPlay("FX\Ambience\" & $AmbienceToLoad  & "\R" & $iload & ".ogg", true, true)

_SetVolume($FXAmbience[$iload], 0)

$temp1 = random(1, 2, 1)
if $temp1 = 1 then $ambiencepos[$iload][0] = 5
if $temp1 = 2 then $ambiencepos[$iload][0] = $MAX_X-2

$AmbiencePos[$iload][1] = random(0, $Max_Y, 1)

Next
if $CurrLevel = 1 then
$FXEOLS[0] = _SoundPlay("FX\EOLS\l1.ogg", true, true)
_SetVolume($FXEOLS[0], 0)
ElseIf $CurrLevel = 2 then
$FXEOLS[1] = _SoundPlay("FX\EOLS\l2.ogg", true, true)
_SetVolume($FXEOLS[1], 0)
ElseIf $CurrLevel = 3 then
$FXEOLS[2] = _SoundPlay("FX\EOLS\l3.ogg", true, true)
_SetVolume($FXEOLS[2], 0)
EndIf

EndFunc
func Main()
$SoundsLoaded = 1
$AutoRangeCheck = Iniread("set.dat", "Settings", "autoRangeCheck", "0")
$kills = 0
$shootingdirection = 1
$ThrowGrenade = 0
$ThrewGrenade = 0

_AIK_EngineSetAllSoundsPaused(False)

if $MissionMode = 1 then
if $currlevel = 1 then
$FXEOLS[0] = _SoundPlay("FX\EOLS\l1.ogg", true)
;PlayAmbiental("FX\EOLS\l1.ogg", true)
EndIf
if $currlevel = 2 then
$FXEOLS[1] = _SoundPlay("FX\EOLS\l2.ogg", true)
;PlayAmbiental("FX\EOLS\l2.ogg", true)
EndIf
if $currlevel = 3 then
$FXEOLS[2] = _SoundPlay("FX\EOLS\l3.ogg", true)
;PlayAmbiental("FX\EOLS\l3.ogg", true)
EndIf
if $currlevel = 5 then
$FXEOLS[1] = _SoundPlay("FX\EOLS\l2.ogg", true)
;PlayAmbiental("FX\EOLS\l2.ogg", true)
EndIf
EndIf

_ReduceMemory()
while 1

If WinGetProcess("") = @AutoItPid Then
CheckMisc()
CheckGrenades()
CheckKeys()
CheckPosition()
if $zombiemode = 0 then CheckEnemies()
if $zombiemode = 1 then CheckZombies()
PanSounds()
EndIf
sleep(13)
WEnd
EndFunc
func CheckMisc()
if $YouDuck = 1 and $YourWalktimer[1] < 1000 then $YourWalktimer[1] = 1000
if $YouDuck = 0 and $YourWalktimer[1] > 500 then $YourWalktimer[1] = 250
if $PunchThrown = 1 and timerDiff($PunchThrownTimer) > 250 and $youduck = 0 then
if $ShootingDirection = 1 then CheckNorthPunch()
if $ShootingDirection = 2 then CheckEastPunch()
if $ShootingDirection = 3 then CheckSouthPunch()
if $ShootingDirection = 4 then CheckWestPunch()
$PunchThrown = 0
EndIf
if $CurrWeapon = 3 and TimerDiff($SniperRangeTimer) > 500 then
$SniperRangeTimer = TimerInit()
CheckrangeSniper()
EndIf
if $AutoRangeCheck = 1 and TimerDiff($SniperRangeTimer) > 1000 then
$SniperRangeTimer = TimerInit()
CheckRange()
EndIf
if $missionmode = 1 and TimerDiff($GameTimer) > 3600000 then
ResetSounds()
ResetData()
$FXIntro = _SoundPlay("FX\Cutscenes\GameOver.ogg")

while _isplaying("FX\Cutscenes\GameOver.ogg")
if _ispressed($spacebar) then _fade($FXIntro)
WEnd
;_SoundDrop($FXIntro)
ShowMenu()
EndIf
if $CurrLevel = 4 then
if $enemyalert[0] = 1 then $enemyalert[0] = 0
if $enemyactive[0] = 0 then
GoToLevel(5)
EndIf
EndIf
if $CurrLevel = 3 then
if $enemyactive[$maxenem] = 0 and $Level3Pass = 0 then

$Level3Pass = 1
EndIf

if TimerDiff($LevelTimer) > 180000 then
_Soundstop($FXMusic)
;_SoundDrop($FXMusic)
$FXMusic = _SoundPlay("FX\Music\Game3_4.ogg", true)


playerhurt(100000)
EndIf
if TimerDiff($Leveltimer) > 60000 and TimerDiff($Leveltimer) < 120000 and $Level3ChangeMusic = 0 then
$Level3ChangeMusic = 1
_Soundstop($FXMusic)
;_SoundDrop($FXMusic)
$FXMusic = _SoundPlay("FX\Music\Game3_2.ogg", true)
$MusicVolume = IniRead("Set.dat", "Settings", "MusicVolume", "0")
_setvolume($FXMusic, $MusicVolume)


EndIf

if TimerDiff($Leveltimer) > 120000 and TimerDiff($Leveltimer) < 180000 and $Level3ChangeMusic = 1 then
$Level3ChangeMusic = 2
_Soundstop($FXMusic)
;_SoundDrop($FXMusic)
$FXMusic = _SoundPlay("FX\Music\Game3_3.ogg", true)
$MusicVolume = IniRead("Set.dat", "Settings", "MusicVolume", "0")
_setvolume($FXMusic, $MusicVolume)


EndIf

EndIf

if $healthrestoring = 1 and timerDiff($Healthrestoringtimer) > 3000 then
$healthrestoring = 0
EndIf
if $reloading = 1 and TimerDiff($ReloadingTimer) > 1000 then
$reloading = 0
EndIf
if $YouMadeNoise > 3 and $YouMadeNoiseTimerRunning = 0 then
$YouMadeNoiseTimerRunning = 1
$YouMadeNoiseTimer = TimerInit()
EndIf
if TimerDiff($YouMadeNoiseTimer) > 10000 and $YouMadeNoiseTimerRunning = 1 then
$YouMadeNoise = 0
$YouMadeNoiseTimerRunning = 0
EndIf
EndFunc
func CheckGrenades()

if $throwgrenade = 1 and TimerDiff($ThrowGrenadeTimer) > 1000 then

$grenadepos[0] = $yourpos[0]
$grenadepos[1] = $yourpos[1]
if $GrenadeDirection = 1 then $grenadepos[1] += 10
if $GrenadeDirection = 2 then $grenadepos[0] += 10
if $GrenadeDirection = 3 then $grenadepos[1] -= 10
if $GrenadeDirection = 4 then $grenadepos[0] -= 10
if $grenadepos[0] < 1 then
$grenadepos[0] = 1
PlaySoundPositioned("FX\Grenades\bounce.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)
PlayAmbientalPositioned("FX\Grenades\bounce.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)

EndIf

if $grenadepos[0] > $Max_X then
$grenadepos[0] = $Max_X
PlaySoundPositioned("FX\Grenades\bounce.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)
PlayAmbientalPositioned("FX\Grenades\bounce.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)

EndIf
if $grenadepos[1] < 1 then
$grenadepos[1] = 1
PlaySoundPositioned("FX\Grenades\bounce.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)
PlayAmbientalPositioned("FX\Grenades\bounce.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)
EndIf
if $grenadepos[1] > $Max_Y then
$grenadepos[1] = $Max_Y
PlaySoundPositioned("FX\Grenades\bounce.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)
PlayAmbientalPositioned("FX\Grenades\bounce.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)
EndIf
$ThrowGrenade = 0
PlaySoundPositioned("FX\Grenades\beep.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)
PlayAmbientalPositioned("FX\Grenades\beep.ogg", $GrenadePos[0], $GrenadePos[1], $IntVolumeStep, $IntPanstep)
PlaySoundPositioned("FX\Grenades\drop.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)
PlayAmbientalPositioned("FX\Grenades\drop.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)


$threwgrenade = 1
$ThrowGrenadetimer = TimerInit()

EndIf
if $threwgrenade = 1 and TimerDiff($ThrowGrenadeTimer) > 500 then

$ThrewGrenade = 0
PlaySoundPositioned("FX\Grenades\explode.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)
PlayAmbientalPositioned("FX\Grenades\explode.ogg", $GrenadePos[0], $GrenadePos[1], $IntPanStep, $IntVolumeStep)
CheckGrenadeHit()
EndIf
EndFunc
func CheckGrenadeHit()

for $iload = 0 to $MaxOBJ
if $objectpos[$iload][0] - $grenadepos[0] > -10 and $objectpos[$iload][0] - $grenadepos[0] < 10 and $objectpos[$iload][1] - $grenadepos[1] > -10 and $objectpos[$iload][1] - $grenadepos[1] < 10 then
_Soundstop($ObjectSound[$iload][0])
$ObjectActive[$iload] = 0
EndIf
Next
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][0] - $grenadepos[0] > -5 and $enemypos[$iload][0] - $grenadepos[0] < 5 and $enemypos[$iload][1] - $grenadepos[1] > -5 and $enemypos[$iload][1] - $grenadepos[1] < 5 then

EnemyHit($iload, 100)
EndIf

if $enemypos[$iload][0] - $grenadepos[0] > -10 and $enemypos[$iload][0] - $grenadepos[0] < 10  and $enemypos[$iload][1] - $grenadepos[1] > -10 and $enemypos[$iload][1] - $grenadepos[1] < 10 then

EnemyHit($iload, 50)
EndIf
EndIf
Next

if $yourpos[0] - $grenadepos[0] > -5 and $yourpos[0] - $grenadepos[0] < 5 and $yourpos[1] - $grenadepos[1] > -5 and $yourpos[1] - $grenadepos[1] < 5 then

PlayerHurt(100)
EndIf

if $yourpos[0] - $grenadepos[0] > -10 and $yourpos[0] - $grenadepos[0] < 10  and $yourpos[1] - $grenadepos[1] > -10 and $yourpos[1] - $grenadepos[1] < 10 then

PlayerHurt(50)
EndIf


EndFunc

func CheckZombies()

if $ZombieMode = 0 then
for $iload = 0 to $maxenem
if $enemypos[$iload][0] - $yourpos[0] < 60 and $yourpos[0] - $enemypos[$iload][0] > -60 and $enemypos[$iload][1] - $yourpos[1] < 60 and $yourpos[1] - $enemypos[$iload][1] > -60 then
if $enemyactive[$iload] = 0 then
if $enemyrespawn[$iload] = 1 and TimerDiff($EnemyRespawnTimer[$iload]) > 10000 then
for $isecond = 0 to 10
;_Soundstop($EnemyFX[$iload][$isecond])
;;_SoundDrop($EnemyFX[$iload][$isecond])
Next
$enemyrespawn[$iload] = 1
$EnemyShooting[$iload] = 0
$EnemyAlert[$iload] = 0
$enemyactive[$iload] = 1
$enemyattack[$iload][0] = TimerInit()
$enemyattack[$iload][1] = random(400, 800, 1)
$enemyspeed[$iload][1] = random(500, 1000, 1)
$enemytype[$iload] = random(0, 2, 1)
$TempSpawn = random(1, 4, 1)
if $TempSpawn = 1 then
$enemypos[$iload][0] = 1
$enemypos[$iload][1] = 1
ElseIf $TempSpawn = 2 then
$enemypos[$iload][0] = 1
$enemypos[$iload][1] = $Max_Y
ElseIf $TempSpawn = 3 then
$enemypos[$iload][0] = $MAX_X
$enemypos[$iload][1] = $Max_Y
ElseIf $TempSpawn = 4 then
$enemypos[$iload][0] = $MAX_X
$enemypos[$iload][1] = 1
EndIf
$Enemyhealth[$iload] = random(50, 100, 1)



EndIf
EndIf
if $enemyactive[$iload] = 1 then

#CS
if $LookingThrough = 0 then

for $ISecond = 0 to 11
if $enemypos[$iload][0] - $yourpos[0] < 35 and $yourpos[0] - $enemypos[$iload][0] > -35 and $enemypos[$iload][1] - $yourpos[1] < 35 and $yourpos[1] - $enemypos[$iload][1] > -35 then
generate_pan_2D($YourPos[0], $YourPos[1], $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, $EnemyFX[$ILoad][$ISecond])
Else
if not _Soundgetvolume($EnemyFX[$iload][$isecond]) < -0.01 then _setvolume($EnemyFX[$iload][$isecond], 0)
EndIf
Next

EndIf
#CE
if TimerDiff($enemyspeed[$iload][0]) > $enemyspeed[$iload][1] then
$enemyspeed[$iload][0] = TimerInit()
if $EnemyAlert[$iload] = 1 then

if $enemypos[$iload][0] < $yourpos[0] then $enemypos[$iload][0] += 1
if $enemypos[$iload][0] > $yourpos[0] then $enemypos[$iload][0] -= 1
if $enemypos[$iload][1] < $yourpos[1] then $enemypos[$iload][1] += 1
if $enemypos[$iload][1] > $yourpos[1] then $enemypos[$iload][1] -= 1
Else
if $enemypos[$iload][0] < $EnemyDest[$iload][0] then $enemypos[$iload][0] += 1
if $enemypos[$iload][0] > $EnemyDest[$iload][0] then $enemypos[$iload][0] -= 1
if $enemypos[$iload][1] < $EnemyDest[$iload][1] then $enemypos[$iload][1] += 1
if $enemypos[$iload][1] > $EnemyDest[$iload][1] then $enemypos[$iload][1] -= 1
if $Enemypos[$iload][0] = $EnemyDest[$iload][0]  and $EnemyPos[$iload][1] = $EnemyDest[$iload][1] then
$EnemyDest[$iload][0] = random(1, $MAX_X, 1)
$EnemyDest[$iload][1] = random(1, $MAX_Y, 1)
EndIf
EndIf
if $enemypos[$iload][0] - $yourpos[0] < 30 and $yourpos[0] - $enemypos[$iload][0] > -30 and $enemypos[$iload][1] - $yourpos[1] < 30 and $yourpos[1] - $enemypos[$iload][1] > -30 then
$TempVar = random(8, 9, 1)
PlaySoundPositioned("FX\Steps\" & $StepsToLoad & "\" & random(1, 6, 1) & ".ogg", $Enemypos[$iload][0], $Enemypos[$iload][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\Steps\" & $StepsToLoad & "\" & random(1, 6, 1) & ".ogg", $Enemypos[$iload][0], $Enemypos[$iload][1], $IntPanStep, $IntVolumeStep, False)
EndIf



EndIf

if $EnemyAlert[$iload] = 0 then

for $isecond = $yourpos[0]-5 to $yourpos[0]+5
for $ithird = $yourpos[1]-5 to $yourpos[1]+5
if $enemypos[$iload][0] = $isecond and $enemypos[$iload][1] = $ithird then
$EnemyAlert[$iload] = 1

$enemyFX[$iload][10] = PlaySoundPositioned("FX\AI\" & $Enemytype[$iload] & "\notice.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\AI\" & $Enemytype[$iload] & "\notice.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
EndIf
Next
Next



if $YouMadeNoiseTimerRunning = 1 and $EnemyAlert[$iload] = 0 then
if $enemypos[$iload][0] - $yourpos[0] < 20 and $yourpos[0] - $enemypos[$iload][0] > -20 and $enemypos[$iload][1] - $yourpos[1] < 20 and $yourpos[1] - $enemypos[$iload][1] > -20 then
$EnemyAlert[$iload] = 1

$enemyFX[$iload][10] = PlaySoundPositioned("FX\AI\" & $Enemytype[$iload] & "\notice.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\AI\" & $Enemytype[$iload] & "\notice.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
EndIf
EndIf
EndIf
if $YoumadeNoiseTimerRunning = 1 and TimerDiff($YouMadeNoiseTimer) > 10000 and $EnemyAlert[$iload] = 1 then
if not $enemypos[$iload][0] - $yourpos[0] < 10 and $yourpos[0] - $enemypos[$iload][0] > -10 and $enemypos[$iload][1] - $yourpos[1] < 10 and $yourpos[1] - $enemypos[$iload][1] > -10 then
$EnemyAlert[$iload] = 0

EndIf
EndIf

if $EnemyAlert[$iload] = 1 then

for $isecond = 0 to 5
if $enemypos[$iload][0]-$isecond = $yourpos[0] or $enemypos[$iload][0]+$isecond = $yourpos[0] then
if $enemypos[$iload][1]-$isecond = $yourpos[1] or $enemypos[$iload][1]+$isecond = $yourpos[1] then
if TimerDiff($EnemyAttack[$iload][0]) > $EnemyAttack[$iload][1] then
$EnemyAttack[$iload][0] = TimerInit()
$enemyattack[$iload][1] = random(400, 1000, 1)


$enemyFX[$iload][11] = PlaySoundPositioned("FX\AI\" & $Enemytype[$iload] & "\attack.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\AI\" & $Enemytype[$iload] & "\attack.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
$enemyshooting[$iload] = 1
$enemyshootingtimer[$iload] = TimerInit()
EndIf
EndIf
EndIf
Next

if $enemyshooting[$iload] = 1 and timerdiff($enemyshootingtimer[$iload]) > 300 then

if $youduck <>  1 then
$enemyFX[$iload][11] = PlaySoundPositioned("FX\AI\" & $Enemytype[$iload] & "\gun.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\AI\" & $Enemytype[$iload] & "\gun.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
PlayerHurt()

$enemyshooting[$iload] = 0
EndIf
EndIf
EndIf
EndIf
EndIf
Next
EndIf
EndFunc
func CheckEnemies()

if $ZombieMode = 0 then
for $iload = 0 to $maxenem
if $enemypos[$iload][0] - $yourpos[0] < 60 and $yourpos[0] - $enemypos[$iload][0] > -60 and $enemypos[$iload][1] - $yourpos[1] < 60 and $yourpos[1] - $enemypos[$iload][1] > -60 then
if $enemyactive[$iload] = 0 then
if $enemyrespawn[$iload] = 1 and TimerDiff($EnemyRespawnTimer[$iload]) > 10000 then
#CS
for $isecond = 0 to 10
;_Soundstop($EnemyFX[$iload][$isecond])
;;_SoundDropnemyFX[$iload][$isecond])
Next
#CE
$enemyrespawn[$iload] = 1
$EnemyShooting[$iload] = 0
$EnemyAlert[$iload] = 0
$enemyactive[$iload] = 1
$enemyattack[$iload][0] = TimerInit()
$enemyattack[$iload][1] = random(400, 800, 1)
$enemyspeed[$iload][1] = random(500, 1000, 1)
$enemytype[$iload] = random(0, 2, 1)
$TempSpawn = random(1, 4, 1)
if $TempSpawn = 1 then
$enemypos[$iload][0] = 1
$enemypos[$iload][1] = 1
ElseIf $TempSpawn = 2 then
$enemypos[$iload][0] = 1
$enemypos[$iload][1] = $Max_Y
ElseIf $TempSpawn = 3 then
$enemypos[$iload][0] = $MAX_X
$enemypos[$iload][1] = $Max_Y
ElseIf $TempSpawn = 4 then
$enemypos[$iload][0] = $MAX_X
$enemypos[$iload][1] = 1
EndIf
$Enemyhealth[$iload] = random(50, 100, 1)



EndIf
EndIf
if $enemyactive[$iload] = 1 then
#CS
if $LookingThrough = 0 then

for $ISecond = 0 to 11
if $enemypos[$iload][0] - $yourpos[0] < 35 and $yourpos[0] - $enemypos[$iload][0] > -35 and $enemypos[$iload][1] - $yourpos[1] < 35 and $yourpos[1] - $enemypos[$iload][1] > -35 then
;generate_pan_2D($YourPos[0], $YourPos[1], $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, $EnemyFX[$ILoad][$ISecond])
Else
if not _Soundgetvolume($EnemyFX[$iload][$isecond]) < -0.01 then _setvolume($EnemyFX[$iload][$isecond], 0)
EndIf
Next

EndIf
#CE
if TimerDiff($enemyspeed[$iload][0]) > $enemyspeed[$iload][1] then
$enemyspeed[$iload][0] = TimerInit()
if $EnemyAlert[$iload] = 1 then

if $enemypos[$iload][0] < $yourpos[0] then $enemypos[$iload][0] += 1
if $enemypos[$iload][0] > $yourpos[0] then $enemypos[$iload][0] -= 1
if $enemypos[$iload][1] < $yourpos[1] then $enemypos[$iload][1] += 1
if $enemypos[$iload][1] > $yourpos[1] then $enemypos[$iload][1] -= 1
Else
if $enemypos[$iload][0] < $EnemyDest[$iload][0] then $enemypos[$iload][0] += 1
if $enemypos[$iload][0] > $EnemyDest[$iload][0] then $enemypos[$iload][0] -= 1
if $enemypos[$iload][1] < $EnemyDest[$iload][1] then $enemypos[$iload][1] += 1
if $enemypos[$iload][1] > $EnemyDest[$iload][1] then $enemypos[$iload][1] -= 1
if $Enemypos[$iload][0] = $EnemyDest[$iload][0]  and $EnemyPos[$iload][1] = $EnemyDest[$iload][1] then
$EnemyDest[$iload][0] = random(1, $MAX_X, 1)
$EnemyDest[$iload][1] = random(1, $MAX_Y, 1)
EndIf
EndIf
if $enemypos[$iload][0] - $yourpos[0] < 30 and $yourpos[0] - $enemypos[$iload][0] > -30 and $enemypos[$iload][1] - $yourpos[1] < 30 and $yourpos[1] - $enemypos[$iload][1] > -30 then
$TempVar = random(8, 9, 1)
PlaySoundPositioned("FX\Steps\" & $StepsToLoad & "\" & random(1, 6, 1) & ".ogg", $Enemypos[$iload][0], $Enemypos[$iload][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\Steps\" & $StepsToLoad & "\" & random(1, 6, 1) & ".ogg", $Enemypos[$iload][0], $Enemypos[$iload][1], $IntPanStep, $IntVolumeStep, False)
EndIf



EndIf

if $EnemyAlert[$iload] = 0 then

for $isecond = $yourpos[0]-5 to $yourpos[0]+5
for $ithird = $yourpos[1]-5 to $yourpos[1]+5
if $enemypos[$iload][0] = $isecond and $enemypos[$iload][1] = $ithird then
$EnemyAlert[$iload] = 1

$enemyFX[$iload][10] = PlaySoundPositioned("FX\AI\" & $Enemytype[$iload] & "\notice.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\AI\" & $Enemytype[$iload] & "\notice.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
EndIf
Next
Next



if $YouMadeNoiseTimerRunning = 1 and $EnemyAlert[$iload] = 0 then
if $enemypos[$iload][0] - $yourpos[0] < 20 and $yourpos[0] - $enemypos[$iload][0] > -20 and $enemypos[$iload][1] - $yourpos[1] < 20 and $yourpos[1] - $enemypos[$iload][1] > -20 then
$EnemyAlert[$iload] = 1

$enemyFX[$iload][10] = PlaySoundPositioned("FX\AI\" & $Enemytype[$iload] & "\notice.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\AI\" & $Enemytype[$iload] & "\notice.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
EndIf
EndIf
EndIf
if $YoumadeNoiseTimerRunning = 1 and TimerDiff($YouMadeNoiseTimer) > 10000 and $EnemyAlert[$iload] = 1 then
if not $enemypos[$iload][0] - $yourpos[0] < 10 and $yourpos[0] - $enemypos[$iload][0] > -10 and $enemypos[$iload][1] - $yourpos[1] < 10 and $yourpos[1] - $enemypos[$iload][1] > -10 then
$EnemyAlert[$iload] = 0

EndIf
EndIf

if $EnemyAlert[$iload] = 1 then

for $isecond = 0 to 5
if $enemypos[$iload][0]-$isecond = $yourpos[0] or $enemypos[$iload][0]+$isecond = $yourpos[0] then
if $enemypos[$iload][1]-$isecond = $yourpos[1] or $enemypos[$iload][1]+$isecond = $yourpos[1] then
if TimerDiff($EnemyAttack[$iload][0]) > $EnemyAttack[$iload][1] then
$EnemyAttack[$iload][0] = TimerInit()
$enemyattack[$iload][1] = random(400, 1000, 1)


$enemyFX[$iload][11] = PlaySoundPositioned("FX\AI\" & $Enemytype[$iload] & "\gun.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\AI\" & $Enemytype[$iload] & "\gun.ogg", $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep, $IntVolumeStep, False)

$enemyshooting[$iload] = 1
$enemyshootingtimer[$iload] = TimerInit()
;msgbox(64, "", $youduck)
EndIf
EndIf
EndIf
Next

if $enemyshooting[$iload] = 1 and timerdiff($enemyshootingtimer[$iload]) > 300 then
if $youduck <>  1 then PlayerHurt()
if $youduck = 1 then
$IsHit = 0
$DuckChance += 1
if $DuckChance > 2 then
$RandomVar = Random(1, 3, 1)
if $Randomvar = 1 then
PlayerHurt()
$isHit = 1
Else
$Richo = random(0, 7, 1)
$FXRicho[$richo] = _SoundPlay("fx\weapons\richo" & random(1, 8, 1) & ".ogg")
PlayAmbiental("fx\weapons\richo" & random(1, 8, 1) & ".ogg")
EndIf
EndIf
if not $IsHit = 1 then
$Richo = random(0, 7, 1)
$FXRicho[$richo] = _SoundPlay("fx\weapons\richo" & random(1, 8, 1) & ".ogg")
PlayAmbiental("fx\weapons\richo" & random(1, 8, 1) & ".ogg")
EndIf
EndIf

$enemyshooting[$iload] = 0


EndIf
EndIf
EndIf
EndIf
Next
EndIf
EndFunc

func CheckKeys()
;if _ispressed($q) then $OneVar = Inputbox("", "")
;if _ispressed($w) then $TwoVar = Inputbox("", "")
;if _ispressed($e) then $ThreeVar = Inputbox("", "")
;if _ispressed($r) then $CurrLevelRS = Inputbox("", "")
if _ispressed($f1) then
if $AutoRangecheck = 0 then
$AutoRangeCheck = 1
vo("on")
IniWrite("set.dat", "settings", "AutoRangeCheck", "1")
else
$AutorangeCheck = 0
vo("off")
IniWrite("set.dat", "settings", "AutoRangeCheck", "0")
EndIf

EndIf
;if _ispressed($Spacebar) then
;CheckRange()
;EndIf
if _ispressed($k) then
vo($kills)
if $kills = 1 then
vo("kill")
else
vo("kills")
EndIf
EndIf
;if _ispressed($f1) then s_play($fxweapons[0])
if _ispressed($delete) and $YouDuck = 0 then
$CheatCMD = Inputbox("Cheat Console", "Enter a cheat code")
if $Cheatcmd = "Time to PWN!" then $HasSniper = 1
if $CheatCMD = "Me Nu Wanna Die!" then $yourhealth = 100000
if $CheatCMD = "Grenades, sir, I need grenades!" then $grenadecount += 100
if $cheatCMD = "Me want me MG!" then
$HasMG = 1
$MGSound[1] = _SoundPlay("fx\objects\mg_pick.ogg")
PlayAmbiental("fx\objects\mg_pick.ogg")
_Soundstop($MGSound[0])
EndIf
if $CheatCMD = "Can me be level 1?" and $MissionMode = 1 then GoToLevel(1)
if $CheatCMD = "Me wanna be Level 2!" and $MissionMode = 1 then GoToLevel(2)
if $CheatCMD = "Jump in the fire!" and $MissionMode = 1 then GoToLevel(3)
if $CheatCMD = "Can me get pwnt?" and $MissionMode = 1 then GoToLevel(4)
if $CheatCMD = "Me wanna run!" and $MissionMode = 1 then GoToLevel(5)
if $CheatCMD = "Get me outa here!" then GoToLevel("End")
if $CheatCMD = "Ammo! I needs ammo!" then $Clips += 20
if $CheatCMD = "Medkits! I need Medkits over here! Hello?" then $Healthrestaurations += 10
EndIf

;if _ispressed($f6) then gotolevel("end")
;if _ispressed($f5) then GoToLevel(5)
;if _ispressed($o) then msgbox(64, "", $currlevel)
;if _ispressed($f4) then GoToLevel(4)

;if _ispressed($f3) then GoToLevel("3")
if _ispressed($x) and $healthrestaurations > 0 and $healthrestoring = 0 then
$HealthRestoring = 1
$Healthrestoringtimer = TimerInit()
$yourhealth = 100
$FXPlayer[7] = _SoundPlay("FX\Player\inject.ogg")
PlayAmbiental("FX\Player\inject.ogg")
$healthrestaurations -= 1
endIf

;if _ispressed($t0) then $HASMG = 1

if _ispressed($r) and $reloading = 0 and $clips > 0 then
$reloading = 1
$ReloadingTimer = TimerInit()
$FXweapons[4] = _SoundPlay("FX\weapons\Reload.ogg")
PlayAmbiental("FX\weapons\Reload.ogg")
if $CurrWeapon = 1 then $AmmoGun = 10
if $CurrWeapon = 2 then $AmmoMG = 50
$Clips -= 1
EndIf

;if _ispressed($p) then
;msgbox(64, "", $yourpos[0] & $yourpos[1] & $eolp[0][0] & $eolp[0][1])
;EndIf


;if _ispressed($b) then
;$YourPos[0] = 1
;$YourPos[1] = 1
;EndIf
;if _ispressed($s) then Status()
;if _ispressed($F1) then
;ResetSounds()
;ResetData()
;GoToLevel(1)
;
;endIf


;if _ispressed($F2) then

;GoToLevel(2)
;endIf
;if _ispressed($z) then
;$yourpos[0] = $CodePos[0]-2
;$yourpos[1] = $CodePos[1]-2
;EndIf
if _ispressed($page_down) then
_setvolume($FXMusic, _Soundgetvolume($FXMusic)-0.01)
IniWrite("set.dat", "settings", "MusicVolume", _Soundgetvolume($FXMusic))
EndIf
if _ispressed($page_up) then
_setvolume($FXMusic, _Soundgetvolume($FXMusic)+0.01)
IniWrite("set.dat", "settings", "MusicVolume", _Soundgetvolume($FXMusic))
EndIf


if _ispressed($d) and $YouDuck = 0 then
$FXPlayer[4] = _SoundPlay("FX\Player\duck.ogg")
PlayAmbiental("FX\Player\duck.ogg")
$DuckChance = 0
while _ispressed($d)
CheckMisc()
if $youduck <> 1 then $youduck = 1
CheckGrenades()
CheckKeys()
CheckPosition()
if $zombiemode = 0 then CheckEnemies()
if $zombiemode = 1 then CheckZombies()
PanSounds()
if _ispressed($l) then
$FXmisc[1] = _SoundPlay("fx\misc\Zoom_In.ogg")
PlayAmbiental("fx\misc\Zoom_In.ogg")
while _ispressed($L)
$LookingThrough = 1

CheckMisc()
CheckGrenades()

CheckPosition()
if $zombiemode = 0 then CheckEnemies()
if $zombiemode = 1 then CheckZombies()



for $iload = 0 to $MaxEnem
if $enemyactive[$iload] = 1 then
if $enemypos[$iload][0] - $yourpos[0] < 30 and $yourpos[0] - $enemypos[$iload][0] > -30 and $enemypos[$iload][1] - $yourpos[1] < 30 and $yourpos[1] - $enemypos[$iload][1] > -30 then
for $ISecond = 0 to 10
generate_pan_2D($YourPos[0], $YourPos[1], $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep-0.03, $intVolumeStep-0.035, $EnemyFX[$ILoad][$ISecond])
Next
generate_pan_2D($YourPos[0], $YourPos[1], $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep-0.03, $intVolumeStep-0.035, $EnemyFX[$ILoad][11])
EndIf
EndIf
Next


if $MissionMode = 1 then
if $CurrLevel = 1 then generate_pan_2D($YourPos[0], $YourPos[1], $eolp[0][0], $eolp[0][1], $IntPanStep-0.03, $intVolumeStep-0.035, $FXEOLS[0])
if $CurrLevel = 2 or $Currlevel = 5 then generate_pan_2D($YourPos[0], $YourPos[1], $eolp[0][0], $eolp[0][1], $IntPanStep-0.03, $intVolumeStep-0.035, $FXEOLS[1])
if $CurrLevel = 3 then generate_pan_2D($YourPos[0], $YourPos[1], $eolp[0][0], $eolp[0][1], $IntPanStep-0.03, $intVolumeStep-0.035, $FXEOLS[2])
if $NeedsCode = 1 then generate_pan_2D($YourPos[0], $YourPos[1], $CodePos[0], $codePos[1], $IntPanStep-0.03, $intVolumeStep-0.035, $CodeSound[0])

EndIf
if $CreateMG = 1 then generate_pan_2D($YourPos[0], $YourPos[1], $mgpos[0], $mgpos[1], $IntPanStep-0.03, $intVolumeStep-0.035, $MGSound[0])
if $throwgrenade = 1 then generate_pan_2D($YourPos[0], $YourPos[1], $grenadepos[0], $grenadepos[1], $IntPanStep-0.03, $intVolumeStep-0.035, $FXGrenades[4])
for $iload = 0 to $MaxOBJ
if $ObjectActive[$iload] = 1 then
if $objectpos[$iload][0] - $yourpos[0] < 30 and $yourpos[0] - $objectpos[$iload][0] > -30 and $objectpos[$iload][1] - $yourpos[1] < 30 and $yourpos[1] - $objectpos[$iload][1] > -30 then

generate_pan_2D($YourPos[0], $YourPos[1], $ObjectPos[$iload][0], $ObjectPos[$iload][1], $IntPanStep-0.03, $intVolumeStep-0.035, $ObjectSound[$ILoad][0])
generate_pan_2D($YourPos[0], $YourPos[1], $ObjectPos[$iload][0], $ObjectPos[$iload][1], $IntPanStep-0.03, $intVolumeStep-0.035, $ObjectSound[$ILoad][1])
EndIf
EndIf
Next
for $iload = 1 to $AmbienceSources
generate_pan_2D($YourPos[0], $YourPos[1], $AmbiencePos[$iload][0], $AmbiencePos[$iload][1], $IntPanStep-0.03, $intVolumeStep-0.035, $FXAmbience[$ILoad])
Next
WEnd
$LookingThrough = 0
$FXmisc[2] = _SoundPlay("fx\misc\Zoom_Out.ogg")
PlayAmbiental("fx\misc\Zoom_Out.ogg")
EndIf
WEnd
$youduck = 0
$FXPlayer[5] = _SoundPlay("FX\Player\unduck.ogg")
PlayAmbiental("FX\Player\unduck.ogg")
EndIf
if _ispressed($t1) and TimerDiff($GunSwitchTimer) > 1000 then
$GunSwitchTimer = TimerInit()
$CurrWeapon = 1
$FXweapons[2] = _SoundPlay("FX\weapons\switch.ogg")
PlayAmbiental("FX\weapons\switch.ogg")
EndIf
if _ispressed($t2) and TimerDiff($GunSwitchTimer) > 1000 then
$GunSwitchTimer = TimerInit()
$CurrWeapon = 4
$FXweapons[2] = _SoundPlay("FX\weapons\switchM.ogg")
PlayAmbiental("FX\weapons\switchM.ogg")
EndIf

if _ispressed($t3) and TimerDiff($GunSwitchTimer) > 1000 and $HasMG = 1 then
$GunSwitchTimer = TimerInit()
$CurrWeapon = 2
$FXweapons[2] = _SoundPlay("FX\weapons\switch.ogg")
PlayAmbiental("FX\weapons\switch.ogg")
EndIf
if _ispressed($t4) and TimerDiff($GunSwitchTimer) > 1000 then
if $HasSniper = 1 then
$GunSwitchTimer = TimerInit()
$CurrWeapon = 3
$FXweapons[2] = _SoundPlay("FX\weapons\switch.ogg")
PlayAmbiental("FX\weapons\switch.ogg")
Else
if not _isplaying("fx\weapons\ttp.ogg") then
_SoundPlay("fx\weapons\ttp.ogg")
PlayAmbiental("fx\weapons\ttp.ogg")
EndIf
EndIf
EndIf
if _ispressed($shift) and $throwgrenade = 0 and $grenadecount > 0 and $YouDuck = 0 then
$grenadecount -= 1
$GrenadeDirection = $shootingdirection
$FXGrenades[2] = _SoundPlay("FX\Grenades\pull.ogg")
PlayAmbiental("FX\Grenades\pull.ogg")
sleep(300)
$FXGrenades[3] = _SoundPlay("FX\Grenades\throw.ogg")
PlayAmbiental("FX\Grenades\throw.ogg")
$YouMadeNoise += 4
$ThrowGrenade = 1
$ThrowGrenadeTimer = TimerInit()
EndIf
if _ispressed($control) and $YouDuck = 0 then
if $CurrWeapon = 1 and $HasGun = 1 and $Reloading = 0 then FireGun()
if $CurrWeapon = 2 and $reloading = 0 then FireMG()
if $CurrWeapon = 3 and $reloading = 0 then FireSniper()
if $CurrWeapon = 4 and $reloading = 0 then FireHand()
EndIf
if _ispressed($L) then
$FXmisc[1] = _SoundPlay("fx\misc\Zoom_In.ogg")
PlayAmbiental("fx\misc\Zoom_In.ogg")
while _ispressed($L)
$LookingThrough = 1

CheckMisc()
CheckGrenades()

CheckPosition()
if $zombiemode = 0 then CheckEnemies()
if $zombiemode = 1 then CheckZombies()



for $iload = 0 to $MaxEnem
if $enemyactive[$iload] = 1 then
if $enemypos[$iload][0] - $yourpos[0] < 30 and $yourpos[0] - $enemypos[$iload][0] > -30 and $enemypos[$iload][1] - $yourpos[1] < 30 and $yourpos[1] - $enemypos[$iload][1] > -30 then
for $ISecond = 0 to 10
generate_pan_2D($YourPos[0], $YourPos[1], $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep-0.03, $intVolumeStep-0.035, $EnemyFX[$ILoad][$ISecond])
Next
generate_pan_2D($YourPos[0], $YourPos[1], $EnemyPos[$iload][0], $EnemyPos[$iload][1], $IntPanStep-0.03, $intVolumeStep-0.035, $EnemyFX[$ILoad][11])
EndIf
EndIf
Next


if $MissionMode = 1 then
if $CurrLevel = 1 then generate_pan_2D($YourPos[0], $YourPos[1], $eolp[0][0], $eolp[0][1], $IntPanStep-0.03, $intVolumeStep-0.035, $FXEOLS[0])
if $CurrLevel = 2 or $Currlevel = 5 then generate_pan_2D($YourPos[0], $YourPos[1], $eolp[0][0], $eolp[0][1], $IntPanStep-0.03, $intVolumeStep-0.035, $FXEOLS[1])
if $CurrLevel = 3 then generate_pan_2D($YourPos[0], $YourPos[1], $eolp[0][0], $eolp[0][1], $IntPanStep-0.03, $intVolumeStep-0.035, $FXEOLS[2])
if $NeedsCode = 1 then generate_pan_2D($YourPos[0], $YourPos[1], $CodePos[0], $codePos[1], $IntPanStep-0.03, $intVolumeStep-0.035, $CodeSound[0])

EndIf
if $CreateMG = 1 then generate_pan_2D($YourPos[0], $YourPos[1], $mgpos[0], $mgpos[1], $IntPanStep-0.03, $intVolumeStep-0.035, $MGSound[0])
if $throwgrenade = 1 then generate_pan_2D($YourPos[0], $YourPos[1], $grenadepos[0], $grenadepos[1], $IntPanStep-0.03, $intVolumeStep-0.035, $FXGrenades[4])
for $iload = 0 to $MaxOBJ
if $ObjectActive[$iload] = 1 then
if $objectpos[$iload][0] - $yourpos[0] < 30 and $yourpos[0] - $objectpos[$iload][0] > -30 and $objectpos[$iload][1] - $yourpos[1] < 30 and $yourpos[1] - $objectpos[$iload][1] > -30 then

generate_pan_2D($YourPos[0], $YourPos[1], $ObjectPos[$iload][0], $ObjectPos[$iload][1], $IntPanStep-0.03, $intVolumeStep-0.035, $ObjectSound[$ILoad][0])
generate_pan_2D($YourPos[0], $YourPos[1], $ObjectPos[$iload][0], $ObjectPos[$iload][1], $IntPanStep-0.03, $intVolumeStep-0.035, $ObjectSound[$ILoad][1])
EndIf
EndIf
Next
for $iload = 1 to $AmbienceSources
generate_pan_2D($YourPos[0], $YourPos[1], $AmbiencePos[$iload][0], $AmbiencePos[$iload][1], $IntPanStep-0.03, $intVolumeStep-0.035, $FXAmbience[$ILoad])
Next
WEnd
$LookingThrough = 0
$FXmisc[2] = _SoundPlay("fx\misc\Zoom_Out.ogg")
PlayAmbiental("fx\misc\Zoom_Out.ogg")
EndIf
if _ispressed($escape) then
ResetSounds()
DeMemorySounds()
ResetData()
ShowMenu()
EndIf
if _ispressed($Left) and $HealthRestoring = 0 then WalkLeft()
if _Ispressed($Right) and $HealthRestoring = 0 then WalkRight()
if _ispressed($up) and $HealthRestoring = 0 then WalkUp()
if _ispressed($Down) and $HealthRestoring = 0 then WalkDown()
if _ispressed($a) then
vo("ammo")
if $currweapon = 1 then vo($AmmoGun)
if $currweapon = 2 then vo($AmmoMG)
if $CurrWeapon = 1 then
vo("Shotgun")
if $AmmoGun = 1 then
vo("bullet")
else
vo("Bullets")
EndIf
EndIf
if $CurrWeapon = 2 then
vo("m60")
if $AmmoMG = 1 then
vo("bullet")
else
vo("Bullets")
EndIf
EndIf
EndIf
if _ispressed($h) then
vo($YourHealth)
vo("percent")
vo("health")
EndIf
if _ispressed($g) then
vo($GrenadeCount)
if $grenadecount = 1 then
vo("Grenade")

else
vo("grenades")
EndIf
EndIf
if _ispressed($m) then
if $missionmode = 1 then vo("MissionMode")
if $missionmode = 0 then
if $tutorialMap = 1 then
vo("TutorialMap")
Else
vo("Survivalmap")
vo("with")

if $zombiemode = 1 then vo("zombies")
if $zombiemode = 0 then vo("humans")
EndIf
EndIf
EndIf
if _ispressed($c) then vo($clips)
if _ispressed($z) then vo($HealthRestaurations)
EndFunc
func WalkUp()

if TimerDiff($yourWalktimer[0]) > $YourWalktimer[1] then
$YouMadeNoise += 0.5

if $shootingdirection <> 1 then
$FXPlayer[6] = _SoundPlay("FX\Player\turn.ogg")
PlayAmbiental("FX\Player\turn.ogg")
_setpan($FXPlayer[6], 0)



$ShootingDirection = 1

EndIf
$YourWalkTimer[0] = TimerInit()
$StepBuffer[1] = $StepBuffer[0]
$StepBuffer[0] = Random(0, 5, 1)
while $StepBuffer[0] = $StepBuffer[1]
$StepBuffer[0] = random(0, 5, 1)
WEnd
$StepToPlay = $StepBuffer[0]
$StepBuffer[2] += 1
if $StepBuffer[2] > 2 then $StepBuffer[2] = 1
$FXSteps[$Steptoplay] = _SoundPlay("fx\steps\" & $StepsToLoad & "\" & $StepToPlay+1 & ".ogg", false, true)
PlayAmbiental("fx\steps\" & $StepsToLoad & "\" & $StepToPlay+1 & ".ogg", false, true)
if $StepBuffer[2] = 1 then _setpan($FXsteps[$StepToPlay], -0.05)
if $StepBuffer[2] = 2 then _setpan($FXSteps[$StepToPlay], 0.05)
_AIK_SoundSetIsPaused($FXSteps[$Steptoplay], false)
$Yourpos[1] = $yourpos[1]+1

EndIf
EndFunc
func WalkDown()

if TimerDiff($yourWalktimer[0]) > $YourWalktimer[1] then
$YouMadeNoise += 0.5
if $shootingdirection <> 3 then
$FXPlayer[6] = _SoundPlay("FX\Player\turn.ogg")
PlayAmbiental("FX\Player\turn.ogg")
_setpan($FXPlayer[6], 0)

$ShootingDirection = 3

EndIf
$YourWalkTimer[0] = TimerInit()
$StepBuffer[1] = $StepBuffer[0]
$StepBuffer[0] = Random(0, 5, 1)
while $StepBuffer[0] = $StepBuffer[1]
$StepBuffer[0] = random(0, 5, 1)
WEnd
$StepToPlay = $StepBuffer[0]
$StepBuffer[2] += 1
if $StepBuffer[2] > 2 then $StepBuffer[2] = 1
$FXSteps[$Steptoplay] = _SoundPlay("fx\steps\" & $StepsToLoad & "\" & $StepToPlay+1 & ".ogg", false, true)
PlayAmbiental("fx\steps\" & $StepsToLoad & "\" & $StepToPlay+1 & ".ogg", false, true)
if $StepBuffer[2] = 1 then _setpan($FXsteps[$StepToPlay], -0.05)
if $StepBuffer[2] = 2 then _setpan($FXSteps[$StepToPlay], 0.05)
_AIK_soundSetIsPaused($FXSteps[$Steptoplay], false)

$Yourpos[1] = $yourpos[1]-1

EndIf
EndFunc
func WalkLeft()

if TimerDiff($yourWalktimer[0]) > $YourWalktimer[1] then
$YouMadeNoise += 0.5
if $shootingdirection <> 4 then
$FXPlayer[6] = _SoundPlay("FX\Player\turn.ogg")
PlayAmbiental("FX\Player\turn.ogg")
_setpan($FXPlayer[6], 0.3)

$ShootingDirection = 4
EndIf
$YourWalkTimer[0] = TimerInit()
$StepBuffer[1] = $StepBuffer[0]
$StepBuffer[0] = Random(0, 5, 1)
while $StepBuffer[0] = $StepBuffer[1]
$StepBuffer[0] = random(0, 5, 1)
WEnd
$StepToPlay = $StepBuffer[0]
$StepBuffer[2] += 1
if $StepBuffer[2] > 2 then $StepBuffer[2] = 1
$FXSteps[$Steptoplay] = _SoundPlay("fx\steps\" & $StepsToLoad & "\" & $StepToPlay+1 & ".ogg", false, true)
PlayAmbiental("fx\steps\" & $StepsToLoad & "\" & $StepToPlay+1 & ".ogg", false, true)
if $StepBuffer[2] = 1 then _setpan($FXsteps[$StepToPlay], -0.05)
if $StepBuffer[2] = 2 then _setpan($FXSteps[$StepToPlay], 0.05)
_AIK_soundSetIsPaused($FXSteps[$Steptoplay], false)

$Yourpos[0] = $yourpos[0]-1

EndIf
EndFunc
func WalkRight()

if TimerDiff($yourWalktimer[0]) > $YourWalktimer[1] then
$YouMadeNoise += 0.5
if $shootingdirection <> 2 then
$FXPlayer[6] = _SoundPlay("FX\Player\turn.ogg")
PlayAmbiental("FX\Player\turn.ogg")
_setpan($FXPlayer[6], -0.3)
$ShootingDirection = 2
EndIf
$YourWalkTimer[0] = TimerInit()
$StepBuffer[1] = $StepBuffer[0]
$StepBuffer[0] = Random(0, 5, 1)
while $StepBuffer[0] = $StepBuffer[1]
$StepBuffer[0] = random(0, 5, 1)
WEnd
$StepToPlay = $StepBuffer[0]
$StepBuffer[2] += 1
if $StepBuffer[2] > 2 then $StepBuffer[2] = 1
$FXSteps[$Steptoplay] = _SoundPlay("fx\steps\" & $StepsToLoad & "\" & $StepToPlay+1 & ".ogg", false, true)
PlayAmbiental("fx\steps\" & $StepsToLoad & "\" & $StepToPlay+1 & ".ogg", false, true)
if $StepBuffer[2] = 1 then _setpan($FXsteps[$StepToPlay], -0.05)
if $StepBuffer[2] = 2 then _setpan($FXSteps[$StepToPlay], 0.05)
_AIK_soundSetIsPaused($FXSteps[$Steptoplay], false)

$Yourpos[0] = $yourpos[0]+1

EndIf
EndFunc

func CheckPosition()

if $missionmode = 1 then
if $CurrLevel = 1 then
if $yourpos[0] = $eolp[0][0] and $yourpos[1] = $eolp[0][1] and $HasCode = 1 then

GoToLevel(2)
EndIf
If $yourpos[0] = $CodePos[0] and $yourpos[1] = $CodePos[1] and $hascode = 0 then
$HasCode = 1
$NeedsCode = 0
_Soundstop($CodeSound[0])
$CodeSound[1] = _SoundPlay("FX\Objects\Trigger_pick.ogg")
PlayAmbiental("FX\Objects\Trigger_pick.ogg")
EndIf
EndIf
if $CurrLevel = 2 then
if $yourpos[0] = $eolp[0][0] and $yourpos[1] = $eolp[0][1] then
GoToLevel(3)
EndIf
EndIf
if $CurrLevel = 3 then
if $yourpos[0] = $eolp[0][0] and $yourpos[1] = $eolp[0][1] and $Level3Pass = 1 then
GoToLevel(4)
EndIf
EndIf
if $currlevel = 5 then
if $yourpos[0] = $eolp[0][0] and $yourpos[1] = $eolp[0][1] then
GoToLevel("End")
EndIf
EndIf
EndIf
if $CreatedMG = 1 and $HasMG = 0 and $yourpos[0] = $mgpos[0] and $yourpos[1] = $mgpos[1] then
$HasMG = 1
$MGSound[1] = _SoundPlay("fx\objects\mg_pick.ogg")
PlayAmbiental("fx\objects\mg_pick.ogg")
_Soundstop($MGSound[0])
EndIf
for $iload = 0 to $MaxOBJ
if $ObjectActive[$iload] = 1 then
if $Yourpos[0] = $ObjectPos[$iload][0] and $yourpos[1] = $ObjectPos[$iload][1] then
_Soundstop($ObjectSound[$iload][0])
$ObjectSound[$iload][1] = _SoundPlay("FX\Objects\" & $ObjectName[$iload] & "_pick.ogg")
PlayAmbiental("FX\Objects\" & $ObjectName[$iload] & "_pick.ogg")
$ObjectActive[$iload] = 0
if $objecttype[$iload] = 1 then $healthrestaurations += 1
if $objecttype[$iload] = 2 then $clips += 1
if $objecttype[$iload] = 3 then $clips += 1
if $objecttype[$iload] = 4 then $grenadecount += 1
EndIf
EndIf
Next
if $yourpos[0] < 1 then
$FXPlayer[3] = _SoundPlay("FX\Player\hitwall.ogg")
PlayAmbiental("FX\Player\hitwall.ogg")
$Yourpos[0] = 1
EndIf
if $yourpos[0] > $Max_X then
$FXPlayer[3] = _SoundPlay("FX\Player\hitwall.ogg")
PlayAmbiental("FX\Player\hitwall.ogg")
$Yourpos[0] = $Max_X
EndIf

if $yourpos[1] < 1 then
$FXPlayer[3] = _SoundPlay("FX\Player\hitwall.ogg")
PlayAmbiental("FX\Player\hitwall.ogg")
$Yourpos[1] = 1
EndIf
if $yourpos[1] > $Max_Y then
$FXPlayer[3] = _SoundPlay("FX\Player\hitwall.ogg")
PlayAmbiental("FX\Player\hitwall.ogg")
$Yourpos[1] = $Max_Y
EndIf
For $iload = 0 to $AmbienceSources
if $yourpos[0] = $Ambiencepos[$iload][0] and $yourpos[1] = $ambiencepos[$iload][1] then
$FXPlayer[3] = _SoundPlay("FX\Player\hitwall.ogg")
PlayAmbiental("FX\Player\hitwall.ogg")
if $ambiencepos[$iload][0] > 1 then
$yourpos[0] -= 1
Else
$yourpos[0] += 1
EndIf
If $ambiencepos[$iload][1] > 1 then
$yourpos[1] -= 1
else
$yourpos[1] += 1
EndIf
EndIf
Next
EndFunc
Func PanSounds()

if $MissionMode = 1 then
if $NeedsCode = 1 then generate_pan_2D($YourPos[0], $YourPos[1], $CodePos[0], $codePos[1], $IntPanStep, $IntVolumeStep, $CodeSound[0])
if $CurrLevel = 1 then generate_pan_2D($YourPos[0], $YourPos[1], $eolp[0][0], $eolp[0][1], $IntPanStep, $IntVolumeStep, $FXEOLS[0])
if $CurrLevel = 2 or $Currlevel = 5 then generate_pan_2D($YourPos[0], $YourPos[1], $eolp[0][0], $eolp[0][1], $IntPanStep, $IntVolumeStep, $FXEOLS[1])
if $CurrLevel = 3 then generate_pan_2D($YourPos[0], $YourPos[1], $eolp[0][0], $eolp[0][1], $IntPanStep, $IntVolumeStep, $FXEOLS[2])
EndIf
if $CreateMG = 1 then generate_pan_2D($YourPos[0], $YourPos[1], $mgpos[0], $mgpos[1], $IntPanStep, $IntVolumeStep, $MGSound[0])
if $throwgrenade = 1 then generate_pan_2D($YourPos[0], $YourPos[1], $grenadepos[0], $grenadepos[1], $IntPanStep, $IntVolumeStep, $FXGrenades[4])
for $iload = 0 to $MaxOBJ
if $ObjectActive[$iload] = 1 then
if $objectpos[$iload][0] - $yourpos[0] < 30 and $yourpos[0] - $objectpos[$iload][0] > -30 and $objectpos[$iload][1] - $yourpos[1] < 30 and $yourpos[1] - $objectpos[$iload][1] > -30 then

generate_pan_2D($YourPos[0], $YourPos[1], $ObjectPos[$iload][0], $ObjectPos[$iload][1], $IntPanStep, $IntVolumeStep, $ObjectSound[$ILoad][0])
generate_pan_2D($YourPos[0], $YourPos[1], $ObjectPos[$iload][0], $ObjectPos[$iload][1], $IntPanStep, $IntVolumeStep, $ObjectSound[$ILoad][1])
EndIf
EndIf
Next
for $iload = 1 to $AmbienceSources
generate_pan_2D($YourPos[0], $YourPos[1], $AmbiencePos[$iload][0], $AmbiencePos[$iload][1], $IntPanStep, $IntVolumeStep, $FXAmbience[$ILoad])
Next
EndFunc
func FireGun()

if TimerDiff($ShootingTimer) > 1000 then
if $ammoGun > 0 then
$YouMadeNoise += 5
$ammoGun -= 1
$ShootingTimer = TimerInit()
$RandomBuffer = random(0, 19, 1)
$FXweapons[0] = _SoundPlay("FX\weapons\gun.ogg")
PlayAmbiental("FX\weapons\gun.ogg")
if $ShootingDirection = 1 then CheckNorth()
if $ShootingDirection = 2 then CheckEast()
if $ShootingDirection = 3 then CheckSouth()
if $ShootingDirection = 4 then CheckWest()
else
if not _isplaying("FX\weapons\OOAClick.ogg") then
$FXweapons[5] = _SoundPlay("FX\weapons\OOAClick.ogg")
PlayAmbiental("FX\weapons\OOAClick.ogg")
EndIf
EndIf
EndIf
EndFunc
func FireHand()

if TimerDiff($ShootingTimer) > 1000 then

$YouMadeNoise += 1

$ShootingTimer = TimerInit()
$RandomBuffer = random(0, 19, 1)
$FXWeapons[9] = _SoundPlay("fx\weapons\punch_throw.ogg")
PlayAmbiental("fx\weapons\punch_throw.ogg")
$PunchThrown = 1
$PunchThrownTimer = TimerInit()


EndIf
EndFunc
func FireSniper()


if TimerDiff($ShootingTimer) > 3000 then
$YouMadeNoise += 5

$ShootingTimer = TimerInit()
$RandomBuffer = random(0, 19, 1)
$FXWeapons[8] = _SoundPlay("fx\weapons\Sniper.ogg")
PlayAmbiental("fx\weapons\Sniper.ogg")
if $ShootingDirection = 1 then CheckNorthSniper()
if $ShootingDirection = 2 then CheckEastSniper()
if $ShootingDirection = 3 then CheckSouthSniper()
if $ShootingDirection = 4 then CheckWestSniper()



EndIf
EndFunc
func FireMG()

if TimerDiff($ShootingTimer) > 100 then

if $AmmoMG > 0 then
$YouMadeNoise += 5
$ammoMG -= 1
$ShootingTimer = TimerInit()
$RandomBuffer = random(0, 19, 1)
$FXweapons[1] = _SoundPlay("FX\weapons\mg.ogg")
PlayAmbiental("FX\weapons\mg.ogg")
if $ShootingDirection = 1 then CheckNorth()
if $ShootingDirection = 2 then CheckEast()
if $ShootingDirection = 3 then CheckSouth()
if $ShootingDirection = 4 then CheckWest()
else
if not _isplaying("FX\weapons\OOAClick.ogg") then
$FXweapons[5] = _SoundPlay("FX\weapons\OOAClick.ogg")
PlayAmbiental("FX\weapons\OOAClick.ogg")
EndIf
EndIf
EndIf
EndFunc
func checkNorth()

for $ISecond = 0 to 10
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][0] = $yourpos[0] then
if $enemypos[$iload][1] = $yourpos[1]+$isecond then
if $CurrWeapon = 1 then EnemyHit($iload, 70)
if $CurrWeapon = 2 then EnemyHit($iload)
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndFunc
func checkSouth()

for $ISecond = 0 to 10 step 1
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][0] = $yourpos[0] then
if $enemypos[$iload][1] = $yourpos[1]-$isecond then
if $CurrWeapon = 1 then EnemyHit($iload, 70)
if $CurrWeapon = 2 then EnemyHit($iload)
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndFunc

func checkWest()

for $ISecond = 0 to 10
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][1] = $yourpos[1] then
if $enemypos[$iload][0] = $yourpos[0]-$isecond then
if $CurrWeapon = 1 then EnemyHit($iload, 70)
if $CurrWeapon = 2 then EnemyHit($iload)
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndFunc
func checkEast()

for $ISecond = 0 to 10 step 1
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][1] = $yourpos[1] then
if $enemypos[$iload][0] = $yourpos[0]+$isecond then
if $CurrWeapon = 1 then EnemyHit($iload, 70)
if $CurrWeapon = 2 then EnemyHit($iload)
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndFunc

func checkNorthPunch()

for $ISecond = 0 to 2
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][0] = $yourpos[0] then
if $enemypos[$iload][1] = $yourpos[1]+$isecond then
$FXWeapons[10] = _SoundPlay("fx\weapons\punch_impact.ogg")
PlayAmbiental("fx\weapons\punch_impact.ogg")
EnemyHit($iload, 50)
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndFunc
func checkSouthPunch()

for $ISecond = 0 to 2 step 1
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][0] = $yourpos[0] then
if $enemypos[$iload][1] = $yourpos[1]-$isecond then
$FXWeapons[10] = _SoundPlay("fx\weapons\punch_impact.ogg")
PlayAmbiental("fx\weapons\punch_impact.ogg")
EnemyHit($iload, 50)
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndFunc

func checkWestPunch()

for $ISecond = 0 to 2
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][1] = $yourpos[1] then
if $enemypos[$iload][0] = $yourpos[0]-$isecond then
$FXWeapons[10] = _SoundPlay("fx\weapons\punch_impact.ogg")
PlayAmbiental("fx\weapons\punch_impact.ogg")
EnemyHit($iload, 50)
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndFunc
func checkEastPunch()

for $ISecond = 0 to 2 step 1
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][1] = $yourpos[1] then
if $enemypos[$iload][0] = $yourpos[0]+$isecond then
$FXWeapons[10] = _SoundPlay("fx\weapons\punch_impact.ogg")
PlayAmbiental("fx\weapons\punch_impact.ogg")
EnemyHit($iload, 50)
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndFunc


func checkNorthSniper()

for $ISecond = 0 to 100
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][0] = $yourpos[0] then
if $enemypos[$iload][1] = $yourpos[1]+$isecond then
EnemyHit($iload, 1000)
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndFunc
func checkSouthSniper()

for $ISecond = 0 to 100 step 1
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][0] = $yourpos[0] then
if $enemypos[$iload][1] = $yourpos[1]-$isecond then
EnemyHit($iload, 1000)
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndFunc

func checkWestSniper()

for $ISecond = 0 to 100
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][1] = $yourpos[1] then
if $enemypos[$iload][0] = $yourpos[0]-$isecond then
EnemyHit($iload, 1000)
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndFunc
func checkEastSniper()

for $ISecond = 0 to 100 step 1
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][1] = $yourpos[1] then
if $enemypos[$iload][0] = $yourpos[0]+$isecond then
EnemyHit($iload, 1000)
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndFunc
func EnemyHit($OBJNum, $amount = 20)

if $enemyactive[$objnum] = 0 then return

$enemyhealth[$objnum] -= $amount
if $enemyhealth[$objnum] > 0 then
if $enemypos[$objnum][0] - $yourpos[0] < 35 and $yourpos[0] - $enemypos[$objnum][0] > -35 and $enemypos[$objnum][1] - $yourpos[1] < 35 and $yourpos[1] - $enemypos[$objnum][1] > -35 then
PlaySoundPositioned("FX\AI\" & $Enemytype[$objnum] & "\hit.ogg", $Enemypos[$objnum][0], $Enemypos[$objnum][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\AI\" & $Enemytype[$objnum] & "\hit.ogg", $Enemypos[$objnum][0], $Enemypos[$objnum][1], $IntPanStep, $IntVolumeStep, False)
EndIf
if $enemyalert[$objnum] = 0 then
$EnemyAlert[$objnum] = 1
if $enemypos[$objnum][0] - $yourpos[0] < 35 and $yourpos[0] - $enemypos[$objnum][0] > -35 and $enemypos[$objnum][1] - $yourpos[1] < 35 and $yourpos[1] - $enemypos[$objnum][1] > -35 then
PlaySoundPositioned("FX\AI\" & $Enemytype[$objnum] & "\notice.ogg", $Enemypos[$objnum][0], $Enemypos[$objnum][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\AI\" & $Enemytype[$objnum] & "\notice.ogg", $Enemypos[$objnum][0], $Enemypos[$objnum][1], $IntPanStep, $IntVolumeStep, False)
EndIf
EndIf
EndIf
if $enemyhealth[$objnum] < 1 then
if $enemypos[$objnum][0] - $yourpos[0] < 35 and $yourpos[0] - $enemypos[$objnum][0] > -35 and $enemypos[$objnum][1] - $yourpos[1] < 35 and $yourpos[1] - $enemypos[$objnum][1] > -35 then
PlaySoundPositioned("FX\AI\" & $Enemytype[$objnum] & "\die.ogg", $Enemypos[$objnum][0], $Enemypos[$objnum][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\AI\" & $Enemytype[$objnum] & "\die.ogg", $Enemypos[$objnum][0], $Enemypos[$objnum][1], $IntPanStep, $IntVolumeStep, False)
EndIf
if $enemypos[$objnum][0] - $yourpos[0] < 35 and $yourpos[0] - $enemypos[$objnum][0] > -35 and $enemypos[$objnum][1] - $yourpos[1] < 35 and $yourpos[1] - $enemypos[$objnum][1] > -35 then
PlaySoundPositioned("FX\AI\" & $Enemytype[$objnum] & "\fall" & random(1, 5, 1) & ".ogg", $Enemypos[$objnum][0], $Enemypos[$objnum][1], $IntPanStep, $IntVolumeStep, False)
PlayAmbientalPositioned("FX\AI\" & $Enemytype[$objnum] & "\fall" & random(1, 5, 1) & ".ogg", $Enemypos[$objnum][0], $Enemypos[$objnum][1], $IntPanStep, $IntVolumeStep, False)
EndIf
$Kills += 1
$enemyactive[$objnum] = 0
$EnemyRespawnTimer[$objnum] = TimerInit()
EndIf
EndFunc

func PlayerHurt($amount = 20)

$yourhealth -= $amount
if $yourhealth > 0 then $FXPlayer[2] = _SoundPlay("FX\Player\hit.ogg")
if $yourhealth < 1 then
$FXPlayer[1] = _SoundPlay("FX\player\die.ogg")
PlayAmbiental("FX\player\die.ogg")
while _isplaying("FX\player\die.ogg")
sleep(1)
WEnd
ResetSounds()
ResetData()
if $GameMode = 1 then
$GameTimer = TimerInit()
GoToLevel(1)

EndIf
if $GameMode = 2 then
GoToLevel("Survival1")
EndIf
If $GameMode = 3 then GoToLevel("Tut1")
EndIf
#CE
EndFunc
func DeMemorySounds()
;_SoundDrop($FXEOLS[0])
;_SoundDrop($FXEOLS[1])
for $iload = 0 to 4
;_SoundDrop($FXExplosions[$iload])
Next

;_SoundDrop($FXGrenades[0])
;_SoundDrop($FXGrenades[1])
;_SoundDrop($FXGrenades[2])
;_SoundDrop($FXGrenades[3])
;_SoundDrop($FXGrenades[4])
;_SoundDrop($FXGrenades[5])
;_SoundDrop($FXmisc[0])
;_SoundDrop($FXmisc[1])
;_SoundDrop($FXmisc[2])

;_SoundDrop($FXPlayer[0])
;_SoundDrop($FXPlayer[1])
;_SoundDrop($FXPlayer[2])
;_SoundDrop($FXPlayer[3])
;_SoundDrop($FXPlayer[4])
;_SoundDrop($FXPlayer[5])
;_SoundDrop($FXPlayer[6])
;_SoundDrop($FXweapons[0])
;_SoundDrop($FXweapons[1])
;_SoundDrop($FXweapons[2])
;;_SoundDrop($FXweapons[3])
;_SoundDrop($FXweapons[4])
EndFunc
func ResetSounds()
_AIK_EngineStopAllSounds()
#CS
if $SoundsLoaded = 1 then
$SoundsLoaded = 0
_SoundDrop($FXmusic)
_SoundDrop($CodeSound[0])

_SoundDrop($MGSound[0])
_SoundDrop($MGSound[1])





for $iload = 0 to $MaxEnem
for $isecond = 0 to 11
_SoundDrop($EnemyFX[$iload][$isecond])
Next
Next
for $iload = 0 to $maxobj

_SoundDrop($ObjectSound[$iload][0])
_SoundDrop($ObjectSound[$iload][1])
Next

_SoundDrop($MGSound[0])
_SoundDrop($MGSound[1])
EndIf
#CE
EndFunc
func ResetData()
$Level3ChangeMusic = 0
$Level3Pass = 0
$WalkingSpeed = 0
$SpeedChanging = 0
$IntPanStep = -0.015
$IntVolumeStep = 0.05
$SpeedChanging = TimerInit()

$TutorialMap = 0
$Reloading = 0
$Reloadingtimer = TimerInit()
$MusicVolume = IniRead("Set.dat", "Settings", "MusicVolume", "0")



$HasCode = 0
$NeedsCode = 1
$codepos[0] = 1

$codesound[0] = 0
$codesound[1] = 0

$CurrWeapon = 1
$HasGun = 1
$AmmoGun = 100
$AmmoMG = 100
$Clips = 1
$HasMG = 0
$Grenadecount = 5
$CreateMG = 1
$CreatedMG = 0
$mgpos[0] = 1
$mgpos[1] = 1
$mgsound[0] = 0
$mgsound[1] = 0
$AmbienceToLoad = "level1"
$StepsToLoad = 0
$AmbienceSources = 6
$ShootingDirection = 1
$GrenadeDirection = 1

$Max_X = 50
$MAX_Y = 50
$MaxEnem = 1
$MaxOBJ = 10
$GunSwitchTimer = TimerInit()

$YouDuck = 0
$stepbuffer[0] = 0
$stepbuffer[1] = 0
$stepbuffer[2] = 0
$yourpos[0] = 0
$yourpos[1] = 0
$SavedPosition = 1
$HealthRestaurations = 1
$HealthRestoring = 0
$HealthRestoringtimer = timerInit()

$LookingThrough = 0
$YourHealth = 100

$Objects = 0
$shooting = 0
$ShootingTimer = 0
$throwgrenade = 0
$ThrowGrenadeTimer = 0
$ThrewGrenade = 0
$grenadepos[0] = 0
$grenadepos[1] = 0

$LevelTimer = 0
$TimeForLevel = 180000
$BatteryPower = 0
$YouMadeNoise = 0
$YouMadeNoiseTimer = 0
$YouMadeNoiseTimerRunning = 0

EndFunc
Func LoadMap($MapID)
if $MapID = "Survival1" then
$CurrLevelRS = -2000

$yourpos[0] = 1
$yourpos[1] = 1
$CurrLevel = "Survival1"
$CreateMG = 1
$AmbienceToLoad = "Survival1"
$StepsToLoad = "S1"
$AmbienceSources = 4
$Max_X = 100
$MAX_Y = 100
$MaxEnem = 20
$MaxOBJ = 20
$eolp[0][0] = 25
$eolp[0][1] = $Max_Y

EndIf

if $MapID = "Tut1" then
$CurrLevelRS = -1000
$yourpos[0] = 1
$yourpos[1] = 1
$CurrLevel = "Tut1"
$CreateMG = 0
$AmbienceToLoad = "Tut1"
$StepsToLoad = "T1"
$AmbienceSources = 3
$Max_X = 40
$MAX_Y = 60
$MaxEnem = 0.5
$MaxOBJ = 5
$eolp[0][0] = 25
$eolp[0][1] = $Max_Y
EndIf


if $MapID = 1 then
$CurrLevelRS = -7000
if $needscode = 1 then
$codepos[0] = random(20, $Max_X, 1)
$codePos[1] = random(20, $Max_Y, 1)
$CodeSound[0] = _SoundPlay("FX\objects\Trigger.ogg", true, true)
_setvolume($CodeSound[0], 0)



$HasCode = 0
EndIf
$yourpos[0] = 1
$yourpos[1] = 1
$CurrLevel = 1
$CreateMG = 1
$AmbienceToLoad = "Level1"
$StepsToLoad = 0
$AmbienceSources = 6
$Max_X = 50
$MAX_Y = 50
$MaxEnem = 2
$MaxOBJ = 5
$eolp[0][0] = 25
$eolp[0][1] = $Max_Y
ElseIf $MapID = 2 then
$CurrLevelRS = -3000
$CurrLevel = 2
$CreateMG = 0
$AmbienceToLoad = "Level2"
$StepsToLoad = 1
$AmbienceSources = 4
$Max_X = 5
$MAX_Y = 200
$MaxEnem = 15
$MaxOBJ = 50
$eolp[0][0] = 3
$eolp[0][1] = $Max_Y
ElseIf $MapID = 3 then
$CurrLevelRS = -6000
$Level3Pass = 0
$Level3ChangeMusic = 0
$CurrLevel = 3
$CreateMG = 0
$AmbienceToLoad = "Level3"
$StepsToLoad = 2
$AmbienceSources = 6
$Max_X = 200
$MAX_Y = 200
$MaxEnem = 20
$MaxOBJ = 10
$eolp[0][0] = 20
$eolp[0][1] = $Max_Y
$LevelTimer = TimerInit()

ElseIf $MapID = 4 then
$CurrLevelRS = -9000
$CurrLevel = 4
$CreateMG = 0
$AmbienceToLoad = "Level4"
$StepsToLoad = 3
$AmbienceSources = 0
$Max_X = 20
$MAX_Y = 20
$MaxEnem = 0
$MaxOBJ = 0
$eolp[0][0] = 2
$eolp[0][1] = $Max_Y



ElseIf $MapID = 5 then
$CurrLevelRS = -1000
$CurrLevel = 5
$CreateMG = 0
$AmbienceToLoad = "Level5"
$StepsToLoad = 4
$AmbienceSources = 3
$Max_X = 5
$MAX_Y = 400
$MaxEnem = 25
$MaxOBJ = 15
$eolp[0][0] = 2
$eolp[0][1] = $Max_Y


EndIf

GenerateLevel()
EndFunc
func GoToLevel($LevelNR)
ResetSounds()
_AIK_EngineStopallSounds()
if $levelnr = "End" then
FileInstall("cheats.txt", @scriptdir & "\cheats.txt")
$FXIntro = _SoundPlay("fx\cutscenes\scene6.ogg")
while _isplaying("fx\cutscenes\scene6.ogg")
if _ispressed($Spacebar) then _fade($FXIntro)
WEnd
;_SoundDrop($FXMusic)
ResetData()
ShowMenu()
EndIf
if $LevelNR = 1 then
$yourpos[0] = 1
$yourpos[1] = 1
$FXIntro = _SoundPlay("fx\cutscenes\scene1.ogg")

while _isplaying("fx\cutscenes\scene1.ogg")
if _ispressed($Spacebar) then _fade($FXIntro)
WEnd
;_SoundDrop($FXIntro)
;_SoundDrop($FXMusic)
$FXMusic = _SoundPlay("FX\Music\Game1.ogg", true, true)
$MusicVolume = IniRead("Set.dat", "Settings", "MusicVolume", "0")
_setvolume($FXMusic, $MusicVolume)

LoadMap(1)
Main()
EndIf
if $LevelNR = 2 then

$FXIntro = _SoundPlay("fx\cutscenes\scene2.ogg")

while _isplaying("fx\cutscenes\scene2.ogg")
if _ispressed($Spacebar) then _fade($FXIntro)
WEnd
;_SoundDrop($FXIntro)
;_SoundDrop($FXMusic)
$FXMusic = _SoundPlay("FX\Music\Game2.ogg", true, true)
$MusicVolume = IniRead("Set.dat", "Settings", "MusicVolume", "0")
_setvolume($FXMusic, $MusicVolume)

$FXmisc[0] = _SoundPlay("fx\misc\alarm.ogg")
LoadMap(2)

Main()
EndIf
if $LevelNR = 3 then
$yourpos[0] = 1
$yourpos[1] = 1
_SoundStop($FXMisc[0])
$FXIntro = _SoundPlay("fx\cutscenes\scene3.ogg")
while _isplaying("fx\cutscenes\scene3.ogg")
if _ispressed($Spacebar) then _fade($FXIntro)
WEnd
;_SoundDrop($FXIntro)
;_SoundDrop($FXMusic)
$FXMusic = _SoundPlay("FX\Music\Game3_1.ogg", true, true)
$MusicVolume = IniRead("Set.dat", "Settings", "MusicVolume", "0")
_setvolume($FXMusic, $MusicVolume)


LoadMap(3)
Main()
EndIf
if $LevelNR = 4 then
$yourpos[0] = 1
$yourpos[1] = 1
$FXIntro = _SoundPlay("fx\cutscenes\scene4.ogg")
while _isplaying("fx\cutscenes\scene4.ogg")
if _ispressed($Spacebar) then _fade($FXIntro)
WEnd
;_SoundDrop($FXIntro)
;_SoundDrop($FXMusic)
$FXMusic = _SoundPlay("FX\Music\Game4.ogg", true, true)
$MusicVolume = IniRead("Set.dat", "Settings", "MusicVolume", "0")
_setvolume($FXMusic, $MusicVolume)


LoadMap(4)
Main()
EndIf
if $levelnr = 5 then
$yourpos[0] = 1
$yourpos[1] = 1

$FXIntro = _SoundPlay("fx\cutscenes\scene5.ogg")
while _isplaying("fx\cutscenes\scene5.ogg")
if _ispressed($Spacebar) then _fade($FXIntro)
WEnd
;_SoundDrop($FXIntro)
;_SoundDrop($FXMusic)
$FXMusic = _SoundPlay("FX\Music\Game5.ogg", true, true)
$MusicVolume = IniRead("Set.dat", "Settings", "MusicVolume", "0")
_setvolume($FXMusic, $MusicVolume)


LoadMap(5)
Main()
EndIf
if $LevelNR = "Survival1" then







;_SoundDrop($FXMusic)
$FXMusic = _SoundPlay("FX\Music\Survival.ogg", true, true)
$MusicVolume = IniRead("Set.dat", "Settings", "MusicVolume", "0")
_setvolume($FXMusic, $MusicVolume)

LoadMap("Survival1")
Main()
EndIf
if $LevelNR = "Tut1" then
$FXIntro = _SoundPlay("FX\Cutscenes\TutorialScene.ogg")
while _isplaying("FX\Cutscenes\TutorialScene.ogg")
if _ispressed($SpaceBar) then _fade($FXIntro)
WEnd
;_SoundDrop($FXIntro)






;_SoundDrop($FXMusic)
$FXMusic = _SoundPlay("FX\Music\Tutorial.ogg", true, true)
$MusicVolume = IniRead("Set.dat", "Settings", "MusicVolume", "0")
_setvolume($FXMusic, $MusicVolume)

LoadMap("Tut1")
Main()
EndIf
EndFunc
func Status()
for $iload = 0 to $MaxEnem
msgbox(64, "", $EnemyAlert[$iload])
Next
EndFunc
func CheckRange()
if $ShootingDirection = 1 then
for $ISecond = 0 to 10
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][0] = $yourpos[0] then
if $enemypos[$iload][1] = $yourpos[1]+$isecond then
_SoundPlay("FX\weapons\Range.ogg")
ExitLoop
EndIf
EndIf
EndIf

Next
for $iload = 0 to $MaxObj
if $ObjectActive[$iload] = 1 then
if $Objectpos[$iload][0] = $yourpos[0] then
if $ObjectPos[$iload][1] = $yourpos[1]+$isecond then
_SoundPlay("FX\weapons\RangeOBJ.ogg")
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndIf
if $ShootingDirection = 3 then
for $ISecond = 0 to 10 step 1
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][0] = $yourpos[0] then
if $enemypos[$iload][1] = $yourpos[1]-$isecond then
_SoundPlay("FX\weapons\Range.ogg")
ExitLoop
EndIf
EndIf
EndIf
Next
for $iload = 0 to $MaxObj
if $ObjectActive[$iload] = 1 then
if $Objectpos[$iload][0] = $yourpos[0] then
if $ObjectPos[$iload][1] = $yourpos[1]-$isecond then
_SoundPlay("FX\weapons\RangeOBJ.ogg")
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndIf
if $ShootingDirection = 4 then
for $ISecond = 0 to 10
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][1] = $yourpos[1] then
if $enemypos[$iload][0] = $yourpos[0]-$isecond then
_SoundPlay("FX\weapons\Range.ogg")
ExitLoop
EndIf
EndIf
EndIf
Next
for $iload = 0 to $MaxOBJ
if $ObjectActive[$iload] = 1 then
if $Objectpos[$iload][1] = $yourpos[1] then
if $Objectpos[$iload][0] = $yourpos[0]-$isecond then
_SoundPlay("FX\weapons\RangeOBJ.ogg")
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndIf
If $ShootingDirection = 2 then
for $ISecond = 0 to 10 step 1
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][1] = $yourpos[1] then
if $enemypos[$iload][0] = $yourpos[0]+$isecond then
_SoundPlay("FX\weapons\Range.ogg")
ExitLoop
EndIf
EndIf
EndIf
Next
for $iload = 0 to $MaxOBJ
if $ObjectActive[$iload] = 1 then
if $Objectpos[$iload][1] = $yourpos[1] then
if $Objectpos[$iload][0] = $yourpos[0]+$isecond then
_SoundPlay("FX\weapons\RangeOBJ.ogg")
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndIf
EndFunc
func CheckRangeSniper()
if $ShootingDirection = 1 then
for $ISecond = 0 to 100
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][0] = $yourpos[0] then
if $enemypos[$iload][1] = $yourpos[1]+$isecond then
_SoundPlay("FX\weapons\Range.ogg")
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndIf
if $ShootingDirection = 3 then
for $ISecond = 0 to 100 step 1
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][0] = $yourpos[0] then
if $enemypos[$iload][1] = $yourpos[1]-$isecond then
_SoundPlay("FX\weapons\Range.ogg")
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndIf
if $ShootingDirection = 4 then
for $ISecond = 0 to 100
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][1] = $yourpos[1] then
if $enemypos[$iload][0] = $yourpos[0]-$isecond then
_SoundPlay("FX\weapons\Range.ogg")
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndIf
If $ShootingDirection = 2 then
for $ISecond = 0 to 100 step 1
for $iload = 0 to $MaxEnem
if $EnemyActive[$iload] = 1 then
if $enemypos[$iload][1] = $yourpos[1] then
if $enemypos[$iload][0] = $yourpos[0]+$isecond then
_SoundPlay("FX\weapons\Range.ogg")
ExitLoop
EndIf
EndIf
EndIf
Next
Next
EndIf
EndFunc
func PlaySoundPositioned($SoundHandle, $EnX, $EnY, $PanStep, $VolStep, $LoopVar = False)
$ToReturn = _AIK_EnginePlay2DName($SoundHandle, $LoopVar, true)
generate_pan_2D($YourPos[0], $YourPos[1], $EnX, $EnY, $IntPanStep, $IntVolumeStep, $ToReturn)
_AIK_SoundSetIsPaused($ToReturn,False)
;msgbox(64, "", $SoundHandle & "||" & $EnX & "||" & $EnY & "||" & $PanStep & "||" & $VolStep & "||" & $LoopVar)
return $ToReturn
EndFunc
func playAmbientalPositioned($File, $MX, $MY, $VolStep, $PanStep, $Looped = false)

if $CurrLevel = 1 or $CurrLevel = 2 or $CurrLevel = 3 or $CurrLevel = 4 or $CurrLevel = 5 then _SoundPlay3DReverbPositioned($File, $OneVar, $TwoVar, $ThreeVar, $CurrLevelRS, 1, $Yourpos[0], $YourPos[1], $MX, $MY, $IntVolumeStep-0.003, $Looped)
if $CurrLevel = "Tut1" then _SoundPlay3DReverbPositioned($File, $OneVar, $TwoVar, $ThreeVar, $CurrLevelRS, 0.5, $Yourpos[0], $YourPos[1], $MX, $MY, $IntVolumeStep-0.003, $Looped)
if $CurrLevel = "Survival1" then _SoundPlay3dReverbPositioned($File, $OneVar, $TwoVar, $ThreeVar, $CurrLevelRS, 0.5, $Yourpos[0], $YourPos[1], $MX, $MY, $IntVolumeStep-0.003, $Looped)
EndFunc
func playAmbiental($File, $Looped = false, $SomethingElse = false)

if $CurrLevel = 1 or $CurrLevel = 2 or $CurrLevel = 3 or $CurrLevel = 4 or $CurrLevel = 5 then _SoundPlay3DReverb($File, $OneVar, $TwoVar, $ThreeVar, $CurrLevelRS,1,$Looped)
if $CurrLevel = "Tut1" then _SoundPlay3DReverb($File, $OneVar, $TwoVar, $ThreeVar, $CurrLevelRS,0.5,$Looped)
if $CurrLevel = "Survival1" then _SoundPlay3DReverb($File, $OneVar, $TwoVar, $ThreeVar, $CurrLevelRS,0.5,$Looped)
EndFunc