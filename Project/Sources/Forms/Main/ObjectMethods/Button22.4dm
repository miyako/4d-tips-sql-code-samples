// Calling 4D Methods
If (bTrace=1)
	TRACE:C157
End if 

Header1:=0

Case of 
	: (Radio1=1)
		// Using standard 4D code
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY LONGINT:C221(aNrActors; 0)
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		ARRAY TEXT:C222(aMedias; 0)
		C_LONGINT:C283($NrOfActors; $i; $vInd)
		
		$vInd:=0
		$NrOfActors:=7
		ALL RECORDS:C47([MOVIES:1])
		For ($i; 1; Records in selection:C76([MOVIES:1]))
			$vCrtActors:=Find_Nr_Of_Actors([MOVIES:1]ID:1)
			If ($vCrtActors>=$NrOfActors)
				$vInd:=$vInd+1
				INSERT IN ARRAY:C227(aMovieYear; $vInd; 1)
				aMovieYear{$vInd}:=[MOVIES:1]Year_of_Movie:5
				INSERT IN ARRAY:C227(aTitles; $vInd; 1)
				aTitles{$vInd}:=[MOVIES:1]Title:2
				INSERT IN ARRAY:C227(aDirectors; $vInd; 1)
				aDirectors{$vInd}:=[MOVIES:1]Director:3
				INSERT IN ARRAY:C227(aMedias; $vInd; 1)
				aMedias{$vInd}:=[MOVIES:1]Media:9
				INSERT IN ARRAY:C227(aSoldTickets; $vInd; 1)
				aSoldTickets{$vInd}:=[MOVIES:1]Sold_Tickets:12
				INSERT IN ARRAY:C227(aNrActors; $vInd; 1)
				aNrActors{$vInd}:=$vCrtActors
			End if 
			NEXT RECORD:C51([MOVIES:1])
		End for 
		SORT ARRAY:C229(aMovieYear; aTitles; aDirectors; aMedias; aSoldTickets; aNrActors; >)
		
	: (Radio2=1)
		// Using 4D SQL code
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY LONGINT:C221(aNrActors; 0)
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		ARRAY TEXT:C222(aMedias; 0)
		C_LONGINT:C283($NrOfActors; $i; $vInd)
		
		$vInd:=0
		$NrOfActors:=7
		Begin SQL
			  SELECT Year_of_Movie, Title, Director, Media, Sold_Tickets, {fn Find_Nr_Of_Actors(ID) AS NUMERIC}
			      FROM MOVIES
			      WHERE {fn Find_Nr_Of_Actors(ID) AS NUMERIC} >= :$NrOfActors
			      ORDER BY 1
			      INTO :aMovieYear, :aTitles, :aDirectors, :aMedias, :aSoldTickets, :aNrActors;
		End SQL
		
	: (Radio3=1)
		// Using ODBC commands
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY LONGINT:C221(aNrActors; 0)
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		ARRAY TEXT:C222(aMedias; 0)
		C_LONGINT:C283($NrOfActors; $i; $vInd)
		C_TEXT:C284($tQueryTxt)
		
		$vInd:=0
		$NrOfActors:=7
		SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
		$tQueryTxt:=""
		$tQueryTxt:=$tQueryTxt+"SELECT Year_of_Movie, Title, Director, Media, Sold_Tickets, {fn Find_Nr_Of_Actors(ID) AS NUMERIC}"
		$tQueryTxt:=$tQueryTxt+" FROM MOVIES"
		$tQueryTxt:=$tQueryTxt+" WHERE {fn Find_Nr_Of_Actors(ID) AS NUMERIC} >= :$NrOfActors"
		$tQueryTxt:=$tQueryTxt+" ORDER BY 1"
		SQL EXECUTE:C820($tQueryTxt; aMovieYear; aTitles; aDirectors; aMedias; aSoldTickets; aNrActors)
		SQL LOAD RECORD:C822(SQL all records:K49:10)
		SQL LOGOUT:C872
		
	: (Radio4=1)
		// Using QUERY BY SQL
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY LONGINT:C221(aNrActors; 0)
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		ARRAY TEXT:C222(aMedias; 0)
		C_LONGINT:C283($NrOfActors; $i; $vInd)
		
		$vInd:=0
		$NrOfActors:=7
		QUERY BY SQL:C942([MOVIES:1]; "{fn Find_Nr_Of_Actors(ID) AS NUMERIC} >= :$NrOfActors")
		For ($i; 1; Records in selection:C76([MOVIES:1]))
			$vInd:=$vInd+1
			INSERT IN ARRAY:C227(aMovieYear; $vInd; 1)
			aMovieYear{$vInd}:=[MOVIES:1]Year_of_Movie:5
			INSERT IN ARRAY:C227(aTitles; $vInd; 1)
			aTitles{$vInd}:=[MOVIES:1]Title:2
			INSERT IN ARRAY:C227(aDirectors; $vInd; 1)
			aDirectors{$vInd}:=[MOVIES:1]Director:3
			INSERT IN ARRAY:C227(aMedias; $vInd; 1)
			aMedias{$vInd}:=[MOVIES:1]Media:9
			INSERT IN ARRAY:C227(aSoldTickets; $vInd; 1)
			aSoldTickets{$vInd}:=[MOVIES:1]Sold_Tickets:12
			INSERT IN ARRAY:C227(aNrActors; $vInd; 1)
			aNrActors{$vInd}:=Find_Nr_Of_Actors([MOVIES:1]ID:1)
			NEXT RECORD:C51([MOVIES:1])
		End for 
		SORT ARRAY:C229(aMovieYear; aTitles; aDirectors; aMedias; aSoldTickets; aNrActors; >)
		
	: (Radio5=1)
		// Using dynamic SQL by EXECUTE IMMEDIATE
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY INTEGER:C220(aMovieYear; 0)
		ARRAY LONGINT:C221(aNrActors; 0)
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		ARRAY TEXT:C222(aMedias; 0)
		C_LONGINT:C283($NrOfActors; $i; $vInd)
		C_TEXT:C284($tQueryTxt)
		
		$vInd:=0
		$NrOfActors:=7
		$tQueryTxt:=""
		$tQueryTxt:=$tQueryTxt+"SELECT Year_of_Movie, Title, Director, Media, Sold_Tickets, {fn Find_Nr_Of_Actors(ID) AS NUMERIC}"
		$tQueryTxt:=$tQueryTxt+" FROM MOVIES"
		$tQueryTxt:=$tQueryTxt+" WHERE {fn Find_Nr_Of_Actors(ID) AS NUMERIC} >= :$NrOfActors"
		$tQueryTxt:=$tQueryTxt+" ORDER BY 1"
		$tQueryTxt:=$tQueryTxt+" INTO :aMovieYear, :aTitles, :aDirectors, :aMedias, :aSoldTickets,"+" :aNrActors;"
		Begin SQL
			 EXECUTE IMMEDIATE :$tQueryTxt;
		End SQL
		
End case 
Header1:=1

