ALTER FUNCTION "DBA"."WygenerujSyganture"( IN Tytul VARCHAR(30) )
RETURNS CHAR(8)

BEGIN
	DECLARE "SygnaturaN" CHAR(8);
	DECLARE RNumber1 CHAR(1);
    DECLARE RNumber2 CHAR(1);
    DECLARE RNumber3 CHAR(1);
    DECLARE Flag BIT;
    DECLARE Syg CHAR(8);
    DECLARE Kursor CURSOR FOR 
    (SELECT Sygnatura 
     FROM Egzemplarz);

    SET Flag = 1;
    SET SygnaturaN ='';
    SET SygnaturaN = SygnaturaN + CONVERT(CHAR(1),ASCII(SUBSTRING(Tytul,1,1))%10);
    SET SygnaturaN = SygnaturaN + CONVERT(CHAR(1),ASCII(SUBSTRING(Tytul,2,1))%10);
    SET SygnaturaN = SygnaturaN +'-';
     
    WHILE Flag = 1 LOOP
    
        SET RNumber1 = CONVERT(char(1),CONVERT(INTEGER,rand()*10));
        SET RNumber2 = CONVERT(char(1),CONVERT(INTEGER,rand()*10));
        SET RNumber3 = CONVERT(char(1),CONVERT(INTEGER,rand()*10));
        SET SygnaturaN = SygnaturaN + RNumber1 + RNumber2 + RNumber3;
        OPEN Kursor;
        Petla: LOOP
            FETCH NEXT Kursor INTO Syg;
            IF SQLCODE <> 0 THEN LEAVE Petla ENDIF;
            IF SygnaturaN = (SELECT Sygnatura 
                             FROM Egzemplarz
                             WHERE Sygnatura = Syg) THEN 
            SET FLAG =1;
            ELSE 
            SET FLAG =0;
            ENDIF;
          END LOOP;
          CLOSE Kursor;   
      END LOOP;
    MESSAGE SygnaturaN TO CLIENT;
	RETURN "SygnaturaN";
END