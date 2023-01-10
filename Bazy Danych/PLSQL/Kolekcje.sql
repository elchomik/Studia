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