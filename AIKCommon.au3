func _SoundPlay($File, $LoopSound=false, $StartPaused = false)
return _AIK_EnginePlay2DName($File, $LoopSound, $StartPaused)
EndFunc
func _SoundPlay3DReverb($File, $VarOne, $VarTwo, $VarThree, $RoomSize = 1000, $Volume = 1, $LoopSound=false, $StartPaused = false)
$TempSound = _AIK_EnginePlay2DName($File, $LoopSound, true)
_AIK_EffectEnableI3DL2Reverb($TempSound, $VarOne, $VarTwo, $VarThree, $RoomSize)
_SetVolume($TempSound, $Volume)
_AIK_SoundSetIsPaused($TempSound, False)
EndFunc
func _SoundPlayWavesReverb($File, $RoomSize = 0, $LoopSound=false, $StartPaused = false)
$TempSound = _AIK_EnginePlay2DName($File, $LoopSound, true)
_AIK_EffectEnableWavesReverb($TempSound, $RoomSize)
_AIK_SoundSetIsPaused($TempSound, False)
EndFunc
func _SoundPlayEcho($File, $RoomSize = 1000, $LoopSound=false, $StartPaused = false)
$TempSound = _AIK_EnginePlay2DName($File, $LoopSound, true)
_AIK_EffectEnableEcho($TempSound, 15, 50, 100, 120, 1)
_AIK_SoundSetIsPaused($TempSound, False)
EndFunc

func _SoundPlay3DReverbPositioned($File, $VarOne, $VarTwo, $VarThree, $RoomSize, $Volume, $YX, $YY, $NX, $NY, $VolStep, $LoopSound=false)
$TempSound = _AIK_EnginePlay2DName($File, $LoopSound, true)
_AIK_EffectEnableI3DL2Reverb($TempSound, $VarOne, $VarTwo, $VarThree, $RoomSize)

generate_pan_2D($YX, $YY, $NX, $NY, 0, $VolStep, $TempSound, $Volume)
_AIK_SoundSetIsPaused($TempSound, False)
EndFunc
func _SoundPlayWavesReverbPositioned($File, $RoomSize, $YX, $YY, $NX, $NY, $VolStep, $LoopSound=false, $StartPaused = false)
$TempSound = _AIK_EnginePlay2DName($File, $LoopSound, true)
_AIK_EffectEnableWavesReverb($TempSound, $RoomSize)
generate_pan_2D($YX, $YY, $NX, $NY, 0, $VolStep, $TempSound)
_AIK_SoundSetIsPaused($TempSound, False)
EndFunc
func _SoundPlayEchoPositioned($File, $RoomSize, $YX, $YY, $NX, $NY, $VolStep, $LoopSound=false, $StartPaused = false)
$TempSound = _AIK_EnginePlay2DName($File, $LoopSound, true)
_AIK_EffectEnableEcho($TempSound, 15, 50, 100, 120, 1)
generate_pan_2D($YX, $YY, $NX, $NY, 0, $VolStep, $TempSound)
_AIK_SoundSetIsPaused($TempSound, False)
EndFunc
func _SoundStop($File)
return _AIK_SoundStop($File)
EndFunc
func _SoundDrop($File)
return _AIK_SoundDrop($File)
EndFunc
func _IsPlaying($File)
Return _AIK_EngineIsCurrentlyPlayingName($File)
EndFunc
func _SetVolume($File, $value)
if $Value <=1 and $value >= 0 then
return _AIK_SoundSetVolume($File, $Value)
EndIf
EndFunc
func _SoundGetVolume($File)
return _AIK_SoundGetVolume($File)
EndFunc

func _SetPan($File, $value)
return _AIK_SoundSetPan($File, $Value)
EndFunc
func _SoundGetPan($File)
return _AIK_SoundGetPan($File)
EndFunc
func _Fade($File)
for $iFade = _AIK_SoundGetVolume($File) to 0 step -0.01
_AIK_SoundSetVolume($File, $iFade)
sleep(20)
Next
_AIK_SoundStop($File)
EndFunc