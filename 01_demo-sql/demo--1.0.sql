CREATE OR REPLACE FUNCTION demo_version() RETURNS TEXT  
    AS $$ SELECT  'Demo Extension 1.1 for pg_tle' $$
LANGUAGE SQL;

