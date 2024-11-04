CREATE OR REPLACE FUNCTION plan_exhibition(IN exhibition_name VARCHAR, IN start_date DATE, IN end_date DATE)
RETURNS VOID AS $$
DECLARE
    exhibition_id BIGINT;
BEGIN
    -- Insert the new exhibition
    INSERT INTO exhibition (name, start, expected_end)
    VALUES (exhibition_name, start_date, end_date)
    RETURNING id INTO exhibition_id;

    -- Check if the exhibition was successfully inserted
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Failed to plan exhibition';
    END IF;
END;
$$ LANGUAGE plpgsql;

