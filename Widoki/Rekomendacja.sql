ALTER VIEW "DBA"."Rekomendacja"
AS
-- rekomendacja trzech najpopularniejszych ksi¹¿ek pod kryteria klienta
SELECT TOP 3 K.Tytul AS Tytul
FROM Ksiazka AS K 
JOIN Gatunek AS G ON (K.GatunekID=G.GatunekID)
JOIN Egzemplarz AS E ON (K.KsiazkaID=E.KsiazkaID)
RIGHT JOIN (SELECT  Sygnatura, KontoID  
      FROM HistoriaWypozyczen AS HW
      UNION ALL
      SELECT Sygnatura, KontoID
      FROM Wypozyczenie AS W
) AS tab ON (tab.Sygnatura=E.Sygnatura)
--ulubiony gatunek klienta o najwiêkszej liczbie wypozyczen
WHERE G.Gatunek = (SELECT TOP 1 G.Gatunek 
                    FROM (SELECT KontoID, Sygnatura 
                         FROM Wypozyczenie AS W 
                         UNION ALL 
                         SELECT KontoID, Sygnatura 
                         FROM HistoriaWypozyczen AS HW) AS tab1
                    JOIN Egzemplarz AS E ON (E.Sygnatura=tab1.Sygnatura)
                    JOIN Ksiazka AS K ON (K.KsiazkaID=E.KsiazkaID)
                    JOIN Gatunek AS G ON (K.GatunekID=G.GatunekID)
                    WHERE tab1.KontoID = (SELECT TOP 1 tab3.KontoID 
                                          FROM (SELECT  W.kontoID, W.Sygnatura 
                                                FROM Wypozyczenie AS W
                                                UNION ALL 
                                                SELECT HW.KontoID, HW.Sygnatura 
                                                FROM HistoriaWypozyczen AS HW) AS tab3
                                          GROUP BY tab3.KontoID
                                          ORDER BY COUNT(tab3.Sygnatura) DESC)
                    GROUP BY G.Gatunek
                    ORDER BY COUNT(*) DESC) AND tab.KontoID <> (SELECT TOP 1 tab3.KontoID 
                                                                FROM (SELECT  W.kontoID, W.Sygnatura 
                                                                FROM Wypozyczenie AS W
                                                                UNION ALL 
                                                                SELECT HW.KontoID, HW.Sygnatura 
                                                                FROM HistoriaWypozyczen AS HW) AS tab3
                                                                GROUP BY tab3.KontoID
                                                                ORDER BY COUNT(tab3.Sygnatura) DESC)
GROUP BY K.Tytul
ORDER BY COUNT(*) DESC