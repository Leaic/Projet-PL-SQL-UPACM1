INSERT INTO tHotel(pknom, adresse, nombrePiece,category) VALUES ('VALLEE','VALLEE LONGKAK',40,'HOTEL');
INSERT INTO tHotel(pknom, adresse, nombrePiece,category) VALUES ('CITE','CITE',50,'LOGEMENT');
INSERT INTO tHotel(pknom, adresse, nombrePiece,category) VALUES ('HOTEL HILTON','BOULEVARE',100,'AFFAIRE');
INSERT INTO tHotel(pknom, adresse, nombrePiece,category) VALUES ('BELLE EPOQUE','MANGUIER',50,'LOGEMENT');
INSERT INTO tHotel(pknom, adresse, nombrePiece,category) VALUES ('FRANCO','FACE MATEMFENG',40,'HOTEL');

-- directeur
INSERT INTO tDirecteur VALUES('ARIVE','HAALAND','VICTOR',(SELECT REF(h)
    FROM tHotel h
    WHERE pkNom='CITE'),
    1000000, 100000);

INSERT INTO tDirecteur VALUES('AM85F1','MESSI','ARRAF',(SELECT REF(h)
    FROM tHotel h
    WHERE pkNom='FRANCO'),
    2000000, 50000);

INSERT INTO tDirecteur VALUES('QRTU8DE','BENJAMIN','FERU',(SELECT REF(h)
    FROM tHotel h
    WHERE pkNom='VALLEE'),
    750000, 100000);

INSERT INTO tDirecteur VALUES('TYUII81SE','MANI','ELISA',(SELECT REF(h)
    FROM tHotel h
    WHERE pkNom='HOTEL HILTON'),
    5000000, 1000000);

INSERT INTO tDirecteur VALUES('UIOD87U','CINTIA','TAMO',(SELECT REF(h)
    FROM tHotel h
    WHERE pkNom='BELLE EPOQUE'),
    500000, 90000);


-- Personnel
INSERT INTO tPersonnel VALUES('ERTD85','JEAN','MARC',(SELECT REF(h)
    FROM tHotel h
    WHERE pkNom='CITE'),
    100000, 10);

INSERT INTO tPersonnel VALUES('AMINE2F','LINE','MONTE',(SELECT REF(h)
    FROM tHotel h
    WHERE pkNom='FRANCO'),
    2000000, 50);

INSERT INTO tPersonnel VALUES('TUEW51Y','ANTONIE','TALLA',(SELECT REF(h)
    FROM tHotel h
    WHERE pkNom='VALLEE'),
    50000, 1);

INSERT INTO tPersonnel VALUES('8POU7EW','AFFOU','LARISSA',(SELECT REF(h)
    FROM tHotel h
    WHERE pkNom='HOTEL HILTON'),
    5000000, 15);

INSERT INTO tPersonnel VALUES('QSITU5G','MEVA','CHRISTINE',(SELECT REF(h)
    FROM tHotel h
    WHERE pkNom='BELLE EPOQUE'),
    500000, 90);


----- CHAMBRES
INSERT INTO tChambre
    SELECT 'C1', 2, 40000, REF(h)
    FROM tHotel h
    WHERE pkNom='CITE';

INSERT INTO tChambre
    SELECT 'C5', 8, 100000, REF(h)
    FROM tHotel h
    WHERE pkNom='VALLEE';

INSERT INTO tChambre
    SELECT 'CC5', 8, 100000, REF(h)
    FROM tHotel h
    WHERE pkNom='CITE';

INSERT INTO tChambre
    SELECT 'HH1', 1, 500000, REF(h)
    FROM tHotel h
    WHERE pkNom='HOTEL HILTON';

INSERT INTO tChambre
    SELECT 'HH2', 1, 750000, REF(h)
    FROM tHotel h
    WHERE pkNom='HOTEL HILTON';

INSERT INTO tChambre
    SELECT 'B8', 3, 100000, REF(h)
    FROM tHotel h
    WHERE pkNom='BELLE EPOQUE';

INSERT INTO tChambre
    SELECT 'B10', 8, 200000, REF(h)
    FROM tHotel h
    WHERE pkNom='BELLE EPOQUE';

INSERT INTO tChambre
    SELECT 'F5', 1, 80000, REF(h)
    FROM tHotel h
    WHERE pkNom='FRANCO';

INSERT INTO tChambre
    SELECT 'F10', 2, 200000, REF(h)
    FROM tHotel h
    WHERE pkNom='FRANCO';


-- Clients
INSERT INTO tClients VALUES('123456I', 'AMINATOU', 'FARAH');
INSERT INTO tClients VALUES('QWERTY', 'TAYO', 'IVAN');
INSERT INTO tClients VALUES('AZERTY', 'MESSUDOM', 'LESLEY');
INSERT INTO tClients VALUES('AVINIO5', 'NTHO', 'FLAVIA');
INSERT INTO tClients VALUES('AVENU520', 'NDET', 'FRANQZ');

----- OCCUPATION
INSERT INTO toccupation VALUES('CC5', '123456I', SYSDATE);
INSERT INTO toccupation VALUES('CC5','123456I', To_date('30-05-23', 'DD-MM-YY'));
INSERT INTO toccupation VALUES('CC5', '123456I', To_date('01-05-23', 'DD-MM-YY'));
INSERT INTO toccupation VALUES('CC5', 'AVINIO5', To_date('15-05-23', 'DD-MM-YY'));
INSERT INTO toccupation VALUES('CC5', 'AZERTY', SYSDATE);
INSERT INTO toccupation VALUES('HH2','AZERTY', To_date('30-05-23', 'DD-MM-YY'));
INSERT INTO toccupation VALUES('F5', 'AVINIO5', To_date('01-05-23', 'DD-MM-YY'));
