ALTER PROCEDURE "DBA"."DodajKlienta"( IN NPESEL CHAR(11), Imie VARCHAR(20), Nazwisko VARCHAR (20),
Miejscowosc VARCHAR(20), Ulica VARCHAR(20),NumerDomu VARCHAR(4), 
NumerMieszkania VARCHAR(4),KodPocztowy VARCHAR(6) )

BEGIN
    DECLARE Flag INTEGER;
    DECLARE KID INTEGER;
    BEGIN 
        INSERT INTO Klient(PESEL,Imie,Nazwisko,Miejscowosc,Ulica, NumerDomu,NumerMieszkania,KodPocztowy)
        VALUES(NPESEL,Imie,Nazwisko,Miejscowosc, Ulica,NumerDomu,NumerMieszkania,KodPocztowy);
        
        SET Flag=CAST(SUBSTRING(NPESEL,0,1)AS INTEGER)*1+CAST(SUBSTRING(NPESEL,1,1)AS INTEGER)*3+CAST(SUBSTRING(NPESEL,2,1)AS INTEGER)*7+CAST(SUBSTRING(NPESEL,3,1)AS INTEGER)*9+
        CAST(SUBSTRING(NPESEL,4,1)AS INTEGER)*1+CAST(SUBSTRING(NPESEL,5,1)AS INTEGER)*3+CAST(SUBSTRING(NPESEL,6,1)AS INTEGER)*7+CAST(SUBSTRING(NPESEL,7,1)AS INTEGER)*9+CAST(SUBSTRING(NPESEL,8,1)AS INTEGER)*1+
        CAST(SUBSTRING(NPESEL,9,1)AS INTEGER)*3;
        
        SET Flag=Flag % 10;
        SET Flag=10-Flag;
        SET Flag=Flag % 10;
        
        IF Flag <> CAST(SUBSTRING(NPESEL,10,1)AS INTEGER) THEN
        ROLLBACK;
        MESSAGE 'Niepoprawny numer PESEL' TO Client;    
        ENDIF;
    END
    
    INSERT INTO KontoBiblioteczne(PESEL,DataZalozenia)
    VALUES(NPESEL,now());
    SET KID = (SELECT KontoID 
                FROM KontoBiblioteczne
                WHERE PESEL = NPESEL
                );
    UPDATE KontoBiblioteczne
    SET NumerKontaBankowego=utworzIBAN(KID)
    WHERE KontoID=KID;

END