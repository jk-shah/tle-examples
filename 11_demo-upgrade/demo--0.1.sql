CREATE OR REPLACE FUNCTION demo_version() RETURNS TEXT  
    AS $$ SELECT  'Demo Extension 0.9' $$
LANGUAGE SQL;

