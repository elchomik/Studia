-- Zadanie 209
SET SERVEROUTPUT ON 
SELECT  COUNT(ID_Egzamin) AS liczba_egzaminow
        FROM Egzaminy e RIGHT JOIN Osrodki o 
        ON e.ID_Osrodek = o.ID_Osrodek
        WHERE Nazwa_Osrodek = 'LBS'
        GROUP BY o.ID_Osrodek;

DECLARE
    NO_FOUND EXCEPTION;
    NO_EXISTS EXCEPTION;
    CURSOR c1 is SELECT COUNT(ID_Egzamin) AS liczba_egzaminow
        FROM Egzaminy e RIGHT JOIN Osrodki o 
        ON e.ID_Osrodek = o.ID_Osrodek
        WHERE Nazwa_Osrodek = 'LBS'
        GROUP BY o.ID_Osrodek;
BEGIN
    FOR vc1 in c1 LOOP 
        BEGIN
        IF vc1.liczba_egzaminow IS NULL THEN
            RAISE NO_EXISTS;
        ELSIF vc1.liczba_egzaminow = 0 THEN
            RAISE NO_FOUND;
        END IF;
          dbms_output.put_line('W danym oœrodku odby³o siê ' || vc1.liczba_egzaminow || ' egzaminow');
        EXCEPTION
            WHEN
                NO_EXISTS THEN 
                    dbms_output.put_line('Oœrodek o podanej nazwie nie istnieje');
            WHEN NO_FOUND THEN
                    dbms_output.put_line('Oœrodek nie uczestniczy³ w egzaminach');
        END;
    END LOOP;
END;


-- KOLEKCJA PL/SQL

--ZADANIE 214
DECLARE
    TYPE Typ_NT IS TABLE OF NUMBER;
    NT_Lista Typ_NT := Typ_NT(10,50,100);
BEGIN
    NULL;
END;


--Zadanie 215

DECLARE
    Type Typ_NT IS TABLE OF NUMBER;
    NT_Lista Typ_NT := Typ_NT(10,50,100);
BEGIN
    NT_Lista.EXTEND ;
    NT_Lista(4) := 150;
    
    FOR i IN 1..NT_Lista.count LOOP
        dbms_output.put_line( NT_Lista(i));
    END LOOP;
END;

--Zadanie 216
DECLARE
    TYPE Typ_NTP IS TABLE OF Przedmioty.Nazwa_Przedmiot%TYPE;
    NT_Przedmioty Typ_NTP := Typ_NTP();
    i NUMBER DEFAULT 0;
    CURSOR c1 is SELECT Nazwa_Przedmiot FROM Przedmioty ORDER BY 1;
BEGIN
    FOR vc1 IN c1 LOOP
        i:= i+1;
        NT_Przedmioty.EXTEND;
        NT_Przedmioty(i) := vc1.Nazwa_Przedmiot;
    END LOOP;
END;

--Zadanie 217
CREATE OR REPLACE TYPE Typ_Harm_Obj AS Object(Nazwa_Przedmiot VARCHAR(40), Data_Egzamin DATE);
CREATE OR REPLACE TYPE Typ_Harm IS TABLE OF Typ_Harm_Obj;
CREATE TABLE Harmonogram(ID_Osrodek NUMBER(3) PRIMARY KEY, Plany Typ_Harm)
    NESTED TABLE Plany STORE AS Plan_tabela;
    
--Zadanie 218
DECLARE 
    vHarm Typ_Harm := Typ_Harm(Typ_Harm_Obj('Hurtowanie danych','12-01-15'));
BEGIN
    INSERT INTO Harmonogram VALUES(3, Typ_Harm(Typ_Harm_Obj('Bazy danych','12-01-15'),
                                      Typ_Harm_Obj('Jêzyki baz danych', '12-01-20')));
    INSERT INTO Harmonogram VALUES(1, vHarm);
END;


--Zadanie 219
SELECT INTO THE(SELECT Plany FROM Harmonogram WHERE ID_OSRODEK=1)
    VALUES (Typ_Harm_Obj('Business Intelligence','12-02-05'));
    
--Zadanie 221
DECLARE
    TYPE Typ_Rec_Osr IS RECORD(Id Osrodki.ID_Osrodek%TYPE,
                                Nazwa Osrodki.Nazwa_Osrodek%TYPE);
    TYPE Typ_VTO IS VARRAY(999) OF Typ_Rec_Osr;
    VT_Osrodki Typ_VTO := Typ_VTO();
    CURSOR c1 IS SELECT Id_Osrodek, Nazwa_Osrodek FROM Osrodki;
    i NUMBER DEFAULT 0;
BEGIN
    FOR vc1 IN c1 LOOP
     i:=c1%ROWCOUNT;
     VT_Osrodki.EXTEND;
     VT_Osrodki(i) := vc1;
     dbms_output.put_line(VT_Osrodki(i).Id || ' ' || VT_Osrodki(i).Nazwa);
    END LOOP;
    EXCEPTION
        WHEN SUBSCRIPT_BEYOND_COUNT THEN
            dbms_output.put_line('Licznik poza zakresem');
END;

--Zadanie 222
CREATE OR REPLACE Type Typ_VT_Terminy IS VARRAY(365) OF DATE;
CREATE TABLE studenci_Terminy(Id_Student VARCHAR2(7), Terminy Typ_VT_Terminy);

DECLARE
   i NUMBER DEFAULT 0;
   VT_Terminy Typ_VT_Terminy := Typ_VT_Terminy();
   CURSOR cStudent IS SELECT Id_Student FROM Studenci;
   CURSOR cTerminy(p_IdStudent VARCHAR2) IS SELECT DISTINCT Data_Egzamin FROM Egzaminy WHERE Id_Student = p_IdStudent; 
BEGIN
    FOR vStudent IN cStudent LOOP
        dbms_output.put_line('------');
        dbms_output.put_line('Student: ' || vStudent.Id_Student);
        FOR vTermin IN cTerminy(vStudent.Id_Student) LOOP
             i:= cTerminy%ROWCOUNT;
             VT_Terminy.EXTEND;
             VT_Terminy(i):= vTermin.Data_Egzamin;
             dbms_output.put_line('Data: ' || VT_Terminy(i));
        END LOOP;
        INSERT INTO studenci_Terminy VALUES(vStudent.Id_Student, VT_Terminy);
        VT_Terminy :=Typ_VT_Terminy();
    END LOOP;
END;

--Zadanie 223
DECLARE
    TYPE Osrodki_rec IS RECORD (Id Osrodki.Id_Osrodek%TYPE,
                              Nazwa_Osrodek Osrodki.Nazwa_Osrodek%TYPE);
    TYPE Osrodki_VT IS VARRAY(999) OF Osrodki_rec;
    NT_Osrodki Osrodki_VT := Osrodki_VT();
    CURSOR c1 IS SELECT Id_Osrodek, Nazwa_Osrodek FROM Osrodki;
    i NUMBER DEFAULT 0;
BEGIN
    FOR vc1 IN c1 LOOP
     i:=c1%ROWCOUNT;
     NT_Osrodki.EXTEND;
     NT_Osrodki(i) := vc1;
     dbms_output.put_line(NT_osrodki(i).Id || ' ' || NT_osrodki(i).Nazwa_Osrodek);
    END LOOP;
    
    EXCEPTION
        WHEN SUBSCRIPT_BEYOND_COUNT THEN
            dbms_output.put_line('Licznik poza zakresem');
END;


--Zadanie 224
DECLARE
    TYPE Osrodki_rec IS RECORD (Id_Osrodek Osrodki.Id_Osrodek%TYPE,
                              Nazwa_Osrodek Osrodki.Nazwa_Osrodek%TYPE);
    TYPE Osrodki_VT IS TABLE OF Osrodki_rec;
    NT_Osrodki Osrodki_VT := Osrodki_VT();
    CURSOR c1 IS SELECT Id_Osrodek, Nazwa_Osrodek FROM Osrodki;
    zmienna Osrodki_rec;
    i NUMBER DEFAULT 0;
    FUNCTION checkIfExamExists(Id_osrodek Osrodki.ID_Osrodek%TYPE) RETURN BOOLEAN IS
        x VARCHAR(1);
        BEGIN
            SELECT DISTINCT 'X' INTO x FROM Egzaminy e WHERE e.ID_Osrodek = Id_osrodek;
                RETURN TRUE;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                RETURN FALSE;
        END;
BEGIN
    FOR vc1 IN c1 LOOP
      i:=c1%ROWCOUNT;
     NT_Osrodki.EXTEND;
     NT_Osrodki(i) := vc1;
     dbms_output.put_line(NT_osrodki(i).Id_Osrodek || ' ' || NT_osrodki(i).Nazwa_Osrodek);
    END LOOP;
    dbms_output.put_line('====================>');
    FOR i IN NT_Osrodki.FIRST..NT_Osrodki.COUNT() LOOP
        IF NOT (checkIfExamExists(NT_Osrodki(i).Id_Osrodek)) THEN
            NT_Osrodki.DELETE(i);
        END IF;
    END LOOP;
    dbms_output.put_line('Lista oœrodków po usuniêciu');
    FOR i IN NT_Osrodki.FIRST..NT_Osrodki.COUNT() LOOP
        dbms_output.put_line(NT_Osrodki(i).Id_Osrodek || ' ' || NT_osrodki(i).Nazwa_Osrodek);
    END LOOP;
    EXCEPTION
        WHEN SUBSCRIPT_BEYOND_COUNT THEN
            dbms_output.put_line('Licznik poza zakresem');
END;


--Zadanie 225
DESCRIBE Egzaminy;
CREATE OR REPLACE TYPE TPrzedmiotyObj AS OBJECT(Nazwa_Przedmiot VARCHAR2(100),
                                                Data_Egzamin DATE);
CREATE OR REPLACE TYPE TPrzedmioty IS TABLE OF TPrzedmiotyObj;
CREATE TABLE Indeks2(Id_Student VARCHAR2(7), Nazwisko VARCHAR2(50), Imie VARCHAR2(50),
                                T_Przedmioty TPrzedmioty) NESTED TABLE T_Przedmioty STORE AS Tabela_Przedmioty;
                                
DECLARE
        wynik TPrzedmioty := TPrzedmioty();
        i NUMBER DEFAULT 0;
        CURSOR cStudenci IS SELECT ID_Student, Nazwisko, Imie FROM Studenci;
        CURSOR cPrzedmioty(p_IdStudent Studenci.ID_Student%TYPE) IS SELECT 
            Nazwa_Przedmiot, Data_Egzamin FROM Egzaminy e INNER JOIN Przedmioty p
            ON p.Id_Przedmiot = e.Id_Przedmiot WHERE e.ID_Student = p_IdStudent
                AND zdal='T';
BEGIN
    FOR vc1 IN cStudenci LOOP
        dbms_output.put_line('-------');
        dbms_output.put_line(vc1.Id_Student || ' ' || vc1.Nazwisko || ' ' || vc1.Imie);
        FOR vc2 IN cPrzedmioty(vc1.Id_Student) LOOP
            i:= cPrzedmioty%ROWCOUNT;
            wynik.EXTEND;
            wynik(i):= TPrzedmiotyObj(vc2.Nazwa_Przedmiot, vc2.Data_Egzamin);
            dbms_output.put_line(vc2.Nazwa_Przedmiot || ' ' || vc2.Data_Egzamin);
        END LOOP;
        INSERT INTO Indeks2 VALUES(vc1.Id_Student, vc1.Nazwisko, vc1.Imie, wynik);
        wynik := TPrzedmioty();
    END LOOP;
END;
SELECT * FROM Indeks2;


--Zadanie 228
DESCRIBE Osrodki;
DESCRIBE Egzaminatorzy;
CREATE OR REPLACE TYPE TEgzaminyObj AS OBJECT (Id_Egzaminator Number, Nazwisko VARCHAR2(25), Imie VARCHAR2(15),
                                    Liczba_egzaminow NUMBER);
CREATE OR REPLACE TYPE TEgzaminy IS TABLE OF TEgzaminyObj;
CREATE TABLE Analityka(Id_Osrodek NUMBER, Nazwa_Osrodek VARCHAR2(50),
                        T_Egzaminy TEgzaminy) NESTED TABLE T_Egzaminy STORE AS Tabela_Egzaminy;
DECLARE
    wynik TEgzaminy := TEgzaminy();
    i NUMBER DEFAULT 0;
    CURSOR cOsrodki IS SELECT Id_Osrodek, Nazwa_Osrodek FROM Osrodki;
    CURSOR cEgzaminatorzy(p_IdOsrodek Osrodki.Id_Osrodek%TYPE) IS SELECT
        e.Id_Egzaminator, Nazwisko, Imie, COUNT(Id_Egzamin) AS Liczba_egzaminow FROM
        Egzaminatorzy egz INNER JOIN Egzaminy e ON e.Id_Egzaminator = egz.Id_Egzaminator
        WHERE e.Id_Osrodek = p_IdOsrodek GROUP BY e.Id_Egzaminator, Nazwisko, Imie;
BEGIN
    FOR vc1 IN cOsrodki LOOP
    dbms_output.put_line('--Osrodek--');
    dbms_output.put_line(vc1.ID_Osrodek || ' ' || vc1.Nazwa_Osrodek);
        FOR vc2 IN cEgzaminatorzy(vc1.Id_Osrodek) LOOP
            i:=cEgzaminatorzy%ROWCOUNT;
            wynik.EXTEND;
            wynik(i):= TEgzaminyObj(vc2.ID_Egzaminator, vc2.Nazwisko, vc2.Imie, vc2.Liczba_Egzaminow);
            dbms_output.put_line(vc2.ID_Egzaminator || ' ' || vc2.Nazwisko || ' ' || vc2.Imie || ' ' || vc2.Liczba_Egzaminow);
        END LOOP;
        INSERT INTO Analityka VALUES(vc1.Id_Osrodek, vc1.Nazwa_Osrodek, wynik);
        wynik := TEgzaminy();
    END LOOP;
END;

--Zadanie 229
DESCRIBE analityka;
select a.*,  nt.* 
    from Analityka a, table(a.t_egzaminy) nt; 


--Zadanie 230
CREATE OR REPLACE TYPE T_OsrodekObj AS OBJECT(Id_Osrodek NUMBER, Nazwa_Osrodek VARCHAR2(50), Liczba_egzaminow NUMBER);
CREATE OR REPLACE TYPE T_Osrodek IS TABLE OF T_OsrodekObj;
CREATE TABLE Analityka_Studenci(ID_Student VARCHAR2(7), Nazwisko VARCHAR2(50), Imie VARCHAR2(50), 
            TOsrodek T_Osrodek) NESTED TABLE TOsrodek STORE AS Tabela_Osrodek;
DECLARE
    wynik T_Osrodek := T_Osrodek();
    i NUMBER DEFAULT 0;
    CURSOR cStudenci IS SELECT Id_Student, Nazwisko, Imie FROM Studenci;
    CURSOR cOsrodki(p_IdStudent Studenci.ID_Student%TYPE) IS SELECT e.Id_Osrodek, Nazwa_Osrodek, COUNT(ID_Egzamin) AS Liczba_Egzaminow
        FROM Egzaminy e INNER JOIN Osrodki o ON e.ID_Osrodek = o.Id_Osrodek
        WHERE e.ID_Student = p_IdStudent
        GROUP BY e.ID_Osrodek, Nazwa_Osrodek;
BEGIN
    FOR vc1 IN cStudenci LOOP
        FOR vc2 IN cOsrodki(vc1.ID_Student) LOOP
            i:=cOsrodki%ROWCOUNT;
            wynik.EXTEND;
            wynik(i):=T_OsrodekObj(vc2.Id_Osrodek, vc2.Nazwa_Osrodek, vc2.Liczba_Egzaminow);
        END LOOP;
        INSERT INTO Analityka_Studenci VALUES(vc1.Id_Student, vc1.Nazwisko, vc1.Imie, wynik);
        wynik:=T_Osrodek();
    END LOOP;
END;

DESCRIBE Analityka_Studenci;
select a.*,  nt.* 
    from Analityka_Studenci a, table(a.tosrodek) nt; 


--Zadanie 232
DECLARE
    TYPE Record_Studenci IS RECORD (Id_Student Studenci.ID_Student%TYPE, Liczba_egzaminow NUMBER);
    TYPE Typ_VTS IS VARRAY(999) OF Record_Studenci;
    VT_Studenci Typ_VTS := TYP_VTS();
    i NUMBER DEFAULT 0;
    CURSOR c1 IS SELECT s.Id_Student, COUNT(ID_Egzamin) AS Liczba_egzaminow 
        FROM Studenci s LEFT JOIN Egzaminy e ON s.Id_Student = e.Id_Student
        GROUP BY s.Id_Student
         ORDER BY 2 DESC;
BEGIN
    FOR vc1 IN c1 LOOP
     i:=c1%ROWCOUNT;
     VT_Studenci.EXTEND;
     VT_Studenci(i):=vc1;
     dbms_output.put_line(VT_Studenci(i).Id_Student || ' ' || VT_Studenci(i).Liczba_egzaminow);
    END LOOP;
EXCEPTION
    WHEN SUBSCRIPT_BEYOND_COUNT THEN
        dbms_output.put_line('Licznik poza zakresem');
END;

--Zadanie 234
CREATE OR REPLACE TYPE Typ_Terminy IS VARRAY(365) OF DATE;
CREATE TABLE Przedmioty_Terminy(Nazwa_Przedmiot VARCHAR2(50), Terminy Typ_Terminy);
DECLARE 
        wynik Typ_Terminy :=Typ_Terminy();
        i NUMBER DEFAULT 0;
        CURSOR cPrzedmioty IS SELECT Id_Przedmiot, Nazwa_Przedmiot FROM Przedmioty;
        CURSOR cDane(p_IdPrzedmiot Przedmioty.Id_Przedmiot%TYPE) IS SELECT
            DISTINCT Data_Egzamin FROM Egzaminy e WHERE e.Id_Przedmiot = p_IdPrzedmiot;
BEGIN
    FOR vc1 IN cPrzedmioty LOOP
        dbms_output.put_line('---');
        dbms_output.put_line(vc1.Id_Przedmiot || ' ' || vc1.Nazwa_Przedmiot);
        FOR vc2 IN cDane(vc1.Id_Przedmiot) LOOP
            i:=cDane%ROWCOUNT;
            wynik.EXTEND;
            wynik(i):=vc2.Data_Egzamin;
            dbms_output.put_line(wynik(i));
        END LOOP;
        INSERT INTO Przedmioty_Terminy VALUES(vc1.Nazwa_Przedmiot, wynik);
        wynik := Typ_Terminy();
    END LOOP;
END;

--Zadanie 236
CREATE OR REPLACE TYPE Typ_Przedmioty_Obj AS OBJECT(Nazwa_Przedmiot VARCHAR2(50),
                        liczba_niezdanych_egzaminow NUMBER, liczba_egzaminow NUMBER);
CREATE OR REPLACE TYPE Typ_Przedmioty IS TABLE OF Typ_Przedmioty_Obj ;
CREATE Table Analityka_Egzamin(Id_Student VARCHAR(7) , Imie VARCHAR2(50), Nazwisko VARCHAR2(50),
        Przedmiot Typ_Przedmioty)
        NESTED TABLE Przedmiot STORE AS Przedmioty_tabela;
DECLARE
    wynik Typ_Przedmioty := Typ_Przedmioty();
    i NUMBER DEFAULT 0;
    CURSOR cStudenci IS SELECT Id_Student, Imie, Nazwisko FROM Studenci;
    CURSOR cPrzedmiotyDane(p_IdStudent Studenci.Id_Student%TYPE) IS SELECT Nazwa_Przedmiot, 
            (select COUNT(Id_Egzamin) AS Liczba_niezdanych FROM Egzaminy e 
                WHERE zdal = 'N' AND e.ID_Student = p_IdStudent and e.id_przedmiot = p.id_przedmiot ) AS Liczba_Nzd, 
                (select COUNT(Id_Egzamin) AS liczba_egzaminow FROM Egzaminy e WHERE e.ID_Student = p_IdStudent 
                                and e.id_przedmiot = p.id_przedmiot ) AS Liczba
        from przedmioty p ;
BEGIN
    FOR vc1 IN cStudenci LOOP
    dbms_output.put_line('----------');
    dbms_output.put_line(vc1.Id_Student || ' ' || vc1.Imie || ' ' || vc1.Nazwisko);
        FOR vc2 IN cPrzedmiotyDane(vc1.Id_Student) LOOP
            i:= cPrzedmiotyDane%ROWCOUNT;
            wynik.EXTEND;
            wynik(i) := Typ_Przedmioty_Obj(vc2.Nazwa_przedmiot, vc2.Liczba_Nzd, vc2.Liczba ) ;
            dbms_output.put_line(vc2.Nazwa_Przedmiot || ' ' || vc2.Liczba_Nzd || ' ' || vc2.Liczba );
        END LOOP;
         INSERT INTO Analityka_Egzamin VALUES (vc1.id_student,  vc1.imie, vc1.nazwisko, wynik);
        wynik := Typ_Przedmioty();
    END LOOP;
END;


select ae.ID_STudent, nt.nazwa_przedmiot, nt.liczba_niezdanych_egzaminow, nt.liczba_egzaminow from Analityka_egzamin ae, table(ae.przedmiot) nt ;