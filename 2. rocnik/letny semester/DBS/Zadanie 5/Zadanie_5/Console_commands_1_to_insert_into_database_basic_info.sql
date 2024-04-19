INSERT INTO zone(name)
VALUES ('ZONE A');
INSERT INTO zone(name)
VALUES ('ZONE B');
INSERT INTO zone(name)
VALUES ('ZONE C');
INSERT INTO zone(name)
VALUES ('ZONE D');

INSERT INTO category(name)
VALUES ('Mammal');
INSERT INTO category(name)
VALUES ('Amphibious');
INSERT INTO category(name)
VALUES ('Insect');

SELECT insert_specimen('Slon Africky', NULL, 'Mammal');
SELECT insert_specimen('Vcela medonosna', NULL, 'Insect');
SELECT insert_specimen('Krokodil velkozuby', NULL, 'Amphibious');

INSERT INTO institutions(name)
VALUES ('Presovske Muzeum');
INSERT INTO institutions(name)
VALUES ('Trnavske Muzeum J. Gotha');
INSERT INTO institutions(name)
VALUES ('Vystavisko vo Zvolene');