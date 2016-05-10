;voiceover script to handle providing speech output, coded by Valiant8086 with PKB games.
;Include this in your script for your application. It will play sounds if it can find them, otherwise it will speak them with sapi. 
;syntax: vo ("string")

#include <file.au3>
#include <sapi.au3>
$digitToSpeak = ""
$hundredth = ""

if fileExists ("fx\speech\0.ogg") = 1 then
$numberFilesExist = "yes"
else
$numberFilesExist = "no"
endIf

func vo ($toSpeak)
$ToHandleNegative = StringSplit($ToSpeak, "")
if $ToHandleNegative[1] = "-" then
SpeakIt ("negative")
$ToSpeak = 0
for $iload = 2 to $ToHandleNegative[0]
$ToSpeak = $ToSpeak & $ToHandlenegative[$iload]
Next
endIf
if stringIsDigit ($toSpeak) = 1 then

if fileExists ("fx\speech\"&$toSpeak&".ogg") = 1 then
speakit ($toSpeak)
elseIf fileExists ("speech\"&$toSpeak&".ogg") = 0 then
if $numberFilesExist = "yes" then
$string = $toSpeak
while $string <> ""
if stringLen ($string) = 2 or stringLen ($string) = 5 or stringLen($string) = 8 then ;places?
if stringLeft ($string, 1) = 1 then
$digitToSpeak = stringLeft ($string, 2)
if stringLen($string)=5 then
$hundredth = "thousand"
elseIf stringLen($string)=8 then
$hundredth = "million"
endIf
$string = stringRight ($string, stringLen($string)-2)
elseIf stringLeft ($string, 1) = 0 then
if stringLen($string)=5 then
$check = stringTrimRight($toSpeak, 4)
if stringRight($check, 2) <> 00 then
$hundredth = "thousand"
$check = ""
endIf
elseIf stringLen($string)=8 then
$hundredth = "million"
endIf
$string = stringRight ($string, stringLen($string)-1)
else
$digitToSpeak = stringLeft ($string, 1)&"0"
if stringLen($string)=5 and stringLeft(stringRight($string, 4), 1) = 0 then
$hundredth = "thousand"
elseIf stringLen($string)=8 and stringLeft(stringRight($string, 8), 1) = 0 then
$hundredth = "million"
endIf
$string = stringRight ($string, stringLen($string)-1)
endIf
elseIf stringLen ($string) = 1 or stringLen($string) = 3 or stringLen($string) = 4 or stringLen ($string) = 6 or stringLen($string) = 7 or stringLen($string) = 9 then
if stringLeft ($string, 1) <> 0 then
$digitToSpeak = stringLeft ($string, 1)
if stringLen($string) = 3 or stringLen($string) = 6 or stringLen($string) = 9 then
$hundredth = "hundred"
elseIf stringLen($string) = 4 then
$hundredth = "thousand"
elseIf stringLen($string) = 7 then
$hundredth = "million"
endIf
$string = stringRight ($string, stringLen($string)-1)
else
$string = stringRight ($string, stringLen($string)-1)
endIf
endIf

if $digitToSpeak <> "" then
speakIt ($digitToSpeak)
$digitToSpeak = ""
endIf

if $hundredth <> "" then
speakIt ($hundredth)
$hundredth = ""
endIf
wend
else
speak ($toSpeak)
endIf
endIf
else
if fileExists ("fx\speech\"&$toSpeak&".ogg") = 1 then
speakIt ($toSpeak)
$toSpeak = ""
else
speak ($toSpeak)
endIf
 endIf
endFunc

func speakIt ($soundToPlay)
$soundToPlayThing = _SoundPlay("fx\speech\"&$soundToPlay&".ogg")

while _isplaying("fx\speech\"&$soundToPlay&".ogg")
sleep(1)
WEnd
_SoundDrop($SoundToPlayThing)
endFunc