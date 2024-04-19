CREATE OR REPLACE FUNCTION loan_specimen_from_institution(
    IN spec_name VARCHAR,
    IN len_date TIMESTAMP,
    IN exp_arrival_date TIMESTAMP,
    IN own_id BIGINT,
    IN cat_name VARCHAR)
RETURNS VOID AS $$
DECLARE
    spec_id BIGINT;
    loan_id BIGINT; -- Variable to store the generated loan ID

BEGIN
    -- Insert the specimen into the Specimen table
    PERFORM insert_specimen(spec_name, NULL, cat_name);

    -- Get the ID of the inserted specimen
    SELECT id INTO spec_id FROM Specimen WHERE specimen_name = spec_name;
    -- Update status of specimen (nepritomny = neni v muzeu u nas)
    UPDATE specimen
    SET status = 'nepritomny'
    WHERE id = spec_id;

    -- Insert the loan record into the Loans table
    INSERT INTO Loans (specimen_id, owner_id, lend_date, expected_arrival_date, state)
    VALUES (spec_id, own_id, len_date, exp_arrival_date, 'v doprave')
    RETURNING id INTO loan_id;
END;
$$ LANGUAGE plpgsql;