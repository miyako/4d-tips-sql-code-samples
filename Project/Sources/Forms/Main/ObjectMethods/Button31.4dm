// 4D connection via 4D ODBC dirver
If (bTrace=1)
	TRACE:C157
End if 

C_TEXT:C284($Crt_DSN; $My_4D_DSN)
ARRAY TEXT:C222(aDSN; 0)
ARRAY TEXT:C222(aDS_Driver; 0)
ARRAY TEXT:C222(aTitles; 0)
ARRAY TEXT:C222(aDirectors; 0)
ARRAY TEXT:C222(aMedias; 0)

REDUCE SELECTION:C351([MOVIES:1]; 0)

// By default the current DSN is the local one
$Crt_DSN:=SQL Get current data source:C990
ALERT:C41("The current DSN is "+$Crt_DSN)

// Do someting on the local database
Begin SQL
	        SELECT Title, Director, Media
	            FROM MOVIES
	            ORDER BY 1
	            INTO :aTitles, :aDirectors, :aMedias;
End SQL

// Get the data sources of of type User defined in the ODBC manager
SQL GET DATA SOURCE LIST:C989(User data source:K49:12; aDSN; aDS_Driver)
$My_4D_DSN:="Test_ODBC_Driver_v11"
If (Find in array:C230(aDSN; $My_4D_DSN)>0)
	
	// Establish a connection between 4D and another 4D database via the ODBC Driver v11
	_O_USE EXTERNAL DATABASE:C959($My_4D_DSN; "Administrator"; "")
	If (Ok=1)
		
		// The current DSN is the 4D one
		$Crt_DSN:=SQL Get current data source:C990
		ALERT:C41("The current DSN is "+$Crt_DSN)
		
		ARRAY TEXT:C222(aTitles; 0)
		ARRAY TEXT:C222(aDirectors; 0)
		ARRAY TEXT:C222(aMedias; 0)
		
		// Do something  on the external (4D) database
		Begin SQL
			        SELECT Title, Director, Media
			            FROM MOVIES
			            ORDER BY 1
			            INTO :aTitles, :aDirectors, :aMedias;
		End SQL
		
		// Close the external connexion opened with the USE EXTERNAL DATABASE command
		_O_USE INTERNAL DATABASE:C960
		// The current DSN becomes the local one
		$Crt_DSN:=SQL Get current data source:C990
		ALERT:C41("The current DSN is "+$Crt_DSN)
		
	Else 
		ALERT:C41("Unable to connect to the external data source")
	End if 
Else 
	ALERT:C41("ODBC Driver data source not found")
End if 

