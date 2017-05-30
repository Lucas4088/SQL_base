ALTER VIEW PopularnyGatunek5L
AS
SELECT  Gatunek ,sum(tab.ilosc) as Popularnosc
FROM (
	SELECT  G.Gatunek AS Gatunek, COUNT(E.Sygnatura) AS ilosc
	FROM Wypozyczenie AS W
	JOIN Egzemplarz AS E ON (W.Sygnatura=E.Sygnatura)
	JOIN Ksiazka AS K ON (E.KsiazkaID=K.KsiazkaID)
    JOIN Gatunek AS G ON (K.GatunekID=G.GatunekID)
    WHERE DATEDIFF(YY,W.DataWypozyczenia,NOW(*))<=5
    GROUP BY Gatunek
	UNION ALL
    SELECT  G.Gatunek AS Gatunek, COUNT(E.Sygnatura) AS ilosc
    FROM HistoriaWypozyczen AS HW
    JOIN Egzemplarz AS E ON (HW.Sygnatura=E.Sygnatura)
    JOIN Ksiazka AS K ON (E.KsiazkaID=K.KsiazkaID)
    JOIN Gatunek AS G ON (K.GatunekID=G.GatunekID)
    WHERE DATEDIFF(YY,HW.DataWypozyczenia,NOW(*))<=5
    GROUP BY Gatunek
ORDER BY ilosc DESC
) AS tab 
GROUP BY Gatunek
HAVING  Popularnosc = (SELECT  TOP 1 ilosc as Popularnosc
                       FROM (
                        	SELECT  G.Gatunek AS Gatunek, COUNT(E.Sygnatura) AS ilosc
                        	FROM Wypozyczenie AS W
                        	JOIN Egzemplarz AS E ON (W.Sygnatura=E.Sygnatura)
                        	JOIN Ksiazka AS K ON (E.KsiazkaID=K.KsiazkaID)
                            JOIN Gatunek AS G ON (K.GatunekID=G.GatunekID)
                            WHERE DATEDIFF(YY,W.DataWypozyczenia,NOW(*))<=5
                            GROUP BY Gatunek
                        	UNION ALL
                            SELECT  G.Gatunek AS Gatunek, COUNT(E.Sygnatura) AS ilosc
                            FROM HistoriaWypozyczen AS HW
                            JOIN Egzemplarz AS E ON (HW.Sygnatura=E.Sygnatura)
                            JOIN Ksiazka AS K ON (E.KsiazkaID=K.KsiazkaID)
                            JOIN Gatunek AS G ON (K.GatunekID=G.GatunekID)
                            WHERE DATEDIFF(YY,HW.DataWypozyczenia,NOW(*))<=5
                            GROUP BY Gatunek
                        ORDER BY ilosc DESC
                        ) AS tab
                        ORDER BY Popularnosc DESC) 