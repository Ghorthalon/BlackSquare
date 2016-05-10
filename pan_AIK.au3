$ChangedFreq = 0
func generate_pan_2D($Listener_X, $Listener_Y, $source_X, $source_Y, $PanStep, $VolumeStep,  $SoundHandle, $InitVolume = 1)

$delta_x=0;
$delta_y=0;
$final_pan=0;
$final_volume=$InitVolume
if($source_x<$listener_x) then

$delta_x=$listener_x-$source_x;
$final_pan=$Final_Pan-($delta_x*$panstep);
$final_volume=$final_volume-($delta_x*$volumestep);
EndIf
if($source_x>$listener_x) then

$delta_x=$source_x-$listener_x;
$final_pan=$Final_Pan+($delta_x*$panstep);
$final_volume=$final_volume-($delta_x*$volumestep);

EndIf
if($source_y<$listener_y) then


$delta_y=$listener_y-$source_y;
$final_volume=$final_volume-($delta_y*$volumestep);
EndIf
if($source_y>$listener_y) then

$delta_y=$source_y-$listener_y;
$final_volume=$final_volume-($delta_y*$volumestep);
EndIf
if $final_volume < -10000 then $final_volume = -10000
if $final_pan < -10000 then $final_pan = -10000
if $final_pan > 10000 then $final_pan = 10000

_AIK_SoundSetVolume($SoundHandle, $Final_Volume)
_AIK_SoundSetPan($SoundHandle, $Final_Pan)




EndFunc

func generate_pan($your_value, $oponent_value, $panstep, $volumestep, $soundhandle)
$final = 0
$Result1 = $oponent_value-$your_value
$result1 = $result1*$panstep
if $result1 > 10000 then 

$result = 10000


EndIf
if $result1 < -10000 then 

$result = -10000

EndIf
$volume = $oponent_value-$your_value
$volume = $volume*$volumestep
if $volume > 0 then $volume = "-" & $volume
if $volume < -10000 then 

$volume = -10000


EndIf
$final = $result1
if s_getpan($soundhandle) <> $final then s_setpan($soundhandle, $final)
if s_getvolume($soundhandle) <> $volume then s_setvolume($soundhandle, $volume)

EndFunc

func generate_Channel_pan($your_value, $oponent_value, $panstep, $volumestep, $soundhandle, $ChannelHandle)
$final = 0
$Result1 = $oponent_value-$your_value
$result1 = $result1*$panstep
if $result1 > 100 then 

$result = 100

EndIf
if $result1 < -100 then 

$result = -100


EndIf
$volume = 100

$Delta = $oponent_value-$your_value
$volume = $volume-($Delta*$volumestep)

if $volume < 0 then 

$volume = 0


EndIf
$final = $result1

c_pan($soundhandle, $ChannelHandle, $final)
c_volume($soundhandle, $ChannelHandle, $volume)

EndFunc

