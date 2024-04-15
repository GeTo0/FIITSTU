CREATE OR REPLACE FUNCTION update_specimen_status_on_exhibition()
RETURNS TRIGGER AS $$
BEGIN
    -- Get the current exhibition status
    DECLARE exhibition_status ExhibitionStatus;
    SELECT status INTO exhibition_status FROM Exhibition WHERE id = NEW.exhibition_id;

    -- If the exhibition is finished, set the specimen status to 'na sklade'
    IF exhibition_status = 'skoncena' THEN
        UPDATE Specimen
        SET status = 'na sklade'
        WHERE id = NEW.specimen_id;
    ELSE
        -- Check if the specimen is being put on exhibition after the start date
        DECLARE exhibition_start TIMESTAMP;
        SELECT start INTO exhibition_start FROM Exhibition WHERE id = NEW.exhibition_id;

        -- Check if the specimen is currently in storage or the exhibition is starting
        IF (OLD.status = 'na sklade' OR OLD.status = 'pripravuje sa') AND CURRENT_TIMESTAMP >= exhibition_start THEN
            -- Update specimen status to 'na vystave'
            UPDATE Specimen
            SET status = 'na vystave'
            WHERE id = NEW.specimen_id;
        ELSE
            -- Raise an exception if the specimen status is not 'na sklade' or 'pripravuje sa'
            RAISE EXCEPTION 'Specimen can only be put on exhibition if its status is "na sklade" or "pripravuje sa".';
        END IF;
    END IF;

    -- Check if the specimen is in Loans and meets the specified conditions
    IF EXISTS (SELECT 1 FROM Loans WHERE specimen_id = NEW.specimen_id AND lend_date IS NOT NULL AND return_date IS NULL) THEN
        -- Update specimen status to 'vypoziciava sa'
        UPDATE Specimen
        SET status = 'vypoziciava sa'
        WHERE id = NEW.specimen_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_specimen_status_on_exhibition_trigger
AFTER INSERT ON ExhibitionSpecimen
FOR EACH ROW
EXECUTE FUNCTION update_specimen_status_on_exhibition();