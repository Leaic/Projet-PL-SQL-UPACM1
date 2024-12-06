DROP TABLE toccupation;
DROP TABLE tloyer;
DROP TABLE tChambre;
DROP TABLE tClients;
DROP TABLE tHotel;
DROP TABLE tDirecteur;
DROP TABLE tPersonnel;
DROP TYPE occupation;
DROP TYPE loyer;
DROP TYPE chambre;
DROP TYPE Directeur;
DROP TYPE Personnel;
DROP TYPE hotel;
DROP TYPE clients;
DROP TRIGGER CALCULLOYER;

CREATE OR REPLACE TYPE personnes AS OBJECT(
    pkCNI varchar2(25),
    nom VARCHAR2(25),
    prenom VARCHAR2(25)
) NOT FINAL;
/

CREATE OR REPLACE TYPE hotel AS OBJECT(
    pknom VARCHAR2(25),
    adresse VARCHAR2(100),
    nombrePiece NUMBER(3),
    category VARCHAR2(25),
    MEMBER FUNCTION chiffreAffaire(dateDabut IN DATE, dateFin IN DATE) RETURN NUMBER
);
/

CREATE TABLE tHotel OF hotel(
    PRIMARY KEY(pknom)
);

--2
CREATE OR REPLACE TYPE chambre FORCE AS OBJECT(
    nos VARCHAR2(25),
    nombreLit NUMBER(10),
    prix NUMBER(7),
    fkHotel REF hotel,
    MEMBER FUNCTION loyer(dates IN DATE) RETURN NUMBER
);
/

CREATE TABLE tChambre OF chambre(
    PRIMARY KEY(nos),
    SCOPE FOR (fkHotel) IS tHotel
);

--3
CREATE OR REPLACE TYPE clients UNDER personnes(
);
/

CREATE TABLE tClients OF clients(
    PRIMARY KEY(pkCNI)
);

--4
CREATE TYPE occupation AS OBJECT(
    fkChambre varchar2(25),
    fkClient varchar2 (25),
    dates DATE
);
/

CREATE TABLE toccupation OF occupation (
PRIMARY KEY(fkChambre, fkClient, dates),
FOREIGN KEY (fkChambre) REFERENCES tChambre(nos),
FOREIGN KEY (fkClient) REFERENCES tClients(PKCNI)
);

-- 5
CREATE TYPE loyer AS OBJECT(
    no_chambre VARCHAR2(25),
    dates date,
    montant number(7)
);
/

CREATE TABLE tLoyer OF loyer(
    PRIMARY KEY(no_chambre,dates),
    FOREIGN KEY (no_chambre) REFERENCES tChambre(nos)
);

-- 6
CREATE  or replace TYPE BODY chambre
IS
    MEMBER FUNCTION loyer(dates IN DATE) RETURN NUMBER
    IS
        total NUMBER(7);
        BEGIN
            SELECT SUM(l.montant) t INTO total
            FROM tLoyer l
            WHERE l.no_chambre = self.nos AND To_date(l.dates, 'DD-MM-YY') = To_date(dates, 'DD-MM-YY');

        RETURN total;
    END;
END;
/


--7
CREATE TYPE BODY hotel
IS
    MEMBER FUNCTION chiffreAffaire(dateDabut IN DATE, dateFin IN DATE) RETURN NUMBER
    IS
        chiffre NUMBER(7);
    BEGIN
        SELECT SUM(l.montant) INTO chiffre FROM tLoyer l
        INNER JOIN tChambre c ON l.no_chambre = c.nos
        WHERE c.fkHotel.pknom = self.pknom AND To_date(l.dates, 'DD-MM-YY') BETWEEN To_date(dateDabut, 'DD-MM-YY') AND To_date(dateFin, 'DD-MM-YY');

        RETURN chiffre;
    END;
END;
/


-- 8
create or replace trigger CALCULLOYER
before insert on tOccupation
for each row
declare
        new_no VARCHAR2(25);
        new_date DATE;
        total NUMBER(7);
        numb NUMBER(7);
    BEGIN
        new_no := :NEW.fkChambre;
        new_date := :NEW.dates;
        total := 0;

        SELECT SUM(t.montant) INTO total 
            FROM tloyer t 
            WHERE t.no_chambre = new_no 
                AND to_char(t.dates,'YYYY-MM-DD') = to_char(new_date,'YYYY-MM-DD');

        SELECT COUNT (*)  INTO numb 
            FROM tloyer t
            WHERE t.no_chambre = new_no 
                AND to_char(t.dates,'YYYY-MM-DD') = to_char(new_date,'YYYY-MM-DD');
        
    if total = 0 or numb = 0 then
        dbms_output.put_line('Nouveau! ');
        insert INTO tloyer select new_no, new_date, c.prix FROM tChambre c where c.nos = new_no;
    else
        dbms_output.put_line('maj! ');
        update tLoyer SET montant = montant + total WHERE no_chambre = new_no AND to_char(dates,'YYYY-MM-DD') = to_char(new_date,'YYYY-MM-DD');
    end if;

    dbms_output.put_line('Occupation a la chambre: ' || new_no);
end;
/

CREATE OR REPLACE TYPE directeur UNDER personnes(
    fkHotel REF HOTEL,
    salaireBase NUMBER(7),
    prime NUMBER(7),
    MEMBER FUNCTION salaireDir RETURN NUMBER
);
/

CREATE TABLE tDirecteur OF directeur(
    PRIMARY KEY(pkCNI),
    SCOPE FOR (fkHotel) IS tHotel
);

CREATE OR REPLACE TYPE BODY directeur
IS
    MEMBER FUNCTION salaireDir RETURN NUMBER
    IS
        salaire NUMBER(7);
        prime NUMBER(7);
        total NUMBER(20);
        BEGIN
            salaire := self.salaireBase;
            prime := self.prime;
            total := salaire + prime;

        RETURN total;
    END;
END;
/

CREATE OR REPLACE TYPE personnel UNDER personnes(
    fkHotel REF HOTEL,
    salaireBase NUMBER(7),
    anciennete NUMBER(7),
    MEMBER FUNCTION salaireEmp RETURN NUMBER
);
/

CREATE TABLE tPersonnel OF personnel(
    PRIMARY KEY(pkCNI),
    SCOPE FOR (fkHotel) IS tHotel
);

CREATE OR REPLACE TYPE BODY personnel
IS
    MEMBER FUNCTION salaireEmp RETURN NUMBER
    IS
        salaire NUMBER(7);
        pourcentage float;
        total NUMBER(20);
        BEGIN
            salaire := self.salaireBase;
            pourcentage := self.anciennete / 100;
            total := salaire * (1 + pourcentage);

        RETURN total;
    END;
END;
/
