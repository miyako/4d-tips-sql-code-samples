

C_LONGINT:C283($Event)
$Event:=Form event code:C388

Case of 
		
	: ($Event=On Load:K2:1)
		C_LONGINT:C283($Width; $Height; vnumPages)
		FORM GET PROPERTIES:C674("Main"; $Width; $Height; vnumPages)
		vCrtFormPage:=1
		Radio1:=1
		bTrace:=0
		ARRAY LONGINT:C221(aNrActors; 0)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		ARRAY TEXT:C222(aMedias; 0)
		
	: ($Event=On Unload:K2:2)
		
End case 
