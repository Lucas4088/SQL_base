CREATE PROCEDURE NaliczKare()
BEGIN 

    DECLARE kara NUMERIC(2,2);
    DECLARE nrWypozyczenia INTEGER ;
    DECLARE Iterator CURSOR FOR 
    (SELECT WypozyczenieID
     FROM Wypozyczenie);
    OPEN Iterator;
    Petla: LOOP 
        FETCH NEXT Iterator INTO nrWypozyczenia;
        IF SQLCODE <> 0 THEN LEAVE Petla ENDIF;
        --Tutaj tylko dodaje nowa kare(dodaje nowy rekord w karaID) trzeba jeszcze aktualizowaæ stara 
        IF (SELECT KaraID 
            FROM Wypozyczenie
            WHERE WypozyczenieID=nrWypozyczenia)=NULL --kluczowe dla dodania nowego rekordu w Kara
            
            IF (SELECT Wypozyczenie.DataZwrotu 
                FROM Wypozyczenie 
                WHERE WypozyczenieID = nrWypozyczenia) =  NULL --Egzemplarz nie zostal zwrocony
                AND 
                (SELECT DBA.Wypozyczenie.CzyPrzedluzona 
                FROM Wypozyczenie 
                WHERE WypozyczenieID = nrWypozyczenia) = 0 --Egzemplarz nie zostal przedluzony
                AND 
                DATEDIFF(DAY,(SELECT TerminZwrotu          --konieczne przy obliczaniu kary
                              FROM Wypozyczenie
                              WHERE WypozyczenieID=nrWypozyczenia), now())>0  --czy pojawila sie kara  
                THEN  
                INSERT INTO Kara(KontoID,WypozyczenieID,DataNa³o¿enia)
                VALUES(SELECT KontoID 
                       FROM Wypozyczenie
                       WHERE WypozyczenieID=nrWypozyczenia,
                       nrWypozyczenia,
                       now());
                --Dodac teraz do wypozyczenia KaraID 
                UPDATE Wypozyczenie 
                SET KaraID = (SELECT KaraID
                              FROM Kara
                              WHERE WypozyczenieID=nrWypozyczenia)
                WHERE DBA.Wypozyczenie.WypozyczenieID=nrWypozyczenia;
                --Do konta bibliotecznego dodac wartosc kary bo moze byc na kilka egzemplarzy
                UPDATE KontoBiblioteczne
                --dodaje plus 0.1 bo kara jest naliczana kazdego dnia
                SET DoZaplaty = DoZaplaty + (SELECT WartoœæJednostkowa 
                                             FROM Kara
                                             WHERE WypozyczeniID=nrWypozyczenia)
                WHERE KontoBiblioteczne=(SELECT KontoID
                                         FROM Wypozyczenie
                                         WHERE WypozyczenieID=nrWypozyczenia)
    
                --aktualizowanie starej kary czyli po prostu doliczenie do kary z konta bibl wyliczonej wartosci 
                
            
 