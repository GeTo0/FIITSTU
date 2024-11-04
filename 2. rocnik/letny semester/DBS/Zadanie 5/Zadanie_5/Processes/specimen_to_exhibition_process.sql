CREATE OR REPLACE FUNCTION specimen_to_exh(IN exhibition_id BIGINT, IN specimen_id BIGINT, IN zone_id BIGINT)
RETURNS VOID AS $$
DECLARE
    specimen_status SpecimenStatus;
    exhibition_status ExhibitionStatus;
BEGIN
    -- Get the status of the specimen
    SELECT status INTO specimen_status FROM Specimen WHERE id = specimen_id;

    -- Check if the specimen is available for exhibition
    IF specimen_status = 'na sklade' THEN
        -- Insert the new record into the ExhibitionSpecimen table
        INSERT INTO ExhibitionSpecimen (exhibition_id, specimen_id, zone_id)
        VALUES (exhibition_id, specimen_id, zone_id);

        -- Get the status of the exhibition
        SELECT status INTO exhibition_status FROM Exhibition WHERE id = exhibition_id;

        -- If the exhibition is ongoing, update the specimen status to "na vystave"
        IF exhibition_status = 'prebieha' THEN
            UPDATE Specimen
            SET status = 'na vystave'
            WHERE id = specimen_id;
        END IF;

    ELSE
        -- Raise an exception if the specimen is not available for exhibition
        RAISE EXCEPTION 'Specimen with ID % is not available for exhibition. Its status is %.', specimen_id, specimen_status;
    END IF;
END;
$$ LANGUAGE plpgsql;

