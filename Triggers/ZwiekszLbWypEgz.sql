ALTER TRIGGER "ZwiekszLbWypEgz" AFTER INSERT 
ORDER 1 ON Wypozyczenie
REFERENCING NEW AS nowy
FOR EACH ROW 

BEGIN 
     DECLARE l_egz int;
     SET l_egz=(SELECT KoB.LiczbaWypEgzemplarzy
            FROM KontoBiblioteczne AS KoB
            WHERE KoB.KontoID = nowy.KontoID);
    SET l_egz= l_egz+1;
    IF l_egz<=10 THEN 
        UPDATE KontoBiblioteczne
        SET LiczbaWypEgzemplarzy=l_egz
        WHERE KontoID=nowy.KontoID;
    ELSE 
        SIGNAL "Nie mozna wypozyczyc wiecej egzemplarzy";
    ENDIF

END