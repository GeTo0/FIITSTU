CREATE OR REPLACE FUNCTION perform_control_and_update_status()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the actual_arrival_date is not NULL in the Control table for the specimen
    IF EXISTS (SELECT 1 FROM Control WHERE specimen_id = NEW.specimen_id AND specimen_actual_arrival_date IS NOT NULL) THEN
        -- Update Specimen status to "na sklade"
        UPDATE Specimen
        SET status = 'na sklade'
        WHERE id = NEW.specimen_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER perform_control_and_update_status_trigger
AFTER UPDATE ON Control
FOR EACH ROW
EXECUTE FUNCTION perform_control_and_update_status();


