//%attributes = {"publishedSql":true}
//(F) Find_Nr_Of_Actors
C_LONGINT:C283($0; $1; $vMovie_ID)
$vMovie_ID:=$1

QUERY:C277([MOVIE_ACTOR:3]; [MOVIE_ACTOR:3]Movie_ID:1=$vMovie_ID)
$0:=Records in selection:C76([MOVIE_ACTOR:3])
