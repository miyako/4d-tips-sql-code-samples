// Using ORDER BY
If (bTrace=1)
	TRACE:C157
End if 

Header1:=0

Case of 
	: (Radio1=1)
		// Using standard 4D Code
		ARRAY LONGINT:C221(aNrActors; 0)
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		ARRAY TEXT:C222(aMedias; 0)
		C_LONGINT:C283($MovieYear)
		
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		$MovieYear:=1960
		QUERY:C277([MOVIES:1]; [MOVIES:1]Year_of_Movie:5>=$MovieYear)
		SELECTION TO ARRAY:C260([MOVIES:1]Year_of_Movie:5; aMovieYear; [MOVIES:1]Title:2; aTitles; [MOVIES:1]Director:3; aDirectors; [MOVIES:1]Media:9; aMedias; [MOVIES:1]Sold_Tickets:12; aSoldTickets)
		SORT ARRAY:C229(aMovieYear; aTitles; aDirectors; aMedias; >)
		
	: (Radio2=1)
		// Using 4D SQL 
		ARRAY LONGINT:C221(aNrActors; 0)
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		ARRAY TEXT:C222(aMedias; 0)
		C_LONGINT:C283($MovieYear)
		
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		$MovieYear:=1960
		Begin SQL
			SELECT Year_of_Movie, Title, Director, Media, Sold_Tickets
			FROM MOVIES
			WHERE Year_of_Movie >= :$MovieYear
			ORDER BY 1
			INTO :aMovieYear, :aTitles, :aDirectors, :aMedias,  :aSoldTickets;
		End SQL
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aMovieYear))
		
	: (Radio3=1)
		// Using ODBC commands
		C_TEXT:C284($tQueryTxt)
		ARRAY LONGINT:C221(aNrActors; 0)
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		ARRAY TEXT:C222(aMedias; 0)
		C_LONGINT:C283($MovieYear)
		
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		$MovieYear:=1960
		SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
		$tQueryTxt:=""
		$tQueryTxt:=$tQueryTxt+"SELECT Year_of_Movie, Title, Director, Media, Sold_Tickets"
		$tQueryTxt:=$tQueryTxt+" FROM MOVIES"
		$tQueryTxt:=$tQueryTxt+" WHERE Year_of_Movie >= :$MovieYear"
		$tQueryTxt:=$tQueryTxt+" ORDER BY 1"
		SQL EXECUTE:C820($tQueryTxt; aMovieYear; aTitles; aDirectors; aMedias; aSoldTickets)
		SQL LOAD RECORD:C822(SQL all records:K49:10)
		SQL LOGOUT:C872
		
	: (Radio4=1)
		// Using QUERY BY SQL
		ARRAY LONGINT:C221(aNrActors; 0)
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		ARRAY TEXT:C222(aMedias; 0)
		C_LONGINT:C283($MovieYear)
		
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		$MovieYear:=1960
		QUERY BY SQL:C942([MOVIES:1]; "Year_of_Movie >= :$MovieYear")
		
		SELECTION TO ARRAY:C260([MOVIES:1]Year_of_Movie:5; aMovieYear; [MOVIES:1]Title:2; aTitles; [MOVIES:1]Director:3; aDirectors; [MOVIES:1]Media:9; aMedias; [MOVIES:1]Sold_Tickets:12; aSoldTickets)
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aMovieYear))
		SORT ARRAY:C229(aMovieYear; aTitles; aDirectors; aMedias; >)
		
	: (Radio5=1)
		// Using dynamic SQL by EXECUTE IMMEDIATE
		ARRAY LONGINT:C221(aNrActors; 0)
		C_TEXT:C284($tQueryTxt)
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		ARRAY TEXT:C222(aMedias; 0)
		C_LONGINT:C283($MovieYear)
		
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		$MovieYear:=1960
		$tQueryTxt:=""
		$tQueryTxt:=$tQueryTxt+"SELECT Year_of_Movie, Title, Director, Media, Sold_Tickets"
		$tQueryTxt:=$tQueryTxt+" FROM MOVIES"
		$tQueryTxt:=$tQueryTxt+" WHERE Year_of_Movie >= :$MovieYear"
		$tQueryTxt:=$tQueryTxt+" ORDER BY 1"
		$tQueryTxt:=$tQueryTxt+"  INTO :aMovieYear, :aTitles, :aDirectors, :aMedias, :aSoldTickets;"
		Begin SQL
			EXECUTE IMMEDIATE :$tQueryTxt;
		End SQL
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aMovieYear))
		
End case 
Header1:=1



