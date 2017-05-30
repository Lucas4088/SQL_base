--SELECT KoB.PESEL, 
--FROM KontoBiblioteczne AS KoB 
--JOIN(
    SELECT tab.KontoID,tab.Tytul,sum(tab.ilosc) as LacznaLbWyp
                    FROM (
                    	SELECT  W.KontoID as KontoID, K.Tytul AS Tytul, COUNT(E.Sygnatura) AS ilosc
                    	FROM Wypozyczenie AS W
                    	JOIN Egzemplarz AS E ON (W.Sygnatura=E.Sygnatura)
                    	JOIN Ksiazka AS K ON (E.KsiazkaID=K.KsiazkaID)
                        GROUP BY KontoID,Tytul
                    	UNION ALL
                        SELECT  HW.KontoID as KontoID,K.Tytul AS Tytul, COUNT(E.Sygnatura) AS ilosc
                        FROM HistoriaWypozyczen AS HW
                        JOIN Egzemplarz AS E ON (HW.Sygnatura=E.Sygnatura)
                        JOIN Ksiazka AS K ON (E.KsiazkaID=K.KsiazkaID)
                        GROUP BY KontoID,Tytul
                    ORDER BY ilosc DESC
                    ) AS tab 
                    GROUP BY tab.KontoID, tab.Tytul
                    ORDER BY LacznaLbWyp DESC--) AS LWyp 
--ON (KoB.KontoID=Lwyp.KontoID)
--JOIN Egzemplarz AS E ON(E.Sygnatura=LWyp.Sygnatura)
--JOIN Placowka AS P ON(P.PlacowkaID=E.PlacowkaID)
                    