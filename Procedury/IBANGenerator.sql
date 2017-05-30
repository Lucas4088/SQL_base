ALTER PROCEDURE "DBA"."UtworzKontoBankowe"(IN KlientId INTEGER, OUT NumerKonta VARCHAR(26))
BEGIN 
    DECLARE C INTEGER ;
    DECLARE  A CHAR(8);
    DECLARE B CHAR(16) ;
    SET A = '85236941';
    SET C = ((CONVERT(INTEGER,A))%KlientId*(KlientId%17))/KlientId;
    CASE 
        WHEN C <10 THEN SET C=C+10
        WHEN C > 10000000 THEN SET C=C / 1000000
        WHEN C > 1000000 THEN SET C=C / 100000
        WHEN C > 100000 THEN SET C=C / 10000
        WHEN C > 10000 THEN SET C=C / 1000
        WHEN C > 1000 THEN SET C=C / 100
        WHEN C > 100 THEN SET C=C / 10
    END ;
        
    SET B=replicate('0',16-length(CONVERT(VARCHAR(10),KlientID)));--+CONVERT(VARCHAR(10),KlientID)));
    SET B=B+CONVERT(VARCHAR(10),KlientID);
    SET NumerKonta=CONVERT(CHAR(2),C)+A+B;
    MESSAGE 'PESEL TO: ' TO CLIENT;
    MESSAGE NumerKonta TO CLIENT;
    MESSAGE B TO CLIENT;
    RETURN NumerKonta;
END
    
    