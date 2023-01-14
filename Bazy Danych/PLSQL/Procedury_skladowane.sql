--Zadanie 264
CREATE PROCEDURE Dodaj_Studenta(P_Id VARCHAR2, PImie VARCHAR2, PNazwisko VARCHAR2) IS
    FUNCTION Check_Id(P_Ids VARCHAR2) RETURN BOOLEAN IS x VARCHAR2(1);
        BEGIN
            BEGIN
                SELECT 'X' INTO x FROM Studenci WHERE Id_Student = P_Ids;
                RETURN FALSE;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN RETURN TRUE;
            END;
        END Check_Id;
BEGIN
    IF Check_Id(PId) THEN
        INSERT INTO Studenci(ID_Student, Imie) VALUES (P_Id,PImie,PNazwisko);
        COMMIT;
    ELSE
        dbms_output.put_line('Student o podanym Id ju¿ istnieje w bazie danych');
    END IF;
END Dodaj_Studenta;

--Zadanie 265
CREATE PROCEDURE Wer_Daty_Egzaminu IS 
    CURSOR CEgzaminy IS SELECT Data_Egzamin FROM Egzaminy
        FOR UPDATE OF Data_Egzamin;
BEGIN
    FOR vData IN CEgzaminy LOOP
        IF vData.Data_Egzamin > SYSDATE THEN
            UPDATE Egzaminy SET Data_Egzamin = SYSDATE
                WHERE CURRENT OF CEgzaminy;
        END IF;
    END LOOP;
END Wer_Daty_Egzaminu;

--Zadanie 267
CREATE PROCEDURE Wer_Data_ECDL IS 
    CURSOR c1 IS SELECT Data_ECDL FROM Studenci 
        FOR UPDATE OF Data_ECDL;
BEGIN
    FOR vc1 IN c1 LOOP
        IF vc1.Data_ECDL > SYSDATE THEN
            UPDATE Studenci SET Data_ECDL = SYSDATE
                WHERE CURRENT OF c1;
        END IF;
    END LOOP;
END Wer_Data_ECDL;


