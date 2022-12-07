CREATE OR REPLACE FUNCTION demo_version() RETURNS TEXT  
    AS $$ SELECT  'Demo Extension 0.1 for pg_tle' $$
LANGUAGE SQL;

