-- 1) AFFICHER TOUT LES CHAMBRES AVEC LEUR LOYER DU 1ER MAI
select c.nos, c.loyer('01/MAY/2023') from tchambre c;

-- 2) AFFICHER TOUT LE NOM DES HOTELS AVEC LEUR CHIFFRES D'AFFAIRE GENERE ENTRE LE 1 MAI ET LE 30 MAI 
select h.pknom, h.chiffreAffaire('01/MAY/2023', '30/MAY/2023') from tHotel h;

-- 3) AFFICHER TOUT LES NOM DES DIRECTEURS ET LES SALAIRES
select d.nom, d.salaireDir() from tdirecteur d;

-- 4) AFFICHER TOUT LES NOM DES PERSONNEL ET LES SALAIRES
select t.nom, t.salaireEmp() from tPersonnel t;

-- 5) AFFICHER TOUT LES NOMS, LES SALAIRES DE BASE, ET L'ANCIENETE EN POURCENTAGE DES PERSONNELS
select t.nom, t.salaireBase, (t.anciennete || ' %') AS anciennete from tPersonnel t;

-- 6) TOUT LES PERSONNEL DE LE L'HOTEL CITE
select * from tPersonnel t where t.fkHotel.pknom = 'CITE';

-- 7) TOUT LES CLIENT QUI ONT OCCUPE UNE CHAMBRE LE 1ER MAI
SELECT cl.nom, cl.prenom, c.nos, c.prix
FROM tOccupation o
INNER JOIN tCLIENTs CL ON o.fkclient = cl.pkcni
INNER JOIN tChambre c ON o.fkChambre = c.nos
WHERE o.dates = '01/MAY/2023';

-- 8) TOUT LES CLIENTS QUI ONT OCCUPE UNE CHAMBRE A L'HOTEL CITE ENTRE LE 1ER MAI ET LE 30 MAI AINSI QUE LA DATE
SELECT cl.pkcni, cl.nom, cl.prenom, o.dates
FROM tOccupation o
INNER JOIN tCLIENTs CL ON o.fkclient = cl.pkcni
INNER JOIN tChambre c ON o.fkChambre = c.nos
INNER JOIN tHotel h ON c.fkHotel.pknom = h.pknom
WHERE h.pknom = 'CITE' AND o.dates BETWEEN '01/MAY/2023' AND '30/MAY/2023';

-- 9) AFFICHER TOUT LES CHAMBRES DE L'HOTEL CITE
SELECT c.nos, c.nombreLit, c.prix
FROM tChambre c
WHERE c.fkHotel.pknom = 'CITE'
;

-- 10) AFFICHER TOUT LES NOS DE CHAMBRE DE L'HOTEL CITE QUI ONT DEJA ETE OCCUPER PAR DES CLIENTS
SELECT c.nos
FROM tOccupation o
INNER JOIN tChambre c ON o.fkChambre = c.nos
INNER JOIN tHotel h ON c.fkHotel.pknom = h.pknom
WHERE h.pknom = 'CITE' AND o.dates BETWEEN '01/MAY/2023' AND '30/MAY/2023'
GROUP BY c.nos;