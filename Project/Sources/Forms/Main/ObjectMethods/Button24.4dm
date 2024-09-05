// Joins
If (bTrace=1)
	TRACE:C157
End if 

Header3:=0
Header2:=0
Header1:=0

Case of 
	: (Radio1=1)
		// Using standard 4D code
		ARRAY LONGINT:C221(aSoldTickets; 0)
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		C_LONGINT:C283($i; $vInd)
		
		$vInd:=0
		ALL RECORDS:C47([ACTORS:2])
		For ($i; 1; Records in selection:C76([ACTORS:2]))
			$vInd:=$vInd+1
			INSERT IN ARRAY:C227(aTitles; $vInd; 1)
			aTitles{$vInd}:=[ACTORS:2]FirstName:3+" "+[ACTORS:2]LastName:2
			RELATE ONE:C42([ACTORS:2]Birth_City_ID:5)
			INSERT IN ARRAY:C227(aDirectors; $vInd; 1)
			aDirectors{$vInd}:=[CITIES:5]City_Name:2
			NEXT RECORD:C51([ACTORS:2])
		End for 
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY INTEGER:C220(aMovieYear; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aSoldTickets; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aTitles))
		MULTI SORT ARRAY:C718(aDirectors; >; aTitles; >; aMovieYear; aMedias; aSoldTickets; aNrActors)
		
	: (Radio2=1)
		// Using 4D SQL code
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		
		Begin SQL
			     SELECT CONCAT(CONCAT(ACTORS.FirstName,' '),ACTORS.LastName), CITIES.City_Name
			         FROM ACTORS, CITIES
			         WHERE ACTORS.Birth_City_ID=CITIES.City_ID
			         ORDER BY 2,1
			         INTO :aTitles, :aDirectors;
		End SQL
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY INTEGER:C220(aMovieYear; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aSoldTickets; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aTitles))
		
	: (Radio3=1)
		// Using ODBC commands
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		C_TEXT:C284($tQueryTxt)
		
		SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
		$tQueryTxt:=""
		$tQueryTxt:=$tQueryTxt+"SELECT CONCAT(CONCAT(ACTORS.FirstName,' '),ACTORS.LastName), CITIES.City_Name"
		$tQueryTxt:=$tQueryTxt+" FROM ACTORS, CITIES"
		$tQueryTxt:=$tQueryTxt+" WHERE ACTORS.Birth_City_ID=CITIES.City_ID"
		$tQueryTxt:=$tQueryTxt+" ORDER BY 2,1"
		SQL EXECUTE:C820($tQueryTxt; aTitles; aDirectors)
		SQL LOAD RECORD:C822(SQL all records:K49:10)
		SQL LOGOUT:C872
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY INTEGER:C220(aMovieYear; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aSoldTickets; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aTitles))
		
	: (Radio4=1)
		// Using QUERY BY SQL
		ALERT:C41("Not available, you are not allowed to pass more than one table as the first parameter")
		
	: (Radio5=1)
		// Using dynamic SQL by EXECUTE IMMEDIATE
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		C_TEXT:C284($tQueryTxt)
		
		$tQueryTxt:=""
		$tQueryTxt:=$tQueryTxt+"SELECT CONCAT(CONCAT(ACTORS.FirstName,' '),ACTORS.LastName), CITIES.City_Name"
		$tQueryTxt:=$tQueryTxt+" FROM ACTORS, CITIES"
		$tQueryTxt:=$tQueryTxt+" WHERE ACTORS.Birth_City_ID=CITIES.City_ID"
		$tQueryTxt:=$tQueryTxt+" ORDER BY 2,1"
		$tQueryTxt:=$tQueryTxt+" INTO :aTitles, :aDirectors"
		Begin SQL
			EXECUTE IMMEDIATE :$tQueryTxt;
		End SQL
		// Intialize the rest of the list box columns in order to visualise the information
		ARRAY INTEGER:C220(aMovieYear; Size of array:C274(aTitles))
		ARRAY TEXT:C222(aMedias; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aSoldTickets; Size of array:C274(aTitles))
		ARRAY LONGINT:C221(aNrActors; Size of array:C274(aTitles))
		
End case 
Header3:=1

