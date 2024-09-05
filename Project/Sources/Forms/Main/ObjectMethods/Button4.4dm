// Debugging SQL code
If (bTrace=1)
	TRACE:C157
End if 

ARRAY LONGINT:C221(aSoldTickets; 0)
ARRAY INTEGER:C220(aMovieYear; 0)
C_LONGINT:C283($MovieYear; $MinSoldTickets)
$MovieYear:=1979
$MinSoldTickets:=10000000

Begin SQL
	  SELECT Year_of_Movie, SUM(Sold_Tickets)
	      FROM MOVIES
	      WHERE Year_of_Movie >= :$MovieYear
	      GROUP BY Year_of_Movie
	      HAVING SUM(Sold_Tickets < :$MinSoldTickets
	      ORDER BY 1
	      INTO :aMovieYear,  :aSoldTickets;
End SQL
