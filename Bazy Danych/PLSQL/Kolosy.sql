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


--Zadanie 2 ---

DECLARE
    punkty NUMBER;
    CURSOR c1 IS SELECT o.Id_Osrodek, Nazwa_Osrodek, EXTRACT(year FROM Data_Egzamin) AS Rok FROM
        Osrodki o INNER JOIN Egzaminy e ON o.Id_Osrodek = e.Id_Osrodek
        GROUP BY o.Id_Osrodek, Nazwa_Osrodek, EXTRACT(year FROM Data_Egzamin)
        ORDER BY 2,3;
        
    FUNCTION liczbaEgzamin(p_IdOsrodek Osrodki.Id_Osrodek%TYPE) RETURN NUMBER IS
        liczbaPkt NUMBER;
        CURSOR c2 IS SELECT COUNT(Id_Egzamin) AS Liczba_egz FROM Egzaminy WHERE Id_Osrodek = p_IdOsrodek;
    BEGIN
        OPEN c2;
            FETCH c2 INTO liczbaPkt;
            IF liczbaPkt IS NULL THEN
                RETURN 0;
            END IF;
            RETURN liczbaPkt;
        CLOSE c2;
    END liczbaEgzamin;
BEGIN
    FOR vc1 IN c1 LOOP
        punkty:= liczbaEgzamin(vc1.Id_Osrodek);
        dbms_output.put_line(vc1.Nazwa_Osrodek || ' ' || vc1.Rok || ' ' || punkty);
    END LOOP;
END;


--Zadanie 4
DECLARE
    CURSOR c1 IS SELECT DISTINCT Data_Egzamin FROM Egzaminy ORDER BY 1 DESC;
    CURSOR c2(pDataEgz Egzaminy.Data_Egzamin%TYPE) IS SELECT egz.Id_Egzaminator, Imie, Nazwisko, Nazwa_Przedmiot FROM Egzaminatorzy egz INNER JOIN Egzaminy e 
        ON egz.Id_Egzaminator = e.Id_Egzaminator 
        INNER JOIN Przedmioty p ON p.Id_Przedmiot = e.Id_Przedmiot
        WHERE Data_Egzamin = pDataEgz;
BEGIN
    FOR vc1 IN c1 LOOP
        EXIT WHEN c1%ROWCOUNT > 2;
        dbms_output.put_line('--------');
        dbms_output.put_line(vc1.Data_Egzamin);
        FOR vc2 in c2(vc1.Data_Egzamin) LOOP
            dbms_output.put_line(vc2.Id_Egzaminator || ' ' || vc2.Imie || ' ' || vc2.Nazwisko || ' ' || vc2.Nazwa_Przedmiot);
        END LOOP;
    END LOOP;
END;


--Zadanie 5

DECLARE
    ex Exception;
    CURSOR c1 IS SELECT e.Id_Student, Imie, Nazwisko, EXTRACT(YEAR FROM Data_Egzamin) AS Rok, 
        COUNT(Id_Egzamin) AS Liczba_egz FROM Studenci s INNER JOIN Egzaminy e
        ON s.Id_Student = e.ID_Student
        GROUP BY e.Id_Student, Imie, Nazwisko,Extract(YEAR FROM Data_Egzamin)
        ORDER BY  5;
BEGIN
    FOR vc1 IN c1 LOOP
        BEGIN
        IF vc1.Liczba_egz > 10 THEN
            RAISE ex;
        END IF;
        EXCEPTION
            WHEN ex THEN
                dbms_output.put_line(vc1.Id_Student || ' ' || vc1.Imie || ' ' || vc1.Nazwisko || ' ' || vc1.Rok || ' ' || vc1.Liczba_egz);
        END;
    END LOOP;
END;


--Zadanie 6

DECLARE
    wynik Egzaminy.Data_Egzamin%TYPE;
    CURSOR c1 IS SELECT DISTINCT e.Id_Przedmiot, Nazwa_Przedmiot FROM Przedmioty p INNER JOIN Egzaminy e
        ON e.Id_Przedmiot = p.Id_Przedmiot;
    CURSOR c2(p_IdPrzedmiot PRzedmioty.Id_Przedmiot%TYPE, dataEgz Egzaminy.Data_Egzamin%TYPE) IS SELECT DISTINCT
        e.Id_Student, Imie, Nazwisko FROM Studenci s INNER JOIN Egzaminy e ON s.Id_Student = e.Id_Student
        WHERE e.Id_Przedmiot = p_IdPrzedmiot AND Data_Egzamin = dataEgz;
    
    FUNCTION getLastDate(p_IdPrzedmiot NUMBER) RETURN Egzaminy.Data_Egzamin%TYPE IS  
        dataMax Egzaminy.Data_Egzamin%TYPE;
        BEGIN
            SELECT MAX(Data_Egzamin) INTO dataMax FROM Egzaminy e WHERE e.Id_Przedmiot = p_IdPrzedmiot;
                RETURN dataMax;
        END getLastDate;
BEGIN
    FOR vc1 IN c1 LOOP
        wynik := getLastDate(vc1.Id_Przedmiot);
        dbms_output.put_line('Studenci zdaj¹cy egzamin w ostatnim dniu egzaminowania ' ||  wynik || ' ' ||  vc1.Nazwa_Przedmiot || '\n');
        FOR vc2 IN c2(vc1.Id_Przedmiot, wynik) LOOP
            dbms_output.put_line(vc2.Id_Student || ' ' || vc2.Imie || ' ' || vc2.Nazwisko);
        END LOOP;
    END LOOP;
END;


---Zadanie 7

DECLARE 
    czyBralUdzial BOOLEAN;
    CURSOR c1 IS SELECT o.Id_Osrodek, Nazwa_Osrodek, EXTRACT(YEAR FROM Data_Egzamin) AS Rok FROM 
        Osrodki o INNER JOIN Egzaminy e ON e.Id_Osrodek = o.Id_Osrodek;
    CURSOR c2(p_IdOsrodek OSrodki.ID_Osrodek%TYPE, pData NUMBER) IS SELECT s.ID_Student, Imie, Nazwisko
        FROM Studenci s INNER JOIN Egzaminy e ON e.Id_Student = s.Id_Student
        WHERE e.Id_Osrodek = p_IdOsrodek AND EXTRACT(YEAR FROM Data_Egzamin) = pData;
    FUNCTION kontrolaStudenta(pId NUMBER, rok NUMBER, pIdStudent VARCHAR2) RETURN BOOLEAN IS bral BOOLEAN DEFAULT FALSE;
        x varchar2(1);
        BEGIN
            SELECT DISTINCT 'X' INTO x FROM Egzaminy WHERE Id_Osrodek = pId AND EXTRACT(YEAR FROM Data_Egzamin) = rok
                AND ID_Student = pIdStudent;
                RETURN TRUE;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN RETURN FALSE;
        END kontrolaStudenta;
BEGIN
    FOR vc1 IN c1 LOOP 
            dbms_output.put_line('-----------------');
            dbms_output.put_line(vc1.Nazwa_Osrodek || ' ' || vc1.Rok);
        FOR vc2 IN c2(vc1.Id_Osrodek, vc1.Rok) LOOP
            IF kontrolaStudenta(vc1.Id_Osrodek, vc1.Rok, vc2.Id_Student) THEN
                dbms_output.put_line(vc2.Id_Student || ' ' || vc2.Imie || ' ' || vc2.Nazwisko);
            END IF;
        END LOOP;
    END LOOP;
END;


--Zadanie 8

DECLARE
    TYPE StudType IS RECORD(idStudent Varchar2(7), Imie VARCHAR2(50), Nazwisko VARCHAR2(30),
        Liczba_egz NUMBER, Suma_pkt NUMBER);
    TYPE StudData IS TABLE OF StudType;
    NT_Studenci StudData := StudData();
    i NUMBER DEFAULT 0;
    CURSOR c1 IS SELECT e.Id_Student, Imie, Nazwisko, COUNT(Id_Egzamin) AS Liczba_Egz,
        SUM(punkty) AS punkty FROM Studenci s INNER JOIN Egzaminy e ON e.Id_Student = s.Id_Student
        GROUP BY e.Id_Student, Imie, Nazwisko
        ORDER BY 4 DESC;
BEGIN
    FOR vc1 IN c1 LOOP
        i:= c1%ROWCOUNT;
        NT_Studenci.EXTEND;
        NT_Studenci(i):= StudType(vc1.Id_Student, vc1.Imie, vc1.Nazwisko, vc1.Liczba_egz, vc1.punkty);
        dbms_output.put_line(NT_Studenci(i).idStudent || ' ' ||NT_Studenci(i).Imie || ' ' || 
            NT_Studenci(i).Nazwisko || ' ' || NT_Studenci(i).Liczba_egz || ' ' || NT_Studenci(i).Suma_pkt);
    END LOOP;
END;

