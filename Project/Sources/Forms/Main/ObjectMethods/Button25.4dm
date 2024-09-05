// Subqueries
If (bTrace=1)
	TRACE:C157
End if 

Header1:=0

Case of 
	: (Radio1=1)
		// Using standard 4D code
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY TEXT:C222(aTitles; 0)
		C_LONGINT:C283($i; $vInd; $vAvgSoldTickets)
		
		$vInd:=0
		ALL RECORDS:C47([MOVIES:1])
		$vAvgSoldTickets:=Average:C2([MOVIES:1]Sold_Tickets:12)
		For ($i; 1; Records in selection:C76([MOVIES:1]))
			If ([MOVIES:1]Sold_Tickets:12>$vAvgSoldTickets)
				$vInd:=$vInd+1
				INSERT IN ARRAY:C227(aTitles; $vInd; 1)
				aTitles{$vInd}:=[MOVIES:1]Title:2
				INSERT IN ARRAY:C227(aSoldTickets; $vInd; 1)
				aSoldTickets{$vInd}:=[MOVIES:1]Sold_Tickets:12
			End if 
			NEXT RECORD:C51([MOVIES:1])
		End for 
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY INTEGER:C220(aMovieYear; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aDirectors; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aTitles))
		SORT ARRAY:C229(aTitles; aDirectors; aMovieYear; aMedias; aSoldTickets; aNrActors; >)
		
	: (Radio2=1)
		// Using 4D SQL code
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY TEXT:C222(aTitles; 0)
		Begin SQL
			     SELECT Title, Sold_Tickets
			        FROM MOVIES
			     WHERE Sold_Tickets > (SELECT AVG(Sold_Tickets) FROM MOVIES)
			     ORDER BY 1
			     INTO :aTitles, :aSoldTickets;
		End SQL
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY INTEGER:C220(aMovieYear; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aDirectors; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aTitles))
		SORT ARRAY:C229(aTitles; aDirectors; aMovieYear; aMedias; aSoldTickets; aNrActors; >)
		
	: (Radio3=1)
		// Using ODBC commands
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY TEXT:C222(aTitles; 0)
		C_TEXT:C284($tQueryTxt)
		
		SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
		$tQueryTxt:=""
		$tQueryTxt:=$tQueryTxt+"SELECT Title, Sold_Tickets"
		$tQueryTxt:=$tQueryTxt+" FROM MOVIES"
		$tQueryTxt:=$tQueryTxt+" WHERE Sold_Tickets > (SELECT AVG(Sold_Tickets) FROM MOVIES)"
		$tQueryTxt:=$tQueryTxt+" ORDER BY 1"
		SQL EXECUTE:C820($tQueryTxt; aTitles; aSoldTickets)
		SQL LOAD RECORD:C822(SQL all records:K49:10)
		SQL LOGOUT:C872
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY INTEGER:C220(aMovieYear; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aDirectors; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aTitles))
		SORT ARRAY:C229(aTitles; aDirectors; aMovieYear; aMedias; aSoldTickets; aNrActors; >)
		
	: (Radio4=1)
		// Using QUERY BY SQL
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY TEXT:C222(aTitles; 0)
		
		QUERY BY SQL:C942([MOVIES:1]; "Sold_Tickets > (SELECT AVG(Sold_Tickets) FROM MOVIES)")
		ORDER BY:C49([MOVIES:1]; [MOVIES:1]Title:2; >)
		SELECTION TO ARRAY:C260([MOVIES:1]Title:2; aTitles; [MOVIES:1]Sold_Tickets:12; aSoldTickets)
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY INTEGER:C220(aMovieYear; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aDirectors; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aTitles))
		SORT ARRAY:C229(aTitles; aDirectors; aMovieYear; aMedias; aSoldTickets; aNrActors; >)
		
	: (Radio5=1)
		// Using dynamic SQL by EXECUTE IMMEDIATE
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY TEXT:C222(aTitles; 0)
		C_TEXT:C284($tQueryTxt)
		
		$tQueryTxt:=""
		$tQueryTxt:=$tQueryTxt+"SELECT Title, Sold_Tickets"
		$tQueryTxt:=$tQueryTxt+" FROM MOVIES"
		$tQueryTxt:=$tQueryTxt+" WHERE Sold_Tickets > (SELECT AVG(Sold_Tickets) FROM MOVIES)"
		$tQueryTxt:=$tQueryTxt+" ORDER BY 1"
		$tQueryTxt:=$tQueryTxt+" INTO :aTitles, :aSoldTickets"
		Begin SQL
			EXECUTE IMMEDIATE :$tQueryTxt;
		End SQL
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY INTEGER:C220(aMovieYear; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aDirectors; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aTitles))
		
End case 
Header1:=1

