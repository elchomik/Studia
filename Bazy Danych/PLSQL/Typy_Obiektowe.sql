--Zadanie 238
CREATE OR REPLACE TYPE T_Student_Obj AS OBJECT(Id_Student VARCHAR2(7), Nazwisko VARCHAR2(40), Imie VARCHAR2(20));
DECLARE
    Student_Obj T_Student_Obj := T_Student_Obj('0000007','Muryjas', 'Mateusz');
BEGIN
    NULL;
END;

--Zadanie 239
CREATE OR REPLACE TYPE T_Osrodek_Obj AS OBJECT (Id_Osrodek NUMBER(3), Nazwa_Osrodek VARCHAR2(40), Nazwa_s VARCHAR2(5),
            MEMBER PROCEDURE Gen_Skr_Osr(Nazwa_Osrodek VARCHAR2));
CREATE OR REPLACE TYPE BODY T_Osrodek_Obj AS 
    MEMBER PROCEDURE Gen_Skr_Osr(Nazwa_Osrodek VARCHAR2) IS
    BEGIN
        IF Nazwa_Osrodek IS NOT NULL THEN
        SELF.Nazwa_s:=SUBSTR(Nazwa_Osrodek,1,2) || TO_CHAR(Sq_Osrodek.NEXTVAL);
        END IF;
    END Gen_Skr_Osr;
END;

DECLARE
    V_OsrObj1 T_OsrodekObj:= T_OsrodekObj(1,'CKMP',NULL);
    V_OsrObj2 T_OsrodekObj:= T_OsrodekObj(2,'WSIZ',NULL);
BEGIN
    V_OsrObj1.Gen_Skr_Osr;
    dbms_output.put_line(V_OsrObj1.Nazwa_s);
    V_OsrObj2.Gen_Skr_Osr;
    dbms_output.put_line(V_OsrObj2.Nazwa_s);
END;


--Zadanie 240
CREATE OR REPLACE TYPE T_Student_Obj AS OBJECT(ID_Student NUMBER(5), Imie VARCHAR2(20), Nazwisko VARCHAR2(40));
CREATE TABLE Studenci_Obj(Student T_Student_Obj);
DECLARE
    v_Stud T_Student_Obj;
    CURSOR c1 IS SELECT Student FROM Studenci_Obj;
BEGIN
    INSERT INTO Studenci_Obj VALUES(T_Student_Obj(1,'Mateusz','Muryjas'));
    INSERT INTO Studenci_Obj VALUES(T_Student_Obj(2,'Micha³','Baræ'));
    INSERT INTO Studenci_Obj VALUES(T_Student_Obj(3,'Anna','Muryjas'));
    
    OPEN c1;
    LOOP
        FETCH c1 INTO v_Stud;
        EXIT WHEN c1%NOTFOUND;
        dbms_output.put_line(v_Stud.Id_Student || ' ' || v_Stud.Imie || ' ' || v_Stud.Nazwisko);
    END LOOP;
    CLOSE c1;
END;

--Zadanie 241
CREATE OR REPLACE TYPE T_Egzaminator_Obj AS OBJECT(
    Id_Egzaminator NUMBER(5),
    Nazwisko VARCHAR2(40),
    Imie VARCHAR2(20));
CREATE TABLE Egzaminatorzy_Obj OF T_Egzaminator_Obj;

INSERT INTO Egzaminatorzy_Obj VALUES(T_Egzaminator_Obj(1,'Muryjas','Mateusz'));
INSERT INTO Egzaminatorzy_Obj VALUES(T_Egzaminator_Obj(2,'Baræ','Micha³'));
INSERT INTO Egzaminatorzy_Obj VALUES(T_Egzaminator_Obj(3,'Muryjas','Piotr'));
DECLARE
    v_Egzaminator T_Egzaminator_Obj;
    CURSOR c1 IS SELECT VALUE(Egzam) FROM Egzaminatorzy_Obj Egzam;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO v_Egzaminator;
        EXIT WHEN c1%NOTFOUND;
        dbms_output.put_line(v_Egzaminator.Id_Egzaminator || ' ' || v_Egzaminator.Nazwisko || ' ' || v_Egzaminator.Imie);
    END LOOP;
    CLOSE c1;
END;