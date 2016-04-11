CREATE SCHEMA IF NOT EXISTS main;

--- Drop All

Drop Table IF EXISTS main.phrases cascade;
Drop Table IF EXISTS main.localisations cascade;
Drop Table IF EXISTS main.articles cascade;
Drop Table IF EXISTS main.agent_fields cascade;
Drop Table IF EXISTS main.field_types cascade;
Drop Table IF EXISTS main.agents cascade;
Drop Table IF EXISTS main.logins cascade;
Drop Table IF EXISTS main.domains cascade;
Drop Table IF EXISTS main.languages cascade;

/*******************************************-=[ languages ]=-*******************************************/
	CREATE SEQUENCE main.language_id_seq MINVALUE 5;
	
	CREATE TABLE IF NOT EXISTS  main.languages(
			Id INT primary key default nextval('main.language_id_seq'),
			Shortest_Name char(2),
			Short_Name char(3),
			Full_name VARCHAR(50)		
		);

	INSERT INTO main.Languages (Id, Shortest_Name, Short_Name, Full_name) values (804, 'UA', 'UKR', 'Українська');

	ALTER SEQUENCE main.language_id_seq OWNED BY main.languages.id;
/*******************************************-=[ /languages ]=-*******************************************/

/*******************************************-=[ domains ]=-*******************************************/
	CREATE SEQUENCE main.domain_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.domains(
			Id INT primary key default nextval('main.domain_id_seq'),
			Domain_Name VARCHAR(50) not null,
			Default_Lang_Id INT not null default 804,
			site_domain_name  VARCHAR(50)
		);

	ALTER TABLE main.Domains ADD CONSTRAINT FK_Domain_Lang foreign key (Default_Lang_Id) references main.Languages (Id);

	INSERT INTO main.Domains (Id, Domain_Name, Default_Lang_Id) values (0, '[Default]', 804);
	
	ALTER SEQUENCE main.domain_id_seq OWNED BY main.domains.id;
/*******************************************-=[ /domains ]=-*******************************************/

/*******************************************-=[ articles ]=-*******************************************/
	CREATE SEQUENCE main.articles_id_seq MINVALUE 5;
	
	CREATE TABLE IF NOT EXISTS  main.articles(
			Id INT primary key default nextval('main.articles_id_seq'),
			name VARCHAR(50),
			guid uuid,
			Domain_Id INT not null, 
			Lang_Id INT not null default 804,
			category VARCHAR(50),
			subcategory VARCHAR(50),
			picture VARCHAR(255),
			date1 date,
			date2 date,
			text1 VARCHAR(500),
			text2 VARCHAR(500),
			article_text text,
			order_value int not null default 0
		);
		
	ALTER TABLE main.articles ADD CONSTRAINT FK_article_Domain foreign key (Domain_Id) references main.Domains (Id);	
	ALTER TABLE main.articles ADD CONSTRAINT FK_articles_lang foreign key (Lang_Id) references main.Languages (Id);
	
	ALTER SEQUENCE main.articles_id_seq OWNED BY main.articles.id;
/*******************************************-=[ articles ]=-*******************************************/

/*******************************************-=[ phrases ]=-*******************************************/
	CREATE SEQUENCE main.phrases_id_seq MINVALUE 5;
	
	CREATE TABLE IF NOT EXISTS  main.phrases(
			Id INT primary key default nextval('main.phrases_id_seq'),
			name VARCHAR(50),
			Domain_Id INT not null,
			Lang_Id INT not null default 804,
			category VARCHAR(50),
			subcategory VARCHAR(50),
			text VARCHAR(250)
		);
		
	ALTER TABLE main.phrases ADD CONSTRAINT FK_phrase_Domain foreign key (Domain_Id) references main.Domains (Id);	
	ALTER TABLE main.phrases ADD CONSTRAINT FK_phrases_lang foreign key (Lang_Id) references main.Languages (Id);
	ALTER SEQUENCE main.phrases_id_seq OWNED BY main.phrases.id;
/*******************************************-=[ phrases ]=-*******************************************/

/*******************************************-=[ logins ]=-*******************************************/
	CREATE SEQUENCE main.login_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.logins(
			Id INT primary key default nextval('main.login_id_seq'),
			username VARCHAR(50),
			guid uuid,
			eMail VARCHAR(50),
			password varchar(64) NOT NULL,
			password_salt varchar(20) NOT NULL,
			created timestamp NOT NULL default now(),
			attempt varchar(15) NOT NULL DEFAULT '0',
			Status SMALLINT not null default 0
		);
		
	ALTER SEQUENCE main.login_id_seq OWNED BY main.logins.id;
/*******************************************-=[ /logins ]=-*******************************************/

/*******************************************-=[ agents ]=-*******************************************/
	CREATE SEQUENCE main.agent_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.agents(
			Id INT primary key default nextval('main.agent_id_seq'),
			Name VARCHAR(50) not null,
			Domain_Id INT not null,
			Login_Id INT,
			Guid uuid,
			EMail VARCHAR(50) not null,
			Phone VARCHAR(50) not null,
			Status SMALLINT not null default 0,
			Profile_Picture VARCHAR(250),
			position VARCHAR(50)
		);

	ALTER TABLE main.agents ADD CONSTRAINT FK_Agent_Domain foreign key (Domain_Id) references main.Domains (Id);
	ALTER TABLE main.agents ADD CONSTRAINT UK_Agents unique (Domain_Id,EMail);
	
	ALTER SEQUENCE main.agent_id_seq OWNED BY main.agents.id;
/*******************************************-=[ /agents ]=-*******************************************/

/*******************************************-=[ localisations ]=-*******************************************/
	CREATE SEQUENCE main.localisation_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.localisations(
			Id INT primary key default nextval('main.localisation_id_seq'),
			Resource_Id INT not null, -- Domain, Agent, Object, etc... Id
			Resource_Type char(1),  -- D = Domain, U = Agent Name, L = Lang, O = Object type, C = City, R = Region, T = Text, F = Flat_Type, M = Material
			Lang_Id INT not null default 804,
			Domain_Id INT not null default 0, --- If no localisation for current domain - use default
			Local_Text VARCHAR(250) not null,
			Short_text VARCHAR(25) not null
		);


	ALTER TABLE main.localisations ADD CONSTRAINT FK_Local_Lang foreign key (Lang_Id) references main.Languages (Id);
	ALTER TABLE main.localisations ADD CONSTRAINT FK_Local_Domain foreign key (Domain_Id) references main.Domains (Id);
	
	ALTER SEQUENCE main.localisation_id_seq OWNED BY main.localisations.id;
/*******************************************-=[ /localisations ]=-*******************************************/

/*******************************************-=[ agent_fields ]=-*******************************************/
	CREATE TABLE IF NOT EXISTS  main.field_types (
	Id INT primary key,
	Is_multi SMALLINT not null default 0, -- 0 - Singular, >0 - multi
	Field_type VARCHAR(25) not null
	);
		
	CREATE SEQUENCE main.agent_phone_id_seq MINVALUE 1;
	
	CREATE TABLE IF NOT EXISTS  main.agent_fields (
	Id INT primary key default nextval('main.agent_phone_id_seq'),
	Agent_Id INT not null,
	Field_type_id INT not null default 1,  --- Personal
	f_value VARCHAR(255) not null
	);
	
	ALTER TABLE  main.agent_fields ADD CONSTRAINT FK_AgField_Types foreign key (field_type_id) references main.field_types (Id);
	
	ALTER SEQUENCE main.agent_phone_id_seq OWNED BY main.field_types.id;
/*******************************************-=[ /agent_fields ]=-*******************************************/

