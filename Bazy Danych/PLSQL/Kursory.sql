--Kursory w PL/SQL
SET SERVEROUTPUT ON;
--Zadanie 184
BEGIN
    FOR i in 1..100 LOOP
        IF MOD(i,2) = 0 THEN
            dbms_output.put_line(i);
        END IF;
    END LOOP;
END;

--Zadamoe 185
DECLARE
    i NUMBER DEFAULT 0;
    CURSOR CStudent IS SELECT ID_Student, Nazwisko, Imie FROM Studenci ORDER BY Nazwisko, Imie;
BEGIN
    FOR wiersz IN CStudent LOOP
        i:= i+1;
        dbms_output.put_line(i || ' ' || wiersz.ID_Student || ' ' || wiersz.Nazwisko || ' ' || wiersz.Imie);
    END LOOP;
END;

--Zadanie 186
DECLARE
    vData DATE;
    CURSOR CEgzaminy IS SELECT Data_Egzamin From Egzaminy ORDER BY 1 DESC; 
BEGIN
    OPEN CEgzaminy;
    IF CEgzaminy%ISOPEN THEN
        FOR i IN 1..3 LOOP
            FETCH CEgzaminy INTO vData;
            EXIT WHEN CEgzaminy%NOTFOUND;
            dbms_output.put_line(vData);
        END LOOP;
    CLOSE CEgzaminy;
    END IF;
END;


--Zadanie 187
CREATE TRIGGER BI_Przedmioty BEFORE INSERT ON Przedmioty FOR EACH ROW
    DECLARE
        imax Przedmioty.Id_Przedmiot%TYPE;
    BEGIN
        SELECT MAX(Id_Przedmiot) INTO imax FROM Przedmioty;
        :new.Id_przedmiot := imax+1;
    END;
    
--Zadanie 188

DECLARE
    i NUMBER DEFAULT 0;
    CURSOR CEgzaminatorzy IS SELECT Id_Egzaminator, Nazwisko, Imie FROM Egzaminatorzy ORDER BY 2,3;
BEGIN
    FOR wiersz IN CEgzaminatorzy LOOP
        i:= i+1;
        dbms_output.put_line(i || ' ' || wiersz.Id_Egzaminator || ' ' || wiersz.Nazwisko || ' ' || wiersz.Imie);
    END LOOP;
END;


--Zadanie 189 
DECLARE 
    CURSOR c1 IS SELECT o.ID_Osrodek, Nazwa_Osrodek, COUNT(DISTINCT ID_Egzamin) AS Liczba FROM 
        Egzaminy e INNER JOIN Osrodki o ON e.Id_osrodek = o.Id_osrodek
        GROUP BY o.ID_OSrodek,Nazwa_Osrodek
        ORDER BY 2 ASC;
     osrodek c1%ROWTYPE;
    
BEGIN
     DBMS_OUTPUT.PUT_LINE('Oœrodki z liczb¹ egzaminów mniejsz¹ ni¿ 5:');
     DBMS_OUTPUT.PUT_LINE('------------------------------------------');
     OPEN c1;
     WHILE c1%FOUND LOOP 
        FETCH c1 INTO osrodek;
        IF osrodek.Liczba < 5 THEN
        DBMS_OUTPUT.PUT_LINE(osrodek.Id_osrodek || ' ' || osrodek.Nazwa_osrodek || ' ' || osrodek.liczba);
        END IF;
        FETCH c1 INTO osrodek;
     END LOOP;
     CLOSE c1;
     
     DBMS_OUTPUT.PUT_LINE('Oœrodki z liczb¹ egzaminów wiêksza ni¿ 5  i mniejsz¹ ni¿ 10:');
     DBMS_OUTPUT.PUT_LINE('------------------------------------------');
     OPEN c1;
     WHILE c1%FOUND LOOP 
        FETCH c1 INTO osrodek;
        IF osrodek.liczba > 5 AND osrodek.Liczba <=10 THEN
        DBMS_OUTPUT.PUT_LINE(osrodek.Id_osrodek || ' ' || osrodek.Nazwa_osrodek || ' ' || osrodek.liczba);
        END IF;
        FETCH c1 INTO osrodek;
     END LOOP;
     CLOSE c1;
     
     DBMS_OUTPUT.PUT_LINE('Oœrodki z liczb¹ egzaminów wiêksza ni¿ 10:');
     DBMS_OUTPUT.PUT_LINE('------------------------------------------');
     OPEN c1;
     WHILE c1%FOUND LOOP 
        FETCH c1 INTO osrodek;
        IF osrodek.liczba >10 THEN
        DBMS_OUTPUT.PUT_LINE(osrodek.Id_osrodek || ' ' || osrodek.Nazwa_osrodek || ' ' || osrodek.liczba);
        END IF;
        FETCH c1 INTO osrodek;
     END LOOP;
     CLOSE c1;
END;


--Zadanie 190
DECLARE
    CURSOR c1 IS SELECT Nazwa_Przedmiot, COUNT(DISTINCT ID_Egzamin) AS liczba FROM Przedmioty 
        p INNER JOIN Egzaminy e ON e.Id_Przedmiot = p.Id_Przedmiot
        GROUP BY Nazwa_Przedmiot
        ORDER BY liczba DESC;
    wynik c1%ROWTYPE;
BEGIN
    OPEN c1;
    IF c1%ISOPEN THEN
        FOR i in 1..3 LOOP
            FETCH c1 INTO wynik;
            EXIT WHEN c1%NOTFOUND;
            dbms_output.put_line(wynik.Nazwa_Przedmiot || ' ' || wynik.liczba);
        END LOOP;
    CLOSE c1;
    END IF;
END;

--Zadanie 191 sposób prawilny
DECLARE
    CURSOR c1 IS SELECT DISTINCT Data_Egzamin FROM Egzaminy;
    CURSOR cStudenci(pData Egzaminy.Data_Egzamin%TYPE) IS SELECT
        e.Id_Student, Nazwisko, Imie FROM Studenci s INNER JOIN
        Egzaminy e ON e.Id_Student = s.Id_Student AND Data_Egzamin = pData ORDER BY 1;
BEGIN
    FOR vc1 IN c1 LOOP
        EXIT WHEN c1%ROWCOUNT>3;
        dbms_output.put_line(vc1.Data_Egzamin);
        FOR vc2 IN cStudenci(vc1.Data_Egzamin) LOOP
            dbms_output.put_line(vc2.Id_Student || ' ' || vc2.Nazwisko || ' ' || vc2.Imie);
        END LOOP;
    END LOOP;
END;


--Zadanie 192 sposób prawilny
DECLARE
    CURSOR c1 IS SELECT DISTINCT o.Id_Osrodek, Nazwa_Osrodek FROM Osrodki o
        INNER JOIN Egzaminy e ON e.Id_Osrodek = o.Id_Osrodek AND
        Nazwa_Osrodek = 'CKMP';
    CURSOR c2(p_Id_Osrodek Osrodki.Id_Osrodek%TYPE) IS SELECT e.Id_Student,Imie,Nazwisko, COUNT(Id_Egzamin) AS Liczba_egzaminow
        FROM Studenci s INNER JOIN Egzaminy e ON s.Id_Student = e.Id_Student
        INNER JOIN Osrodki o ON o.Id_Osrodek = e.Id_Osrodek
        WHERE e.Id_Osrodek = p_Id_Osrodek
        GROUP BY e.Id_Student,Imie,Nazwisko
        ORDER BY 4 DESC;
BEGIN
    FOR vc1 IN c1 LOOP
            dbms_output.put_line(vc1.Id_Osrodek || ' ' || vc1.Nazwa_Osrodek);
        FOR vc2 IN c2(vc1.Id_Osrodek) LOOP
            EXIT WHEN c2%ROWCOUNT>2;
            dbms_output.put_line(vc2.Id_Student || ' ' || vc2.Imie || ' ' || vc2.Nazwisko || ' ' || vc2.Liczba_Egzaminow);
        END LOOP;
    END LOOP;
END;


--Zadanie 194

DECLARE
    CURSOR c1 IS SELECT zdal FROM Egzaminy FOR UPDATE;
    minVal INT;
    maxVal INT;
BEGIN
    FOR vc1 IN c1 LOOP
        IF UPPER(vc1.zdal) = 'T' THEN
            minVal :=3;
            maxVal :=5;
        ELSE
            minVal :=2;
            maxVal :=2.99;
        END IF;
        UPDATE Egzaminy SET Punkty = ROUND(dbms_random.value(minVal,maxVal),2)
            WHERE CURRENT OF c1;
    END LOOP;
END;


--Zadanie 195 
DECLARE
    CURSOR c1 IS SELECT Id_Student, Nazwisko, Imie From Studenci ORDER BY 2,3;
    CURSOR c2(Id_Student VARCHAR) IS SELECT p.Nazwa_Przedmiot, COUNT(*) as liczba
        FROM Przedmioty p INNER JOIN Egzaminy e ON p.Id_Przedmiot = e.Id_Przedmiot
        WHERE e.Id_student = Id_Student
        GROUP BY p.nazwa_przedmiot;
BEGIN
    FOR vc1 IN c1 LOOP
        dbms_output.put_line(vc1.Id_student || ' ' || vc1.Imie || ' ' || vc1.Nazwisko);
        FOR vc2 IN c2(vc1.Id_Student) LOOP
            dbms_output.put_line(vc2.nazwa_przedmiot || ' ' || vc2.liczba);
        END LOOP;
            DBMS_OUTPUT.put_line('============================') ;
    END LOOP;
END;