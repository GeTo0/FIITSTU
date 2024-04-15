CREATE OR REPLACE FUNCTION update_loan_state()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if lend_date is NOT NULL and return_date is NULL
    IF NEW.lend_date IS NOT NULL AND NEW.return_date IS NULL THEN
        NEW.state = 'v doprave';
    -- Check if return_date is NOT NULL
    ELSIF NEW.return_date IS NOT NULL THEN
        NEW.state = 'pripraveny na kontrolu';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_loan_state_trigger
BEFORE INSERT OR UPDATE ON Loans
FOR EACH ROW
EXECUTE FUNCTION update_loan_state();