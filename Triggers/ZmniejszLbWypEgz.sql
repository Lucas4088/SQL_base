CREATE TRIGGER "ZmniejszLbWypEgz"
//zwieksza liczbe egzemplarzy na danym koncie po dodaniu wypozyczeniaON Wypozyczenie
INSTEAD OF DELETE 
ON Wypozyczenie
REFERENCING OLD AS deleted
BEGIN 
     DECLARE l_egz int;
     SET l_egz=(SELECT KoB.LiczbaWypEgzemplarzy
            FROM KontoBiblioteczne AS KoB
            WHERE KoB.KontoID = deleted.KontoID);
    SET l_egz= l_egz-1;
    IF l_egz>=0 THEN 
        UPDATE KontoBiblioteczne
        SET LiczbaWypEgzemplarzy=l_egz
        WHERE KontoID=deleted.KontoID;
    ELSE 
        SIGNAL "Blad";
    ENDIF

END