$CurrPlayingOption = 0
$CurrPlayingOptionFX = 0
$SelectedSound = ""
$ISecond = 0
dim $OptionListSound[50]
$MenuOptionSound = ""

#include-once
func CreateMenu($Menu_Desc, $Menu_Options)
$KeyMovement = 0
_AIK_EnginePlay2DName("fx\menu\appear.ogg")
$OptionList = Stringsplit($Menu_Options, "|")
$ToSet = $OptionList[0]


$MenuDesc = _AIK_EnginePlay2DName("fx\speech\" & $Menu_Desc & ".ogg")

$SelectedOption = 0
sleep(500)
while 1
If WinGetProcess("") = @AutoItPid Then
if _ispressed($page_down) then
_AIK_SoundSetVolume($FXMusic, _AIK_SoundGetVolume($FXMusic)-0.003)
IniWrite("set.dat", "settings", "MusicVolume", _AIK_SoundGetVolume($FXMusic))
EndIf
if _ispressed($page_up) then
_AIK_SoundSetVolume($FXMusic, _AIK_SoundGetVolume($FXMusic)+0.003)
IniWrite("set.dat", "settings", "MusicVolume", _AIK_SoundGetVolume($FXMusic))
EndIf
if _ispressed($down) and $KeyMovement = 0 then
_AIK_SoundStop($MenuDesc)

$KeyMovement = 1
_AIK_EnginePlay2DName("fx\menu\select.ogg")
$SelectedOption = $SelectedOption+1
if $SelectedOption > $OptionList[0] then 
_AIK_EnginePlay2DName("fx\menu\boundary.ogg")
$SelectedOption = $Optionlist[0]
EndIf

_AIK_SoundStop($CurrPlayingOption)
_AIK_SoundDrop($CurrPlayingOption)
$CurrPlayingOption = _AIK_EnginePlay2DName("FX\Speech\" & $OptionList[$selectedOption] & ".ogg")



EndIf
if _ispressed($up) and $KeyMovement = 0 then
_AIK_SoundStop($MenuDesc)
$KeyMovement = 1
_AIK_EnginePlay2DName("fx\menu\select.ogg")
$SelectedOption = $SelectedOption-1
if $SelectedOption < 1 then 
_AIK_EnginePlay2DName("fx\menu\boundary.ogg")
$SelectedOption = 1
EndIf

_AIK_SoundStop($CurrPlayingOption)
_AIK_SoundDrop($CurrPlayingOption)
$CurrPlayingOption = _AIK_EnginePlay2DName("FX\Speech\" & $OptionList[$selectedOption] & ".ogg")


_AIK_EffectEnableI3DL2Reverb($CurrPlayingOptionFX)
EndIf
if not _ispressed($Up) and not _ispressed($down) and $KeyMovement = 1 then $KeyMovement = 0
if _ispressed($escape) then

_AIK_EnginePlay2DName("FX\Menu\Back.ogg")

sleep(500)
Return -1

ExitLoop
EndIf
if _ispressed($Enter) then
if $SelectedOption > 0 then

_AIK_EnginePlay2DName("fx\menu\val.ogg")

sleep(400)
Return $SelectedOption


ExitLoop
EndIf
EndIf
if _ispressed($spacebar) then
_AIK_EnginePlay2DName("FX\Speech\" & $OptionList[$selectedOption] & ".ogg")
sleep(250)
EndIf
EndIf
Sleep(2)
WEnd
EndFunc