
CREATE ROLE estate_admin ENCRYPTED PASSWORD 'md56051ca6eda487e4aceec99e11578f959' CREATEROLE INHERIT LOGIN;  -- YnCAb6F9y7l1ibfL
GRANT select, insert, update, delete, references, trigger ON ALL TABLES IN SCHEMA main TO estate_admin;

CREATE ROLE estate_public ENCRYPTED PASSWORD 'md50500563a5582be6429bd8ede29b066f5' LOGIN;  -- qR5jGVfbahJa

GRANT SELECT, references, trigger ON TABLE main.agents, main.field_types, main.agent_fields, main.articles TO estate_public;



