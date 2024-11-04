CREATE OR REPLACE FUNCTION insert_specimen(IN specimen_name VARCHAR, IN description VARCHAR, IN category_name VARCHAR)
RETURNS VOID AS $$
DECLARE
    cat_id INT;
BEGIN
    -- Check if the category exists
    SELECT id INTO cat_id FROM Category WHERE name = category_name;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Category % does not exist', category_name;
    END IF;

    -- Insert the new specimen
    INSERT INTO Specimen (specimen_name, description, category_id, status)
    VALUES (specimen_name, description, cat_id, 'na sklade');
END;
$$ LANGUAGE plpgsql;

