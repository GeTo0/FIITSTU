CREATE OR REPLACE FUNCTION update_exhibition_status()
RETURNS TRIGGER AS $$
BEGIN
    -- If actual_end is not NULL, set status to "skoncena" and update "length"
    IF NEW.actual_end IS NOT NULL THEN
        NEW.status = 'skoncena';
        NEW.length = NEW.actual_end - NEW.start;
    -- If current time is after start and actual_end is NULL, set status to "prebieha"
    ELSIF CURRENT_TIMESTAMP > NEW.start AND NEW.actual_end IS NULL THEN
        NEW.status = 'prebieha';
    -- If current time is before start, set status to "pripravuje sa"
    ELSE
        NEW.status = 'pripravuje sa';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_exhibition_status_trigger
BEFORE INSERT OR UPDATE ON Exhibition
FOR EACH ROW
EXECUTE FUNCTION update_exhibition_status();