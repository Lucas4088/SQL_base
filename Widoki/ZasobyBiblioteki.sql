--Zagranizcne zasoby bilbilioteczne z podzialem na ich typ oraz placowke 
SELECT P.PlacowkaID,P.MiejscowoscPL, N.Typ, count(E.Sygnatura) as ilosc
    FROM Placowka AS P 
    RIGHT JOIN Egzemplarz AS E ON (P.PlacowkaID=E.PlacowkaID)
    LEFT JOIN Ksiazka AS K ON (E.KsiazkaID=K.KsiazkaID)
    LEFT JOIN Autorstwo AS Aus ON(Aus.KsiazkaID=K.KsiazkaID)
    LEFT JOIN Autor AS A ON (A.AutorID=Aus.AutorID) 
    LEFT JOIN Nosnik AS N ON(E.NosnikID=N.NosnikID)
    WHERE A.Kraj <> 'Polska'
    GROUP BY P.PlacowkaID,P.MiejscowoscPL, N.Typ 
    ORDER BY P.PlacowkaID



