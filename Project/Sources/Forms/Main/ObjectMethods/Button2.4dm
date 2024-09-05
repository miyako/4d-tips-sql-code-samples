// WHERE clause
If (bTrace=1)
	TRACE:C157
End if 

Header1:=0

Case of 
	: (Radio1=1)
		// Using standard 4D Code
		C_LONGINT:C283($NoMovies)
		
		$NoMovies:=0
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		QUERY:C277([MOVIES:1]; [MOVIES:1]Year_of_Movie:5>=1960)
		$NoMovies:=Records in selection:C76([MOVIES:1])
		//ALERTE("The Video Library contains "+Chaine($NoMovies)+" movies more recent or equal to 1960")
		
	: (Radio2=1)
		// Using 4D SQL
		C_LONGINT:C283($NoMovies)
		
		$NoMovies:=0
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		Begin SQL
			SELECT COUNT(*) 
			   FROM MOVIES
			   WHERE Year_of_Movie >= 1960
			   INTO :$NoMovies;
		End SQL
		//ALERTE("The Video Library contains "+Chaine($NoMovies)+" movies more recent or equal to 1960")
		
	: (Radio3=1)
		// Using ODBC commands
		C_LONGINT:C283($NoMovies)
		$NoMovies:=0
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		
		SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
		SQL EXECUTE:C820("SELECT COUNT(*) FROM MOVIES WHERE Year_of_Movie >= 1960"; $NoMovies)
		SQL LOAD RECORD:C822(SQL all records:K49:10)
		SQL LOGOUT:C872
		//ALERTE("The Video Library contains "+Chaine($NoMovies)+" movies more recent or equal to 1960")
		
	: (Radio4=1)
		// Using QUERY BY SQL
		C_LONGINT:C283($NoMovies)
		
		$NoMovies:=0
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		QUERY BY SQL:C942([MOVIES:1]; "Year_of_Movie >= 1960")
		$NoMovies:=Records in selection:C76([MOVIES:1])
		//ALERTE("The Video Library contains "+Chaine($NoMovies)+" movies more recent or equal to 1960")
		
	: (Radio5=1)
		// Using dynamic SQL by EXECUTE IMMEDIATE
		C_LONGINT:C283($NoMovies)
		C_TEXT:C284($tQueryTxt)
		
		$NoMovies:=0
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		$tQueryTxt:="SELECT COUNT(*) FROM MOVIES WHERE Year_of_Movie >= 1960 INTO :$NoMovies;"
		Begin SQL
			EXECUTE IMMEDIATE :$tQueryTxt;
		End SQL
		//ALERTE("The Video Library contains "+Chaine($NoMovies)+" movies more recent or equal to 1960")
		
End case 


$Alert:=Get localized string:C991("Main_Alerts_TheMoviesTableContains1MoviesReleased")
$Alert:=Replace string:C233($Alert; "<1>"; String:C10($NoMovies; "###,###,##0"))

ALERT:C41($Alert)




