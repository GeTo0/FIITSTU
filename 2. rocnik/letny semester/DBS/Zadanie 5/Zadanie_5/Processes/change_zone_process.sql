CREATE OR REPLACE FUNCTION change_specimen_zone(IN exh_id BIGINT, IN spec_id BIGINT, IN new_zone_id BIGINT)
RETURNS VOID AS $$
BEGIN
    -- Update the zone of the specimen in the ExhibitionSpecimen table
    UPDATE ExhibitionSpecimen
    SET zone_id = new_zone_id
    WHERE exh_id = exhibition_id AND spec_id = specimen_id;
END;
$$ LANGUAGE plpgsql;