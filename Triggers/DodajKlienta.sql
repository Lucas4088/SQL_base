ALTER TRIGGER UtworzenieKonta AFTER INSERT 
ON Klient
REFERENCING NEW AS inserted
FOR EACH ROW 
BEGIN 
    DECLARE KID INTEGER;
   
    INSERT INTO KontoBiblioteczne(PESEL,DataZalozenia)
    VALUES(inserted.PESEL,timestamp);
    SET KID = (SELECT KlientID 
                FROM Klient
                WHERE inserted.PESEL = Klient.PESEL
                );
    UPDATE KontoBiblioteczne
    SET NumerKontaBankowego=utworzIBAN(KID)
    WHERE KontoID=KID;
END