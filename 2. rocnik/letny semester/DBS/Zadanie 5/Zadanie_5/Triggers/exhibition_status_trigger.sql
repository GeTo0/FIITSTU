CREATE OR REPLACE FUNCTION update_exhibition_status()
RETURNS TRIGGER AS $$
BEGIN
    -- If actual_end is not NULL, set status to "skoncena" and update "length"
    IF NEW.actual_end IS NOT NULL THEN
        NEW.status = 'skoncena';
        NEW.length = NEW.actual_end - NEW.start ::timestamp;
    -- If current time is after start and actual_end is NULL, set status to "prebieha"
    ELSIF CURRENT_TIMESTAMP > NEW.start AND NEW.actual_end IS NULL THEN
        NEW.status = 'prebieha';
        NEW.length=NULL;
    -- If current time is before start, set status to "pripravuje sa"
    ELSE
        NEW.status = 'pripravuje sa';
        NEW.length=NULL;
    END IF;

    -- If the status of the exhibition is "skoncena", update the status of all specimens associated with it to "na sklade"
    IF NEW.status = 'skoncena' THEN
        UPDATE Specimen
        SET status = 'na sklade'
        WHERE id IN (SELECT specimen_id FROM ExhibitionSpecimen WHERE exhibition_id = NEW.id);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_exhibition_status_trigger
BEFORE INSERT OR UPDATE ON exhibition
FOR EACH ROW
EXECUTE FUNCTION update_exhibition_status();

