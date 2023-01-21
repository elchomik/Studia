1. Utworzyć kolekcję typu tablica zagnieżdżona i nazwać ją NT_Studenci. 
Kolekcja powinna zawierać elementy opisujące liczbę egzaminów każdego studenta oraz liczbę zdobytych punktów przez studenta. 
Zainicjować wartości elementów kolekcji na podstawie danych z tabel Studenci i Egzaminy. 
Zapewnić, by studenci umieszczeni w kolejnych elementach uporządkowani byli wg liczby zdawanych egzaminów, 
od największej do najmniejszej (tzn. pierwszy element kolekcji zawiera studenta, który miał najwięcej egzaminów). 
Po zainicjowaniu kolekcji, wyświetlić wartości znajdujące się w poszczególnych jej elementach.

2. Dla każdego ośrodka, w którym odbył się egzamin, wyznaczyć liczbę studentów, 
którzy byli egzaminowani w danym ośrodku w kolejnych latach.
 Liczbę egzaminowanych studentów należy wyznaczyć przy pomocy funkcji PL/SQL. 
Wynik w postaci listy ośrodków i w/w liczb przedstawić w postaci posortowanej wg nazwy ośrodka i numeru roku.

3. Utworzyć w bazie danych tabelę o nazwie Analityka. 
Tabela powinna zawierać informacje o liczbie egzaminów poszczególnych egzaminatorów w poszczególnych ośrodkach. 
W tabeli utworzyć 4 kolumny. Trzy pierwsze kolumny opisują egzaminatora (identyfikator, imię i nazwisko). 
Czwarta kolumna o nazwie Osrodki opisuje ośrodek (identyfikator oraz nazwa) oraz liczbę egzaminów danego egzaminatora w tym ośrodku. 
Dane dotyczące ośrodka i liczby egzaminów należy umieścić w kolumnie będącej kolekcją typu tablica zagnieżdżona. 
Wprowadzić dane do tabeli Analityka na podstawie danych zgromadzonych w tabelach Egzaminy, Osrodki i Egzaminatorzy.

Następnie wyświetlić dane znajdujące się w tabeli Analityka.

4. Proszę wskazać tych egzaminatorów, którzy przeprowadzili egzaminy w dwóch ostatnich dniach egzaminowania z każdego przedmiotu. 
Jeśli z danego przedmiotu nie było egzaminu, proszę wyświetlić komunikat "Brak egzaminów". 

W odpowiedzi należy umieścić nazwę przedmiotu, datę egzaminu (w formacie DD-MM-YYYY) oraz identyfikator, nazwisko i imię egzaminatora. Zadanie należy wykonać z użyciem kursora.

5. Który student zdawał z przedmiotu "Bazy danych" więcej niż 10 egzaminów w ciągu jednego roku?
 Zadanie należy rozwiązać przy pomocy wyjątków (dodatkowo można wykorzystać kursory). 
W odpowiedzi proszę podać pełne dane studenta (identyfikator, nazwisko, imię), rok (w formacie YYYY) oraz liczbę egzaminów.