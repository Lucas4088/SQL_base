ALTER TRIGGER "DodanieWypozyczenia" BEFORE INSERT
ORDER 1 ON Wypozyczenie
REFERENCING NEW AS Nowa
FOR EACH ROW
BEGIN
    DECLARE flag INTEGER;
    DECLARE l_wyp INTEGER;

    SET l_wyp=(SELECT LiczbaWypEgzemplarzy
               FROM KontoBiblioteczne AS KoB
               WHERE Nowa.KontoID=KoB.KontoID);
    SET flag =(SELECT W.WypozyczenieID 
               FROM Wypozyczenie AS W
               WHERE W.Sygnatura=Nowa.Sygnatura);
    IF l_wyp =10 OR flag <> 0 THEN 
        SIGNAL "Ten egzemplarz zostal juz wypozyczony"
    ENDIF
END