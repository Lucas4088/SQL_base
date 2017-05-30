ALTER PROCEDURE "DBA"."ZestawienieKsiegozbioru"( IN MaxPojemnosc INTEGER, IN IDBiblioteki INTEGER, OUT LPKsiazek INTEGER,
                                                OUT LEBook INTEGER, OUT LABook INTEGER, OUT Ksiegozbior INTEGER, OUT Pozostalo INTEGER)
//liczba pozostalych wolnych dedykowanych miejsc na ksiazki dla danej biblioteki lub jesli
//IDBiblioteki rowne zeru wtedy wylicza dla wszystkich bibliotek laczna ilsoc pozostalych miejsc
BEGIN
	DECLARE Suma INTEGER;
    DECLARE TmpPozostalo INTEGER;
    DECLARE TmpPKsiazek INTEGER;
    DECLARE TmpEbook INTEGER;
    DECLARE TmpAbook INTEGER;
    DECLARE TmpKsiegozbior INTEGER;
    

    DECLARE Kursor CURSOR FOR
    (SELECT PlacowkaID 
     FROM Placowka);
    
    SET Suma =0;
    SET TmpPozostalo = 0;
    SET TmpPKsiazek = 0;
    SET TmpEbook = 0;
    SET TmpAbook = 0;
    SET TmpKsiegozbior = 0;

    IF IDBiblioteki > 0 THEN    
    SET LPKsiazek = (SELECT COUNT(*)
                     FROM Egzemplarz 
                     WHERE NosnikID =3 AND PlacowkaID = IDBiblioteki);
    SET LEBook = (SELECT COUNT(*)
                     FROM Egzemplarz 
                     WHERE NosnikID =2 AND PlacowkaID = IDBiblioteki);
    SET LAbook = (SELECT COUNT(*)
                     FROM Egzemplarz 
                     WHERE NosnikID =1 AND PlacowkaID = IDBiblioteki);
    SET Ksiegozbior = LPKsiazek + LEBook + LABook;
    SET Pozostalo = MAXPojemnosc - Ksiegozbior;
    ELSE 
    SET IDBiblioteki = 0;
    OPEN Kursor;
    Petla: LOOP 
        FETCH NEXT Kursor INTO IDBiblioteki;
        IF SQLCODE <> 0 THEN LEAVE Petla ENDIF;
        SET LPKsiazek = TmpPKsiazek + (SELECT COUNT(*)
                     FROM Egzemplarz 
                     WHERE NosnikID =3 AND PlacowkaID = IDBiblioteki);
        SET LEbook = TmpEbook + (SELECT COUNT(*)
                     FROM Egzemplarz 
                     WHERE NosnikID =2 AND PlacowkaID = IDBiblioteki);
        SET LABook = TmpABook + (SELECT COUNT(*)
                     FROM Egzemplarz 
                     WHERE NosnikID =1 AND PlacowkaID = IDBiblioteki);
        SET Ksiegozbior = (LPKsiazek - TmpPKsiazek) + (LEBook - TmpEBook) + (LABook - TmpABook);

        SET TmpPKsiazek = LPKsiazek;
        SET TmpEbook = LEBook;
        SET TmpAbook = LABook;
        
        SET Pozostalo = TmpPozostalo + MaxPojemnosc - Ksiegozbior;
        SET TmpPozostalo = Pozostalo;
        END LOOP 
        ENDIF;
        MESSAGE 'Pozostalo miejsc: ' TO CLIENT;
        MESSAGE Pozostalo TO CLIENT; 
    
END