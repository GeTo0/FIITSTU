DROP TABLE IF EXISTS ExhibitionSpecimen CASCADE;
DROP TABLE IF EXISTS Control CASCADE;
DROP TABLE IF EXISTS Loans CASCADE;
DROP TABLE IF EXISTS Specimen CASCADE;
DROP TABLE IF EXISTS Institutions CASCADE;
DROP TABLE IF EXISTS Zone CASCADE;
DROP TABLE IF EXISTS Exhibition CASCADE;
DROP TABLE IF EXISTS Category CASCADE;

DROP TYPE IF EXISTS SpecimenStatus;
DROP TYPE IF EXISTS LoanState;
DROP TYPE IF EXISTS ExhibitionStatus;

CREATE TYPE LoanState AS ENUM ('pripraveny na kontrolu', 'v doprave');
CREATE TYPE SpecimenStatus AS ENUM ('vypoziciava sa', 'na sklade', 'na vystave', 'na kontrole');
CREATE TYPE ExhibitionStatus AS ENUM ('pripravuje sa', 'prebieha', 'skoncena');

CREATE TABLE Category (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR NOT NULL
);

CREATE TABLE Exhibition (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  zone_id BIGINT NOT NULL,
  start TIMESTAMP NOT NULL,
  length INTERVAL NOT NULL,
  expected_end TIMESTAMP NOT NULL,
  actual_end TIMESTAMP,
  status ExhibitionStatus NOT NULL
);

CREATE TABLE Zone (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  exhibition_id BIGINT NOT NULL,
  FOREIGN KEY (exhibition_id) REFERENCES Exhibition(id)
);

CREATE TABLE Institutions (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR NOT NULL
);

CREATE TABLE Specimen (
  id BIGSERIAL PRIMARY KEY,
  specimen_name VARCHAR NOT NULL,
  description VARCHAR,
  status SpecimenStatus NOT NULL,
  category_id BIGINT NOT NULL,
  FOREIGN KEY (category_id) REFERENCES Category(id)
);

CREATE TABLE Loans (
  id BIGSERIAL PRIMARY KEY,
  specimen_id BIGINT NOT NULL,
  owner_id BIGINT NOT NULL,
  state LoanState NOT NULL,
  return_date TIMESTAMP,
  lend_date TIMESTAMP,
  FOREIGN KEY (specimen_id) REFERENCES Specimen(id),
  FOREIGN KEY (owner_id) REFERENCES Institutions(id)
);

CREATE TABLE Control (
  id BIGSERIAL PRIMARY KEY,
  loan_id BIGINT,
  specimen_id BIGINT UNIQUE,
  checkup_time INTERVAL,
  specimen_sent_date TIMESTAMP,
  specimen_expected_arrival_date TIMESTAMP,
  specimen_actual_arrival_date TIMESTAMP,
  FOREIGN KEY (specimen_id) REFERENCES Specimen(id),
  FOREIGN KEY (loan_id) REFERENCES Loans(id)
);

CREATE TABLE ExhibitionSpecimen (
  specimen_id BIGINT,
  exhibition_id BIGINT,
  FOREIGN KEY (specimen_id) REFERENCES Specimen(id),
  FOREIGN KEY (exhibition_id) REFERENCES Exhibition(id),
  PRIMARY KEY (specimen_id, exhibition_id)
);

--/i control_trigger
--/i exhibition_status_trigger
--/i loan_state_trigger
--/i specimen_status_trigger
