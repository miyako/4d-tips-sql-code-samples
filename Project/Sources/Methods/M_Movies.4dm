//%attributes = {}
C_LONGINT:C283($WinRef)

FORM SET INPUT:C55([MOVIES:1]; "Input")
FORM SET OUTPUT:C54([MOVIES:1]; "Output")

ALL RECORDS:C47([MOVIES:1])

SET MENU BAR:C67(1)
DISABLE MENU ITEM:C150(1; 1)
$WinRef:=Open form window:C675([MOVIES:1]; "Output"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
MODIFY SELECTION:C204([MOVIES:1]; *; *)
CLOSE WINDOW:C154($WinRef)

ENABLE MENU ITEM:C149(1; 1)

SET WINDOW TITLE:C213("")
