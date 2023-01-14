--Zadanie 253
DECLARE
    PROCEDURE pDodStudent(pId VARCHAR2, pNazwisko VARCHAR2, pImie VARCHAR2) IS
        BEGIN
            INSERT INTO Studenci(Id_Student,Nazwisko, Imie) VALUES(pId,pNazwisko,pImie);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                dbms_output.put_line('Istnieje student o podanym identyfikatorze');
        END pDodStudent;
BEGIN 
    pDodStudent('000077','Muryjas','Mateusz');
END;

--Zadanie 254
DECLARE
    FUNCTION pJestOsrodek(pId NUMBER) RETURN BOOLEAN IS
        istnieje BOOLEAN DEFAULT FALSE;
        x VARCHAR2(1);
        CURSOR c1 IS SELECT 'X' FROM Osrodki WHERE ID_Osrodek = pId;
    BEGIN
        OPEN c1;
            IF c1%ISOPEN THEN
                FETCH c1 INTO x;
                IF c1%FOUND THEN
                istnieje:=TRUE;
            END IF;
        CLOSE c1;
        END IF;
        RETURN istnieje;
    END pJestOsrodek;
BEGIN
    IF pJestOsrodek(1) THEN
        dbms_output.put_line('Istnieje taki oœrodek');
    ELSE
        dbms_output.put_line('Nie istnieje taki oœrodek');
    END IF;
END;

--Zadanie 255

DECLARE
    PROCEDURE PMOsrodek(p_IdOsrodek NUMBER) IS
            CURSOR c1 IS SELECT Nazwa_Osrodek, Miasto FROM Osrodki WHERE Id_Osrodek = p_IdOsrodek;
            wynik c1%ROWTYPE;
        BEGIN
            OPEN c1;
            FETCH c1 INTO wynik;
            UPDATE Osrodki 
                SET Nazwa_Osrodek = CONCAT('Zaktualizowano ', wynik.Nazwa_Osrodek)
                WHERE Id_Osrodek = p_IdOsrodek;
            
            UPDATE Osrodki
                SET Miasto = CONCAT('Zaktualizowano', wynik.Miasto)
                WHERE Id_Osrodek = p_IdOsrodek;
        END PMOsrodek;
BEGIN
    PMOsrodek(2);
END;


--Zadanie 256
DECLARE
    PROCEDURE wyswietlDane IS
            CURSOR c1 IS SELECT e.Id_Osrodek, Nazwa_Osrodek FROM
                Osrodki o INNER JOIN Egzaminy e ON e.Id_Osrodek = o.Id_Osrodek;
            wynik c1%ROWTYPE;
        BEGIN
            dbms_output.put_line('Oœrodki w których odby³y siê ju¿ egzaminy');
            FOR vc1 IN c1 LOOP
                dbms_output.put_line(vc1.Id_Osrodek || ' ' || vc1.Nazwa_Osrodek);
            END LOOP;
        END wyswietlDane;
BEGIN
    wyswietlDane();
END;

DESCRIBE Egzaminy;
--Zadanie 257
DECLARE
    CURSOR cStudenci IS SELECT Id_Student, Imie, Nazwisko FROM Studenci;
    wynik cStudenci%ROWTYPE;
    punkty NUMBER;
    
    FUNCTION liczbaPunktow(p_IdStudent NUMBER) RETURN NUMBER IS
        sumaPkt NUMBER;
        CURSOR c1 IS SELECT SUM(punkty) FROM Egzaminy 
            WHERE Id_Student = p_IdStudent;
        BEGIN
            OPEN c1;
                FETCH c1 INTO sumaPkt;
                IF sumaPkt IS NULL THEN
                    RETURN -1;
                ELSE 
                    RETURN sumaPkt;
                END IF;
            CLOSE c1;
        END liczbaPunktow;
BEGIN
    FOR vc1 IN cStudenci LOOP
        punkty:=liczbaPunktow(vc1.Id_Student);
        dbms_output.put_line(vc1.Imie || ' ' || vc1.Nazwisko || ' ' || punkty);
    END LOOP;
END;

DESCRIBE Studenci;
--Zadanie 261
DECLARE
  CURSOR c1 IS SELECT Id_Student, Nazwisko, Imie FROM Studenci;
  liczbaWszystkichPrzedmiotow NUMBER;
  dataOstatniegoEgz Egzaminy.Data_Egzamin%TYPE;
  
  FUNCTION ileWszystkichPrzedmiotow RETURN NUMBER IS x NUMBER;
    BEGIN
        SELECT COUNT(DISTINCT ID_PRZEDMIOT) INTO x FROM Przedmioty;
        RETURN x;
    END ileWszystkichPrzedmiotow;
    
    FUNCTION czyStudentZdalWszystkiePrzedmioty(p_IdStudent Studenci.ID_Student%TYPE, liczba_wszystkich NUMBER) RETURN BOOLEAN IS 
        zdal_wszystkie BOOLEAN DEFAULT FALSE;
        ileZdal NUMBER;
    BEGIN
        SELECT COUNT(DISTINCT Id_Przedmiot) INTO ileZdal FROM Egzaminy e WHERE e.zdal = 'T';
        IF ileZdal=liczba_wszystkich THEN 
            zdal_wszystkie:=true;
        ELSE
            zdal_wszystkie:=false;
        END IF;
        RETURN zdal_wszystkie;
    END czyStudentZdalWszystkiePrzedmioty;
    
    FUNCTION dataOstatniegoZdanegoEgzaminu(p_IdStudent Studenci.Id_Student%TYPE) RETURN DATE IS
        data_egz DATE;
        BEGIN
            SELECT MAX(DISTINCT Data_Egzamin) INTO data_egz FROM Egzaminy 
                WHERE Id_Student = p_IdStudent AND zdal = 'T';
            RETURN data_egz;
        END dataOstatniegoZdanegoEgzaminu;
BEGIN
    liczbaWszystkichPrzedmiotow:= ileWszystkichPrzedmiotow();
    FOR vc1 IN c1 LOOP
        IF czyStudentZdalWszystkiePrzedmioty(vc1.Id_Student, liczbaWszystkichPrzedmiotow) THEN
            dataOstatniegoEgz:= dataOstatniegoZdanegoEgzaminu(vc1.Id_Student);
            UPDATE Studenci
                SET Data_ECDL = dataOstatniegoEgz,
                    NR_ECDL = vc1.Id_Student
            WHERE Id_Student = vc1.Id_Student;
        END IF;
    END LOOP;
END;

