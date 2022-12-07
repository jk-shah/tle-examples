SELECT pgtle.install_extension(
'demo',
'1.0',
'"Demo 1.0 Extension using pg_tle"',
$_pgtle_$
CREATE OR REPLACE FUNCTION demo_version() RETURNS TEXT       AS $$ SELECT  'Demo Extension 1.1 for pg_tle' $$ LANGUAGE SQL;
$_pgtle_$
);
