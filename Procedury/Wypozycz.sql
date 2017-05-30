ALTER PROCEDURE "DBA"."Wypozycz"(  IN OPESEL CHAR(26), OSygnatura  CHAR(8))
/* RESULT( column_name column_type, ... ) */
//SPRAWDZ CZY NIE OSIAGNAL LIMITU, CZY NIE MA KARY NALICZONEJ
//UTWORZ NOWY REKORD W WYPOZYCZENIACH
//Zwieksz liczbe wypozyczen
BEGIN
	 IF(SELECT DoZaplaty 
        FROM KontoBiblioteczne
        WHERE PESEL = OPESEL ) = 0.0 
        AND 
        (SELECT LiczbaWypEgzemplarzy 
        FROM KontoBiblioteczne
        WHERE PESEL = OPESEL ) <10 THEN
        INSERT INTO Wypozyczenie (KontoID,Sygnatura,DataWypozyczenia,TerminZwrotu,CzyPrzedluzona)
        VALUES ((SELECT KontoID 
                   FROM KontoBiblioteczne
                   WHERE PESEL=OPESEL), OSygnatura,NOw(),DATEADD(mm,1,NOW()),0);
        UPDATE KontoBiblioteczne
        SET LiczbaWypEgzemplarzy=LiczbaWypEgzemplarzy+1
        WHERE PESEL =OPESEL;
        ENDIF;
        
END