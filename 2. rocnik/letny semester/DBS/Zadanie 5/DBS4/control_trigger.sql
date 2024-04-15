CREATE OR REPLACE FUNCTION perform_control_and_update_status()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the specimen is ready for control
    IF NEW.state = 'pripraveny na kontrolu' AND checkup_time IS NOT NULL THEN
        -- Update specimen_sent_date to current time
        UPDATE Control
        SET specimen_sent_date = CURRENT_TIMESTAMP
        WHERE loan_id = NEW.id;
        -- Insert a record into the Control table
        INSERT INTO Control (loan_id, specimen_id, checkup_time, specimen_sent_date)
        VALUES (NEW.id, NEW.specimen_id, checkup_time, CURRENT_TIMESTAMP);

        -- Update Specimen status to "na kontrole"
        UPDATE Specimen
        SET status = 'na kontrole'
        WHERE id = NEW.specimen_id;

        UPDATE Loans
        SET state = NULL
        WHERE id = NEW.id;
    END IF;

    -- Check if the current time is equal to Control sent_date + checkup_time
    IF CURRENT_TIMESTAMP = (NEW.specimen_sent_date + NEW.checkup_time)  AND NEW.status = 'na kontrole' THEN
        -- Update Specimen status to "na sklade"
        UPDATE Specimen
        SET status = 'na sklade'
        WHERE id = NEW.specimen_id;

        -- Update actual_arrival_date to the current time
        UPDATE Control
        SET specimen_actual_arrival_date = CURRENT_TIMESTAMP
        WHERE loan_id = NEW.id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER perform_control_and_update_status_trigger
AFTER UPDATE ON Loans
FOR EACH ROW
EXECUTE FUNCTION perform_control_and_update_status();