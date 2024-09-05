//%attributes = {}
Demo_Init

DISABLE MENU ITEM:C150(1; 1)

$Launch:=Demo_Open

If ($Launch)
	PS_Samples
Else 
	DISABLE MENU ITEM:C150(1; 1)
End if 


