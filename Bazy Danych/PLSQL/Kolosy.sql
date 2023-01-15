---Zadanie 1 Egzaminy w ci¹gu dwóch ostatnich dni egzaminowania
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c1 IS SELECT Id_Przedmiot, Nazwa_Przedmiot FROM Przedmioty;
    CURSOR c2(pIdPrzedmiot Przedmioty.Id_Przedmiot%TYPE) IS SELECT e.Id_Egzaminator, Imie, Nazwisko, Data_Egzamin 
        FROM Egzaminy e INNER JOIN Egzaminatorzy egz 
        ON e.Id_Egzaminator = egz.Id_Egzaminator
        WHERE e.Id_Przedmiot = pIdPrzedmiot
        ORDER BY 4 DESC;
BEGIN
    FOR vc1 IN c1 LOOP
        dbms_output.put_line('---------------');
        dbms_output.put_line(vc1.Nazwa_Przedmiot);
        FOR vc2 IN c2(vc1.Id_Przedmiot) LOOP
            EXIT WHEN c2%ROWCOUNT > 2;
            dbms_output.put_line(vc2.Id_Egzaminator || ' ' || vc2.Imie || ' ' || vc2.Nazwisko || ' ' || vc2.Data_Egzamin);
            IF c2%NOTFOUND THEN
                dbms_output.put_line('Brak egzaminow');
            END IF;
        END LOOP;
    END LOOP;
END;


---Zadanie 2

DECLARE
    e EXCEPTION;
    CURSOR c1 IS SELECT e.Id_Student, Nazwisko, Imie, extract(year FROM Data_Egzamin) AS Rok,
        COUNT(Id_Egzamin) AS Liczba_egzaminow FROM Studenci s INNER JOIN Egzaminy e
        ON e.Id_Student = s.Id_Student INNER JOIN Przedmioty p ON p.Id_Przedmiot = e.Id_Przedmiot
        WHERE UPPER(Nazwa_Przedmiot) = 'Bazy danych'
        GROUP BY e.Id_Student,Nazwisko, Imie, EXTRACT(YEAR FROM Data_Egzamin);
BEGIN
    FOR vc1 IN c1 LOOP
        BEGIN
            IF vc1.Liczba_egzaminow > 10 THEN
                RAISE e;
            END IF;
        EXCEPTION
            WHEN e THEN 
                dbms_output.put_line(vc1.Id_Student || ' ' || vc1.Nazwisko || ' ' || vc1.Imie || ' ' || vc1.Rok || ' ' || vc1.Liczba_egzaminow);
        END;
    END LOOP;
END;


---Zadanie 4 
CREATE OR REPLACE TYPE Osrodki_Rec AS OBJECT(Nazwa_Osrodka VARCHAR2(50),
                            Id_Osrodek NUMBER);
CREATE OR REPLACE TYPE OsrodkiTypObj_1 AS OBJECT(Data_Egzamin DATE,
                        Osrodki Osrodki_Rec);
DECLARE 
    TYPE OsrodkiTypWiersz IS TABLE OF OsrodkiTypObj_1 ;
    NT_Osrodki OsrodkiTypWiersz := OsrodkiTypWiersz();
    i NUMBER DEFAULT 0;
        CURSOR c1 IS SELECT DISTINCT Data_Egzamin FROM Egzaminy ORDER BY 1 DESC;
        CURSOR c2(pData Egzaminy.Data_Egzamin%TYPE) IS SELECT e.Id_Osrodek, Nazwa_Osrodek FROM
            Osrodki o INNER JOIN Egzaminy e ON e.Id_Osrodek = o.Id_Osrodek
            WHERE Data_Egzamin = pData;
BEGIN
    FOR vc1 IN c1 LOOP
        dbms_output.put_line('---------');
        EXIT WHEN c1%ROWCOUNT > 3;
        dbms_output.put_line(vc1.Data_Egzamin);
        FOR vc2 IN c2(vc1.Data_Egzamin) LOOP
            i:= c2%ROWCOUNT;
            NT_Osrodki.EXTEND;
            NT_Osrodki(i):=OsrodkiTypObj_1(vc1.Data_Egzamin, Osrodki_Rec(vc2.Nazwa_Osrodek,vc2.Id_Osrodek));
            dbms_output.put_line(vc2.Id_Osrodek || ' ' || vc2.Nazwa_Osrodek);
        END LOOP;
    END LOOP;
END;

--Sposób drugi imo bardziej prawilny ale kto wie
DECLARE
    TYPE Osrodki_Wiersz IS RECORD(Id_Osrodek Osrodki.Id_Osrodek%TYPE,
                                  Nazwa_Osrodek Osrodki.Nazwa_Osrodek%TYPE);
    TYPE Osr_Typ IS TABLE OF Osrodki_Wiersz;
    NT_Osrodki Osr_Typ := Osr_Typ();
    i NUMBER DEFAULT 0;
    CURSOR c1 IS SELECT DISTINCT Data_Egzamin FROM Egzaminy ORDER BY 1 DESC;
    CURSOR c2(pData Egzaminy.Data_Egzamin%TYPE) IS SELECT o.Id_Osrodek, Nazwa_Osrodek FROM Osrodki o INNER JOIN Egzaminy e
        ON e.Id_Osrodek = o.Id_Osrodek WHERE Data_Egzamin = pData;
BEGIN
    FOR vc1 IN c1 LOOP
        dbms_output.put_line('---Dane-----');
        EXIT WHEN c1%ROWCOUNT>3;
        dbms_output.put_line(vc1.Data_Egzamin);
        FOR vc2 IN c2(vc1.Data_Egzamin) LOOP
            i:=c2%ROWCOUNT;
            NT_Osrodki.EXTEND;
            NT_Osrodki(i):= vc2;
            dbms_output.put_line(NT_Osrodki(i).Id_Osrodek || ' ' || vc2.Nazwa_Osrodek);
        END LOOP;
    END LOOP;
END;


--Zadanie 5
CREATE OR REPLACE TYPE typ_zdl_obj AS OBJECT(Rok NUMBER, Miesiac NUMBER, Liczba_egzaminow NUMBER);
CREATE OR REPLACE TYPE typ_zdl IS TABLE OF typ_zdl_obj;
CREATE TABLE PrzedmiotAnaliza2(Nazwa_Przedmiot VARCHAR2(40),
                dataLiczbaEgz typ_zdl) NESTED TABLE dataLiczbaEgz STORE AS wyniki;
DECLARE 
    kolekcja typ_zdl:= typ_zdl();
    i NUMBER DEFAULT 0;
    CURSOR c1 IS SELECT Id_Przedmiot, Nazwa_Przedmiot FROM Przedmioty;
    CURSOR c2(pIdPrzedmiot Przedmioty.Id_Przedmiot%TYPE) IS SELECT EXTRACT(year FROM Data_Egzamin) AS Rok,
        EXTRACT(MONTH FROM Data_Egzamin) AS Miesiac, COUNT(ID_Egzamin) AS Liczba_Egzaminow
        FROM Egzaminy e WHERE e.Id_Przedmiot = pIdPrzedmiot
        GROUP BY EXTRACT(YEAR FROM Data_Egzamin), EXTRACT(MONTH FROM Data_Egzamin)
        ORDER BY 1 DESC;
BEGIN
    FOR vc1 IN c1 LOOP
        dbms_output.put_line('------Wyniki -------');
        dbms_output.put_line(vc1.Nazwa_Przedmiot);
        FOR vc2 IN c2(vc1.Id_Przedmiot) LOOP
            i:=c2%ROWCOUNT;
            kolekcja.EXTEND;
            kolekcja(i):= typ_zdl_obj(vc2.Rok, vc2.Miesiac, vc2.Liczba_Egzaminow);
        END LOOP;
            INSERT INTO PrzedmiotAnaliza2 VALUES(vc1.Nazwa_Przedmiot, kolekcja);
            kolekcja := typ_zdl();
    END LOOP;
END;

select ae.*, nt.* 
    from PrzedmiotAnaliza2 ae, table(ae.dataLiczbaEgz) nt ;


