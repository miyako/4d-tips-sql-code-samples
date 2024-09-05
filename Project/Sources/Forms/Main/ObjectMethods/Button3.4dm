// HAVING clause
If (bTrace=1)
	TRACE:C157
End if 

Header1:=0

Case of 
	: (Radio1=1)
		// Using standard 4D code
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY LONGINT:C221(aSoldTickets; 0)
		C_LONGINT:C283($MovieYear; $vCrtMovieYear; $i; $MinSoldTickets; $vInd)
		
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		$MovieYear:=1979
		$MinSoldTickets:=10000000
		QUERY:C277([MOVIES:1]; [MOVIES:1]Year_of_Movie:5>=$MovieYear)
		ORDER BY:C49([MOVIES:1]; [MOVIES:1]Year_of_Movie:5; >)
		$vCrtMovieYear:=0
		$vInd:=Size of array:C274(aMovieYear)
		For ($i; 1; Records in selection:C76([MOVIES:1]))
			If ([MOVIES:1]Year_of_Movie:5#$vCrtMovieYear)
				$vCrtMovieYear:=[MOVIES:1]Year_of_Movie:5
				If (aSoldTickets{$vInd}<$MinSoldTickets)
					$vInd:=$vInd+1
					INSERT IN ARRAY:C227(aMovieYear; $vInd; 1)
					aMovieYear{$vInd}:=$vCrtMovieYear
					INSERT IN ARRAY:C227(aSoldTickets; $vInd; 1)
				Else 
					aSoldTickets{$vInd}:=0
				End if 
			End if 
			aSoldTickets{$vInd}:=aSoldTickets{$vInd}+[MOVIES:1]Sold_Tickets:12
			NEXT RECORD:C51([MOVIES:1])
		End for 
		If (aSoldTickets{$vInd}>=$MinSoldTickets)
			DELETE FROM ARRAY:C228(aSoldTickets; $vInd; 1)
			DELETE FROM ARRAY:C228(aMovieYear; $vInd; 1)
		End if 
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY TEXT:C222(aTitles; Size of array:C274(aMovieYear))
		ARRAY TEXT:C222(aDirectors; Size of array:C274(aMovieYear))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aMovieYear))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aMovieYear))
		
	: (Radio2=1)
		// Using 4D SQL code
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY LONGINT:C221(aSoldTickets; 0)
		C_LONGINT:C283($MovieYear; $MinSoldTickets)
		
		$MovieYear:=1979
		$MinSoldTickets:=10000000
		Begin SQL
			SELECT Year_of_Movie, SUM(Sold_Tickets)
			    FROM MOVIES
			    WHERE Year_of_Movie >= :$MovieYear
			    GROUP BY Year_of_Movie
			    HAVING SUM(Sold_Tickets) < :$MinSoldTickets
			    ORDER BY 1
			    INTO :aMovieYear,  :aSoldTickets;
		End SQL
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY TEXT:C222(aTitles; Size of array:C274(aMovieYear))
		ARRAY TEXT:C222(aDirectors; Size of array:C274(aMovieYear))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aMovieYear))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aMovieYear))
		
	: (Radio3=1)
		// Using ODBC commands
		C_TEXT:C284($tQueryTxt)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY LONGINT:C221(aSoldTickets; 0)
		C_LONGINT:C283($MovieYear; $MinSoldTickets)
		
		$MovieYear:=1979
		$MinSoldTickets:=10000000
		SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
		$tQueryTxt:=""
		$tQueryTxt:=$tQueryTxt+"SELECT Year_of_Movie, SUM(Sold_Tickets)"
		$tQueryTxt:=$tQueryTxt+" FROM MOVIES"
		$tQueryTxt:=$tQueryTxt+" WHERE Year_of_Movie >= :$MovieYear"
		$tQueryTxt:=$tQueryTxt+" GROUP BY Year_of_Movie"
		$tQueryTxt:=$tQueryTxt+" HAVING SUM(Sold_Tickets) < :$MinSoldTickets"
		$tQueryTxt:=$tQueryTxt+" ORDER BY 1"
		SQL EXECUTE:C820($tQueryTxt; aMovieYear; aSoldTickets)
		SQL LOAD RECORD:C822(SQL all records:K49:10)
		SQL LOGOUT:C872
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY TEXT:C222(aTitles; Size of array:C274(aMovieYear))
		ARRAY TEXT:C222(aDirectors; Size of array:C274(aMovieYear))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aMovieYear))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aMovieYear))
		
	: (Radio4=1)
		// Using QUERY BY SQL
		C_TEXT:C284($tQueryTxt)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY LONGINT:C221(aSoldTickets; 0)
		C_LONGINT:C283($MovieYear; $MinSoldTickets; $vCrtMovieYear; $vInd; $i)
		
		REDUCE SELECTION:C351([MOVIES:1]; 0)
		$MovieYear:=1979
		$MinSoldTickets:=10000000
		QUERY BY SQL:C942([MOVIES:1]; "Year_of_Movie >= :$MovieYear")
		ORDER BY:C49([MOVIES:1]; [MOVIES:1]Year_of_Movie:5; >)
		$vCrtMovieYear:=0
		$vInd:=Size of array:C274(aMovieYear)
		For ($i; 1; Records in selection:C76([MOVIES:1]))
			If ([MOVIES:1]Year_of_Movie:5#$vCrtMovieYear)
				$vCrtMovieYear:=[MOVIES:1]Year_of_Movie:5
				If (aSoldTickets{$vInd}<$MinSoldTickets)
					$vInd:=$vInd+1
					INSERT IN ARRAY:C227(aMovieYear; $vInd; 1)
					aMovieYear{$vInd}:=$vCrtMovieYear
					INSERT IN ARRAY:C227(aSoldTickets; $vInd; 1)
				Else 
					aSoldTickets{$vInd}:=0
				End if 
			End if 
			aSoldTickets{$vInd}:=aSoldTickets{$vInd}+[MOVIES:1]Sold_Tickets:12
			NEXT RECORD:C51([MOVIES:1])
		End for 
		If (aSoldTickets{$vInd}>=$MinSoldTickets)
			DELETE FROM ARRAY:C228(aSoldTickets; $vInd; 1)
			DELETE FROM ARRAY:C228(aMovieYear; $vInd; 1)
		End if 
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY TEXT:C222(aTitles; Size of array:C274(aMovieYear))
		ARRAY TEXT:C222(aDirectors; Size of array:C274(aMovieYear))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aMovieYear))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aMovieYear))
		
	: (Radio5=1)
		// Using dynamic SQL by EXECUTE IMMEDIATE
		C_TEXT:C284($tQueryTxt)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY LONGINT:C221(aSoldTickets; 0)
		C_LONGINT:C283($MovieYear; $MinSoldTickets)
		
		$MovieYear:=1979
		$MinSoldTickets:=10000000
		$tQueryTxt:=""
		$tQueryTxt:=$tQueryTxt+"SELECT Year_of_Movie, SUM(Sold_Tickets)"
		$tQueryTxt:=$tQueryTxt+" FROM MOVIES"
		$tQueryTxt:=$tQueryTxt+" WHERE Year_of_Movie >= :$MovieYear"
		$tQueryTxt:=$tQueryTxt+" GROUP BY Year_of_Movie"
		$tQueryTxt:=$tQueryTxt+" HAVING SUM(Sold_Tickets) < :$MinSoldTickets"
		$tQueryTxt:=$tQueryTxt+" ORDER BY 1"
		$tQueryTxt:=$tQueryTxt+" INTO :aMovieYear, :aSoldTickets;"
		Begin SQL
			EXECUTE IMMEDIATE :$tQueryTxt;
		End SQL
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY TEXT:C222(aTitles; Size of array:C274(aMovieYear))
		ARRAY TEXT:C222(aDirectors; Size of array:C274(aMovieYear))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aMovieYear))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aMovieYear))
		
End case 
Header1:=1

