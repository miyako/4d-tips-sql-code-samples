//%attributes = {}
C_LONGINT:C283($n)
C_TEXT:C284($Title)

$n:=Records in selection:C76([MOVIES:1])
If ($n>1)
	$Title:=String:C10($n)+" movies selected"
Else 
	$Title:=String:C10($n)+" movie selected"  //0 or 1
End if 

SET WINDOW TITLE:C213($Title)
