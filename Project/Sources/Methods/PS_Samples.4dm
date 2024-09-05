//%attributes = {}
//C_ENTIER LONG($WinRef)
//
//FIXER BARRE MENUS(1)
//INACTIVER LIGNE MENU(1;1)
//$WinRef:=Creer fenetre formulaire("Main";Form fenêtre standard ;Centrée horizontalement ;Centrée verticalement ;*)
//DIALOGUE("Main")
//FERMER FENETRE($WinRef)
//
//ACTIVER LIGNE MENU(1;1)
//CHANGER TITRE FENETRE("")
//
//



C_LONGINT:C283($1)
C_LONGINT:C283(<>PS_Samples)

If (Count parameters:C259=0)
	If (Process state:C330(<>PS_Samples)<0) | (<>PS_Samples=0)
		<>PS_Samples:=New process:C317("PS_Samples"; 32000; "PS_Samples"; 0)
	Else 
		BRING TO FRONT:C326(<>PS_Samples)
	End if 
	
Else 
	
	SET MENU BAR:C67(1)
	
	$WinRef:=Open form window:C675("Main"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	DIALOG:C40("Main")
	CLOSE WINDOW:C154($WinRef)
	
	DISABLE MENU ITEM:C150(1; 1)
	
	<>PS_Samples:=0
End if 

