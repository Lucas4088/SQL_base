CREATE  MATERIALIZED VIEW "DBA"."LacznaKwotaKarNaPlacowke"
AS
SELECT P.MiejscowoscPl ,  sum(KoB.DoZaplaty) AS Zaleglosc, COUNT(E.Sygnatura) AS LiczbaEgzemplarzy,
COUNT(DISTINCT(K.KontoID)) AS LiczbaZadluzonychKlientow, CAST(Zaleglosc/LiczbaEgzemplarzy AS DECIMAL(5,2))
AS SrednieZadluzenieNaEgzemplarz
FROM  KontoBiblioteczne AS KoB 
JOIN Kara AS K ON (K.KontoID=Kob.KontoID)
JOIN Wypozyczenie AS W ON (W.WypozyczenieID=K.WypozyczenieID)
JOIN Egzemplarz AS E ON(W.Sygnatura=E.Sygnatura)
JOIN Placówka AS P ON(P.PlacowkaID=E.PlacowkaID)
WHERE KoB.DoZaplaty > 0.00
GROUP BY P.MiejscowoscPl