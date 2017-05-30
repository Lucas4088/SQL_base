--placowki z laczna liczba wypozyczen egzemplarzy historycznych i obecnych
SELECT tab.Miejscowosc AS NazwaPlacowki, sum(tab.LiczbaOsob) AS LiczbaOsob
FROM(
SELECT P.MiejscowoscPl as Miejscowosc,COUNT(K.PESEL) AS LiczbaOsob
FROM Klient AS K 
JOIN KontoBiblioteczne AS KoB ON(K.PESEL=KoB.PESEL)
JOIN Wypozyczenie AS W ON(KoB.KontoID=W.KontoID)
JOIN Egzemplarz AS E ON(W.Sygnatura=E.Sygnatura)
JOIN Placowka AS P ON(P.PlacowkaID=E.PlacowkaID)
GROUP BY P.MiejscowoscPl
UNION ALL 
SELECT P.MiejscowoscPl,COUNT(K.PESEL) AS LiczbaOsob
FROM Klient AS K 
JOIN KontoBiblioteczne AS KoB ON(K.PESEL=KoB.PESEL)
JOIN HistoriaWypozyczen AS HW ON(KoB.KontoID=HW.KontoID)
JOIN Egzemplarz AS E ON(HW.Sygnatura=E.Sygnatura)
JOIN Placowka AS P ON(P.PlacowkaID=E.PlacowkaID)
GROUP BY P.MiejscowoscPl
) AS tab
GROUP BY tab.Miejscowosc
ORDER BY LiczbaOsob DESC