--Najchêtniej czytana ksiazka wraz z liczba egzemplarz danej ksiazki 
CREATE VIEW PopularnoscKsiazek
AS
SELECT tab3.Tytul, tab3.LacznaLbWyp, tablEgz.legzemplarzy
FROM (
    SELECT tab.Tytul,sum(tab.ilosc) as LacznaLbWyp
    FROM (
    	SELECT  K.Tytul as Tytul, COUNT(E.Sygnatura) AS ilosc
    	FROM Wypozyczenie AS W
    	JOIN Egzemplarz AS E ON (W.Sygnatura=E.Sygnatura)
    	JOIN Ksiazka AS K ON (E.KsiazkaID=K.KsiazkaID)
        GROUP BY K.Tytul
      	UNION ALL
    	SELECT  K.Tytul, COUNT(E.Sygnatura) AS ilosc
    	FROM HistoriaWypozyczen AS HW
    	JOIN Egzemplarz AS E ON (HW.Sygnatura=E.Sygnatura)
    	JOIN Ksiazka AS K ON (E.KsiazkaID=K.KsiazkaID)
        GROUP BY K.Tytul
    
    ) AS tab 
    GROUP BY tab.Tytul
    HAVING LacznaLbWyp = (
                    SELECT TOP 1 sum(tab.ilosc) as LacznaLbWyp
                    FROM (
                    	SELECT  K.Tytul as Tytul, COUNT(E.Sygnatura) AS ilosc
                    	FROM Wypozyczenie AS W
                    	JOIN Egzemplarz AS E ON (W.Sygnatura=E.Sygnatura)
                    	JOIN Ksiazka AS K ON (E.KsiazkaID=K.KsiazkaID)
                        GROUP BY K.Tytul
                    	UNION ALL
                        SELECT  K.Tytul, COUNT(E.Sygnatura) AS ilosc
                        FROM HistoriaWypozyczen AS HW
                        JOIN Egzemplarz AS E ON (HW.Sygnatura=E.Sygnatura)
                        JOIN Ksiazka AS K ON (E.KsiazkaID=K.KsiazkaID)
                        GROUP BY K.Tytul
                    //ORDER BY ilosc DESC
                    ) AS tab 
                    GROUP BY tab.Tytul
                    ORDER BY LacznaLbWyp DESC
                    )
)tab3 JOIN (
            SELECT K.Tytul,COUNT(E.Sygnatura) as legzemplarzy
            FROM Ksiazka AS K 
            JOIN Egzemplarz AS E ON(K.KsiazkaID=E.KsiazkaID)
            GROUP BY K.Tytul
            ) AS tablEgz ON(tab3.Tytul =tablEgz.Tytul )
                

