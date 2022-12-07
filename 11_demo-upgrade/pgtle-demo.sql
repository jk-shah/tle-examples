SELECT pgtle.install_extension(
'demo',
'1.0',
'"Demo 1.0 Extension using pg_tle"',
$_pgtle_$
CREATE OR REPLACE FUNCTION demo_version() RETURNS TEXT  AS 'MODULE_PATHNAME','demo' LANGUAGE C STRICT;
$_pgtle_$
);
