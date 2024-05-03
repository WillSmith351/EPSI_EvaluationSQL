---Partie 1

CREATE VIEW ALL_WORKERS AS
SELECT
    last_name AS lastname,
    first_name AS firstname,
    age,
    first_day AS start_date
FROM WORKERS_FACTORY_1
WHERE last_day IS NULL
UNION ALL
SELECT
    last_name AS lastname,
    first_name AS firstname,
    NULL AS age,
    start_date
FROM WORKERS_FACTORY_2
WHERE end_date IS NULL
ORDER BY start_date ASC;

---Partie 2

CREATE VIEW ALL_WORKERS_ELAPSED AS
SELECT
    lastname,
    firstname,
    age,
    start_date,
    SYSDATE - start_date AS jours_ecoules
FROM ALL_WORKERS;

---Partie 3

CREATE VIEW BEST_SUPPLIERS AS
SELECT
    suppliers.name,
    SUM(quantity) AS total_delivered
FROM SUPPLIERS suppliers
JOIN (
    SELECT supplier_id, quantity FROM SUPPLIERS_BRING_TO_FACTORY_1
    UNION ALL
    SELECT supplier_id, quantity FROM SUPPLIERS_BRING_TO_FACTORY_2
) deliveries ON suppliers.supplier_id = deliveries.supplier_id
GROUP BY suppliers.name
HAVING SUM(quantity) > 1000
ORDER BY SUM(quantity) DESC;


---Partie 4

CREATE VIEW ROBOTS_FACTORIES AS
SELECT
    robot.id AS robot_id,
    robot.model,
    factories.main_location
FROM ROBOTS robot
JOIN ROBOTS_FROM_FACTORY robotfactory ON robot.id = robotfactory.robot_id
JOIN FACTORIES factories ON robotfactory.factory_id = factories.id;


