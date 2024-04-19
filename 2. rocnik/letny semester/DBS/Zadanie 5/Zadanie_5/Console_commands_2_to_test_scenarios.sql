--CORRECT Planning
SELECT plan_exhibition('Big Exhibition 1', '2024-04-08','2024-04-15');
--WRONG Planning
--SELECT plan_exhibition('Mammal exhibition 1', '2024-04-08','2023-04-15');
--CHECK if is in table
SELECT *
FROM exhibition;
-- WRONG ADD Specimen to exhibition
--SELECT specimen_to_exh(1,1,1);
--SELECT specimen_to_exh(1,1,2); --cant be in 2 zones at once
--SELECT specimen_to_exh(1,3,3);
--ADD Specimen to exhibition
SELECT specimen_to_exh(1,1,1);
SELECT specimen_to_exh(1,2,1);
SELECT specimen_to_exh(1,3,3);
-- CAN Update actual end to see if trigger works
UPDATE exhibition
SET actual_end = '2024-04-15'
WHERE id = 1;
----------------------------------------------------------------------------------------------------------------
--CHANGE ZONE OF SPECIMEN
SELECT change_specimen_zone(1,1,4);
-- PRINT ALL INFO on Exhibition with ID <num>
SELECT *
FROM exhibitionspecimen
JOIN specimen ON exhibitionspecimen.specimen_id = specimen.id
JOIN exhibition ON exhibitionspecimen.exhibition_id = exhibition.id
WHERE exhibition_id =1;
----------------------------------------------------------------------------------------------------------------
-- Start new exhibition to test with loaned specimen
SELECT plan_exhibition('Mammal exhibition 1', '2024-04-13','2024-05-20');
-- LEND EXEMPLAR FROM ANOTHER INSTITUTION
SELECT loan_specimen_from_institution('Tiger Ciernochvosty', '2024-05-17',
                                      '2024-05-18',1,'Mammal');
-- Specimen arrived, ready to be controlled
UPDATE loans
SET arrival_date = '2024-05-17'
WHERE id = 1;
-- Specimen goes on control
SELECT put_specimen_to_control(1, 4, '3 days', '2024-04-08', '2024-04-11');
-- Try to put him on exhibition
--SELECT specimen_to_exh(2,4,3);
-- Check control and state of specimen
SELECT *
FROM Control;
SELECT *
FROM specimen;
SELECT *
FROM loans;
-- Specimen returns from Control
UPDATE control
SET specimen_actual_arrival_date = '2024-04-11'
WHERE id = 1;
-- Put specimen on exhibition
SELECT specimen_to_exh(2,4,3);
-- Loaned specimen returns to owner from our museum
UPDATE loans
SET return_date = '2024-04-16'
WHERE id = 1;
----------------------------------------------------------------------------------------------------------------
--Check history of exhibitions and specimen present there
SELECT name, start, exhibition.status, actual_end, specimen_name
FROM exhibition
JOIN exhibitionspecimen ON exhibition.id = exhibitionspecimen.exhibition_id
JOIN Specimen ON exhibitionspecimen.specimen_id = Specimen.id