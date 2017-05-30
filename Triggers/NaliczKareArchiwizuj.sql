ALTER TRIGGER "NaliczKareArchiwizuj" AFTER UPDATE OF "DataZwrotu"
ON Wypozyczenie 
REFERENCING NEW AS updated OLD AS deleted
FOR EACH  ROW 
BEGIN
    DECLARE kara NUMERIC(2,2);
    DECLARE Przetrzymanie INTEGER;
        
    SET Przetrzymanie = DATEDIFF(dd,updated.TerminZwrotu,updated.DataZwrotu);
    
    IF Przetrzymanie > 0   
    AND updated.DataZwrotu <>  NULL THEN
    MESSAGE Przetrzymanie TO CLIENT ;
    MESSAGE updated.DataZwrotu TO CLIENT;
    INSERT INTO Kara (KontoID,WypozyczenieID,DataNa³o¿enia,WartoœæJednostkowa)
    VALUES (updated.KontoID,updated.WypozyczenieID,NOW(),0.1);
    SET kara = Przetrzymanie * (SELECT WartoœæJednostkowa
                               FROM Kara 
                               WHERE updated.WypozyczenieID=Kara.WypozyczenieID);

    UPDATE KontoBiblioteczne
    SET DoZaplaty=DoZaplaty+Przetrzymanie
    WHERE updated.KontoID=KontoBiblioteczne.KontoID;
    UPDATE Wypozyczenie
    SET TerminZwrotu=NULL
    WHERE WypozyczenieID=updated.WypozyczenieID;
    --Archiwizacj
    ELSE 
    MESSAGE updated.KontoID TO CLIENT ;
    MESSAGE updated.Sygnatura TO CLIENT ;
    INSERT INTO HistoriaWypozyczen (KontoID,Sygnatura,DataWypozyczenia,DataZwrotu)
    VALUES (updated.KontoID,updated.Sygnatura,updated.DataWypozyczenia,updated.DataZwrotu);
    DELETE FROM Wypozyczenie
    WHERE WypozyczenieID=updated.WypozyczenieID;
    ENDIF;

   MESSAGE updated.KontoID TO CLIENT ;

   
END