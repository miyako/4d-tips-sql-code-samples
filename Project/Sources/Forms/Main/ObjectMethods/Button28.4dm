// Using Statistical functions
If (bTrace=1)
	TRACE:C157
End if 

Header1:=0

Case of 
	: (Radio1=1)
		// Using standard 4D code 
		C_LONGINT:C283($vMin; $vMax; $vSum)
		C_REAL:C285($vAverage)
		C_TEXT:C284($AlertTxt)
		
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		$vMin:=0
		$vMax:=0
		$vAverage:=0
		$vSum:=0
		ALL RECORDS:C47([MOVIES:1])
		$vMin:=Min:C4([MOVIES:1]Sold_Tickets:12)
		$vMax:=Max:C3([MOVIES:1]Sold_Tickets:12)
		$vAverage:=Average:C2([MOVIES:1]Sold_Tickets:12)
		$vSum:=Sum:C1([MOVIES:1]Sold_Tickets:12)
		//$AlertTxt:=""
		//$AlertTxt:=$AlertTxt+"Minimum tickets sold: "+Chaine($vMin)+Caractere(13)
		//$AlertTxt:=$AlertTxt+"Maximum tickets sold: "+Chaine($vMax)+Caractere(13)
		//$AlertTxt:=$AlertTxt+"Average tickets sold: "+Chaine($vAverage)+Caractere(13)
		//$AlertTxt:=$AlertTxt+"Total tickets sold: "+Chaine($vSum)+Caractere(13)
		//ALERTE($AlertTxt)
		
	: (Radio2=1)
		// Using 4D SQL 
		C_LONGINT:C283($vMin; $vMax; $vSum)
		C_REAL:C285($vAverage)
		C_TEXT:C284($AlertTxt)
		
		$vMin:=0
		$vMax:=0
		$vAverage:=0
		$vSum:=0
		Begin SQL
			   SELECT MIN(Sold_Tickets),
			                   MAX(Sold_Tickets),
			                   AVG(Sold_Tickets),
			                   SUM(Sold_Tickets)
			       FROM MOVIES
			       INTO :$vMin, :$vMax, :$vAverage, :$vSum;
		End SQL
		//$AlertTxt:=""
		//$AlertTxt:=$AlertTxt+"Minimum tickets sold: "+Chaine($vMin)+Caractere(13)
		//$AlertTxt:=$AlertTxt+"Maximum tickets sold: "+Chaine($vMax)+Caractere(13)
		//$AlertTxt:=$AlertTxt+"Average tickets sold: "+Chaine($vAverage)+Caractere(13)
		//$AlertTxt:=$AlertTxt+"Total tickets sold: "+Chaine($vSum)+Caractere(13)
		//ALERTE($AlertTxt)
		
	: (Radio3=1)
		// Using ODBC commands
		C_LONGINT:C283($vMin; $vMax; $vSum)
		C_REAL:C285($vAverage)
		C_TEXT:C284($tQueryTxt)
		C_TEXT:C284($AlertTxt)
		
		$vMin:=0
		$vMax:=0
		$vAverage:=0
		$vSum:=0
		SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
		$tQueryTxt:=""
		$tQueryTxt:=$tQueryTxt+"SELECT MIN(Sold_Tickets), MAX(Sold_Tickets), AVG(Sold_Tickets), SUM(Sold_Tickets)"
		$tQueryTxt:=$tQueryTxt+" FROM MOVIES"
		SQL EXECUTE:C820($tQueryTxt; $vMin; $vMax; $vAverage; $vSum)
		SQL LOAD RECORD:C822(SQL all records:K49:10)
		SQL LOGOUT:C872
		//$AlertTxt:=""
		//$AlertTxt:=$AlertTxt+"Minimum tickets sold: "+Chaine($vMin)+Caractere(13)
		//$AlertTxt:=$AlertTxt+"Maximum tickets sold: "+Chaine($vMax)+Caractere(13)
		//$AlertTxt:=$AlertTxt+"Average tickets sold: "+Chaine($vAverage)+Caractere(13)
		//$AlertTxt:=$AlertTxt+"Total tickets sold: "+Chaine($vSum)+Caractere(13)
		//ALERTE($AlertTxt)
		
	: (Radio4=1)
		// Using QUERY BY SQL
		//ALERTE("Not applicable")
		
	: (Radio5=1)
		// Using dynamic SQL by EXECUTE IMMEDIATE
		C_LONGINT:C283($vMin; $vMax; $vSum)
		C_REAL:C285($vAverage)
		C_TEXT:C284($tQueryTxt)
		C_TEXT:C284($AlertTxt)
		
		$vMin:=0
		$vMax:=0
		$vAverage:=0
		$vSum:=0
		$tQueryTxt:=""
		$tQueryTxt:=$tQueryTxt+"SELECT MIN(Sold_Tickets), MAX(Sold_Tickets), AVG(Sold_Tickets), SUM(Sold_Tickets)"
		$tQueryTxt:=$tQueryTxt+" FROM MOVIES"
		$tQueryTxt:=$tQueryTxt+" INTO :$vMin, :$vMax, :$vAverage, :$vSum;"
		Begin SQL
			EXECUTE IMMEDIATE :$tQueryTxt;
		End SQL
		//$AlertTxt:=""
		//$AlertTxt:=$AlertTxt+"Minimum tickets sold: "+Chaine($vMin)+Caractere(13)
		//$AlertTxt:=$AlertTxt+"Maximum tickets sold: "+Chaine($vMax)+Caractere(13)
		//$AlertTxt:=$AlertTxt+"Average tickets sold: "+Chaine($vAverage)+Caractere(13)
		//$AlertTxt:=$AlertTxt+"Total tickets sold: "+Chaine($vSum)+Caractere(13)
		//ALERTE($AlertTxt)
		
End case 

If (Radio4=1)
	
	$Alert:=Get localized string:C991("Main_Alerts_NotApplicable")
	
Else 
	
	$Alert:=Get localized string:C991("Main_Alerts_TicketsSold")
	$Alert:=Replace string:C233($Alert; "<1>"; String:C10($vMin; "###,###,###,##0"))
	$Alert:=Replace string:C233($Alert; "<2>"; String:C10($vMax; "###,###,###,##0"))
	$Alert:=Replace string:C233($Alert; "<3>"; String:C10($vAverage; "###,###,###,##0.00"))
	$Alert:=Replace string:C233($Alert; "<4>"; String:C10($vSum; "###,###,###,##0"))
	
End if 

ALERT:C41($Alert)



