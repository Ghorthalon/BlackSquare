#include-once

; #INDEX# =======================================================================================================================
; Title .........: AIK v1.0
; AutoIt Version : v3.3.6.1
; Language ......: English
; Description ...: Wrapper for irrKlang sound engine.
; Author(s) .....: Smashly
; Dll(s) ........: AIK.dll, IrrKlang.dll, ikpFlac.dll, ikpMP3.dll
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
; E_SOUND_ENGINE_OPTIONS
Global Enum Step *2 $ESEO_MULTI_THREADED = 0x01, _
			$ESEO_MUTE_IF_NOT_FOCUSED, _
			$ESEO_LOAD_PLUGINS, _
			$ESEO_USE_3D_BUFFERS, _
			$ESEO_PRINT_DEBUG_INFO_TO_DEBUGGER, _
			$ESEO_PRINT_DEBUG_INFO_TO_STDOUT, _
			$ESEO_LINEAR_ROLLOFF, _
            $ESEO_DEFAULT_OPTIONS = BitOr($ESEO_MULTI_THREADED, _
										$ESEO_LOAD_PLUGINS, _
										$ESEO_USE_3D_BUFFERS, _;$ESEO_PRINT_DEBUG_INFO_TO_DEBUGGER, _
										$ESEO_PRINT_DEBUG_INFO_TO_STDOUT), _
			$ESEO_FORCE_32_BIT = 0x7fffffff

; E_SOUND_OUTPUT_DRIVER
Global Enum $ESOD_AUTO_DETECT = 0, _
			$ESOD_DIRECT_SOUND_8, _
			$ESOD_DIRECT_SOUND, _
			$ESOD_WIN_MM, _
			$ESOD_ALSA, _
			$ESOD_CORE_AUDIO, _
			$ESOD_NULL, $ESOD_COUNT, _
			$ESOD_FORCE_32_BIT = 0x7fffffff

; E_STREAM_MODE
Global Enum $ESM_AUTO_DETECT  = 0, _
			$ESM_STREAMING, _
			$ESM_NO_STREAMING, _
			$ESM_FORCE_32_BIT = 0x7fffffff

; E_STOP_EVENT_CAUSE
Global Enum $ESEC_SOUND_FINISHED_PLAYING  = 0, _
			$ESEC_SOUND_STOPPED_BY_USER, _
			$ESEC_SOUND_STOPPED_BY_SOURCE_REMOVAL, _
			$ESEC_FORCE_32_BIT = 0x7fffffff

; ESampleFormat
Global Enum $ESF_U8, $ESF_S16
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $_AIKDll = -1
; ===============================================================================================================================

; #INTERNAL_FUNCTION# ===========================================================================================================
;__Init_IrrKlangDll($sDllPath)
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_AIK_EffectDisableAllEffects
;_AIK_EffectDisableChorus
;_AIK_EffectDisableCompressor
;_AIK_EffectDisableDistortion
;_AIK_EffectDisableEcho
;_AIK_EffectDisableFlanger
;_AIK_EffectDisableGargle
;_AIK_EffectDisableI3DL2Reverb
;_AIK_EffectDisableParamEq
;_AIK_EffectDisableWavesReverb
;_AIK_EffectEnableChorus
;_AIK_EffectEnableCompressor
;_AIK_EffectEnableDistortion
;_AIK_EffectEnableEcho
;_AIK_EffectEnableFlanger
;_AIK_EffectEnableGargle
;_AIK_EffectEnableI3DL2Reverb
;_AIK_EffectEnableParamEq
;_AIK_EffectEnableWavesReverb
;_AIK_EffectIsChorusEnabled
;_AIK_EffectIsCompressorEnabled
;_AIK_EffectIsDistortionEnabled
;_AIK_EffectIsEchoEnabled
;_AIK_EffectIsFlangerEnabled
;_AIK_EffectIsGargleEnabled
;_AIK_EffectIsI3DL2ReverbEnabled
;_AIK_EffectIsParamEqEnabled
;_AIK_EffectIsWavesReverbEnabled
;_AIK_EngineAddSoundSourceAlias
;_AIK_EngineAddSoundSourceFromFile
;_AIK_EngineAddSoundSourceFromMemory
;_AIK_EngineAddSoundSourceFromPCMData
;_AIK_EngineGetDefault3DSoundMaxDistance
;_AIK_EngineGetDefault3DSoundMinDistance
;_AIK_EngineGetDriverName
;_AIK_EngineGetSoundSourceByIndex
;_AIK_EngineGetSoundSourceByName
;_AIK_EngineGetSoundSourceCount
;_AIK_EngineGetSoundVolume
;_AIK_EngineIsCurrentlyPlayingName
;_AIK_EngineIsCurrentlyPlayingSource
;_AIK_EngineIsMultiThreaded
;_AIK_EngineLoadPlugins
;_AIK_EnginePlay2DName
;_AIK_EnginePlay2DSource
;_AIK_EnginePlay3DName
;_AIK_EnginePlay3DSource
;_AIK_EngineRemoveAllSoundSources
;_AIK_EngineRemoveSoundSource
;_AIK_EngineRemoveSoundSourceByName
;_AIK_EngineSetAllSoundsPaused
;_AIK_EngineSetDefault3DSoundMaxDistance
;_AIK_EngineSetDefault3DSoundMinDistance
;_AIK_EngineSetDopplerEffectParameters
;_AIK_EngineSetListenerPosition
;_AIK_EngineSetRolloffFactor
;_AIK_EngineSetSoundVolume
;_AIK_EngineStart
;_AIK_EngineStop
;_AIK_EngineStopAllSounds
;_AIK_EngineUpdate
;_AIK_ListCreateAudioRecorderDeviceList
;_AIK_ListCreateSoundDeviceList
;_AIK_ListDrop
;_AIK_ListGetDeviceCount
;_AIK_ListGetDeviceDescription
;_AIK_ListGetDeviceID
;_AIK_RecorderAddSoundSourceFromRecordedAudio
;_AIK_RecorderClearRecordedAudioDataBuffer
;_AIK_RecorderCreateAudioRecorder
;_AIK_RecorderDrop
;_AIK_RecorderGetAudioFormat
;_AIK_RecorderGetDriverName
;_AIK_RecorderGetRecordedAudioData
;_AIK_RecorderIsRecording
;_AIK_RecorderSaveRecordedAudio
;_AIK_RecorderStartRecordingBufferedAudio
;_AIK_RecorderStopRecordingAudio
;_AIK_SoundDrop
;_AIK_SoundGetIsPaused
;_AIK_SoundGetMaxDistance
;_AIK_SoundGetMinDistance
;_AIK_SoundGetPan
;_AIK_SoundGetPlaybackSpeed
;_AIK_SoundGetPlayLength
;_AIK_SoundGetPlayPosition
;_AIK_SoundGetPosition
;_AIK_SoundGetSoundSource
;_AIK_SoundGetVelocity
;_AIK_SoundGetVolume
;_AIK_SoundIsFinished
;_AIK_SoundIsLooped
;_AIK_SoundSetIsLooped
;_AIK_SoundSetIsPaused
;_AIK_SoundSetMaxDistance
;_AIK_SoundSetMinDistance
;_AIK_SoundSetPan
;_AIK_SoundSetPlaybackSpeed
;_AIK_SoundSetPlayPosition
;_AIK_SoundSetPosition
;_AIK_SoundSetVelocity
;_AIK_SoundSetVolume
;_AIK_SoundStop
;_AIK_SourceForceReloadAtNextUse
;_AIK_SourceGetAudioFormat
;_AIK_SourceGetDefaultMaxDistance
;_AIK_SourceGetDefaultMinDistance
;_AIK_SourceGetDefaultVolume
;_AIK_SourceGetForcedStreamingThreshold
;_AIK_SourceGetIsSeekingSupported
;_AIK_SourceGetName
;_AIK_SourceGetPlayLength
;_AIK_SourceGetSampleData
;_AIK_SourceGetStreamMode
;_AIK_SourceSetDefaultMaxDistance
;_AIK_SourceSetDefaultMinDistance
;_AIK_SourceSetDefaultVolume
;_AIK_SourceSetForcedStreamingThreshold
;_AIK_SourceSetStreamMode
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectDisableAllEffects
; Description ...: Disable all active sound effects on a sound.
; Syntax.........: _AIK_EffectDisableAllEffects($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectDisableAllEffects($hSound)
	DllCall($_AIKDll, "none:cdecl", "EffectDisableAllEffects", "uint_ptr", $hSound)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectDisableChorus
; Description ...: Disable the Chorus sound effect on a sound.
; Syntax.........: _AIK_EffectDisableChorus($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectEnableChorus, _AIK_EffectIsChorusEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectDisableChorus($hSound)
	DllCall($_AIKDll, "none:cdecl", "EffectDisableChorus", "uint_ptr", $hSound)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectDisableCompressor
; Description ...: Disable the Compressor sound effects on a sound.
; Syntax.........: _AIK_EffectDisableCompressor($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectEnableCompressor, _AIK_EffectIsCompressorEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectDisableCompressor($hSound)
	DllCall($_AIKDll, "none:cdecl", "EffectDisableCompressor", "uint_ptr", $hSound)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectDisableDistortion
; Description ...: Disable the Distortion sound effects on a sound.
; Syntax.........: _AIK_EffectDisableDistortion($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectEnableDistortion, _AIK_EffectIsDistortionEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectDisableDistortion($hSound)
	DllCall($_AIKDll, "none:cdecl", "EffectDisableDistortion", "uint_ptr", $hSound)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectDisableEcho
; Description ...: Disable the Echo sound effects on a sound.
; Syntax.........: _AIK_EffectDisableEcho($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectEnableEcho, _AIK_EffectIsEchoEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectDisableEcho($hSound)
	DllCall($_AIKDll, "none:cdecl", "EffectDisableEcho", "uint_ptr", $hSound)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectDisableFlanger
; Description ...: Disable the Flanger sound effects on a sound.
; Syntax.........: _AIK_EffectDisableFlanger($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectEnableFlanger, _AIK_EffectIsFlangerEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectDisableFlanger($hSound)
	DllCall($_AIKDll, "none:cdecl", "EffectDisableFlanger", "uint_ptr", $hSound)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectDisableGargle
; Description ...: Disable the Gargle sound effects on a sound.
; Syntax.........: _AIK_EffectDisableGargle($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectEnableGargle, _AIK_EffectIsGargleEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectDisableGargle($hSound)
	DllCall($_AIKDll, "none:cdecl", "EffectDisableGargle", "uint_ptr", $hSound)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectDisableI3DL2Reverb
; Description ...: Disable the I3DL2Reverb sound effects on a sound.
; Syntax.........: _AIK_EffectDisableI3DL2Reverb($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectEnableI3DL2Reverb, _AIK_EffectIsI3DL2ReverbEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectDisableI3DL2Reverb($hSound)
	DllCall($_AIKDll, "none:cdecl", "EffectDisableI3DL2Reverb", "uint_ptr", $hSound)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectDisableParamEq
; Description ...: Disable the ParamEq sound effects on a sound.
; Syntax.........: _AIK_EffectDisableParamEq($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectEnableParamEq, _AIK_EffectIsParamEqEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectDisableParamEq($hSound)
	DllCall($_AIKDll, "none:cdecl", "EffectDisableParamEq", "uint_ptr", $hSound)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectDisableWavesReverb
; Description ...: Disable the WavesReverb sound effects on a sound.
; Syntax.........: _AIK_EffectDisableWavesReverb($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectEnableWavesReverb, _AIK_EffectIsWavesReverbEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectDisableWavesReverb($hSound)
	DllCall($_AIKDll, "none:cdecl", "EffectDisableWavesReverb", "uint_ptr", $hSound)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectEnableChorus
; Description ...: Enable the Chorus sound effects or adjusts its values.
; Syntax.........: _AIK_EffectEnableChorus($hSound[, $nWetDryMix = 50[, $nDepth = 10[, $nFeedback = 25[, $nFrequency = 1.1[, $iSinusWaveForm = True[, $nDelay = 16[, $iPhase = 90]]]]]]])
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
;                  $nWetDryMix - [optional] Ratio of wet (processed) signal to dry (unprocessed) signal. (Min: 0, Max: 100.0, Default: 50)
;                  $nDepth - [optional] Percentage by which the delay time is modulated by the low-frequency oscillator, in hundredths of a percentage point. (Min: 0, Max: 100.0, Default: 10)
;                  $nFeedback - [optional] Percentage of output signal to feed back into the effect's input. (Min: -99, Max: 99.0, Default: 25)
;                  $nFrequency - [optional] Frequency of the LFO. (Min: 0, Max: 10.0, Default 1.1)
;                  $iSinusWaveForm - [optional] True for sinus wave form, false for triangle. (Default: True)
;                  $nDelay - [optional] Number of milliseconds the input is delayed before it is played back. (Min: 0, Max: 20.0, Default: 16)
;                  $iPhase - [optional] Phase differential between left and right LFOs. (Possible values: -180, -90, 0, 90, 180, Default 90)
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: Chorus is a voice-doubling effect created by echoing the original sound with a slight delay and slightly modulating the delay of the echo.
;                  If this sound effect is already enabled, calling this only modifies the parameters of the active effect.
;+
;                  For further understanding of retrieving a Sound pointer look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableChorus, _AIK_EffectIsChorusEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectEnableChorus($hSound, $nWetDryMix = 50, $nDepth = 10, $nFeedback = 25, $nFrequency = 1.1, $iSinusWaveForm = True, $nDelay = 16, $iPhase = 90)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectEnableChorus", _
											"uint_ptr", $hSound, _
											"float", $nWetDryMix, _
											"float", $nDepth, _
											"float", $nFeedback, _
											"float", $nFrequency, _
											"uint", $iSinusWaveForm, _
											"float", $nDelay, _
											"int", $iPhase)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectEnableCompressor
; Description ...: Enable the Compressor sound effects or adjusts its values.
; Syntax.........: _AIK_EffectEnableCompressor($hSound[, $nGain = 0[, $nAttack = 10[, $nRelease = 200[, $nThreshold = -20[, $nRatio = 3[, $nPredelay = 4]]]]]])
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
;                  $nGain - [optional] Output gain of signal after Compressor. (Min: -60, Max: 60.0, Default: 0)
;                  $nAttack - [optional] Time before Compressor reaches its full value. (Min: 0.01, Max: 500.0, Default: 10)
;                  $nRelease - [optional] Speed at which Compressor is stopped after input drops below fThreshold. (Min: 50, Max: 3000.0, Default: 200)
;                  $nThreshold - [optional] Point at which Compressor begins, in decibels. (Min: -60, Max: 0.0, Default 20)
;                  $nRatio - [optional] Compressor ratio. (Min: 1, Max: 100.0, Default 3)
;                  $nPredelay - [optional] Time after lThreshold is reached before attack phase is started, in milliseconds. (Min: 0, Max: 4.0, Default: 4)
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: Compressor is a reduction in the fluctuation of a signal above a certain amplitude.
;                  If this sound effect is already enabled, calling this only modifies the parameters of the active effect.
;+
;                  For further understanding of retrieving a Sound pointer look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableCompressor, _AIK_EffectIsCompressorEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectEnableCompressor($hSound, $nGain = 0, $nAttack = 10, $nRelease = 200, $nThreshold = -20, $nRatio = 3, $nPredelay = 4)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectEnableCompressor", _
											"uint_ptr", $hSound, _
											"float", $nGain, _
											"float", $nAttack, _
											"float", $nRelease, _
											"float", $nThreshold, _
											"float", $nRatio, _
											"float", $nPredelay)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectEnableDistortion
; Description ...: Enable the Distortion sound effect or adjusts its values.
; Syntax.........: _AIK_EffectEnableDistortion($hSound[, $nGain = -18[, $nEdge = 15[, $nPostEQCenterFrequency = 2400[, $nPostEQBandwidth = 2400[, $nPreLowpassCutoff]]]]])
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
;                  $nGain - [optional] Amount of signal change after distortion. (Min: -60, Max: 60.0, Default: -18)
;                  $nEdge - [optional] Percentage of distortion intensity. (Min: 0, Max: 100.0, Default: 15)
;                  $nPostEQCenterFrequency - [optional] Center frequency of harmonic content addition. (Min: 100, Max: 8000, Default: 2400)
;                  $nPostEQBandwidth - [optional] Width of frequency band that determines range of harmonic content addition. (Min: 100, Max: 8000, Default: 2400)
;                  $nPreLowpassCutoff - [optional] Filter cutoff for high-frequency harmonics attenuation. (Min: 100, Max: 8000, Default 8000)
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: Distortion is achieved by adding harmonics to the signal in such a way that, as the level increases, the top of the waveform becomes squared off or clipped.
;                  If this sound effect is already enabled, calling this only modifies the parameters of the active effect.
;+
;                  For further understanding of retrieving a Sound pointer look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableDistortion, _AIK_EffectIsDistortionEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectEnableDistortion($hSound, $nGain = -18, $nEdge = 15, $nPostEQCenterFrequency = 2400, $nPostEQBandwidth = 2400, $nPreLowpassCutoff = 8000)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectEnableDistortion", _
											"uint_ptr", $hSound, _
											"float", $nGain, _
											"float", $nEdge, _
											"float", $nPostEQCenterFrequency, _
											"float", $nPostEQBandwidth, _
											"float", $nPreLowpassCutoff)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectEnableEcho
; Description ...: Enable the Echo sound effect or adjusts its values.
; Syntax.........: _AIK_EffectEnableEcho($hSound[, $nWetDryMix = 50[, $nFeedback = 50[, $nLeftDelay = 500[, $nRightDelay[, $iPanDelay = 0]]]]])
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
;                  $nWetDryMix - [optional] Ratio of wet (processed) signal to dry (unprocessed) signal. (Min: 0, Max: 100.0, Default: 50)
;                  $nFeedback - [optional] Percentage of output fed back into input. (Min: 0, Max: 100.0, Default: 50)
;                  $nLeftDelay - [optional] Delay for left channel, in milliseconds. (Min: 1, Max: 2000, Default: 500)
;                  $nRightDelay - [optional] Delay for right channel, in milliseconds. (Min: 1, Max: 2000, Default: 500)
;                  $iPanDelay - [optional] Value that specifies whether to swap left and right delays with each successive echo. (Min: 0, Max: 1, Default 0)
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: An echo effect causes an entire sound to be repeated after a fixed delay.
;                  If this sound effect is already enabled, calling this only modifies the parameters of the active effect.
;+
;                  For further understanding of retrieving a Sound pointer look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableEcho, _AIK_EffectIsEchoEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectEnableEcho($hSound, $nWetDryMix = 50, $nFeedback = 50, $nLeftDelay = 500, $nRightDelay = 500, $iPanDelay = 0)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectEnableEcho", _
											"uint_ptr", $hSound, _
											"float", $nWetDryMix, _
											"float", $nFeedback, _
											"float", $nLeftDelay, _
											"float", $nRightDelay, _
											"int", $iPanDelay)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectEnableFlanger
; Description ...: Enable the Flanger sound effects or adjusts its values.
; Syntax.........: _AIK_EffectEnableFlanger($hSound[, $nWetDryMix = 50[, $nDepth = 100[, $nFeedback = -50[, $nFrequency = 0.25[, $iSinusWaveForm = True[, $nDelay = 2[, $iPhase = 0]]]]]]])
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
;                  $nWetDryMix - [optional] Ratio of wet (processed) signal to dry (unprocessed) signal. (Min: 0, Max: 100.0, Default: 50)
;                  $nDepth - [optional] Percentage by which the delay time is modulated by the low-frequency oscillator, in hundredths of a percentage point. (Min: 0, Max: 100.0, Default: 100)
;                  $nFeedback - [optional] Percentage of output signal to feed back into the effect's input. (Min: -99, Max: 99.0, Default: -50)
;                  $nFrequency - [optional] Frequency of the LFO. (Min: 0, Max: 10.0, Default 0.25)
;                  $iSinusWaveForm - [optional] True for sinus wave form, false for triangle. (Default: True)
;                  $nDelay - [optional] Number of milliseconds the input is delayed before it is played back. (Min: 0, Max: 20.0, Default: 2)
;                  $iPhase - [optional] Phase differential between left and right LFOs. (Possible values: -180, -90, 0, 90, 180, Default 0)
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: Flange is an echo effect in which the delay between the original signal and its echo is very short and varies over time.
;                  The result is sometimes referred to as a sweeping sound. The term flange originated with the practice of grabbing the
;                  flanges of a tape reel to change the speed.
;                  If this sound effect is already enabled, calling this only modifies the parameters of the active effect.
;+
;                  For further understanding of retrieving a Sound pointer look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableFlanger, _AIK_EffectIsFlangerEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectEnableFlanger($hSound, $nWetDryMix = 50, $nDepth = 100, $nFeedback = -50, $nFrequency = 0.25, $iSinusWaveForm = True, $nDelay = 2, $iPhase = 0)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectEnableFlanger", _
											"uint_ptr", $hSound, _
											"float", $nWetDryMix, _
											"float", $nDepth, _
											"float", $nFeedback, _
											"float", $nFrequency, _
											"uint", $iSinusWaveForm, _
											"float", $nDelay, _
											"int", $iPhase)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectEnableGargle
; Description ...: Enable the Gargle sound effect or adjusts its values.
; Syntax.........: _AIK_EffectEnableGargle($hSound[, $iRateHz = 20[, $iSinusWaveForm = True]])
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
;                  $iRateHz - [optional] Rate of modulation, in Hertz. (Min: 1, Max: 1000, Default: 20)
;                  $iSinusWaveForm - [optional] True for sinus wave form, False for triangle. (Default: True)
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: The gargle effect modulates the amplitude of the signal.
;                  If this sound effect is already enabled, calling this only modifies the parameters of the active effect. .
;+
;                  For further understanding of retrieving a Sound pointer look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableGargle, _AIK_EffectIsGargleEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectEnableGargle($hSound, $iRateHz = 20, $iSinusWaveForm = True)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectEnableGargle", "uint_ptr", $hSound, "int", $iRateHz, "uint", $iSinusWaveForm)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectEnableI3DL2Reverb
; Description ...: Enable the Interactive 3D Level 2 reverb sound effect or adjusts its values.
; Syntax.........: _AIK_EffectEnableI3DL2Reverb($hSound[, $iRoom = -1000[, $iRoomHF = -100[, $nRoomRolloffFactor = 0[, $nDecayTime = 1.49[, $nDecayHFRatio = 0.83[, $iReflections = -2602[, $nReflectionsDelay = 0.007[, $iReverb = 200[, $nReverbDelay = 0.011[, $nDiffusion = 100.0[, $nDensity = 100.0[, $nHFReference = 5000.0]]]]]]]]]]]])
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
;                  $iRoom - [optional] 	Attenuation of the room effect, in millibels (mB). (Min: -10000, Max: 0, Default: -1000)
;                  $iRoomHF - [optional] Attenuation of the room high-frequency effect. I(Min: -10000, Max: 0, Default: -100)
;                  $nRoomRolloffFactor - [optional] Rolloff factor for the reflected signals. (Min: 0.0, Max: 10.0, Default: 0)
;                  $nDecayTime - [optional] Decay time, in seconds. (Min: 0.1, Max: 20.0, Default: 1.49)
;                  $nDecayHFRatio - [optional] Ratio of the decay time at high frequencies to the decay time at low frequencies. (Min: 0.1, Max: 2.0, Default: 0.83)
;                  $iReflections - [optional] Attenuation of early reflections relative to $iRoom. (Min: -10000, Max: 1000, Default -2602)
;                  $nReflectionsDelay - [optional] Delay time of the first reflection relative to the direct path in seconds. (Min: 0.0, Max: 0.3, Default: 0.007)
;                  $iReverb - [optional] Attenuation of late reverberation relative to $iRoom, in mB. (Min: -10000, Max: 2000, Default: 200)
;                  $nReverbDelay - [optional] Time limit between the early reflections and the late reverberation relative to the time of the first reflection. (Min: 0.0, Max: 0.1, Default: 0.011)
;                  $nDiffusion - [optional] Echo density in the late reverberation decay in percent. (Min: 0.0, Max: 100.0, Default: 100.0)
;                  $nDensity - [optional] Modal density in the late reverberation decay, in percent. (Min: 0.0, Max: 100.0, Default: 100.0)
;                  $nHFReference - [optional] Reference high frequency, in hertz. (Min: 20.0, Max: 20000.0, Default: 5000.0)
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: An implementation of the listener properties in the I3DL2 specification. Source properties are not supported.
;                  If this sound effect is already enabled, calling this only modifies the parameters of the active effect.
;+
;                  For further understanding of retrieving a Sound pointer look at
;                  _AIK_EnginePlay3DName or _AIK_EnginePlay3DSource functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableI3DL2Reverb, _AIK_EffectIsI3DL2ReverbEnabled, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectEnableI3DL2Reverb($hSound, $iRoom = -1000, $iRoomHF = -100, $nRoomRolloffFactor = 0, $nDecayTime = 1.49, $nDecayHFRatio = 0.83, $iReflections = -2602, $nReflectionsDelay = 0.007, $iReverb = 200, $nReverbDelay = 0.011, $nDiffusion = 100.0, $nDensity = 100.0, $nHFReference = 5000.0)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectEnableI3DL2Reverb", _
											"uint_ptr", $hSound, _
											"int", $iRoom, _
											"int", $iRoomHF, _
											"float", $nRoomRolloffFactor, _
											"float", $nDecayTime, _
											"float", $nDecayHFRatio, _
											"int", $iReflections, _
											"float", $nReflectionsDelay, _
											"int", $iReverb, _
											"float", $nReverbDelay, _
											"float", $nDiffusion, _
											"float", $nDensity, _
											"float", $nHFReference)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectEnableParamEq
; Description ...: Enable the ParamEq sound effect or adjusts its values.
; Syntax.........: _AIK_EffectEnableParamEq($hSound[, $nCenter = 8000[, $nBandwidth = 12[, $nGain = 0]]])
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
;                  $nCenter - [optional] Center frequency, in hertz. (Min: 80, Max: 16000.0, Default: 8000)
;                  $nBandwidth - [optional] Bandwidth, in semitones. (Min: 1.0, Max: 36.0, Default: 12)
;                  $nGain - [optional] Gain. (Min: -15.0, Max: 15.0, Default: 0)
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: Parametric equalizer amplifies or attenuates signals of a given frequency.
;                  If this sound effect is already enabled, calling this only modifies the parameters of the active effect.
;+
;                  For further understanding of retrieving a Sound pointer look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableParamEq, _AIK_EffectIsParamEqEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3D
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectEnableParamEq($hSound, $nCenter = 8000, $nBandwidth = 12, $nGain = 0)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectEnableParamEq", _
											"uint_ptr", $hSound, _
											"float", $nCenter, _
											"float", $nBandwidth, _
											"float", $nGain)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectEnableWavesReverb
; Description ...: Enable the WavesReverb sound effect or adjusts its values.
; Syntax.........: _AIK_EffectEnableWavesReverb($hSound[, $nInGain = 0[, $nReverbMix = 0[, $nReverbTime = 1000[, $nHighFreqRTRatio = 0.001]]]])
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
;                  $nInGain - [optional] Input gain of signal, in decibels (dB). (Min: -96.0, Max: 0.0, Default: 0.0)
;                  $nReverbMix - [optional] Reverb mix, in dB. (Min: -96.0, Max: 0.0, Default: 0.0)
;                  $nReverbTime - [optional] Reverb time, in milliseconds. (Min: 0.001, Max: 3000.0, Default: 1000)
;                  $nHighFreqRTRatio - [optional] High-frequency reverb time ratio. (Min: 0.001, Max: 0.999, Default: 0.001)
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: If this sound effect is already enabled, calling this only modifies the parameters of the active effect.
;+
;                  For further understanding of retrieving a Sound pointer look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableWavesReverb, _AIK_EffectIsWavesReverbEnabled, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3D
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectEnableWavesReverb($hSound, $nInGain = 0, $nReverbMix = 0, $nReverbTime = 1000, $nHighFreqRTRatio = 0.001)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectEnableWavesReverb", _
											"uint_ptr", $hSound, _
											"float", $nInGain, _
											"float", $nReverbMix, _
											"float", $nReverbTime, _
											"float", $nHighFreqRTRatio)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectIsChorusEnabled
; Description ...: See if the Chorus sound effect is enabled on a sound.
; Syntax.........: _AIK_EffectIsChorusEnabled($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: Success - True if enabled, False if not.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableChorus, _AIK_EffectEnableChorus, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectIsChorusEnabled($hSound)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectIsChorusEnabled", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0,$aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectIsCompressorEnabled
; Description ...: See if the Compressor sound effect is enabled on a sound.
; Syntax.........: _AIK_EffectIsCompressorEnabled($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: Success - True if enabled, False if not.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableCompressor, _AIK_EffectEnableCompressor, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectIsCompressorEnabled($hSound)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectIsCompressorEnabled", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0,$aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectIsDistortionEnabled
; Description ...: See if the Distortion sound effect is enabled on a sound.
; Syntax.........: _AIK_EffectIsDistortionEnabled($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: Success - True if enabled, False if not.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableDistortion, _AIK_EffectEnableDistortion, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectIsDistortionEnabled($hSound)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectIsDistortionEnabled", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0,$aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectIsEchoEnabled
; Description ...: See if the Echo sound effect is enabled on a sound.
; Syntax.........: _AIK_EffectIsEchoEnabled($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: Success - True if enabled, False if not.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableEcho, _AIK_EffectEnableEcho, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectIsEchoEnabled($hSound)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectIsEchoEnabled", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0,$aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectIsFlangerEnabled
; Description ...: See if the Flanger sound effect is enabled on a sound.
; Syntax.........: _AIK_EffectIsFlangerEnabled($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: Success - True if enabled, False if not.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableFlanger, _AIK_EffectEnableFlanger, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectIsFlangerEnabled($hSound)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectIsFlangerEnabled", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0,$aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectIsGargleEnabled
; Description ...: See if the Gargle sound effect is enabled on a sound.
; Syntax.........: _AIK_EffectIsGargleEnabled($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: Success - True if enabled, False if not.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableGargle, _AIK_EffectEnableGargle, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectIsGargleEnabled($hSound)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectIsGargleEnabled", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0,$aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectIsI3DL2ReverbEnabled
; Description ...: See if the I3DL2Reverb sound effect is enabled on a sound.
; Syntax.........: _AIK_EffectIsI3DL2ReverbEnabled($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: Success - True if enabled, False if not.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay3DName or _AIK_EnginePlay3DSource functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableI3DL2Reverb, _AIK_EffectEnableI3DL2Reverb, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectIsI3DL2ReverbEnabled($hSound)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectIsI3DL2ReverbEnabled", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0,$aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectIsParamEqEnabled
; Description ...: See if the ParamEq sound effect is enabled on a sound.
; Syntax.........: _AIK_EffectIsParamEqEnabled($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: Success - True if enabled, False if not.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableParamEq, _AIK_EffectEnableParamEq, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectIsParamEqEnabled($hSound)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectIsParamEqEnabled", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0,$aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EffectIsWavesReverbEnabled
; Description ...: See if the WavesReverb sound effect is enabled on a sound.
; Syntax.........: _AIK_EffectIsWavesReverbEnabled($hSound)
; Parameters ....: $hSound - Pointer to a sound. (See Remarks)
; Return values .: Success - True if enabled, False if not.
; Author ........:
; Modified.......:
; Remarks .......: For further understanding of retrieving a Sound pointer then look at
;                  _AIK_EnginePlay2Dxxxxx or _AIK_EnginePlay3Dxxxxx (xxxxx being either Name or Source) functions.
;                  You will also need to set the parameter $iSoundEffects to True in the play function you use.
; Related .......: _AIK_EffectDisableWavesReverb, _AIK_EffectEnableWavesReverb, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EffectIsWavesReverbEnabled($hSound)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EffectIsWavesReverbEnabled", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineAddSoundSourceAlias
; Description ...: Adds a sound source as alias for an existing sound source, but with a different name or optional different default settings.
; Syntax.........: _AIK_EngineAddSoundSourceAlias($hBaseSource, $sSoundName)
; Parameters ....: $hBaseSource - The sound source where this sound source should be based on.
;                  +This sound source will use the baseSource as base to access the file and similar,
;                  +but it will have its own name and its own default settings.
;                  $sSoundName  - Name for the new sound source to be added.
;                  +You can use _AIK_EnginePlay2DName or _AIK_EnginePlay3DName to play this sound name.
; Return values .: Success - Pointer to the added sound source alias.
;                  Failure - 0 if not sucessful because for example a sound already existed with that name.
; Author ........:
; Modified.......:
; Remarks .......: This is useful if you want to play multiple sounds but each sound isn't necessarily one single file.
;                  Also useful if you want to play the same sound using different names, volumes or min and max 3D distances.
;                  Currently _AIK_EngineIsCurrentlyPlayingSource or _AIK_EngineIsCurrentlyPlayingName will always return False
;                  if the alias is playing due to a known bug with the irrKlang engine. All other function calls to this alias work as expected.
;                  With the returned Source pointer you can use _AIK_EnginePlay2DSource or _AIK_EnginePlay3DSource.
; Related .......: _AIK_EngineAddSoundSourceFromFile, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineGetSoundSourceByIndex, _AIK_EngineGetSoundSourceByName, _AIK_SoundGetSoundSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineAddSoundSourceAlias($hBaseSource, $sSoundName)
    Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "EngineAddSoundSourceAlias", "uint_ptr", $hBaseSource, "str", $sSoundName)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineAddSoundSourceFromFile
; Description ...: Adds a sound source into the sound engine as a file.
; Syntax.........: _AIK_EngineAddSoundSourceFromFile($sFile, $iStreamMode = $ESM_AUTO_DETECT, $iPreload = False)
; Parameters ....: $sFile       - Sound file to add.
;                  $iStreamMode - Streaming mode for this sound source (Default: $ESM_AUTO_DETECT) can be one of the following:
;                  |$ESM_AUTO_DETECT  - Autodetects the best stream mode for a specified audio data.
;                  |$ESM_STREAMING    - Streams the audio data when needed.
;                  |$ESM_NO_STREAMING - Loads the whole audio data into the memory.
;                  $iPreload    - False don't Preload the sound. True the sound will be preloaded. (Default: False)
; Return values .: Success - Pointer to the added sound source.
;                  Failure - 0 if not sucessful because for example a sound already existed with that name.
; Author ........:
; Modified.......:
; Remarks .......: With the returned source pointer you can use _AIK_EnginePlay2DSource or _AIK_EnginePlay3DSource.
;                  If you want to to remove the sound source from the engine use _AIK_EngineRemoveSoundSource or
;                  _AIK_EngineRemoveSoundSourceByName. If you remove the source any alias sources based on this
;                  source will no longer be accessable and if playing will be stopped.
;                  It's not needed to remove the source as it will be disposed of when the engine is stopped.
; Related .......: _AIK_EngineAddSoundSourceAlias, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DSource, _AIK_EngineRemoveSoundSource, _AIK_EngineRemoveSoundSourceByName
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineAddSoundSourceFromFile($sFile, $iStreamMode = $ESM_AUTO_DETECT, $iPreload = False)
    Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "EngineAddSoundSourceFromFile", "str", $sFile, "int", $iStreamMode, "uint", $iPreload)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineAddSoundSourceFromMemory
; Description ...: Adds a sound source into the sound engine as memory source.
; Syntax.........: _AIK_EngineAddSoundSourceFromMemory($hMemory, $iSizeInBytes, $sSoundName[, $iCopyMemory = True])
; Parameters ....: $hMemory      - Pointer to the memory to be treated as loaded sound file.
;                  $iSizeInBytes - Size of the memory chunk, in bytes.
;                  $sSoundName  - Name of the virtual sound file (e.g. "something.mp3").
;                  +You can also use this name when calling _AIK_EnginePlay3DName or _AIK_EnginePlay2DName.
;                  $iCopyMemory - [Optional] If set to True which is Default, the memory block is copied and stored in the engine,
;                  +after calling _AIK_EngineAddSoundSourceFromMemory the memory pointer can be deleted safely.
;                  +If set to False, the memory is not copied and the user takes the responsibility that the memory block
;                  +pointed to remains there as long as the sound engine or at least this sound source exists.
; Return values .: Success - Pointer to a Sound Source.
;                  Failure - 0
; Author ........: [todo]
; Modified.......:
; Remarks .......: You can use the returned pointer with _AIK_EnginePlay2DSource or _AIK_EnginePlay3DSource.
;                  You may need to set the stream mode for the added source to $ESM_NO_STREAMING by using _AIK_SourceSetStreamMode
;                  Or you may need to alter the source streaming threshold by using _AIK_SourceSetForcedStreamingThreshold.
;                  If you want to to remove the sound source from the engine use _AIK_EngineRemoveSoundSource or
;                  _AIK_EngineRemoveSoundSourceByName. If you remove the source any alias sources based on this
;                  source will no longer be accessable and if playing will be stopped.
;                  It's not needed to remove the source as it will be disposed of when the engine is stopped.
; Related .......: _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource, _AIK_EngineRemoveSoundSource, _AIK_EngineRemoveSoundSourceByName, _AIK_SourceSetStreamMode, _AIK_SourceSetForcedStreamingThreshold
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineAddSoundSourceFromMemory($hMemory, $iSizeInBytes, $sSoundName, $iCopyMemory = True)
    Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "EngineAddSoundSourceFromMemory", "ptr", $hMemory, "int", _
								$iSizeInBytes, "str", $sSoundName, "uint", $iCopyMemory)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineAddSoundSourceFromPCMData
; Description ...: Adds a sound source into the sound engine from plain PCM data in memory.
; Syntax.........: _AIK_EngineAddSoundSourceFromPCMData($hMemory, $iSizeInBytes, $sSoundName, $aFormat, [, $iCopyMemory = True])
; Parameters ....: $hMemory      - Pointer to the memory to be treated as loaded sound file.
;                  $iSizeInBytes - Size of the memory chunk, in bytes.
;                  $sSoundName  - Name of the virtual sound file (e.g. "something.wav").
;                  +You can also use this name when calling _AIK_EnginePlay2DName or _AIK_EnginePlay3DName.
;                  $aFormat     - Array containing 4 elements minimal.
;                  +This Array Can be an Array returned by _AIK_SourceGetAudioFormat or a manually created user array containing
;                  +the relivent data as follows;
;                  |$Array[0] - ChannelCount (1 or 2, Mono/Stereo)
;                  |$Array[1] - FrameCount
;                  |$Array[2] - SampleRate   (eg Hz; 8000, 11025, 16000, 22050, 44100, 48000)
;                  |$Array[3] - SampleFormat (ESampleFormat; $ESF_U8 or $ESF_S16)
;                  $iCopyMemory - [Optional] If set to True which is Default, the memory block is copied and stored in the engine,
;                  +after calling _AIK_EngineAddSoundSourceFromPCMData the memory pointer can be deleted safely.
;                  +If set to Flase, the memory is not copied and the user takes the responsibility that the memory block
;                  +pointed to remains there as long as the sound engine or at least this sound source exists.
; Return values .: Success - Pointer to a Sound Source.
;                  Failure - 0
; Author ........: [todo]
; Modified.......:
; Remarks .......: You can use the returned pointer with _AIK_EnginePlay3DSource or _AIK_EnginePlay2DSource.
;                  You may need to set the stream mode for the added source to $ESM_NO_STREAMING by using _AIK_SourceSetStreamMode
;                  Or you may need to alter the source streaming threshold by using _AIK_SourceSetForcedStreamingThreshold.
;                  If you want to to remove the sound source from the engine use _AIK_EngineRemoveSoundSource or
;                  _AIK_EngineRemoveSoundSourceByName. If you remove the source any alias sources based on this
;                  source will no longer be accessable and if playing will be stopped.
;                  It's not needed to remove the source as it will be disposed of when the engine is stopped.
; Related .......: _AIK_EnginePlay2DName, _AIK_EnginePlay3DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DSource, _AIK_EngineRemoveSoundSource, _AIK_EngineRemoveSoundSourceByName, _AIK_SourceSetStreamMode, _AIK_SourceSetForcedStreamingThreshold
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineAddSoundSourceFromPCMData($hMemory, $iSizeInBytes, $sSoundName, $aFormat, $iCopyMemory = True)
	Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "EngineAddSoundSourceFromPCMData", _
	                            "ptr", $hMemory, _
	                            "int",$iSizeInBytes, _
								"str", $sSoundName, _
								"int", $aFormat[0], _
								"int", $aFormat[1], _
								"int", $aFormat[2], _
								"int", $aFormat[3], _
								"uint", $iCopyMemory)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineGetDefault3DSoundMaxDistance
; Description ...: Get the default maximal distance for 3D sounds.
; Syntax.........: _AIK_EngineGetDefault3DSoundMaxDistance()
; Parameters ....: None.
; Return values .: Success - Default maximal distance for 3d sounds. The default value is 1000000000.0.
;                  Failure - 0
; Author ........:
; Modified.......:
; Remarks .......: This value influences how loud a sound is heard based on its distance.
;                  You can change it using _AIK_EngineSetDefault3DSoundmaxDistance, but changing this value is usually not necessary.
;                  This value causes the sound to stop attenuating after it reaches the max distance.
;                  Most people think that this sets the volume of the sound to 0 after this distance, but this is not true.
;                  Only change the minimal distance (using for example _AIK_EngineSetDefault3DSoundMinDistance) to influence this.
;                  See _AIK_SoundSetMaxDistance for details about what the max distance is.
;                  It is also possible to influence this default value for every sound file using _AIK_SourceSetDefaultMaxDistance.
; Related .......: _AIK_EngineGetDefault3DSoundMinDistance, _AIK_EngineSetDefault3DSoundMaxDistance, _AIK_EngineSetDefault3DSoundMaxDistance, _AIK_SourceGetDefaultMaxDistance, _AIK_SourceGetDefaultMinDistance, _AIK_SourceSetDefaultMaxDistance, _AIK_SourceSetDefaultMinDistance, _AIK_SoundGetMaxDistance, _AIK_SoundGetMinDistance, _AIK_SoundSetMaxDistance, _AIK_SoundSetMinDistance
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineGetDefault3DSoundMaxDistance()
    Local $aReturn = DllCall($_AIKDll, "float:cdecl", "EngineGetDefault3DSoundMaxDistance")
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineGetDefault3DSoundMinDistance
; Description ...: Get the default minimal distance for 3D sounds.
; Syntax.........: _AIK_EngineGetDefault3DSoundMinDistance()
; Parameters ....: None.
; Return values .: Success - Default minimal distance for 3d sounds. The default value is 1.0f.
;                  Failure - 0
; Author ........:
; Modified.......:
; Remarks .......: This value influences how loud a sound is heard based on its distance.
;                  You can change it using _AIK_EngineSetDefault3DSoundMinDistance.
;                  See _AIK_SoundSetMinDistance for details about what the min distance is.
;                  It is also possible to influence this default value for every sound file using AIK_SourceSetDefaultMinDistance.
; Related .......: _AIK_EngineGetDefault3DSoundMaxDistance, _AIK_EngineSetDefault3DSoundMaxDistance, _AIK_EngineSetDefault3DSoundMaxDistance, _AIK_SourceGetDefaultMaxDistance, _AIK_SourceGetDefaultMinDistance, _AIK_SourceSetDefaultMaxDistance, _AIK_SourceSetDefaultMinDistance, _AIK_SoundGetMaxDistance, _AIK_SoundGetMinDistance, _AIK_SoundSetMaxDistance, _AIK_SoundSetMinDistance
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineGetDefault3DSoundMinDistance()
    Local $aReturn = DllCall($_AIKDll, "float:cdecl", "EngineGetDefault3DSoundMinDistance")
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineGetDriverName
; Description ...: Get the name of the sound driver the engine is using.
; Syntax.........: _AIK_EngineGetDriverName()
; Parameters ....: None.
; Return values .: Success - The name of the sound driver.
;                  Failure - 0
; Author ........:
; Modified.......:
; Remarks .......: Possible returned strings are "NULL", "ALSA", "CoreAudio", "winMM", "DirectSound" and "DirectSound8".
; Related .......: _AIK_EngineStart
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineGetDriverName()
    Local $aReturn = DllCall($_AIKDll, "str:cdecl", "EngineGetDriverName")
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineGetSoundSourceByIndex
; Description ...: Get a pointer to a sound source by its index.
; Syntax.........: _AIK_EngineGetSoundSourceByIndex($iIndex)
; Parameters ....: $iIndex - Index of the loaded sound source.
;                  |Index Starts at 0 and the Index End is _AIK_EngineGetSoundSourceCount() -1.
; Return values .: Success - Pointer to the sound source.
;                  Failure - 0 if not available.
; Author ........:
; Modified.......:
; Remarks .......: Don't call _AIK_SoundDrop to this pointer, it will be managed by IrrKlang and
;                  exist as long as you don't call _AIK_EngineStop or call _AIK_EngineRemoveSoundSource functions.
; Related .......: _AIK_EngineGetSoundSourceCount, _AIK_EngineRemoveAllSoundSources(), _AIK_EngineRemoveSoundSource, _AIK_EngineRemoveSoundSourceByName
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineGetSoundSourceByIndex($iIndex)
    Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "EngineGetSoundSourceByIndex", "int", $iIndex)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineGetSoundSourceByName
; Description ...: Get a pointer to a sound source by its name.
; Syntax.........: _AIK_EngineGetSoundSourceByName($sSoundName[, $iAddIfNotFound = True])
; Parameters ....: $sSoundName     - String name of the source.
;                  $iAddIfNotFound - [Optional] True or False (Default value is True)
;                  |If 'True' adds the sound source to the list and returns the interface to it if it cannot be found in the sound source list.
;                  |If 'false', returns 0 if the sound source is not in the list and does not modify the list.
;                  |Default value: True.
; Return values .: Success - Pointer to the sound source.
;                  Failure - 0 if not available.
; Author ........:
; Modified.......:
; Remarks .......: Don't call _AIK_SoundDrop to this pointer, it will be managed by IrrKlang and exist as long as
;                  you don't call _AIK_EngineStop or call _AIK_EngineRemoveSoundSource functions.
; Related .......: _AIK_EngineRemoveAllSoundSources(), _AIK_EngineRemoveSoundSource, _AIK_EngineRemoveSoundSourceByName
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineGetSoundSourceByName($sSoundName, $iAddIfNotFound = True)
    Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "EngineGetSoundSourceByName", "str", $sSoundName, "uint", $iAddIfNotFound)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineGetSoundSourceCount
; Description ...: Get a count of loaded sound sources.
; Syntax.........: _AIK_EngineGetSoundSourceCount()
; Parameters ....: None.
; Return values .: Success - Count of how many loaded sound sources the engine has.
; Author ........:
; Modified.......:
; Remarks .......: None
; Related .......: _AIK_EngineAddSoundSourceAlias, _AIK_EngineAddSoundSourceFromFile, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineGetSoundSourceByIndex, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineGetSoundSourceByName
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineGetSoundSourceCount()
    Local $aReturn = DllCall($_AIKDll, "int:cdecl", "EngineGetSoundSourceCount")
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineGetSoundVolume
; Description ...: Get the master sound volume of the engine.
; Syntax.........: _AIK_EngineGetSoundVolume()
; Parameters ....: None.
; Return values .: Success - Master sound volume of the Sound Engine.  (Float value from 0 silent to 1.0 full volume)
; Author ........:
; Modified.......:
; Remarks .......: None.
; Related .......: _AIK_EngineSetSoundVolume, _AIK_SoundGetVolume, _AIK_SoundSetVolume, _AIK_SourceGetDefaultVolume, _AIK_SourceSetDefaultVolume
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineGetSoundVolume()
    Local $aReturn = DllCall($_AIKDll, "float:cdecl", "EngineGetSoundVolume")
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineIsCurrentlyPlayingName
; Description ...: See if a sound with the specified name is currently playing.
; Syntax.........: _AIK_EngineIsCurrentlyPlayingName($sSoundName)
; Parameters ....: $sSoundName - Name of the sound to check.
; Return values .: Success - True if sound is playing, False if not.
; Author ........:
; Modified.......:
; Remarks .......: Using this function with sources created using _AIK_EngineAddSoundSourceAlias that are playing will always return False
;                  This is a known bug with the irrKlang engine at present.
; Related .......: _AIK_EnginePlay2DName, _AIK_EnginePlay3DName
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineIsCurrentlyPlayingName($sSoundName)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EngineIsCurrentlyPlayingName", "str", $sSoundName)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineIsCurrentlyPlayingSource
; Description ...: See if a sound with the specified source is currently playing.
; Syntax.........: _AIK_EngineIsCurrentlyPlayingSource($hSource)
; Parameters ....: $hSource - Pointer to the sound source to check.
; Return values .: Success - True if sound source is playing, False if not.
; Author ........:
; Modified.......:
; Remarks .......: Using this function with sources created using _AIK_EngineAddSoundSourceAlias that are playing will always return False
;                  This is a known bug with the irrKlang engine at present.
; Related .......: _AIK_EnginePlay2DSource, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineIsCurrentlyPlayingSource($hSource)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EngineIsCurrentlyPlayingSource", "uint_ptr", $hSource)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineIsMultiThreaded
; Description ...: See if irrKlang is running in the same thread as the application or is using multithreading.
; Syntax.........: _AIK_EngineIsMultiThreaded()
; Parameters ....: None.
; Return values .: Success - True if the Sound Engine is running MultiThreaded, False if not.
; Author ........:
; Modified.......:
; Remarks .......: None.
; Related .......: _AIK_EngineStart
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineIsMultiThreaded()
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EngineIsMultiThreaded")
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineLoadPlugins
; Description ...: Load irrKlang plugins from a custom path.
; Syntax.........: _AIK_EngineLoadPlugins($sPath)
; Parameters ....: $sPath - Path where to load plugins from.
; Return values .: Success - True if plugins were loaded, False if not.
; Author ........:
; Modified.......:
; Remarks .......: Plugins like ikpMP3.dll (= short for irrKlangPluginMP3) which make it possible to play back mp3 files.
;                  Plugins are being loaded from the current working directory at startup of the sound engine if the parameter
;                  $ESEO_LOAD_PLUGINS is set (which it is by default), but using this method, it is possible
;                  to load plugins from a custom path in addition.
; Related .......: [todo]
; Link ..........:
; Example .......: [todo: Yes, No]
; ===============================================================================================================================
Func _AIK_EngineLoadPlugins($sPath)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EngineLoadPlugins", "str", $sPath)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EnginePlay2DName
; Description ...: Loads a sound source (if not loaded already) from a file and plays it.
; Syntax.........: _AIK_EnginePlay2DName($sName[, $iLooped = False[, $iStartPaused = False[, $iTrack = False[, $iStreamMode = $ESM_AUTO_DETECT[, $iSoundEffects = False]]]]])
; Parameters ....: $sName         - Filename of the sound.
;                  +Can also be string name as used in _AIK_EngineAddSoundSourceAlias, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData
;                  $iLooped       - [Optional] True plays the sound in loop mode, Default is False.
;                  +If set to 'False', the sound is played once, then stopped and deleted from the internal playing list.
;                  +Calls to ISound have no effect after such a non looped sound has been stopped automaticly.
;                  $iStartPaused  - [Optional] True starts the sound paused, Default is False.
;                  +This implies that $iTrack=true.
;                  +Use this if you want to modify some of the playing parameters before the sound actually plays.
;                  +Usually you would set this parameter to true, then use the Sound interface to modify some of the
;                  +sound parameters and then call _AIK_SoundSetIsPaused($hSound, False)
;                  +You need to call _AIK_SoundDrop when setting this parameter to true and you don't need the Sound object anymore.
;                  $iTrack        - [Optional] True tracks the sound, Default is False.
;                  +Makes it possible to track the sound. Causes the method to return a pointer to the Sound interface.
;                  $iStreamMode   - [Optional] Specifies if the file should be streamed or loaded completely into memory for playing.
;                  +Has no efect if the sound has been loaded or played before into the engine.
;                  |$ESM_AUTO_DETECT  - Autodetects the best stream mode for a specified audio data (Default).
;                  |$ESM_STREAMING    - Streams the audio data when needed.
;                  |$ESM_NO_STREAMING - Loads the whole audio data into the memory.
;                  $iSoundEffects - [Optional] Makes it possible to use sound effects such as chorus, distorsions, echo, reverb and similar for this sound.
;                  +Sound effects can then be controlled sound Effect functions. Only enable if necessary.
; Return values .: Success - Returns a pointer to a Sound if the parameters '$iTrack', '$iStartPaused' or 'iEnableSoundEffects' have been set to True.
;                  +Otherwise returns 0
; Author ........: [todo]
; Modified.......:
; Remarks .......: If this method returns a Sound pointer as result, you HAVE to call _AIK_SoundDrop after you don't need the Sound anymore.
;                  Otherwise this will cause memory waste.
; Related .......: _AIK_EngineAddSoundSourceAlias, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_SoundDrop
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EnginePlay2DName($sName, $iLooped = False, $iStartPaused = False, $iTrack = True, $iStreamMode = $ESM_AUTO_DETECT, $iSoundEffects = True)
	Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "EnginePlay2DName", "str", $sName, "uint", $iLooped, _
			"uint", $iStartPaused, "uint", $iTrack, "int", $iStreamMode, "uint", $iSoundEffects)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EnginePlay2DSource
; Description ...: Plays a sound source as 2D sound with its default settings stored in Sound Source interface.
; Syntax.........: _AIK_EnginePlay2DSource($hSource, $iLooped = False[, $iStartPaused = False[, $iTrack = False[, $iSoundEffects = False]]]])
; Parameters ....: $hSource       - The sound source, specifiying sound file source and default settings for this file.
;                  +Use the other _IrrKlangPlay2DFile overloads if you want to specify a filename string instead of this.
;                  $iLooped       - [Optional] True plays the sound in loop mode, Default is False.
;                  +If set to 'False', the sound is played once, then stopped and deleted from the internal playing list.
;                  +Calls to ISound have no effect after such a non looped sound has been stopped automaticly.
;                  $iStartPaused  - [Optional] True starts the sound paused, Default is False.
;                  +This implies that $iTrack=true.
;                  +Use this if you want to modify some of the playing parameters before the sound actually plays.
;                  +Usually you would set this parameter to true, then use the Sound interface to modify some of the
;                  +sound parameters and then call _AIK_SoundSetIsPaused($hSound, False)
;                  +You need to call _AIK_SoundDrop when setting this parameter to true and you don't need the Sound object anymore.
;                  $iTrack        - [Optional] True tracks the sound, Default is False.
;                  +Makes it possible to track the sound. Causes the method to return a pointer to the Sound interface.
;                  $iSoundEffects - [Optional] Makes it possible to use sound effects such as chorus, distorsions, echo, reverb and similar for this sound.
;                  +Sound effects can then be controlled Sound Effect functions. Only enable if necessary.
; Return values .: Success - Returns a pointer to a Sound if the parameters '$iTrack', '$iStartPaused' or 'iEnableSoundEffects' have been set to True.
;                  +Otherwise returns 0
; Author ........: [todo]
; Modified.......:
; Remarks .......: If this method returns a Sound pointer as result, you HAVE to call _AIK_SoundDrop after you don't need the Sound anymore.
;                  Otherwise this will cause memory waste.
; Related .......: _AIK_EngineAddSoundSourceAlias, _AIK_EngineAddSoundSourceFromFile, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineGetSoundSourceByIndex, _AIK_EngineGetSoundSourceByName, _AIK_EngineStart, _AIK_SoundDrop
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EnginePlay2DSource($hSource, $iLooped = False, $iStartPaused = False, $iTrack = True, $iSoundEffects = True)
	Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "EnginePlay2DSource", "uint_ptr", $hSource, "uint", $iLooped, _
			"uint", $iStartPaused, "uint", $iTrack, "uint", $iSoundEffects)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EnginePlay3DName
; Description ...: Loads a sound source (if not loaded already) from a file and plays it as 3D sound.
; Syntax.........: _AIK_EnginePlay3DName($sName, $nPosX, $nPosY, $nPosZ, [, $iLooped = False[, $iStartPaused = False[, $iTrack = False[, $iStreamMode = $ESM_AUTO_DETECT[, $iSoundEffects = False]]]]])
; Parameters ....: $sName         - Filename of the sound.
;                  +Can also be string name as used in _AIK_EngineAddSoundSourceAlias, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData
;                  $nPosX         - X position of the sound (float value).
;                  $nPosY         - Y position of the sound (float value).
;                  $nPosZ         - Z position of the sound (float value).
;                  $iLooped       - [Optional] True plays the sound in loop mode, Default is False.
;                  +If set to 'False', the sound is played once, then stopped and deleted from the internal playing list.
;                  +Calls to ISound have no effect after such a non looped sound has been stopped automaticly.
;                  $iStartPaused  - [Optional] True starts the sound paused, Default is False.
;                  +This implies that $iTrack=true.
;                  +Use this if you want to modify some of the playing parameters before the sound actually plays.
;                  +Usually you would set this parameter to true, then use the Sound interface to modify some of the
;                  +sound parameters and then call _AIK_SoundSetIsPaused($hSound, False)
;                  +You need to call _AIK_SoundDrop when setting this parameter to true and you don't need the Sound object anymore.
;                  $iTrack        - [Optional] True tracks the sound, Default is False.
;                  +Makes it possible to track the sound. Causes the method to return a pointer to the Sound interface.
;                  $iStreamMode   - [Optional] Specifies if the file should be streamed or loaded completely into memory for playing.
;                  +Has no efect if the sound has been loaded or played before into the engine.
;                  |$ESM_AUTO_DETECT  - Autodetects the best stream mode for a specified audio data (Default).
;                  |$ESM_STREAMING    - Streams the audio data when needed.
;                  |$ESM_NO_STREAMING - Loads the whole audio data into the memory.
;                  $iSoundEffects - [Optional] Makes it possible to use sound effects such as chorus, distorsions, echo, reverb and similar for this sound.
;                  +Sound effects can then be controlled Sound Effect functions. Only enable if necessary.
; Return values .: Success - Returns a pointer to a Sound if the parameters '$iTrack', '$iStartPaused' or 'iEnableSoundEffects' have been set to True.
;                  +Otherwise returns 0
; Author ........: [todo]
; Modified.......:
; Remarks .......: If this method returns a Sound pointer as result, you HAVE to call _AIK_SoundDrop after you don't need the Sound anymore.
;                  Otherwise this will cause memory waste.
;+
;                  If your not hearing any sound output due to irrKlang not being able to create 3D bufffers,
;                  you may want to try starting AIK without the $ESEO_USE_3D_BUFFERS option.
;                  eg: _AIK_EngineStart(@ScriptDir, $ESOD_AUTO_DETECT, BitXOR($ESEO_DEFAULT_OPTIONS, $ESEO_USE_3D_BUFFERS))
; Related .......: _AIK_EngineAddSoundSourceAlias, _AIK_EngineAddSoundSourceFromFile, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineStart, _AIK_SoundDrop
; Link ..........:
; Example .......: [todo: Yes, No]
; ===============================================================================================================================
Func _AIK_EnginePlay3DName($sName, $nPosX, $nPosY, $nPosZ, $iLooped = False, $iStartPaused = False, $iTrack = False, _
						    $iStreamMode = $ESM_AUTO_DETECT, $iSoundEffects = False)
	Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "EnginePlay3DName", "str", $sName, _
								"float", $nPosX, "float", $nPosY, "float", $nPosZ, _
	                            "uint", $iLooped, "uint", $iStartPaused, "uint", $iTrack, _
								"int", $iStreamMode, "uint", $iSoundEffects)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EnginePlay3DSource
; Description ...: Plays a sound source as 3D sound with its default settings stored in Sound Source interface.
; Syntax.........: _AIK_EnginePlay3DSource($hSource, $nPosX, $nPosY, $nPosZ[, $iLooped = False[, $iStartPaused = False[, $iTrack = False[, $iSoundEffects = False]]]])
; Parameters ....: $hSource       - The sound source, specifiying sound file source and default settings for this file.
;                  +Use the other _IrrKlangPlay3DFile overloads if you want to specify a filename string instead of this.
;                  $nPosX         - X position of the sound (float value).
;                  $nPosY         - Y position of the sound (float value).
;                  $nPosZ         - Z position of the sound (float value).
;                  $iLooped       - [Optional] True plays the sound in loop mode, Default is False.
;                  +If set to 'False', the sound is played once, then stopped and deleted from the internal playing list.
;                  +Calls to ISound have no effect after such a non looped sound has been stopped automaticly.
;                  $iStartPaused  - [Optional] True starts the sound paused, Default is False.
;                  +This implies that $iTrack=true.
;                  +Use this if you want to modify some of the playing parameters before the sound actually plays.
;                  +Usually you would set this parameter to true, then use the Sound interface to modify some of the
;                  +sound parameters and then call _AIK_SoundSetIsPaused($hSound, False)
;                  +You need to call _AIK_SoundDrop when setting this parameter to true and you don't need the Sound object anymore.
;                  $iTrack        - [Optional] True tracks the sound, Default is False.
;                  +Makes it possible to track the sound. Causes the method to return a pointer to the Sound interface.
;                  $iSoundEffects - [Optional] Makes it possible to use sound effects such as chorus, distorsions, echo, reverb and similar for this sound.
;                  +Sound effects can then be controlled Sound Effect functions. Only enable if necessary.
; Return values .: Success - Returns a pointer to a Sound if the parameters '$iTrack', '$iStartPaused' or 'iEnableSoundEffects' have been set to True.
;                  +Otherwise returns 0
; Author ........: [todo]
; Modified.......:
; Remarks .......: If this method returns a Sound pointer as result, you HAVE to call _AIK_SoundDrop after you don't need the Sound anymore.
;                  Otherwise this will cause memory waste.
;+
;                  If your not hearing any sound output due to irrKlang not being able to create 3D bufffers,
;                  you may want to try starting AIK without the $ESEO_USE_3D_BUFFERS option.
;                  eg: _AIK_EngineStart(@ScriptDir, $ESOD_AUTO_DETECT, BitXOR($ESEO_DEFAULT_OPTIONS, $ESEO_USE_3D_BUFFERS))
; Related .......: _AIK_EngineAddSoundSourceAlias, _AIK_EngineAddSoundSourceFromFile, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineGetSoundSourceByIndex, _AIK_EngineGetSoundSourceByName, _AIK_EngineStart, _AIK_SoundDrop
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EnginePlay3DSource($hSource, $nPosX, $nPosY, $nPosZ, $iLooped = False, $iStartPaused = False, $iTrack = False, $iSoundEffects = False)
	Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "EnginePlay3DSource", "uint_ptr", $hSource, _
								"float", $nPosX, "float", $nPosY, "float", $nPosZ, _
								"uint", $iLooped, "uint", $iStartPaused, "uint", $iTrack, "uint", $iSoundEffects)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineRemoveAllSoundSources
; Description ...: Removes all sound sources from the engine.
; Syntax.........: _AIK_EngineRemoveAllSoundSources()
; Parameters ....: None.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: This will also cause all sounds to be stopped.
;                  Removing sound sources is only necessary if you know you won't use a lot of non-streamed sounds again.
;                  Sound sources of streamed sounds do not cost a lot of memory.
; Related .......:  _AIK_EngineAddSoundSourceAlias, _AIK_EngineAddSoundSourceFromFile, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineGetSoundSourceByIndex, _AIK_EngineGetSoundSourceByName
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineRemoveAllSoundSources()
    DllCall($_AIKDll, "none:cdecl", "EngineRemoveAllSoundSources")
	If @error Then Return SetError(@error, 0, 0)
EndFunc   ;==>_IrrKlangStop


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineRemoveSoundSource
; Description ...: Removes a sound source from the engine, freeing the memory it occupies.
; Syntax.........: _AIK_EngineRemoveSoundSource($hSource)
; Parameters ....: $hSource - Pointer to the Sound Source to remove.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: This will also cause all currently playing sounds of this source to be stopped.
;                  Also note that if the source has been removed successfully,
;                  the value returned by _AIK_EngineGetSoundSourceCount will have been decreased by one.
;                  Removing sound sources is only necessary if you know you won't use a lot of non-streamed sounds again.
;                  Sound sources of streamed sounds do not cost a lot of memory.
; Related .......: _AIK_EngineAddSoundSourceAlias, _AIK_EngineAddSoundSourceFromFile, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineGetSoundSourceByIndex, _AIK_EngineGetSoundSourceByName, _AIK_EngineGetSoundSourceCount
; Link ..........:
; Example .......: [todo: Yes, No]
; ===============================================================================================================================
Func _AIK_EngineRemoveSoundSource($hSource)
    DllCall($_AIKDll, "none:cdecl", "EngineRemoveSoundSource", "uint_ptr", $hSource)
	If @error Then Return SetError(@error, 0, 0)
EndFunc   ;==>_IrrKlangStop


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineRemoveSoundSourceByName
; Description ...: Removes a sound source by its name from the engine, freeing the memory it occupies.
; Syntax.........: _AIK_EngineRemoveSoundSourceByName($sSourceName)
; Parameters ....: $sSourceName - Sound Source name to remove.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: This will also cause all currently playing sounds of this source to be stopped.
;                  Also note that if the source has been removed successfully,
;                  the value returned by _AIK_EngineGetSoundSourceCount will have been decreased by one.
;                  Removing sound sources is only necessary if you know you won't use a lot of non-streamed sounds again.
;                  Sound sources of streamed sounds do not cost a lot of memory.
; Related .......: _AIK_EngineAddSoundSourceAlias, _AIK_EngineAddSoundSourceFromFile, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineGetSoundSourceByIndex, _AIK_EngineGetSoundSourceByName, _AIK_EngineGetSoundSourceCount
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineRemoveSoundSourceByName($sSourceName)
    DllCall($_AIKDll, "none:cdecl", "EngineRemoveSoundSourceByName", "str", $sSourceName)
	If @error Then Return SetError(@error, 0, 0)
EndFunc   ;==>_IrrKlangStop


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineSetAllSoundsPaused
; Description ...: Pauses or unpauses all currently playing sounds.
; Syntax.........: _AIK_EngineSetAllSoundsPaused([$iPause = True])
; Parameters ....: $iPause - [Optional] True pauses all sounds, False unpauses all sounds, Default is True.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: Look at _AIK_SoundGetIsPaused or _AIK_SoundSetIsPaused to query or set the individual pause state of a sound.
; Related .......: _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource, _AIK_SoundGetIsPaused, _AIK_SoundSetIsPaused
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineSetAllSoundsPaused($iPause = True)
    DllCall($_AIKDll, "none:cdecl", "EngineSetAllSoundsPaused", "uint", $iPause)
	If @error Then Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineSetDefault3DSoundMaxDistance
; Description ...: Sets the default maximal distance for 3D sounds.
; Syntax.........: _AIK_EngineSetDefault3DSoundMaxDistance([$nMaxDistance = 1000000000.0])
; Parameters ....: $nMaxDistance - [Optional] Default maximal distance for 3d sounds. The default value is 1000000000.0
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: Changing this value is usually not necessary.
;                  Use _AIK_EngineSetDefault3DSoundMinDistance instead.
;                  Don't change this value if you don't know what you are doing.
;                  This value causes the sound to stop attenuating after it reaches the max distance.
;                  Most people think that this sets the volume of the sound to 0 after this distance, but this is not true.
;                  Only change the minimal distance (using for example _AIK_EngineSetDefault3DSoundMinDistance) to influence this.
;                  See _AIK_SoundSetMaxDistance for details about what the max distance is.
;                  It is also possible to influence this default value for every sound file using _AIK_EngineSetDefault3DSoundMinDistance.
;                  This method only influences the initial distance value of sounds.
;                  For changing the distance after the sound has been started to play,
;                  use _AIK_SoundSetMinDistance and _AIK_SoundSetMaxDistance.
; Related .......: _AIK_EngineGetDefault3DSoundMaxDistance, _AIK_EngineGetDefault3DSoundMinDistance, _AIK_EngineSetDefault3DSoundMinDistance, _AIK_SourceGetDefaultMaxDistance, _AIK_SourceGetDefaultMinDistance, _AIK_SourceSetDefaultMaxDistance, _AIK_SourceSetDefaultMinDistance, _AIK_SoundGetMaxDistance, _AIK_SoundGetMinDistance, _AIK_SoundSetMaxDistance, _AIK_SoundSetMinDistance
; Link ..........:
; Example .......: [todo: Yes, No]
; ===============================================================================================================================
Func _AIK_EngineSetDefault3DSoundMaxDistance($nMaxDistance = 1000000000.0)
    DllCall($_AIKDll, "none:cdecl", "EngineSetDefault3DSoundMaxDistance", "float", $nMaxDistance)
	If @error Then Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineSetDefault3DSoundMinDistance
; Description ...: Sets the default minimal distance for 3D sounds.
; Syntax.........: _AIK_EngineSetDefault3DSoundMinDistance($nMinDistance = 1.0)
; Parameters ....: $nMinDistance - Default minimal distance for 3d sounds. The default value is 1.0
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: This value influences how loud a sound is heard based on its distance.
;                  See _AIK_SoundSetMinDistance for details about what the min distance is.
;                  It is also possible to influence this default value for every sound file using _AIK_EngineSetDefault3DSoundMinDistance.
;                  This method only influences the initial distance value of sounds.
;                  For changing the distance after the sound has been started to play,
;                  use _AIK_SoundSetMinDistance and _AIK_SoundSetMaxDistance.
; Related .......: _AIK_EngineGetDefault3DSoundMaxDistance, _AIK_EngineGetDefault3DSoundMinDistance, _AIK_EngineSetDefault3DSoundMaxDistance, _AIK_SourceGetDefaultMaxDistance, _AIK_SourceGetDefaultMinDistance, _AIK_SourceSetDefaultMaxDistance, _AIK_SourceSetDefaultMinDistance, _AIK_SoundGetMaxDistance, _AIK_SoundGetMinDistance, _AIK_SoundSetMaxDistance, _AIK_SoundSetMinDistance
; Link ..........:
; Example .......: [todo: Yes, No]
; ===============================================================================================================================
Func _AIK_EngineSetDefault3DSoundMinDistance($nMinDistance = 1.0)
    DllCall($_AIKDll, "none:cdecl", "EngineSetDefault3DSoundMinDistance", "float", $nMinDistance)
	If @error Then Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineSetDopplerEffectParameters
; Description ...: Sets parameters affecting the doppler effect.
; Syntax.........: _AIK_EngineSetDopplerEffectParameters($nDopplerFactor = 1.0, $nDistanceFactor = 1.0)
; Parameters ....: $nDopplerFactor  - [Optional] Is a value between 0 and 10 which multiplies the doppler effect.
;                  +Default value is 1.0, which is the real world doppler effect,
;                  +and 10.0f would be ten times the real world doppler effect.
;                  $nDistanceFactor - [Optional] Is the number of meters in a vector unit. The default value is 1.0.
;                  +Doppler effects are calculated in meters per second with this parameter, this can be changed.
;                  +All velocities and positions are influenced by this.
;                  +If the measurement should be in foot instead of meters, set this value to 0.3048 for example.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: None.
; Related .......: [todo]
; Link ..........:
; Example .......: [todo: Yes, No]
; ===============================================================================================================================
Func _AIK_EngineSetDopplerEffectParameters($nDopplerFactor = 1.0, $nDistanceFactor = 1.0)
    DllCall($_AIKDll, "none:cdecl", "EngineSetDopplerEffectParameters", "float", $nDopplerFactor, "float", $nDistanceFactor)
	If @error Then Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineSetListenerPosition
; Description ...: Sets the current listener 3d position.
; Syntax.........: _AIK_EngineSetListenerPosition($nPosX, $nPosY, $nPosZ, $nLookX, $nLookY, $nLookZ[, $nVelocityX = 0[, $nVelocityY = 0[, $nVelocityZ = 0[, $nUpX = 0[, $nUpY = 1[, $nUpZ = 0]]]]]])
; Parameters ....: $nPosX      - X Position of the camera or listener.
;                  $nPosY      - Y Position of the camera or listener.
;                  $nPosZ      - Z Position of the camera or listener.
;                  $nLookX     - X Direction vector where the camera or listener is looking into.
;                  $nLookY     - Y Direction vector where the camera or listener is looking into.
;                  $nLookZ     - Z Direction vector where the camera or listener is looking into.
;                  $nVelocityX - X The velocity per second describes the speed of the listener and is only needed for doppler effects.
;                  $nVelocityY - Y The velocity per second describes the speed of the listener and is only needed for doppler effects.
;                  $nVelocityZ - Z The velocity per second describes the speed of the listener and is only needed for doppler effects.
;                  $nUpX       - X Vector pointing 'up', so the engine can decide where is left and right. This vector is usually 0.
;                  $nUpY       - Y Vector pointing 'up', so the engine can decide where is left and right. This vector is usually 1.
;                  $nUpZ       - Z Vector pointing 'up', so the engine can decide where is left and right. This vector is usually 0.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: When playing sounds in 3D, updating the position of the listener every frame should be done using this function.
; Related .......: _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource, _AIK_EngineSetDopplerEffectParameters
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _AIK_EngineSetListenerPosition($nPosX, $nPosY, $nPosZ, _
									$nLookX, $nLookY, $nLookZ, _
									$nVelocityX = 0, $nVelocityY = 0, $nVelocityZ = 0, _
									$nUpX = 0, $nUpY = 1, $nUpZ = 0)
    DllCall($_AIKDll, "none:cdecl", "EngineSetListenerPosition", _
	                        "float", $nPosX, "float", $nPosY, "float", $nPosZ, _
							"float", $nLookX, "float", $nLookY, "float", $nLookZ, _
							"float", $nVelocityX, "float", $nVelocityY, "float", $nVelocityZ, _
							"float", $nUpX, "float", $nUpY, "float", $nUpZ)
	If @error Then Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineSetRolloffFactor
; Description ...: Sets a rolloff factor which influences the amount of attenuation that is applied to 3D sounds.
; Syntax.........: _AIK_EngineSetRolloffFactor([$nRolloffFactor = 1.0])
; Parameters ....: $nRolloffFactor  - [Optional] The rolloff factor can range from 0.0 to 10.0, Default is 1.0
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: A Rolloff Factor of 0 is no rolloff. A Rolloff Factor of 1.0 is what we experience in the real world.
;                  A value of 2 would mean twice the real-world rolloff.
; Related .......: _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _AIK_EngineSetRolloffFactor($nRolloffFactor = 1.0)
    DllCall($_AIKDll, "none:cdecl", "EngineSetRolloffFactor", "float", $nRolloffFactor)
	If @error Then Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineSetSoundVolume
; Description ...: Sets master sound volume. This value is multiplied with all sounds played.
; Syntax.........: _AIK_EngineSetSoundVolume([$nVolume = 1.0])
; Parameters ....: $nVolume - [Optional] 0 silent to 1.0 full volume, Default is 1.0
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: None
; Related .......: _AIK_EngineGetSoundVolume, _AIK_SoundGetVolume, _AIK_SoundSetVolume, _AIK_SourceGetDefaultVolume, _AIK_SourceGetDefaultVolume
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineSetSoundVolume($nVolume = 1.0)
    DllCall($_AIKDll, "none:cdecl", "EngineSetSoundVolume", "float", $nVolume)
	If @error Then Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineStart
; Description ...: Starts the IrrKlang sound engine ready to play sounds.
; Syntax.........: _AIK_EngineStart([$sDllPath = @ScriptDir[, $iOutputDriver = $ESOD_AUTO_DETECT[, $iEngineOptions = $ESEO_DEFAULT_OPTIONS[, $sDeviceID = 0]]]])
; Parameters ....: $sDllPath       - [optional] Path where IrrKlangWrapper.dll and irrKlang.dll can be found. (Script directory is the default)
;                  $iOutputDriver  - [optional] The sound output driver to be used for sound output. ($ESOD_AUTO_DETECT is the default)
;                  |$ESOD_AUTO_DETECT    - Autodetects the best sound driver for the system.
;                  |$ESOD_DIRECT_SOUND_8 - DirectSound8 sound output driver, windows only.
;                  +In contrast to ESOD_DIRECT_SOUND, this supports sophisticated sound effects but may not be available on old windows versions.
;                  +It behaves very similar to ESOD_DIRECT_SOUND but also supports DX8 sound effects.
;                  |$ESOD_DIRECT_SOUND   - DirectSound sound output driver, windows only.
;                  +This uses DirectSound 3 or above, if available. If DX8 sound effects are needed, use ESOD_DIRECT_SOUND_8 instead.
;                  +The ESOD_DIRECT_SOUND driver may be available on more and older windows versions than ESOD_DIRECT_SOUND_8.
;                  |$ESOD_WIN_MM         - WinMM sound output driver, windows only.
;                  +Supports the ISoundMixedOutputReceiver interface using setMixedDataOutputReceiver.
;                  |$ESOD_NULL           - Null driver, creating no sound output.
;                  $iEngineOptions - [optional] A combination of E_SOUND_ENGINE_OPTIONS literals. ($ESEO_DEFAULT_OPTIONS is the default)
;                  |$ESEO_MULTI_THREADED               - If specified (default), it will make irrKlang run in a separate thread.
;                  |$ESEO_MUTE_IF_NOT_FOCUSED          - If the window of the application doesn't have the focus, irrKlang will be silent if this has been set.
;                  +This will only work when irrKlang is using the DirectSound output driver.
;                  |$ESEO_LOAD_PLUGINS                 - Automaticly loads external plugins when starting up.
;                  +Plugins usually are .dll, .so or .dylib files named for example ikpMP3.dll (= short for irrKlangPluginMP3)
;                  +which are executed after the startup of the sound engine and modify it for example to make it possible to play back mp3 files.
;                  +Plugins are being loaded from the current working directory as well as from the position where the .exe using the irrKlang library resides.
;                  +It is also possible to load the plugins from custom or default paths after the engine has started up using _AIK_EngineLoadPlugins.
;                  |$ESEO_USE_3D_BUFFERS               - Uses 3D sound buffers instead of emulating them when playing 3d sounds (default).
;                  +If this flag is not specified, all buffers will by created in 2D only and 3D positioning will be emulated in software,
;                  +making the engine run faster if hardware 3d audio is slow on the system.
;                  |$ESEO_PRINT_DEBUG_INFO_TO_DEBUGGER - Prints debug messages to the debugger window.
;                  +irrKlang will print debug info and status messages to any windows debugger supporting OutputDebugString() (like VisualStudio).
;                  +This is useful if your application does not capture any console output (see $ESEO_PRINT_DEBUG_INFO_TO_STDOUT).
;                  |$ESEO_PRINT_DEBUG_INFO_TO_STDOUT   - Prints debug messages to stdout (the ConsoleWindow).
;                  +irrKlang will print debug info and status messages stdout, the console window in Windows.
;                  |$ESEO_LINEAR_ROLLOFF               - Uses linear rolloff for 3D sound.
;                  +If specified, instead of the default logarithmic one, irrKlang will use a linear rolloff model which influences the attenuation of the sounds
;                  +over distance. The volume is interpolated linearly between the MinDistance and MaxDistance, making it possible to adjust sounds more easily
;                  +although this is not physically correct. Note that this option may not work when used together with the ESEO_USE_3D_BUFFERS option when using
;                  +Direct3D for example, irrKlang will then turn off ESEO_USE_3D_BUFFERS automaticly to be able to use this option and write out a warning.
;                  |$ESEO_DEFAULT_OPTIONS  - Default parameters when starting up the engine.
;                  +Default paramaters are:
;                  +$ESEO_MULTI_THREADED, $ESEO_LOAD_PLUGINS, $ESEO_USE_3D_BUFFERS, $ESEO_PRINT_DEBUG_INFO_TO_STDOUT
;                  $sDeviceID      - [optional] Some additional optional deviceID for the audio driver. (0 is the default)
;                  +If not needed, simple set this to 0. This can be used for example to set a specific output pcm device for output ("default" or "hw", for example).
;                  +For most driver types, available deviceIDs can be enumerated using _AIK_ListCreateSoundDeviceList.
;                  +See IK_ListCreateSoundDeviceList for Enumerating sound devices for an example.
; Return values .: Success - True and set @error 0
;                  Failure - False and set @error
;                  |@error 0 IrrKlangStart call failed to creates the device object
;                  |@error 1 ~ 4 AutoIt DllCall failed.
;                  |@error 5 AutoIt DllOpen failed due to dll not found at the path specified.
; Author ........:
; Modified.......:
; Remarks .......: Only one irrklang sound output device object is supported by this wrapper.
;                  When a user is finished with irrklang sound output device they should call _AIK_EngineStop to close any open devices.
; Related .......: _AIK_ListCreateSoundDeviceList, _AIK_EngineStop
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineStart($sDllPath = @ScriptDir, $iOutputDriver = $ESOD_AUTO_DETECT, $iEngineOptions = $ESEO_DEFAULT_OPTIONS, $sDeviceID = 0)
	__Init_IrrKlangDll($sDllPath)
	If $_AIKDll = -1 Then Return SetError(5, 0, False) ; Dll Not found
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "EngineStart", "uint", $iOutputDriver, "uint", $iEngineOptions, "str", $sDeviceID)
	If @error Then Return SetError(@error, 0, False) ; AutoIt DllCall error 1 ~ 4
	Return SetError(0, 0, $aReturn[0] = 1) ; No error, Ture if Engine started, False if not.
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineStop
; Description ...: Stops the IrrKlang sound engine.
; Syntax.........: _AIK_EngineStop()
; Parameters ....: None.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: This function will close any open Devices (eg: Sound Engine, Audio Recorder and Device List) and
;                  close AIK.dll.
; Related .......: _AIK_EngineStart, _AIK_ListCreateAudioRecorderDeviceList, _AIK_ListCreateSoundDeviceList
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineStop()
	If $_AIKDll = -1 Then Return
	DllCall($_AIKDll, "none:cdecl", "EngineStop")
	If @error Then Return SetError(@error, 0, 0)
	Sleep(50)
    DllClose($_AIKDll)
	$_AIKDll = -1
EndFunc   ;==>_IrrKlangStop


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineStopAllSounds
; Description ...: Stops all currently playing sounds.
; Syntax.........: _AIK_EngineStopAllSounds()
; Parameters ....: None
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: None
; Related .......: [todo]
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_EngineStopAllSounds()
    DllCall($_AIKDll, "none:cdecl", "EngineStopAllSounds")
	If @error Then Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_EngineUpdate
; Description ...: Updates the audio engine.
; Syntax.........: _AIK_EngineUpdate()
; Parameters ....: None.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: This should be called several times per frame if irrKlang was started in single thread mode.
; Related .......: [todo]
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _AIK_EngineUpdate()
    DllCall($_AIKDll, "none:cdecl", "EngineUpdate")
	If @error Then Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_ListCreateAudioRecorderDeviceList
; Description ...: Creates a list of available recording devices for the driver type.
; Syntax.........: _AIK_ListCreateAudioRecorderDeviceList([$sPath = @ScriptDir, [$iOutputDriver = $ESOD_AUTO_DETECT]])
; Parameters ....: $sDllPath      - [Optional] Path where IrrKlangWrapper.dll and irrKlang.dll can be found. (Script directory is the default)
;                  $iOutputDriver - [Optional] The sound output driver of which the list is generated. Default is $ESOD_AUTO_DETECT.
;                  |$ESOD_AUTO_DETECT    - Autodetects the best sound driver for the system.
;                  |$ESOD_DIRECT_SOUND_8 - DirectSound8 sound output driver, windows only.
;                  +In contrast to $ESOD_DIRECT_SOUND, this supports sophisticated sound effects but may not be available on old windows versions.
;                  +It behaves very similar to $ESOD_DIRECT_SOUND but also supports DX8 sound effects.
;                  |$ESOD_DIRECT_SOUND   - DirectSound sound output driver, windows only.
;                  +This uses DirectSound 3 or above, if available. If DX8 sound effects are needed, use $ESOD_DIRECT_SOUND_8 instead.
;                  +The ESOD_DIRECT_SOUND driver may be available on more and older windows versions than $ESOD_DIRECT_SOUND_8.
;                  |$ESOD_WIN_MM         - WinMM sound output driver, windows only.
;                  |$ESOD_NULL           - Null driver, creating no sound output.
; Return values .: Success - True and @error 0
;                  Failure - False.
;                  |@error 1 ~ 4 - AutoIt Failed DllCall
;                  |@error 5     - AutoIt Failed to find IrrKlangWrapper.dll and or IrrKlang.dll at the specified path
; Author ........:
; Modified.......:
; Remarks .......: The Device IDs in this list can be used as parameter to _AIK_RecorderCreateAudioRecorder to make irrKlang use a special sound device.
;                  You can use other list functions to retrieve the available device Count, Descriptions and IDs.
;                  After you don't need the list anymore, call _AIK_ListDrop in order to free its memory.
;                  Only one Device List may be created at any time (this is a wrapper limitation by design).
;                  Creating a second Device List will automatically drop the first Device List freeing its memory.
;                  This function can be called without calling _AIK_EngineStart.
;                  If for some reason a user is creating a Device List without ever needing to call _AIK_EngineStart then
;                  the user should call _AIK_EngineStop when finished with device list functions to close IrrKlang.
; Related .......: _AIK_ListDrop, _AIK_ListGetDeviceCount, _AIK_ListGetDeviceDescription, _AIK_ListGetDeviceID
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_ListCreateAudioRecorderDeviceList($sDllPath = @ScriptDir, $iOutputDriver = $ESOD_AUTO_DETECT)
	If $_AIKDll = -1 Then __Init_IrrKlangDll($sDllPath)
	If $_AIKDll = -1 Then Return SetError(5, 0, False)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "ListCreateAudioRecorderDeviceList", "uint", $iOutputDriver)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_ListCreateSoundDeviceList
; Description ...: Creates a list of available sound devices for the driver type.
; Syntax.........: _AIK_ListCreateSoundDeviceList([$iOutputDriver = $ESOD_AUTO_DETECT])
; Parameters ....: $sDllPath      - [Optional] Path where IrrKlangWrapper.dll and irrKlang.dll can be found. (Script directory is the default)
;                  $iOutputDriver - [Optional] The sound output driver of which the list is generated. Default is $ESOD_AUTO_DETECT.
;                  |$ESOD_AUTO_DETECT    - Autodetects the best sound driver for the system.
;                  |$ESOD_DIRECT_SOUND_8 - DirectSound8 sound output driver, windows only.
;                  +In contrast to ESOD_DIRECT_SOUND, this supports sophisticated sound effects but may not be available on old windows versions.
;                  +It behaves very similar to ESOD_DIRECT_SOUND but also supports DX8 sound effects.
;                  |$ESOD_DIRECT_SOUND   - DirectSound sound output driver, windows only.
;                  +This uses DirectSound 3 or above, if available. If DX8 sound effects are needed, use ESOD_DIRECT_SOUND_8 instead.
;                  +The ESOD_DIRECT_SOUND driver may be available on more and older windows versions than ESOD_DIRECT_SOUND_8.
;                  |$ESOD_WIN_MM         - WinMM sound output driver, windows only.
;                  +Supports the ISoundMixedOutputReceiver interface using setMixedDataOutputReceiver.
;                  |$ESOD_NULL           - Null driver, creating no sound output.
; Return values .: Success - True
;                  Failure - False.
;                  |@error 1 ~ 4 - AutoIt Failed DllCall
;                  |@error 5     - AutoIt Failed to find IrrKlangWrapper.dll and or IrrKlang.dll at the specified path
; Author ........:
; Modified.......:
; Remarks .......: The Device IDs in this list can be used as parameter to _AIK_EngineStart to make irrKlang use a special sound device.
;                  You can use other List functions to retrieve the available Device Count, Descriptions and IDs.
;                  After you don't need the list anymore, call _AIK_ListDrop in order to free its memory.
;                  Only one Device List may be created at any time (this is a wrapper limitation by design).
;                  Creating a second Device List will automatically drop the first Device List freeing its memory.
;                  This function can be called without calling _AIK_EngineStart.
;                  If for some reason a user is creating a Device List without ever needing to call _AIK_EngineStart then
;                  the user should call _AIK_EngineStop() when finished with device list functions to close IrrKlang.
; Related .......: _AIK_ListDrop, _AIK_ListGetDeviceCount, _AIK_ListGetDeviceDescription, _AIK_ListGetDeviceID
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_ListCreateSoundDeviceList($sDllPath = @ScriptDir, $iOutputDriver = $ESOD_AUTO_DETECT)
	If $_AIKDll = -1 Then __Init_IrrKlangDll($sDllPath)
	If $_AIKDll = -1 Then Return SetError(5, 0, False)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "ListCreateSoundDeviceList", "uint", $iOutputDriver)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_ListDrop
; Description ...: Drops a current Device List freeing the memory it used.
; Syntax.........: _AIK_ListDrop()
; Parameters ....: None.
; Return values .: Success - True
;                  Failure - False.
; Author ........:
; Modified.......:
; Remarks .......: None.
; Related .......: _AIK_ListCreateAudioRecorderDeviceList, _AIK_ListCreateSoundDeviceList
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_ListDrop()
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "ListDrop")
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_ListGetDeviceCount
; Description ...: Get a count of enumerated devices in the list.
; Syntax.........: _AIK_ListGetDeviceCount()
; Parameters ....: None.
; Return values .: Success - The amount of devices in the Device List.
; Author ........:
; Modified.......:
; Remarks .......: None.
; Related .......: _AIK_ListCreateAudioRecorderDeviceList, _AIK_ListCreateSoundDeviceList, _AIK_ListGetDeviceDescription,_AIK_ListGetDeviceID
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_ListGetDeviceCount()
    Local $aReturn = DllCall($_AIKDll, "int:cdecl", "ListGetDeviceCount")
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_ListGetDeviceDescription
; Description ...: Get a description of the device in the Device List.
; Syntax.........: _AIK_ListGetDeviceDescription($iIndex)
; Parameters ....: $iIndex - Index in the Device List to get the description for.
;                  +A value between 0 and _AIK_ListGetDeviceCount()-1.
; Return values .: Success - String containing the device description.
;                  Failure - 0
; Author ........:
; Modified.......:
; Remarks .......: Index 0 of the list will return the Device Description of "default device" and an Device ID as an empty string "".
; Related .......: _AIK_ListCreateAudioRecorderDeviceList, _AIK_ListCreateSoundDeviceList, _AIK_ListGetDeviceCount
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_ListGetDeviceDescription($iIndex)
    Local $aReturn = DllCall($_AIKDll, "str:cdecl", "ListGetDeviceDescription", "int", $iIndex)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_ListGetDeviceID
; Description ...: Get the ID of the device in the Device List.
; Syntax.........: _AIK_ListGetDeviceID($iIndex)
; Parameters ....: $iIndex - Index in the Device List to get the Device ID for.
;                  +A value between 0 and _AIK_ListGetDeviceCount()-1.
; Return values .: Success - String containing the Device ID.
;                  Failure - 0
; Author ........:
; Modified.......:
; Remarks .......: Index 0 of the list will return the Device Description of "default device" and an Device ID as an empty string "".
;                  Use the returned Device ID with _AIK_EngineStart if the Device List was created with _AIK_ListCreateSoundDeviceList,
;                  or _AIK_RecorderCreateAudioRecorder if _AIK_ListCreateAudioRecorderDeviceList was used to create the Device List.
; Related .......: _AIK_ListCreateAudioRecorderDeviceList, _AIK_ListCreateSoundDeviceList, _AIK_ListGetDeviceCount
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_ListGetDeviceID($iIndex)
    Local $aReturn = DllCall($_AIKDll, "str:cdecl", "ListGetDeviceID", "int", $iIndex)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_RecorderAddSoundSourceFromRecordedAudio
; Description ...: Creates a sound source from the recorded audio data.
; Syntax.........: _AIK_RecorderAddSoundSourceFromRecordedAudio([$sSoundName = "RecordedAudio"])
; Parameters ....: $sSoundName - [optional] Name of the virtual sound file (e.g. "RecordedAudio").
;                  +You can also use this name when calling _AIK_EnginePlay2DName or _AIK_EnginePlay3DName.
; Return values .: Success - Pointer to a sound source.
;                  Failure - 0
; Author ........:
; Modified.......:
; Remarks .......: The returned sound source pointer then can be used to play back the recorded audio data using
;                  _AIK_EnginePlay2DSource or _AIK_EnginePlay3DSource.
;                  This method only will succeed if the audio was recorded using _AIK_RecorderStartRecordingBufferedAudio and
;                  audio recording is currently stopped.
; Related .......: _AIK_RecorderClearRecordedAudioDataBuffer, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_RecorderAddSoundSourceFromRecordedAudio($sSoundName = "RecordedAudio")
	Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "RecorderAddSoundSourceFromRecordedAudio", "str", $sSoundName)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_RecorderClearRecordedAudioDataBuffer
; Description ...: Clears recorded audio data buffer, freeing memory.
; Syntax.........: _AIK_RecorderClearRecordedAudioDataBuffer()
; Parameters ....: None.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: This method will only succeed if audio recording is currently stopped.
; Related .......: _AIK_RecorderStopRecordingAudio
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_RecorderClearRecordedAudioDataBuffer()
	Local $aReturn = DllCall($_AIKDll, "none:cdecl", "RecorderClearRecordedAudioDataBuffer")
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_RecorderCreateAudioRecorder
; Description ...: Creates an irrKlang audio recording device.
; Syntax.........: _AIK_RecorderCreateAudioRecorder($iOutputDriver = $ESOD_AUTO_DETECT, $sDeviceID = 0)
; Parameters ....: $iOutputDriver - [optional] The sound output driver to be used for recording audio. (Default: $ESOD_AUTO_DETECT)
;                  |$ESOD_AUTO_DETECT    - Autodetects the best sound driver for the system.
;                  |$ESOD_DIRECT_SOUND_8 - DirectSound8 sound output driver, windows only.
;                  +In contrast to ESOD_DIRECT_SOUND, this supports sophisticated sound effects but may not be available on old windows versions.
;                  +It behaves very similar to ESOD_DIRECT_SOUND but also supports DX8 sound effects.
;                  |$ESOD_DIRECT_SOUND   - DirectSound sound output driver, windows only.
;                  +This uses DirectSound 3 or above, if available. If DX8 sound effects are needed, use ESOD_DIRECT_SOUND_8 instead.
;                  +The ESOD_DIRECT_SOUND driver may be available on more and older windows versions than ESOD_DIRECT_SOUND_8.
;                  |$ESOD_WIN_MM         - WinMM sound output driver, windows only.
;                  +Supports the ISoundMixedOutputReceiver interface using setMixedDataOutputReceiver.
;                  |$ESOD_NULL           - Null driver, creating no sound output.
;                  $sDeviceID - [optional] Some additional optional deviceID for the audio driver. (Default: 0)
; Return values .: Success - True.
;                  Failure - False.
; Author ........:
; Modified.......:
; Remarks .......: Only one recorder device is supported by this wrapper.
;                  _AIK_EngineStart needs to be called at least once before trying to create a recorder.
;                  A user should call _AIK_RecorderDrop when finished with the recorder to close the recorder and free it's resources.
; Related .......: _AIK_RecorderDrop
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_RecorderCreateAudioRecorder($iOutputDriver = $ESOD_AUTO_DETECT, $sDeviceID = 0)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "RecorderCreateAudioRecorder", "uint", $iOutputDriver, "str", $sDeviceID)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_RecorderDrop
; Description ...: Close the recorder, freeing it's memory.
; Syntax.........: _AIK_RecorderDrop()
; Parameters ....: None.
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: None.
; Related .......: _AIK_RecorderCreateAudioRecorder
; Link ..........:
; Example .......: [todo: Yes, No]
; ===============================================================================================================================
Func _AIK_RecorderDrop()
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "RecorderDrop")
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_RecorderGetAudioFormat
; Description ...: Get informations about a sound source.
; Syntax.........: _AIK_RecorderGetAudioFormat()
; Parameters ....: None
; Return values .: Success - Array containg the following:
;                  |$Array[0] - ChannelCount
;                  |$Array[1] - FrameCount
;                  |$Array[2] - SampleRate
;                  |$Array[3] - SampleFormat
;                  |$Array[4] - SampleSize
;                  |$Array[5] - FrameSize
;                  |$Array[6] - SampleDataSize
;                  |$Array[7] - BytesPerSecond
;                  Failure - Array containg no data.
; Author ........:
; Modified.......:
; Remarks .......:  Also contains informations about the length of the recorded audio stream.
; Related .......: _AIK_RecorderCreateAudioRecorder
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_RecorderGetAudioFormat()
    Local $aReturn, $aFormat[8]
    $aReturn = DllCall($_AIKDll, "none:cdecl", "RecorderGetAudioFormat", _
													"int*", 0, _ ; ChannelCount
													"int*", 0, _ ; FrameCount
													"int*", 0, _ ; SampleRate
													"int*", 0, _ ; SampleFormat
													"int*", 0, _ ; SampleSize
													"int*", 0, _ ; FrameSize
													"int*", 0, _ ; SampleDataSize
													"int*", 0)   ; BytesPerSecond
	If @error Then Return SetError(@error, 0, $aFormat)
	For $i = 0 To Ubound($aFormat) - 1
		$aFormat[$i] = $aReturn[$i + 1]
	Next
    Return SetError(0, 0, $aFormat)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_RecorderGetDriverName
; Description ...: Get the name of the sound driver the recorder is using.
; Syntax.........: _AIK_RecorderGetDriverName()
; Parameters ....: None.
; Return values .: Success - String name of the driver being used (See Remarks).
;                  Failure - 0
; Author ........:
; Modified.......:
; Remarks .......: Possible returned strings are "NULL", "ALSA", "CoreAudio", "winMM", "DirectSound" and "DirectSound8".
; Related .......: _AIK_RecorderCreateAudioRecorder
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_RecorderGetDriverName()
	Local $aReturn = DllCall($_AIKDll, "str:cdecl", "RecorderGetDriverName")
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_RecorderGetRecordedAudioData
; Description ...: Get a pointer to the recorded audio data.
; Syntax.........: _AIK_RecorderGetRecordedAudioData()
; Parameters ....: None.
; Return values .: Success - Pointer to the recorded audio data. (See Remarks)
;                  Failure - 0
; Author ........:
; Modified.......:
; Remarks .......: This method will only succeed if audio recording is currently stopped and something was
;                  recorded previously using _AIK_RecorderStartRecordingBufferedAudio.
;                  The lenght of the buffer can be retrieved using _AIK_RecorderGetAudioFormat.
;                  The pointer is only valid as long as not _AIK_RecorderClearRecordedAudioDataBuffer is called or another sample is recorded.
; Related .......: _AIK_RecorderCreateAudioRecorder, _AIK_RecorderStartRecordingBufferedAudio, _AIK_RecorderGetAudioFormat, _AIK_RecorderStopRecordingAudio
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_RecorderGetRecordedAudioData()
	Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "RecorderGetRecordedAudioData")
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_RecorderIsRecording
; Description ...: See if the recorder is currently recording audio.
; Syntax.........: _AIK_RecorderIsRecording()
; Parameters ....: None.
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: None.
; Related .......: _AIK_RecorderCreateAudioRecorder, _AIK_RecorderStartRecordingBufferedAudio
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_RecorderIsRecording()
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "RecorderIsRecording")
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_RecorderSaveRecordedAudio
; Description ...: Save recorded audio to a *.wav file.
; Syntax.........: _AIK_RecorderSaveRecordedAudio([$sFileName = "RecordedAudio.wav"])
; Parameters ....: $sFileName - Name to save the recorded data as (eg: @ScriptDir & "\RecordedAudio.wav")
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: This function is not part of the IrrKlang engine and has been added to the wrapper for ease of use.
;                  Currently this function can only save as *.wav format.
; Related .......: _AIK_RecorderCreateAudioRecorder, _AIK_RecorderStartRecordingBufferedAudio, _AIK_RecorderStopRecordingAudio
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_RecorderSaveRecordedAudio($sFileName = "RecordedAudio.wav")
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "RecorderSaveRecordedAudio", "str", $sFileName)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(@error, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_RecorderStartRecordingBufferedAudio
; Description ...: Start recording audio.
; Syntax.........: _AIK_RecorderStartRecordingBufferedAudio([$iSampleRate = 22050[, $iSampleFormat = $ESF_S16[, $iChannelCount = 1]]])
; Parameters ....: $iSampleRate - [optional Sample rate of the recorded audio. (eg: 8000, 11025, 16000, 22050, 44100, 48000)
;                  $iSampleFormat - [optional Sample format of the recorded audio. Either $ESF_U8 or $ESF_S16
;                  $iChannelCount - [optional Amount of audio channels. Either 1 or 2 (1 mono / 2 stereo)
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: None.
; Related .......: _AIK_RecorderCreateAudioRecorder, _AIK_RecorderStopRecordingAudio
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_RecorderStartRecordingBufferedAudio($iSampleRate = 22050,$iSampleFormat = $ESF_S16, $iChannelCount = 1)
	Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "RecorderStartRecordingBufferedAudio", "int", $iSampleRate, "int", $iSampleFormat, "int", $iChannelCount)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_RecorderStopRecordingAudio
; Description ...: Stop recording audio.
; Syntax.........: _AIK_RecorderStopRecordingAudio()
; Parameters ....: None.
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: None.
; Related .......: _AIK_RecorderCreateAudioRecorder, _AIK_RecorderStartRecordingBufferedAudio
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_RecorderStopRecordingAudio()
	DllCall($_AIKDll, "none:cdecl", "RecorderStopRecordingAudio")
	Return SetError(@error, 0, @error = 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundDrop
; Description ...: Drop a sound to free it's memory.
; Syntax.........: _AIK_SoundDrop($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundDrop($hSound)
    DllCall($_AIKDll, "none:cdecl", "SoundDrop", "uint_ptr", $hSound)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundGetIsPaused
; Description ...: Get if the sound is paused.
; Syntax.........: _AIK_SoundGetIsPaused($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - True if sound is paused, False if not.
; Author ........:
; Modified.......:
; Remarks .......: To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundSetIsPaused, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundGetIsPaused($hSound)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "SoundGetIsPaused", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundGetMaxDistance
; Description ...: Get the maximal distance if this is a 3D sound.
; Syntax.........: _AIK_SoundGetMaxDistance($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - Float value of the sounds max distance.
; Author ........:
; Modified.......:
; Remarks .......: See _AIK_SoundSetMaxDistance for details.
;                  To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundGetMinDistance, _AIK_SoundSetMinDistance, _AIK_SoundSetMaxDistance, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundGetMaxDistance($hSound)
    Local $aReturn = DllCall($_AIKDll, "float:cdecl", "SoundGetMaxDistance", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundGetMinDistance
; Description ...: Get the minimal distance if this is a 3D sound.
; Syntax.........: _AIK_SoundGetMinDistance($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - Float value of the sounds min distance.
; Author ........:
; Modified.......:
; Remarks .......: See _AIK_SoundSetMinDistance for details.
;                  To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundGetMaxDistance, _AIK_SoundSetMinDistance, _AIK_SoundSetMaxDistance, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundGetMinDistance($hSound)
    Local $aReturn = DllCall($_AIKDll, "float:cdecl", "SoundGetMinDistance", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundGetPan
; Description ...: Get the pan of the sound.
; Syntax.........: _AIK_SoundGetPan($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - Float value between -1 and 1, 0 is center.
; Author ........:
; Modified.......:
; Remarks .......: To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundSetPan, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundGetPan($hSound)
    Local $aReturn = DllCall($_AIKDll, "float:cdecl", "SoundGetPan", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundGetPlaybackSpeed
; Description ...: Get the playback speed set by _AIK_SoundSetPlaybackSpeed.
; Syntax.........: _AIK_SoundGetPlaybackSpeed($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - Float value.
; Author ........:
; Modified.......:
; Remarks .......: The default playback speed of a sound is 1. See _AIK_SoundSetPlaybackSpeed for details.
;                  To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundSetPlaybackSpeed, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundGetPlaybackSpeed($hSound)
    Local $aReturn = DllCall($_AIKDll, "float:cdecl", "SoundGetPlaybackSpeed", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundGetPlayLength
; Description ...: Get the play length of the sound in milliseconds.
; Syntax.........: _AIK_SoundGetPlayLength($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - Play length in milliseconds.
;                  Failure - -1 if not known for this sound for example because its decoder does not support
;                  +length reporting or it is a file stream of unknown size.
; Author ........:
; Modified.......:
; Remarks .......: You can also use _AIK_SourceGetPlayLength to get the length of a sound without actually needing to play it.
;                  To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource, _AIK_SourceGetPlayLength
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundGetPlayLength($hSound)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "SoundGetPlayLength", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, -1)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundGetPlayPosition
; Description ...: Get the current play position of the sound in milliseconds.
; Syntax.........: _AIK_SoundGetPlayPosition($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - Play position in milliseconds.
;                  Failure - -1 if not implemented or possible for this sound for example because it
;                  +already has been stopped and freed internally or similar.
; Author ........:
; Modified.......:
; Remarks .......: To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundSetPlayPosition, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundGetPlayPosition($hSound)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "SoundGetPlayPosition", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, -1)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundGetPosition
; Description ...: Get the position of the sound in 3d space.
; Syntax.........: _AIK_SoundGetPosition($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - Array containing X, Y, Z float values as follows.
;                  |$aXYZ[0] - X Position
;                  |$aXYZ[1] - Y Position
;                  |$aXYZ[2] - Z Position
;                  Failure - Array containing no data.
; Author ........:
; Modified.......:
; Remarks .......: To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundSetPosition, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundGetPosition($hSound)
    Local $aReturn, $aXYZ[3]
	$aReturn = DllCall($_AIKDll, "none:cdecl", "SoundGetPosition", "uint_ptr", $hSound, "float*", 0, "float*", 0, "float*", 0)
	If @error Then Return SetError(@error, 0, $aXYZ)
	For $i = 0 To Ubound($aXYZ) - 1
		$aXYZ[$i] = $aReturn[$i + 2]
	Next
	Return SetError(0, 0, $aXYZ)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundGetSoundSource
; Description ...: Get source of the sound which stores the filename and other informations about that sound.
; Syntax.........: _AIK_SoundGetSoundSource($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - Pointer to the Sound Source.
;                  Failure - 0 if the sound source has been removed.
; Author ........:
; Modified.......:
; Remarks .......: To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundGetSoundSource($hSound)
    Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "SoundGetSoundSource", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundGetVelocity
; Description ...: Get the velocity of the sound in 3d space, needed for Doppler effects.
; Syntax.........: _AIK_SoundGetVelocity($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - Array containing X, Y, Z float values as follows.
;                  |$aXYZ[0] - X Velocity
;                  |$aXYZ[1] - Y Velocity
;                  |$aXYZ[2] - Z Velocity
;                  Failure - Array containing no data.
; Author ........:
; Modified.......:
; Remarks .......: To use doppler effects use _AIK_SoundSetVelocity to set a sounds velocity, _AIK_EngineSetListenerPosition to set the
;                  listeners velocity and _AIK_EngineSetDopplerEffectParameters to adjust two parameters influencing the doppler effects intensity.
;                  To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundSetVelocity, AIK_EngineSetDopplerEffectParameters, _AIK_EngineSetListenerPosition, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _AIK_SoundGetVelocity($hSound)
    Local $aReturn, $aXYZ[3]
	$aReturn = DllCall($_AIKDll, "none:cdecl", "SoundGetVelocity", "uint_ptr", $hSound, "float*", 0, "float*", 0, "float*", 0)
	If @error Then Return SetError(@error, 0, $aXYZ)
	For $i = 0 To Ubound($aXYZ) - 1
		$aXYZ[$i] = $aReturn[$i + 2]
	Next
	Return SetError(0, 0, $aXYZ)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundGetVolume
; Description ...: Get the volume of a sound.
; Syntax.........: _AIK_SoundGetVolume($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - float value between 0 (mute) and 1 (full volume).
; Author ........:
; Modified.......:
; Remarks .......: To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundSetVolume, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundGetVolume($hSound)
    Local $aReturn = DllCall($_AIKDll, "float:cdecl", "SoundGetVolume", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundIsFinished
; Description ...: See if the sound has finished playing.
; Syntax.........: _AIK_SoundIsFinished($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - True if sound is finished playing, False if not.
; Author ........:
; Modified.......:
; Remarks .......: Don't mix this up with _AIK_SoundGetIsPaused. _AIK_SoundIsFinished returns if the sound has been finished playing.
;                  If it has, is maybe already have been removed from the playing list of the sound engine and calls to any other
;                  of the methods of ISound will not have any result. If you call _AIK_SoundStop to a playing sound will result
;                  that this function will return True when invoked.
;                  To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundIsFinished($hSound)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "SoundIsFinished", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundIsLooped
; Description ...: See if the sound has been started to play looped.
; Syntax.........: _AIK_SoundIsLooped($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: Success - True if sound is looped, False if not.
; Author ........:
; Modified.......:
; Remarks .......: To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundSetIsLooped, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundIsLooped($hSound)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "SoundIsLooped", "uint_ptr", $hSound)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundSetIsLooped
; Description ...: Set the loop mode of the sound.
; Syntax.........: _AIK_SoundSetIsLooped($hSound, $iLoop)
; Parameters ....: $hSound - Pointer to a Sound.
;                  $iLoop - True to set the sound Looped, False turn off Looping of the sound.
; Return values .: None
; Author ........:
; Modified.......:
; Remarks .......: If the sound is playing looped and it is changed to not-looped, then it will stop playing after the loop has finished.
;                  If it is not looped and changed to looped, the sound will start repeating to be played when it reaches its end.
;                  Invoking this method will not have an effect when the sound already has stopped.
;                  To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundIsLooped, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundSetIsLooped($hSound, $iLoop)
    DllCall($_AIKDll, "none:cdecl", "SoundSetIsLooped", "uint_ptr", $hSound, "uint", $iLoop)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundSetIsPaused
; Description ...: Set the sound paused or unpaused.
; Syntax.........: _AIK_SoundSetIsPaused($hSound, $iPause)
; Parameters ....: $hSound - Pointer to a Sound.
;                  $iPause - True to set the sound paused, False to unpause the sound.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundGetIsPaused, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundSetIsPaused($hSound, $iPause)
    DllCall($_AIKDll, "none:cdecl", "SoundSetIsPaused", "uint_ptr", $hSound, "uint", $iPause)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundSetMaxDistance
; Description ...: Set the maximal distance if this is a 3D sound.
; Syntax.........: _AIK_SoundSetMaxDistance($hSound, $iMaxDistance)
; Parameters ....: $hSound - Pointer to a Sound.
;                  $iMaxDistance - float value.
; Return values .: None
; Author ........:
; Modified.......:
; Remarks .......: Changing this value is usually not necessary. Use _AIK_SoundSetMinDistance instead.
;                  Don't change this value if you don't know what you are doing:
;                  This value causes the sound to stop attenuating after it reaches the max distance.
;                  Most people think that this sets the volume of the sound to 0 after this distance, but this is not true.
;                  Only change the minimal distance (using for example _AIK_SoundSetMinDistance) to influence this.
;                  The maximum distance for a sound source is the distance beyond which the sound does not get any quieter.
;                  The default minimum distance is 1, the default max distance is a huge number like 1000000000.0
;                  To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundGetMinDistance, _AIK_SoundGetMaxDistance, _AIK_SoundSetMinDistance, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundSetMaxDistance($hSound, $iMaxDistance)
    DllCall($_AIKDll, "none:cdecl", "SoundSetMaxDistance", "uint_ptr", $hSound, "float", $iMaxDistance)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundSetMinDistance
; Description ...: Set the minimal distance if this is a 3D sound.
; Syntax.........: _AIK_SoundSetMinDistance($hSound, $iMinDistance)
; Parameters ....: $hSound - Pointer to a Sound.
;                  $iMinDistance - float value.
; Return values .: None
; Author ........:
; Modified.......:
; Remarks .......: Changes the distance at which the 3D sound stops getting louder.
;                  This works like this: As a listener approaches a 3D sound source, the sound gets louder.
;                  Past a certain point, it is not reasonable for the volume to continue to increase.
;                  Either the maximum (zero) has been reached, or the nature of the sound source imposes a logical limit.
;                  This is the minimum distance for the sound source. Similarly, the maximum distance for a sound source is
;                  the distance beyond which the sound does not get any quieter. The default minimum distance is 1,
;                  the default max distance is a huge number like 1000000000.0
;                  To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundGetMinDistance, _AIK_SoundGetMaxDistance, _AIK_SoundSetMaxDistance, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundSetMinDistance($hSound, $iMinDistance)
    DllCall($_AIKDll, "none:cdecl", "SoundSetMinDistance", "uint_ptr", $hSound, "float", $iMinDistance)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundSetPan
; Description ...: Set the pan of a sound.
; Syntax.........: _AIK_SoundSetPan($hSound, $iPan)
; Parameters ....: $hSound - Pointer to a Sound.
;                  $iPan - Float value. (Min: -1, Max: 1, Center: 0)
; Return values .: None
; Author ........:
; Modified.......:
; Remarks .......: To retrieve a pointer to a sound then see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundGetPan, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundSetPan($hSound, $iPan)
    DllCall($_AIKDll, "none:cdecl", "SoundSetPan", "uint_ptr", $hSound, "float", $iPan)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundSetPlaybackSpeed
; Description ...: Set the playback speed (frequency) of the sound.
; Syntax.........: _AIK_SoundSetPlaybackSpeed($hSound[, $iSpeed = 1.0])
; Parameters ....: $hSound - Pointer to a Sound.
;                  $iSpeed - [optional] Factor of the speed increase or decrease. (Default: 1.0) 2 is twice as fast, 0.5 is only half as fast.
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: Plays the sound at a higher or lower speed, increasing or decreasing its frequency which makes it sound lower or higher.
;                  This feature is not available on all sound output drivers (it is on the DirectSound drivers at least), and it does
;                  not work together with the 'EnableSoundEffects' parameter of _AIK_EnginePlay2D and _AIK_EnginePlay3D when using DirectSound.
;                  To retrieve a pointer to a sound then see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundGetPlaybackSpeed, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundSetPlaybackSpeed($hSound, $iSpeed)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "SoundSetPlaybackSpeed", "uint_ptr", $hSound, "float", $iSpeed)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundSetPlayPosition
; Description ...: Set the current play position of the sound in milliseconds.
; Syntax.........: _AIK_SoundSetPlayPosition($hSound, $iPosition)
; Parameters ....: $hSound - Pointer to a Sound.
;                  $iPosition - Position in milliseconds. Must be between 0 and the value returned by getPlayPosition().
; Return values .: Success - True
;                  Failure - False
; Author ........:
; Modified.......:
; Remarks .......: False is returned for example if the sound already finished playing and is stopped or the audio source is not seekable,
;                  for example if it is an internet stream or a a file format not supporting seeking (a .MOD file for example).
;                  A file can be tested if it can bee seeking using _AIK_SourceGetIsSeekingSupported.
;                  To retrieve a pointer to a sound then see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundGetPlayPosition, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource, _AIK_SourceGetIsSeekingSupported
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundSetPlayPosition($hSound, $iPosition)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "SoundSetPlayPosition", "uint_ptr", $hSound, "uint", $iPosition)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundSetPosition
; Description ...: Set the position of the sound in 3d space.
; Syntax.........: _AIK_SoundSetPosition($hSound, $iPosX, $iPosY, $iPosZ)
; Parameters ....: $hSound - Pointer to a Sound.
;                  $iPosX - X Position float value.
;                  $iPosY - Y Position float value.
;                  $iPosZ - Z Position float value.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundGetPosition, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundSetPosition($hSound, $iPosX, $iPosY, $iPosZ)
    DllCall($_AIKDll, "none:cdecl", "SoundSetPosition", "uint_ptr", $hSound, "float", $iPosX, "float", $iPosY, "float", $iPosZ)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundSetVelocity
; Description ...: Set the velocity of the sound in 3d space, needed for Doppler effects.
; Syntax.........: _AIK_SoundSetVelocity($hSound, $iVelX, $iVelY, $$iVelZ)
; Parameters ....: $hSound - Pointer to a Sound.
;                  $iVelX - X Velocity float value.
;                  $iVelY - Y Velocity float value.
;                  $iVelZ - Z Velocity float value.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: To use doppler effects use _AIK_SoundSetVelocity to set a sounds velocity,
;                  _AIK_EngineSetListenerPosition to set the listeners velocity and _AIK_EngineSetDopplerEffectParameters
;                  to adjust two parameters influencing the doppler effects intensity.
; Related .......: _AIK_SoundGetVelocity, _AIK_EngineSetDopplerEffectParameters, _AIK_EngineSetListenerPosition, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _AIK_SoundSetVelocity($hSound, $iVelX, $iVelY, $iVelZ)
    DllCall($_AIKDll, "none:cdecl", "SoundSetVelocity", "uint_ptr", $hSound, "float", $iVelX, "float", $iVelY, "float", $iVelZ)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundSetVolume
; Description ...: Set the volume of the sound.
; Syntax.........: _AIK_SoundSetVolume($hSound, $iVolume)
; Parameters ....: $hSound - Pointer to a Sound.
;                  $iVolume - Float value between 0 (mute) and 1 (full volume).
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: This volume gets multiplied with the master volume of the sound engine and
;                  other parameters like distance to listener when played as 3d sound.
;                  To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_SoundGetVolume, _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundSetVolume($hSound, $iVolume)
    DllCall($_AIKDll, "none:cdecl", "SoundSetVolume", "uint_ptr", $hSound, "float", $iVolume)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SoundStop
; Description ...: Stop the sound and free its resources.
; Syntax.........: _AIK_SoundStop($hSound)
; Parameters ....: $hSound - Pointer to a Sound.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: If you just want to pause the sound, use _AIK_SoundSetIsPaused.
;                  After calling _AIK_SoundStop, _AIK_SoundIsFinished will usually return True.
;                  To retrieve a pointer to a sound see _AIK_EnginePlayXXXXXX (XXXXXX being 2D or 3D Name or Source).
; Related .......: _AIK_EnginePlay2DName, _AIK_EnginePlay2DSource, _AIK_EnginePlay3DName, _AIK_EnginePlay3DSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SoundStop($hSound)
    DllCall($_AIKDll, "none:cdecl", "SoundStop", "uint_ptr", $hSound)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceForceReloadAtNextUse
; Description ...: Forces the sound to be reloaded at next replay.
; Syntax.........: _AIK_SourceForceReloadAtNextUse($hSource)
; Parameters ....: $hSource - Pointer to a Sound Source.
; Return values .: None
; Author ........:
; Modified.......:
; Remarks .......: Sounds which are not played as streams are buffered to make it possible to replay them without much overhead.
;                  If the sound file is altered after the sound has been played the first time,
;                  the engine won't play the changed file then.
;                  Calling this method makes the engine reload the file before the file is played the next time.
; Related .......:  _AIK_EngineAddSoundSourceFromFile
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceForceReloadAtNextUse($hSource)
    DllCall($_AIKDll, "none:cdecl", "SourceForceReloadAtNextUse", "uint_ptr", $hSource)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceGetAudioFormat
; Description ...: Get informations about a sound source.
; Syntax.........: _AIK_SourceGetAudioFormat($hSource)
; Parameters ....: $hSource - Pointer to a Sound Source.
; Return values .: Success - Array containg the following:
;                  |$Array[0] - ChannelCount
;                  |$Array[1] - FrameCount
;                  |$Array[2] - SampleRate
;                  |$Array[3] - SampleFormat
;                  |$Array[4] - SampleSize
;                  |$Array[5] - FrameSize
;                  |$Array[6] - SampleDataSize
;                  |$Array[7] - BytesPerSecond
;                  Failure - Array containg no data.
; Author ........:
; Modified.......:
; Remarks .......: If the sound has never been played before, the sound engine will have to open the file and
;                  try to get the play lenght from there, so this call could take a bit depending on the type of file.
; Related .......: _AIK_EngineAddSoundSourceFromFile, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineGetSoundSourceByIndex, _AIK_EngineGetSoundSourceByName, _AIK_SoundGetSoundSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceGetAudioFormat($hSource)
    Local $aReturn, $aFormat[8]
    $aReturn = DllCall($_AIKDll, "none:cdecl", "SourceGetAudioFormat", "uint_ptr", $hSource, _
													"int*", 0, _ ; ChannelCount
													"int*", 0, _ ; FrameCount
													"int*", 0, _ ; SampleRate
													"int*", 0, _ ; SampleFormat
													"int*", 0, _ ; SampleSize
													"int*", 0, _ ; FrameSize
													"int*", 0, _ ; SampleDataSize
													"int*", 0)   ; BytesPerSecond
	If @error Then Return SetError(@error, 0, $aFormat)
	For $i = 0 To Ubound($aFormat) - 1
		$aFormat[$i] = $aReturn[$i + 2]
	Next
    Return SetError(0, 0, $aFormat)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceGetDefaultMaxDistance
; Description ...: Get the default maxmial distance for 3D sounds played from this source.
; Syntax.........: _AIK_SourceGetDefaultMaxDistance($hSource)
; Parameters ....: $hSource - Pointer to a Sound Source.
; Return values .: Success - Float value of the default maximal distance for 3D sounds from this source.
; Author ........:
; Modified.......:
; Remarks .......: If _AIK_SourceSetDefaultMaxDistance was set to a negative value, it will return the default value
;                  set in the engine, using _AIK_EngineSetDefault3DSoundMaxDistance.
;                  Default value is -1, causing the default max distance of the sound engine to take effect.
; Related .......: _AIK_SourceGetDefaultMinDistance, _AIK_SourceSetDefaultMaxDistance, _AIK_SourceSetDefaultMinDistance, _AIK_EngineGetDefault3DSoundMaxDistance, _AIK_EngineGetDefault3DSoundMinDistance, _AIK_EngineSetDefault3DSoundMaxDistance, _AIK_EngineSetDefault3DSoundMinDistance
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceGetDefaultMaxDistance($hSource)
    Local $aReturn = DllCall($_AIKDll, "float:cdecl", "SourceGetDefaultMaxDistance", "uint_ptr", $hSource)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceGetDefaultMinDistance
; Description ...: Get the default minimal distance for 3D sounds played from this source.
; Syntax.........: _AIK_SourceGetDefaultMinDistance($hSource)
; Parameters ....: $hSource - Pointer to a Sound Source.
; Return values .: Success - Float value of the default minimal distance for 3d sounds from this source.
; Author ........:
; Modified.......:
; Remarks .......: If _AIK_SourceSetDefaultMinDistance was set to a negative value, it will return the default value
;                  set in the engine, using _AIK_EngineSetDefault3DSoundMinDistance.
;                  Default value is -1, causing the default min distance of the sound engine to take effect.
; Related .......: _AIK_SourceGetDefaultMaxDistance, _AIK_SourceSetDefaultMaxDistance, _AIK_SourceSetDefaultMinDistance, _AIK_EngineGetDefault3DSoundMaxDistance, _AIK_EngineGetDefault3DSoundMinDistance, _AIK_EngineSetDefault3DSoundMaxDistance, _AIK_EngineSetDefault3DSoundMinDistance
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceGetDefaultMinDistance($hSource)
    Local $aReturn = DllCall($_AIKDll, "float:cdecl", "SourceGetDefaultMinDistance", "uint_ptr", $hSource)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceGetDefaultVolume
; Description ...: Get the default volume for a sound played from this source.
; Syntax.........: _AIK_SourceGetDefaultVolume($hSource)
; Parameters ....: $hSource - Pointer to a Sound Source.
; Return values .: Success - Default maximal distance for 3D sounds from this source.
; Author ........:
; Modified.......:
; Remarks .......: You can influence this default volume value using _AIK_SourceSetDefaultVolume.
;                  The default volume is being multiplied with the master volume of Sound Engine, change this via _AIK_EngineSetSoundVolume.
; Related .......: _AIK_SourceSetDefaultVolume, _AIK_EngineGetSoundVolume, _AIK_EngineSetSoundVolume, _AIK_SoundGetVolume, _AIK_SoundSetVolume
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceGetDefaultVolume($hSource)
    Local $aReturn = DllCall($_AIKDll, "float:cdecl", "SourceGetDefaultVolume", "uint_ptr", $hSource)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceGetForcedStreamingThreshold
; Description ...: Get the threshold size where irrKlang decides to force streaming a file independent of the user specified setting.
; Syntax.........: _AIK_SourceGetForcedStreamingThreshold($hSource)
; Parameters ....: $hSource - Pointer to a Sound Source.
; Return values .: Success - Threshold size.
; Author ........:
; Modified.......:
; Remarks .......: The value is specified in uncompressed bytes and its default value is about one Megabyte.
;                  See _AIK_SourceSetForcedStreamingThreshold for details.
; Related .......: _AIK_SourceSetForcedStreamingThreshold
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceGetForcedStreamingThreshold($hSource)
    Local $aReturn = DllCall($_AIKDll, "int:cdecl", "SourceGetForcedStreamingThreshold", "uint_ptr", $hSource)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceGetIsSeekingSupported
; Description ...: Get if sounds played from this source will support seeking.
; Syntax.........: _AIK_SourceGetIsSeekingSupported($hSource)
; Parameters ....: $hSource - Pointer to a Sound Source.
; Return values .: Success - True if seeking is supported, False if not
; Author ........:
; Modified.......:
; Remarks .......: Use this to check if you can use _AIK_SoundSetPlayPosition on a sound source.
; Related .......: _AIK_SoundSetPlayPosition
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceGetIsSeekingSupported($hSource)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "SourceGetIsSeekingSupported", "uint_ptr", $hSource)
	If @error Then Return SetError(@error, 0, False)
	Return SetError(0, 0, $aReturn[0] = 1)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceGetName
; Description ...: Get the name of the sound source (usually, this is the file name).
; Syntax.........: _AIK_SourceGetName($hSource)
; Parameters ....: $hSource - Pointer to a Sound Source.
; Return values .: Success - String containg the name of the sound source.
;                  Failure - An empty string ""
; Author ........:
; Modified.......:
; Remarks .......: None.
; Related .......: _AIK_EngineAddSoundSourceFromFile, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineGetSoundSourceByIndex, _AIK_EngineGetSoundSourceByName, _AIK_SoundGetSoundSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceGetName($hSource)
    Local $aReturn = DllCall($_AIKDll, "str:cdecl", "SourceGetName", "uint_ptr", $hSource)
	If @error Then Return SetError(@error, 0, "")
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceGetPlayLength
; Description ...: Get the play length of the sound in milliseconds.
; Syntax.........: _AIK_SourceGetPlayLength($hSource)
; Parameters ....: $hSource - Pointer to a Sound Source.
; Return values .: Success - Play length of the sound in milliseconds.
;                  Failure - -1 if not known for this sound for example because its decoder does not support lenght reporting or
;                  +it is a file stream of unknown size.
; Author ........:
; Modified.......:
; Remarks .......: None.
; Related .......: _AIK_EngineAddSoundSourceFromFile, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineGetSoundSourceByIndex, _AIK_EngineGetSoundSourceByName, _AIK_SoundGetSoundSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceGetPlayLength($hSource)
    Local $aReturn = DllCall($_AIKDll, "uint:cdecl", "SourceGetPlayLength", "uint_ptr", $hSource)
	If @error Then Return SetError(@error, 0, -1)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceGetSampleData
; Description ...: Get a pointer to the loaded and decoded sample data.
; Syntax.........: _AIK_SourceGetSampleData($hSource)
; Parameters ....: $hSource - Pointer to a Sound Source.
; Return values .: Success - Pointer to the sample data. The data is provided in decoded PCM data. (See Remarks)
;                  Failure - 0
; Author ........:
; Modified.......:
; Remarks .......: The exact format of the Sample Data can be retrieved using _AIK_SourceGetAudioFormat.
;                  The returned pointer will only be valid as long as the sound source exists.
;                  This function will only return a pointer to the data if the audio file is not streamed, namely $ESM_NO_STREAMING.
;                  If you need to override the engines streaming threshold then use _AIK_SourceSetForcedStreamingThreshold.
;                  If the sound has never been played before, the sound engine will have to open the file and decode audio data,
;                  so this call could take a bit depending on the type of the file.
; Related .......: _AIK_SourceSetStreamMode, _AIK_SourceSetForcedStreamingThreshold, _AIK_EngineAddSoundSourceFromFile, _AIK_EngineAddSoundSourceFromMemory, _AIK_EngineAddSoundSourceFromPCMData, _AIK_EngineGetSoundSourceByIndex, _AIK_EngineGetSoundSourceByName, _AIK_SoundGetSoundSource
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceGetSampleData($hSource)
    Local $aReturn = DllCall($_AIKDll, "uint_ptr:cdecl", "SourceGetSampleData", "uint_ptr", $hSource)
	If @error Then Return SetError(@error, 0, 0)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceGetStreamMode
; Description ...: Get the detected or set type of the sound with wich the sound will be played.
; Syntax.........: _AIK_SourceGetStreamMode($hSource)
; Parameters ....: $hSource - Pointer to a Sound Source.
; Return values .: Success - 0 ($ESM_AUTO_DETECT) or 1 ($ESM_STREAMING) or 2 ($ESM_NO_STREAMING)
;                  Failure - -1
; Author ........:
; Modified.......:
; Remarks .......: If the returned type is $ESM_AUTO_DETECT, this mode will change after the sound has been played the first time.
; Related .......: _AIK_SourceSetStreamMode
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceGetStreamMode($hSource)
    Local $aReturn = DllCall($_AIKDll, "int_ptr:cdecl", "SourceGetStreamMode", "uint_ptr", $hSource)
	If @error Then Return SetError(@error, 0, -1)
	Return SetError(0, 0, $aReturn[0])
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceSetDefaultMaxDistance
; Description ...: Set the default maximal distance for 3D sounds played from this source.
; Syntax.........: _AIK_SourceSetDefaultMaxDistance($hSource, $iMaxDistance)
; Parameters ....: $hSource      - Pointer to a Sound Source.
;                  $iMaxDistance - Float value for default maximal distance for 3D sounds from this source.
;                  +Set it to a negative value to let sounds of this source use the engine level default max distance,
;                  +which can be set via I_AIK_SetDefault3DSoundMaxDistance.
;                  +Default value is -1, causing the default max distance of the sound engine to take effect.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: Changing this value is usually not necessary. Use _AIK_SourceSetDefaultMinDistance instead.
;                  Don't change this value if you don't know what you are doing.
;                  This value causes the sound to stop attenuating after it reaches the max distance.
;                  Most people think that this sets the volume of the sound to 0 after this distance, but this is not true.
;                  Only change the minimal distance (using for example _AIK_SourceSetDefaultMinDistance) to influence this.
;                  See _AIK_SetMaxDistance for details about what the max distance is.
;                  This method only influences the initial distance value of sounds.
;                  For changing the distance while the sound is played, use _AIK_SoundSetMinDistance and _AIK_SoundSetMaxDistance.
; Related .......: _AIK_SourceGetDefaultMaxDistance, _AIK_SourceGetDefaultMinDistance, _AIK_SourceSetDefaultMinDistance, _AIK_EngineGetDefault3DSoundMaxDistance, _AIK_EngineGetDefault3DSoundMinDistance, _AIK_EngineSetDefault3DSoundMaxDistance, _AIK_EngineSetDefault3DSoundMinDistance
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceSetDefaultMaxDistance($hSource, $iMaxDistance)
    DllCall($_AIKDll, "none:cdecl", "SourceSetDefaultMaxDistance", "uint_ptr", $hSource, "float", $iMaxDistance)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceSetDefaultMinDistance
; Description ...: Set the default minimal distance for 3D sounds played from this source.
; Syntax.........: _AIK_SourceSetDefaultMinDistance($hSource, $iMinDistance)
; Parameters ....: $hSource      - Pointer to a Sound Source.
;                  $iMaxDistance - Float value for default minimal distance for 3D sounds from this source.
;                  +Set it to a negative value to let sounds of this source use the engine level default min distance,
;                  +which can be set via  _AIK_SetDefault3DSoundMinDistance.
;                  +Default value is -1, causing the default min distance of the sound engine to take effect.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: This value influences how loud a sound is heard based on its distance.
;                  See _AIK_SetMinDistance for details about what the min distance is.
;                  This method only influences the initial distance value of sounds.
;                  For changing the distance while the sound is playing, use _AIK_SoundSetMinDistance and _AIK_SoundSetMaxDistance.
; Related .......: _AIK_SourceGetDefaultMaxDistance, _AIK_SourceGetDefaultMinDistance, _AIK_SourceSetDefaultMaxDistance, _AIK_EngineGetDefault3DSoundMaxDistance, _AIK_EngineGetDefault3DSoundMinDistance, _AIK_EngineSetDefault3DSoundMaxDistance, _AIK_EngineSetDefault3DSoundMinDistance
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceSetDefaultMinDistance($hSource, $iMinDistance)
    DllCall($_AIKDll, "none:cdecl", "SourceSetDefaultMinDistance", "uint_ptr", $hSource, "float", $iMinDistance)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceSetDefaultVolume
; Description ...: Set the default volume for a sound played from this source.
; Syntax.........: _AIK_SourceSetDefaultVolume($hSource, $iMinDistance)
; Parameters ....: $hSource - Pointer to a Sound Source.
;                  $iVolume - Float value for default minimal distance for 3D sounds from this source. (Default: 1.0)
;                  +Set it to a negative value to let sounds of this source use the engine level default min distance,
;                  +which can be set via  _AIK_SetDefault3DSoundMinDistance.
;                  +Default value is -1, causing the default min distance of the sound engine to take effect.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: The default volume is being multiplied with the master volume of the SoundEngine, change this via _AIK_EngineSetSoundVolume
; Related .......: _AIK_SourceGetDefaultVolume, _AIK_EngineGetSoundVolume, _AIK_EngineSetSoundVolume, _AIK_SoundGetVolume, _AIK_SoundSetVolume
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceSetDefaultVolume($hSource, $iVolume = 1.0)
    Local $aReturn = DllCall($_AIKDll, "none:cdecl", "SourceSetDefaultVolume", "uint_ptr", $hSource, "float", $iVolume)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceSetForcedStreamingThreshold
; Description ...: Sets the threshold size where irrKlang decides to force streaming a file independent of the user specified setting.
; Syntax.........: _AIK_SourceSetForcedStreamingThreshold($hSource, $iThresholdBytes)
; Parameters ....: $hSource         - Pointer to a Sound Source.
;                  $iThresholdBytes - The value is specified in uncompressed bytes and its default value is about one Megabyte.
;                  +Set to 0 or a negative value to disable stream forcing.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: When specifying $ESM_NO_STREAMING for playing back a sound file, irrKlang will ignore this setting if
;                  the file is bigger than this threshold and stream the file anyway.
;                  To get the size of the uncompressed source audio data see _AIK_SourceGetAudioFormat, Sample Data Size.
;                  Please note that if an audio format is not able to return the size of a sound source and returns -1 as length,
;                  this will be ignored as well and streaming has to be forced.
; Related .......: _AIK_SourceGetAudioFormat, _AIK_SourceSetStreamMode, _AIK_SourceGetForcedStreamingThreshold
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceSetForcedStreamingThreshold($hSource, $iThresholdBytes)
    DllCall($_AIKDll, "none:cdecl", "SourceSetForcedStreamingThreshold", "uint_ptr", $hSource, "int", $iThresholdBytes)
	Return SetError(@error, 0, 0)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name...........: _AIK_SourceSetStreamMode
; Description ...: Set the stream mode which should be used for a sound played from this source.
; Syntax.........: _AIK_SourceSetStreamMode($hSource, $iStreamMode)
; Parameters ....: $hSource     - Pointer to a Sound Source.
;                  $iStreamMode - Streaming mode for this sound source can be one of the following:
;                  |$ESM_AUTO_DETECT  - Autodetects the best stream mode for a specified audio data.
;                  |$ESM_STREAMING    - Streams the audio data when needed.
;                  |$ESM_NO_STREAMING - Loads the whole audio data into the memory.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: If this is set to ESM_NO_STREAMING, the engine still might decide to stream the sound if it is too big.
;                  The threashold for this can be adjusted using _AIK_SetForcedStreamingThreshold.
;                  To get the size of the uncompressed source audio data see _AIK_SourceGetAudioFormat, Sample Data Size.
; Related .......: _AIK_SourceGetAudioFormat, _AIK_SourceGetStreamMode, _AIK_GetForcedStreamingThreshold, _AIK_SetForcedStreamingThreshold
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _AIK_SourceSetStreamMode($hSource, $iStreamMode)
    DllCall($_AIKDll, "int_ptr:cdecl", "SourceSetStreamMode", "uint_ptr", $hSource, "int", $iStreamMode)
	SetError(@error, 0, 0)
EndFunc


; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __Init_IrrKlangDll($sDllPath)
; Description ...: Opens IrrKlangWrapper.dll ready for use.
; Syntax.........: __Init_IrrKlangDll($sDllPath)
; Parameters ....: $sDllPath - Path where IrrKlangWrapper.dll and irrKlang.dll can be found.
; Return values .: None.
; Author ........:
; Modified.......:
; Remarks .......: This function is used internally by _AIK_EngineStart, _AIK_ListCreateAudioRecorderDeviceList, _AIK_ListCreateSoundDeviceList
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func __Init_IrrKlangDll($sDllPath)
	If $_AIKDll <> -1 Then Return
	If Not FileExists($sDllPath & "\irrKlang.dll") Or Not FileExists($sDllPath & "\AIK.dll") Then
		$_AIKDll = -1
		Return
	EndIf
	If Not StringInStr(EnvGet("PATH"), $sDllPath) Then
		EnvSet("PATH", $sDllPath)
	    EnvUpdate()
	EndIf
	$_AIKDll = DllOpen("AIK.dll")
EndFunc