// Using ON ERR CALL command
If (bTrace=1)
	TRACE:C157
End if 

ARRAY LONGINT:C221(aSoldTickets; 0)
ARRAY INTEGER:C220(aMovieYear; 0)
C_LONGINT:C283($MovieYear; $MinSoldTickets; SQL_Error)
$MovieYear:=1979
$MinSoldTickets:=10000000
SQL_Error:=0

// Trigger the SQL_Error_Handler method to catch (trap) errors
ON ERR CALL:C155("SQL_Error_Handler")
Begin SQL
	  SELECT Year_of_Movie, SUM(Sold_Tickets)
	      FROM MOVIES
	      WHERE Year_of_Movie >= :$MovieYear
	      GROUP BY Year_of_Movie
	      HAVING SUM(Sold_Tickets < :$MinSoldTickets
	      ORDER BY 1
	      INTO :aMovieYear,  :aSoldTickets;
End SQL
// Disable the SQL_Error_Handler method
ON ERR CALL:C155("")

If (SQL_Error#0)
	ALERT:C41("SQL Error number: "+String:C10(SQL_Error))
End if 



