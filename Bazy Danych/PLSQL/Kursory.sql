--Kursory w PL/SQL

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

--Zadanie 191
DECLARE 
    CURSOR c1 IS SELECT  DISTINCT s.Id_Student, Imie, Nazwisko, Data_Egzamin
        FROM Studenci s INNER JOIN Egzaminy e
        ON s.Id_Student = e.Id_Student
        ORDER BY 4 DESC;
    wynik c1%ROWTYPE;
BEGIN
    OPEN c1;
    IF c1%ISOPEN THEN
        FOR i in 1..3 LOOP
            FETCH c1 INTO wynik;
            dbms_output.put_line(wynik.Id_Student || ' ' || wynik.Imie || ' ' || wynik.Nazwisko || ' ' || wynik.Data_Egzamin);
        END LOOP;
        CLOSE c1;
    END IF;
END;

--Zadanie 192
DECLARE
    CURSOR c1 IS SELECT o.Id_Osrodek, Nazwa_Osrodek, s.Id_Student, Nazwisko, Imie, COUNT(ID_Egzamin) AS Liczba
        FROM Studenci s INNER JOIN Egzaminy e ON e.Id_Student = s.Id_Student
        INNER JOIN Osrodki o ON o.Id_Osrodek = e.Id_Osrodek
        WHERE Nazwa_Osrodek = 'CKMP'
        GROUP BY o.Id_Osrodek, Nazwa_Osrodek, s.Id_Student, Nazwisko, Imie
        ORDER BY Liczba DESC;
    wynik c1%ROWTYPE;
BEGIN
    OPEN c1;
    IF c1%ISOPEN THEN
        FOR i IN 1..2 LOOP
        FETCH c1 INTO wynik;
         dbms_output.put_line(wynik.Id_Student || ' ' || wynik.Imie || ' ' || wynik.Nazwisko || ' ' ||wynik.liczba);
        END LOOP;
        close c1;
    END IF;
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