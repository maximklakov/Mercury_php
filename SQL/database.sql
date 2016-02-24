CREATE DATABASE mercury
  WITH ENCODING='UTF8'
       OWNER=mercury
       CONNECTION LIMIT=-1
       TABLESPACE=pg_default;
	   
CREATE SCHEMA main
       AUTHORIZATION mercury;
COMMENT ON SCHEMA main
  IS 'Main schema for most DB objects';