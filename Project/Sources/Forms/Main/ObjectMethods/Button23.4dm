// DDL
If (bTrace=1)
	TRACE:C157
End if 

Begin SQL
	DROP TABLE IF EXISTS ACTOR_FANS;
	
	CREATE TABLE ACTOR_FANS
	
	  (ID INT32,
	  Name VARCHAR);
	  
	  INSERT INTO ACTOR_FANS
	    (ID, Name)
	    VALUES(1, 'Francis');
	    
	  ALTER TABLE ACTOR_FANS
	    ADD Phone_Number VARCHAR;
	
	  INSERT INTO ACTOR_FANS
	    (ID, Name, Phone_Number)
	    VALUES (2, 'Florence', '01446677888');
	    
End SQL




