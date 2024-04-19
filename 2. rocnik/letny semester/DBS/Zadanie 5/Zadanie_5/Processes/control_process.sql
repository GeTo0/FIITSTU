CREATE OR REPLACE FUNCTION put_specimen_to_control(
    IN loan_id BIGINT,
    IN specimen_id BIGINT,
    IN checkup_time INTERVAL,
    IN specimen_sent_date TIMESTAMP,
    IN specimen_expected_arrival_date TIMESTAMP)
RETURNS VOID AS $$
BEGIN
    -- Check if the loan state of the specimen is 'pripraveny na kontrolu'
    IF EXISTS (SELECT 1 FROM Loans WHERE id = loan_id AND state = 'pripraveny na kontrolu') THEN
        -- Insert the record into the Control table
        INSERT INTO Control (loan_id, specimen_id, checkup_time, specimen_sent_date, specimen_expected_arrival_date)
        VALUES (loan_id, specimen_id, checkup_time, specimen_sent_date, specimen_expected_arrival_date);

        UPDATE Specimen
        SET status = 'na kontrole'
        WHERE id = specimen_id;

    ELSE
        -- Raise an exception if the loan state is not 'pripraveny na kontrolu'
        RAISE EXCEPTION 'Specimen must be in the "pripraveny na kontrolu" loan state to be put on control.';
    END IF;
END;
$$ LANGUAGE plpgsql;