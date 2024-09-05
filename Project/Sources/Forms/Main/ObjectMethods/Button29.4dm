// ORACLE connection
If (bTrace=1)
	TRACE:C157
End if 

ARRAY TEXT:C222(aDSN; 0)
ARRAY TEXT:C222(aDS_Driver; 0)
C_TEXT:C284($Crt_DSN; $My_ORACLE_DSN)
ARRAY TEXT:C222(aTitles; 0)
ARRAY LONGINT:C221(aNrActors; 0)
ARRAY LONGINT:C221(aSoldTickets; 0)
ARRAY INTEGER:C220(aMovieYear; 0)
ARRAY TEXT:C222(aTitles; 0)
ARRAY TEXT:C222(aDirectors; 0)
ARRAY TEXT:C222(aMedias; 0)
C_LONGINT:C283($MovieYear)
C_TEXT:C284($tQueryTxt)
REDUCE SELECTION:C351([MOVIES:1]; 0)
$MovieYear:=1960

// By default the current DSN is the local one, ";DB4D_SQL_LOCAL;", which is the value of the SQL_INTERNAL constant
$Crt_DSN:=SQL Get current data source:C990
// By default the current DSN is the local one
ALERT:C41("The current DSN is "+$Crt_DSN)

// Do someting on the local database
Begin SQL
	  SELECT Year_of_Movie, Title, Director, Media, Sold_Tickets
	      FROM MOVIES
	      WHERE Year_of_Movie >= :$MovieYear
	      INTO :aMovieYear, :aTitles, :aDirectors, :aMedias, :aSoldTickets;
End SQL

// Get the data sources of the User type defined in the ODBC manager
SQL GET DATA SOURCE LIST:C989(User data source:K49:12; aDSN; aDS_Driver)
$My_ORACLE_DSN:="Test_Oracle_10g"
If (Find in array:C230(aDSN; $My_ORACLE_DSN)>0)
	// Establish a connection between 4D and the data source $My_ORACLE_DSN="Test_Oracle_10g"
	_O_USE EXTERNAL DATABASE:C959($My_ORACLE_DSN; "scott"; "tiger")
	
	// The current DSN is the ORACLE one
	$Crt_DSN:=SQL Get current data source:C990
	ALERT:C41("The current DSN is "+$Crt_DSN)
	ARRAY TEXT:C222(aTitles; 0)
	ARRAY LONGINT:C221(aNrActors; 0)
	ARRAY LONGINT:C221(aSoldTickets; 0)
	ARRAY INTEGER:C220(aMovieYear; 0)
	ARRAY TEXT:C222(aTitles; 0)
	ARRAY TEXT:C222(aDirectors; 0)
	ARRAY TEXT:C222(aMedias; 0)
	
	// Do something  on the external (ORACLE) database
	Begin SQL
		SELECT ENAME FROM EMP INTO :aTitles
	End SQL
	
	// Close the external connexion opened with the USE EXTERNAL DATABASE command
	_O_USE INTERNAL DATABASE:C960
	// The current DSN becomes the local one
	$Crt_DSN:=SQL Get current data source:C990
	ALERT:C41("The current DSN is "+$Crt_DSN)
Else 
	ALERT:C41("ORACLE DSN not installed")
End if 

