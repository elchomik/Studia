--Zadanie 273
CREATE OR REPLACE TRIGGER B_Egzaminy BEFORE INSERT ON Egzaminy
    FOR EACH ROW
BEGIN
    IF :new.Zdal IS NULL THEN
        :new.Zdal:='Y';
    END IF;
END;

--Zadanie 274
CREATE OR REPLACE TRIGGER B_Studenci
    BEFORE UPDATE OF ID_Student ON Studenci FOR EACH ROW
DECLARE
    CURSOR cEgzaminy IS SELECT ID_Student FROM Egzaminy e
        WHERE e.ID_Student = :old.Id_Student FOR UPDATE OF ID_Student;
BEGIN
    IF :new.Id_Student != :old.Id_Student THEN
        FOR vRek IN cEgzaminy LOOP
            UPDATE Egzaminy 
                SET Id_Student = :new.Id_Student
                    WHERE CURRENT OF cEgzaminy; 
        END LOOP;
    END IF;
END;

--Zadanie 275
CREATE OR REPLACE TRIGGER OBJ_Create AFTER CREATE ON SCHEMA
    BEGIN
        INSERT INTO Monitor_Create VALUES(ora_dict_obj_type, ora_dict_obj_name, SYSDATE, ora_login_user);
    END;