CREATE OR REPLACE FUNCTION update_loan_state()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if lend_date is NOT NULL and return_date is NULL (didnt arrive yet)
    IF NEW.lend_date IS NOT NULL AND NEW.arrival_date IS NULL THEN
        NEW.state = 'v doprave';
    -- Check if arrival_date is NOT NULL (it arrived)
    ELSIF NEW.arrival_date IS NOT NULL THEN
        NEW.state = 'pripraveny na kontrolu';
    END IF;
    -- Check if return_date is NOT NULL (we sent it back)
    IF NEW.return_date IS NOT NULL THEN
        NEW.state = 'v doprave';
        UPDATE specimen
        SET status = 'nepritomny'
        WHERE id = NEW.specimen_id;
    END IF;
    RETURN NEW;

END;

$$ LANGUAGE plpgsql;

CREATE TRIGGER update_loan_state_trigger
BEFORE INSERT OR UPDATE ON Loans
FOR EACH ROW
EXECUTE FUNCTION update_loan_state();