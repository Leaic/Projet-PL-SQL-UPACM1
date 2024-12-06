SELECT i.*,
    CASE
        WHEN i.zone_type = 'PAYS' THEN p.libelle
        WHEN i.zone_type = 'REGION' THEN r.libelle
        WHEN i.zone_type = 'DEPARTEMENT' THEN d.libelle
        WHEN i.zone_type = 'COMMUNE' THEN c.libelle
        WHEN i.zone_type = 'CHEFFERIE' THEN ch.denomination
        ELSE 'col'
    END AS collectivite
    FROM zone_probleme i 
    LEFT JOIN  pays p ON p.n_enr = i.zone_id AND i.zone_type = 'PAYS'
    LEFT JOIN region r ON r.n_region = i.zone_id AND i.zone_type = 'REGION'
    LEFT JOIN departement d ON d.id = i.zone_id AND i.zone_type = 'DEPARTEMENT'
    LEFT JOIN commune_communaute c ON c.n_commune = i.zone_id AND i.zone_type = 'COMMUNE'
    LEFT JOIN chefferie ch ON ch.n_chefferie = i.zone_id AND i.zone_type = 'CHEFFERIE'
;

SELECT DISTINCT (col.collectivite, col.zone_id, col.zone_type) FROM (
    SELECT i.*,
    CASE
        WHEN i.zone_type = 'PAYS' THEN p.libelle
        WHEN i.zone_type = 'REGION' THEN r.libelle
        WHEN i.zone_type = 'DEPARTEMENT' THEN d.libelle
        WHEN i.zone_type = 'COMMUNE' THEN c.libelle
        WHEN i.zone_type = 'CHEFFERIE' THEN ch.denomination
        ELSE 'col'
    END AS collectivite
    FROM zone_probleme i 
    LEFT JOIN  pays p ON p.n_enr = i.zone_id AND i.zone_type = 'PAYS'
    LEFT JOIN region r ON r.n_region = i.zone_id AND i.zone_type = 'REGION'
    LEFT JOIN departement d ON d.id = i.zone_id AND i.zone_type = 'DEPARTEMENT'
    LEFT JOIN commune_communaute c ON c.n_commune = i.zone_id AND i.zone_type = 'COMMUNE'
    LEFT JOIN chefferie ch ON ch.n_chefferie = i.zone_id AND i.zone_type = 'CHEFFERIE'
) col;

SELECT * FROM zone_probleme z
    WHERE
        'COMMUNE' = 'PAYS' AND (
            (z.zone_type = 'PAYS' AND 1 = 0)
            OR (1 != 0 AND z.zone_id = 1 AND 1 = 0)
            OR (z.zone_type = 'REGION' AND 1 = 0 AND (z.zone_id IN (SELECT r.n_region FROM region r )))
            OR (z.zone_type = 'REGION' AND 1 != 0 AND z.zone_id IN (SELECT r.n_region FROM region r INNER JOIN pays p ON r.code_pays = p.n_enr AND p.n_enr = 1))
            OR (z.zone_type = 'DEPARTEMENT' AND 1 = 0 AND (z.zone_id IN (SELECT d.id FROM departement d ))) 
            OR (z.zone_type = 'DEPARTEMENT' AND 1 != 0 AND z.zone_id IN (SELECT dp.id FROM departement dp INNER JOIN region r ON r.n_region = dp.code_region INNER JOIN pays p ON r.code_pays = p.n_enr AND p.n_enr = 1))
            OR (z.zone_type = 'COMMUNE' AND 1 = 0 AND (z.zone_id IN (SELECT c.n_commune FROM commune_communaute c )))
            OR (z.zone_type = 'COMMUNE' AND 1 != 0 AND z.zone_id IN (SELECT c.n_commune FROM commune_communaute c INNER JOIN departement dps ON c.code_departement = dps.id INNER JOIN region r ON r.n_region = dps.code_region INNER JOIN pays p ON r.code_pays = p.n_enr AND p.n_enr = 1))
            OR (z.zone_type = 'CHEFFERIE' AND 1 = 0 AND (z.zone_id IN (SELECT ch.n_chefferie FROM chefferie ch)))
            OR (z.zone_type = 'CHEFFERIE' AND 1 != 0 AND z.zone_id IN (SELECT ch.n_chefferie FROM chefferie ch INNER JOIN commune_communaute c ON c.n_commune = ch.commune INNER JOIN departement dps ON c.code_departement = dps.id INNER JOIN region r ON r.n_region = dps.code_region INNER JOIN pays p ON r.code_pays = p.n_enr AND p.n_enr = 1))
        )
    OR 'COMMUNE' = 'REGION' AND (
            (z.zone_type = 'REGION' AND 1 = 0)
            OR (z.zone_type = 'REGION' AND 1 != 0 AND z.zone_id = 1)
            OR (z.zone_type = 'DEPARTEMENT' AND 1 = 0 AND (z.zone_id IN (SELECT d.id FROM departement d)))
            OR (z.zone_type = 'DEPARTEMENT' AND 1 != 0 AND z.zone_id IN (SELECT dp.id FROM departement dp INNER JOIN region r ON r.n_region = dp.code_region AND r.n_region = 1))
            OR (z.zone_type = 'COMMUNE' AND 8 = 0 AND (z.zone_id IN (SELECT c.n_commune FROM commune_communaute c)))
            OR (z.zone_type = 'COMMUNE' AND 8 != 0 AND z.zone_id IN (SELECT c.n_commune FROM commune_communaute c INNER JOIN departement dps ON c.code_departement = dps.id INNER JOIN region r ON r.n_region = dps.code_region AND r.n_region = 8))
            OR (z.zone_type = 'CHEFFERIE' AND 1 = 0 AND (z.zone_id IN (SELECT ch.n_chefferie FROM chefferie ch))) 
            OR (z.zone_type = 'CHEFFERIE' AND 1 != 0 AND z.zone_id IN (SELECT ch.n_chefferie FROM chefferie ch INNER JOIN commune_communaute c ON c.n_commune = ch.commune INNER JOIN departement dps ON c.code_departement = dps.id INNER JOIN region r ON r.n_region = dps.code_region AND r.n_region = 1))
        )
    OR 'COMMUNE' = 'DEPARTEMENT' AND (
            (z.zone_type = 'DEPARTEMENT' AND 1 = 0)
            OR (z.zone_type = 'DEPARTEMENT' AND 1 != 0 AND z.zone_id = 1)
            OR (z.zone_type = 'COMMUNE' AND 1 = 0 AND (z.zone_id IN (SELECT c.n_commune FROM commune_communaute c )))
            OR (z.zone_type = 'COMMUNE' AND 1 != 0 AND z.zone_id IN (SELECT c.n_commune FROM commune_communaute c INNER JOIN departement dps ON c.code_departement = dps.id AND dps.id = 1)) /* Verifier si la commune fait partie du departement correspondant a l'id**/
            OR (z.zone_type = 'CHEFFERIE' AND 1 = 0 AND (z.zone_id IN (SELECT ch.n_chefferie FROM chefferie ch )))
            OR (z.zone_type = 'CHEFFERIE' AND 1 != 0 AND z.zone_id IN (SELECT ch.n_chefferie FROM chefferie ch INNER JOIN commune_communaute c ON c.n_commune = ch.commune INNER JOIN departement dps ON c.code_departement = dps.id AND dps.id = 1))
        )
    OR 'COMMUNE' = 'COMMUNE' AND (
            (z.zone_type = 'COMMUNE' AND 1 = 0 )
            OR (z.zone_type = 'COMMUNE' AND 1 != 0 AND z.zone_id = 1)
            OR (z.zone_type = 'CHEFFERIE' AND 1 = 0 AND (z.zone_id IN (SELECT ch.n_chefferie FROM chefferie ch)))
            OR (z.zone_type = 'CHEFFERIE' AND 1 != 0 AND z.zone_id IN (SELECT ch.n_chefferie FROM chefferie ch INNER JOIN commune_communaute c ON c.n_commune = ch.commune AND c.n_commune = 1))
        )