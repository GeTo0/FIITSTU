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

CREATE TYPE SpecimenStatus AS ENUM ('vlastny', 'vypozicany', 'vypoziciava sa', 'kontroluje sa');
CREATE TYPE LoanState AS ENUM ('na ceste tam', 'spat', 'na sklade', 'na vystave');
CREATE TYPE ExhibitionStatus AS ENUM ('some_status');


CREATE TABLE Category (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR NOT NULL
);

CREATE TABLE Exhibition (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  start TIMESTAMP NOT NULL,
  length INTERVAL,
  expected_end TIMESTAMP NOT NULL,
  actual_end TIMESTAMP,
  status ExhibitionStatus NOT NULL
  CONSTRAINT check_expected_end_after_start CHECK (expected_end IS NULL OR expected_end >= start OR actual_end >= start)
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
  id BIGINT PRIMARY KEY,
  specimen_id BIGINT NOT NULL,
  owner_id BIGINT NOT NULL,
  state LoanState NOT NULL,
  expected_return_date TIMESTAMP,
  return_date TIMESTAMP,
  lend_date TIMESTAMP NOT NULL,
  CONSTRAINT check_return_date CHECK (expected_return_date IS NULL OR return_date >= lend_date OR expected_return_date >= lend_date),
  FOREIGN KEY (specimen_id) REFERENCES Specimen(id),
  FOREIGN KEY (owner_id) REFERENCES Institutions(id)
);

CREATE TABLE Control (
  id BIGINT PRIMARY KEY,
  loan_id BIGINT NOT NULL,
  specimen_id BIGINT UNIQUE NOT NULL,
  checkup_time INTERVAL NOT NULL,
  specimen_sent_date TIMESTAMP NOT NULL,
  specimen_expected_arrival_date TIMESTAMP NOT NULL,
  specimen_actual_arrival_date TIMESTAMP,
  CONSTRAINT check_arrival_date CHECK (specimen_expected_arrival_date IS NULL OR specimen_expected_arrival_date >= specimen_sent_date OR specimen_actual_arrival_date >= specimen_sent_date),
  FOREIGN KEY (specimen_id) REFERENCES Specimen(id),
  FOREIGN KEY (loan_id) REFERENCES Loans(id)
);

CREATE TABLE ExhibitionSpecimen (
  specimen_id BIGINT NOT NULL,
  exhibition_id BIGINT NOT NULL,
  zone_id BIGINT NOT NULL,
  CONSTRAINT zone_check UNIQUE (exhibition_id, specimen_id),
  FOREIGN KEY (specimen_id) REFERENCES Specimen(id),
  FOREIGN KEY (exhibition_id) REFERENCES Exhibition(id),
  FOREIGN KEY (zone_id) REFERENCES Zone(id),
  PRIMARY KEY (specimen_id, exhibition_id)
);
