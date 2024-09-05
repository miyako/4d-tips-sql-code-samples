// SQL query results in variables
If (bTrace=1)
	TRACE:C157
End if 
REDUCE SELECTION:C351([MOVIES:1]; 0)
Header1:=0

Case of 
	: (Radio1=1)
		// Using standard 4D Code
		C_LONGINT:C283($AllMovies)
		$AllMovies:=0
		ALL RECORDS:C47([MOVIES:1])
		$AllMovies:=Records in selection:C76([MOVIES:1])
		//ALERTE("The Video Library contains "+Chaine($AllMovies)+" movies")
		
	: (Radio2=1)
		
		// Using 4D SQL and the "<<>>" notation for the receiving parameter
		C_LONGINT:C283($AllMovies)
		$AllMovies:=0
		Begin SQL
			SELECT COUNT(*) 
			    FROM MOVIES
			    INTO <<$AllMovies>>
		End SQL
		//ALERTE("The Video Library contains "+Chaine($AllMovies)+" movies")
		
		// Using 4D SQL and the ":" notation for the receiving parameter
		C_LONGINT:C283($AllMovies)
		$AllMovies:=0
		Begin SQL
			SELECT COUNT(*) 
			    FROM MOVIES
			    INTO :$AllMovies
		End SQL
		//ALERTE("The Video Library contains "+Chaine($AllMovies)+" movies")
		
		
		// Using 4D SQL and the "<<>>" notation for  receiving an interprocess parameter
		
		If (False:C215)
			
			C_LONGINT:C283(<>AllMovies)
			<>AllMovies:=0
			Begin SQL
				SELECT COUNT(*) 
				    FROM MOVIES
				    INTO <<[<>AllMovies]>>
			End SQL
			ALERT:C41("The Video Library contains "+String:C10(<>AllMovies)+" movies")
			
		End if 
		
		
		
	: (Radio3=1)
		// Using ODBC commands
		C_LONGINT:C283($AllMovies)
		$AllMovies:=0
		// Initialize a connection with the internal SQL engine
		SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
		// Execute the query and return the result in the $AllMovies variable
		SQL EXECUTE:C820("SELECT COUNT(*) FROM MOVIES"; $AllMovies)
		// Retrieve all the records found
		SQL LOAD RECORD:C822(SQL all records:K49:10)
		// Close the connection
		SQL LOGOUT:C872
		//ALERTE("The Video Library contains "+Chaine($AllMovies)+" movies")
		
	: (Radio4=1)
		// Using QUERY BY SQL
		C_LONGINT:C283($AllMovies)
		$AllMovies:=0
		QUERY BY SQL:C942([MOVIES:1]; "ID <> 0")
		$AllMovies:=Records in selection:C76([MOVIES:1])
		//ALERTE("The Video Library contains "+Chaine($AllMovies)+" movies")
		
	: (Radio5=1)
		// Using dynamic SQL by EXECUTE IMMEDIATE
		C_LONGINT:C283($AllMovies)
		$AllMovies:=0
		C_TEXT:C284($tQueryTxt)
		$tQueryTxt:="SELECT COUNT(*) FROM MOVIES INTO :$AllMovies"
		Begin SQL
			EXECUTE IMMEDIATE :$tQueryTxt;
		End SQL
		//ALERTE("The Video Library contains "+Chaine($AllMovies)+" movies")
		
End case 


$Alert:=Get localized string:C991("Main_Alerts_TheMoviesTableContains1Movies")
$Alert:=Replace string:C233($Alert; "<1>"; String:C10($AllMovies; "###,###,##0"))

ALERT:C41($Alert)


