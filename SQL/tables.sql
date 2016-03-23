CREATE SCHEMA IF NOT EXISTS main;

--- Drop All

Drop Table IF EXISTS main.objects cascade;
Drop Table IF EXISTS main.materials cascade;
Drop Table IF EXISTS main.flat_Types cascade;
Drop Table IF EXISTS main.clients cascade;
Drop Table IF EXISTS main.streets cascade;
Drop Table IF EXISTS main.regions cascade;
Drop Table IF EXISTS main.cities cascade;
Drop Table IF EXISTS main.object_Types cascade;
Drop Table IF EXISTS main.texts cascade;
Drop Table IF EXISTS main.localisations cascade;
Drop Table IF EXISTS main.agent_roles cascade;
Drop Table IF EXISTS main.roles cascade;
Drop Table IF EXISTS main.agent_fields cascade;
Drop Table IF EXISTS main.field_types cascade;
Drop Table IF EXISTS main.agents cascade;
Drop Table IF EXISTS main.logins cascade;
Drop Table IF EXISTS main.reset_tokens cascade;
Drop Table IF EXISTS main.user_devices cascade;
Drop Table IF EXISTS main.domains cascade;
Drop Table IF EXISTS main.languages cascade;
Drop Table IF EXISTS main.articles cascade;




/*******************************************-=[ languages ]=-*******************************************/
	CREATE SEQUENCE main.language_id_seq MINVALUE 5;
	
	CREATE TABLE IF NOT EXISTS  main.languages(
			Id INT primary key default nextval('main.language_id_seq'),
			Shortest_Name char(2),
			Short_Name char(3),
			Full_name VARCHAR(50)		
		);

	INSERT INTO main.Languages (Id, Shortest_Name, Short_Name, Full_name) values (0, 'UA', 'UKR', 'Українська');

	ALTER SEQUENCE main.language_id_seq OWNED BY main.languages.id;
/*******************************************-=[ /languages ]=-*******************************************/


/*******************************************-=[ domains ]=-*******************************************/
	CREATE SEQUENCE main.domain_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.domains(
			Id INT primary key default nextval('main.domain_id_seq'),
			Domain_Name VARCHAR(50) not null,
			Default_Lang_Id INT not null default 0,
			site_domain_name  VARCHAR(50)
		);

	ALTER TABLE main.Domains ADD CONSTRAINT FK_Domain_Lang foreign key (Default_Lang_Id) references main.Languages (Id);

	INSERT INTO main.Domains (Id, Domain_Name, Default_Lang_Id) values (0, '[Default]', 0);
	
	ALTER SEQUENCE main.domain_id_seq OWNED BY main.domains.id;
/*******************************************-=[ /domains ]=-*******************************************/

/*******************************************-=[ articles ]=-*******************************************/
	CREATE SEQUENCE main.articles_id_seq MINVALUE 5;
	
	CREATE TABLE IF NOT EXISTS  main.articles(
			Id INT primary key default nextval('main.articles_id_seq'),
			name VARCHAR(50),
			guid uuid,
			Domain_Id INT not null, 
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
	ALTER SEQUENCE main.articles_id_seq OWNED BY main.articles.id;
/*******************************************-=[ articles ]=-*******************************************/

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

/*******************************************-=[ reset_tokens ]=-*******************************************/

	CREATE TABLE IF NOT EXISTS main.reset_tokens (
		token varchar(40) NOT NULL, --COMMENT 'The Unique Token Generated',
		uid INT NOT NULL, --COMMENT 'The User Id',
		requested varchar(20) NOT NULL --COMMENT 'The Date when token was created'
	) ;

/*******************************************-=[ /reset_tokens ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.user_devices_id_seq MINVALUE 5;
	
	CREATE TABLE IF NOT EXISTS main.user_devices (
	  Id  INT primary key default nextval('main.user_devices_id_seq'),
	  UId INT NOT NULL, --COMMENT 'The user''s ID',
	  Token varchar(15) NOT NULL, --COMMENT 'A unique token for the user''s device',
	  Last_access varchar(20) NOT NULL
	);
	
	ALTER SEQUENCE main.user_devices_id_seq OWNED BY main.user_devices.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.agent_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.agents(
			Id INT primary key default nextval('main.agent_id_seq'),
			Name VARCHAR(50) not null,
			Domain_Id INT not null,
			Login_Id INT not null,
			Guid uuid,
			EMail VARCHAR(50) not null,
			Phone VARCHAR(50) not null,
			Status SMALLINT not null default 0,
			Profile_Picture VARCHAR(250),
			position VARCHAR(50)
		);

	ALTER TABLE main.agents ADD CONSTRAINT FK_Agent_Domain foreign key (Domain_Id) references main.Domains (Id);
	ALTER TABLE main.agents ADD CONSTRAINT UK_Agents unique (Domain_Id,EMail);
	ALTER TABLE main.agents ADD CONSTRAINT UK_AgentsLogin unique (Login_id);
	
	ALTER SEQUENCE main.agent_id_seq OWNED BY main.agents.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
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
	
	ALTER TABLE  main.agent_fields ADD CONSTRAINT FK_Phones_Agent foreign key (Agent_Id) references main.agents (Id);
	ALTER TABLE  main.agent_fields ADD CONSTRAINT FK_AgField_Types foreign key (field_type_id) references main.field_types (Id);
	
	ALTER SEQUENCE main.agent_phone_id_seq OWNED BY main.field_types.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.localisation_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.localisations(
			Id INT primary key default nextval('main.localisation_id_seq'),
			Resource_Id INT not null, -- Domain, Agent, Object, etc... Id
			Resource_Type char(1),  -- D = Domain, U = Agent Name, L = Lang, O = Object type, C = City, R = Region, T = Text, F = Flat_Type, M = Material
			Lang_Id INT not null default 0,
			Domain_Id INT not null default 0, --- If no localisation for current domain - use default
			Local_Text VARCHAR(250) not null,
			Short_text VARCHAR(25) not null
		);


	ALTER TABLE main.localisations ADD CONSTRAINT FK_Local_Lang foreign key (Lang_Id) references main.Languages (Id);
	ALTER TABLE main.localisations ADD CONSTRAINT FK_Local_Domain foreign key (Domain_Id) references main.Domains (Id);
	
	ALTER SEQUENCE main.localisation_id_seq OWNED BY main.localisations.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.text_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.texts (
			Id INT primary key default nextval('main.text_id_seq'),
			Domain_Id  INT not null default 0,
			Text_Name VARCHAR(32),
			TText VARCHAR(4000)
		);

	ALTER TABLE main.Texts ADD CONSTRAINT FK_Texts_Domain foreign key (Domain_Id) references main.Domains (Id);
	
	ALTER SEQUENCE main.text_id_seq OWNED BY main.texts.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.object_type_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.object_types(
			Id INT primary key default nextval('main.object_type_id_seq'),
			Obj_Name  VARCHAR(50),
			Short_Name  VARCHAR(5)
		);
		
	ALTER SEQUENCE main.object_type_id_seq OWNED BY main.object_types.id;
	
	INSERT INTO main.object_types (Obj_Name, Short_Name) 
		   values ('Квартира','К'),  ('Будинок','Б') , ('Ділянка', 'Д');

/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.city_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.cities (
			Id INT primary key default nextval('main.city_id_seq'),
			City_Name VARCHAR(50) not null,
			City_Short_Name VARCHAR(5) not null,
			Guid uuid
		);

	INSERT INTO main.cities(Id, City_Name, City_Short_Name) values (1, 'Вінниця', 'Вн');
	
	ALTER SEQUENCE main.city_id_seq OWNED BY main.cities.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.region_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.regions (
			Id INT primary key default nextval('main.region_id_seq'),
			City_Id INT not null,
			Region_Name VARCHAR(50) not null,
			Region_Description VARCHAR(500),
			Guid uuid
		);

	ALTER TABLE main.regions ADD CONSTRAINT FK_Reg_City foreign key (City_Id) references main.Cities(Id);
	
	ALTER SEQUENCE main.region_id_seq OWNED BY main.regions.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.street_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.streets (
			Id INT primary key default nextval('main.street_id_seq'),
			Region_Id INT not null,
			Street_Name VARCHAR(50) not null,
			Street_Description VARCHAR(500),
			Guid uuid
		);

	ALTER TABLE main.streets ADD CONSTRAINT FK_Street_Region foreign key (Region_Id) references main.Regions(Id);
	
	ALTER SEQUENCE main.street_id_seq OWNED BY main.streets.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.flat_types_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS main.flat_types (
		Id INT primary key default nextval('main.flat_types_id_seq'),
		Full_Type VARCHAR(50),
		Short_Type nchar(3)
	);
	
	ALTER SEQUENCE main.flat_types_id_seq OWNED BY main.flat_types.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.material_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.materials (
		Id INT primary key default nextval('main.material_id_seq'),
		Material_Name VARCHAR(50),
		Short_Name nchar(3)
	);
	
	ALTER SEQUENCE main.material_id_seq OWNED BY main.materials.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.object_id_seq MINVALUE 5;

		---- All Areas is in square meters
	CREATE TABLE IF NOT EXISTS  main.objects(
		Id INT primary key default nextval('main.object_id_seq'),
		Short_Description VARCHAR(500),
		Full_Description VARCHAR(4000),
		Guid uuid,
		Domain_Id INT not null,
		Agent_Id INT not null,
		Phone_Id INT,
		Shared_Option SMALLINT not null default 0, -- 0 = Private, 1 = Domain, 2 = Public
		Obj_Type INT not null, --- House, Flat 
		Land_Area float, 
		Apart_Area float, 
		Living_Area float, 
		Kitchen_Area float , 
		Rooms SMALLINT,
		Rooms_Type_Id SMALLINT, -- 
		Region_Id INT,
		Street_Id INT,
		Building_Number VARCHAR(5),
		Flat_Number INT,
		Flat_Type_Id SMALLINT,
		FloorNumber SMALLINT,
		Floors SMALLINT,
		Building_Type_Id  SMALLINT, -- material
		HasPhone SMALLINT,
		Orienter VARCHAR(200),
		Price float,
		Contacts VARCHAR(500),
		tel1 VARCHAR(30),
		tel2 VARCHAR(30),
		tel3 VARCHAR(30),
		Obj_Date Date
	);

	ALTER TABLE main.objects  ADD CONSTRAINT FK_Object_Agents foreign key (Agent_Id) references main.Agents (Id);
	ALTER TABLE main.objects  ADD CONSTRAINT FK_Object_Domains foreign key (Domain_Id) references main.Domains (Id);
	ALTER TABLE main.objects  ADD CONSTRAINT FK_Object_Streets foreign key (Street_Id) references main.Streets (Id);
	ALTER TABLE main.objects  ADD CONSTRAINT FK_Object_Regions foreign key (Region_Id) references main.Regions (Id);
	
	ALTER SEQUENCE main.object_id_seq OWNED BY main.objects.id;
	
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.client_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.clients(
			Id INT primary key default nextval('main.client_id_seq'),
			Name  VARCHAR(50),
			Guid uuid,
			Domain_Id INT not null,
			Agent_Id INT not null,
			Mid_Name VARCHAR(50),
			Birth_Date Date,
			Client_Type SMALLINT, -- 1 - Byer, 2 - Seller, 3- Both, 4 - Rent(look), 5- Rent(give)
			Tel1  VARCHAR(20),
			Tel2  VARCHAR(20),
			Tel3 VARCHAR(20),
			Contract_Id VARCHAR(20),
			Contract_Date Date,
			Agent_Phone_Id INT,
			Document_Type_Id SMALLINT,
			Document_Series VARCHAR(10),
			Document_Number VARCHAR(10),
			Document_Issued Date,
			StreetId INT,
			Building_No VARCHAR(5),
			Flat_No INT,
			Is_For_Rent SMALLINT,
			Short_description VARCHAR(200),
			Full_Description  VARCHAR(500)
			);

	ALTER TABLE main.clients ADD CONSTRAINT FK_Clients_Agent foreign key (Agent_Id) references main.Agents(id);
	ALTER TABLE main.clients ADD CONSTRAINT FK_Clients_Domains foreign key (Domain_Id) references main.Domains(id);
	ALTER TABLE main.clients ADD CONSTRAINT FK_Clients_Ag_Phone foreign key (Agent_Phone_Id) references main.Agent_Fields(id);
	ALTER TABLE main.clients ADD CONSTRAINT FK_Clients_Streets foreign key (StreetId) references main.Streets(id);
	
	ALTER SEQUENCE main.client_id_seq OWNED BY main.clients.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.role_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.roles(
			Id INT primary key default nextval('main.role_id_seq'),
			Role_Name VARCHAR(16) not null,
			Role_Level  SMALLINT not null default 0, -- user cannot grant access of => rights to other users.
			Status SMALLINT not null default 0
		);

	ALTER TABLE main.roles ADD CONSTRAINT UK_Roles unique (Role_Name);
	
	ALTER SEQUENCE main.role_id_seq OWNED BY main.roles.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/

	CREATE TABLE IF NOT EXISTS  main.agent_roles(
			Agent_Id INT not null,
			Role_Id INT not null
		);

	ALTER TABLE main.agent_roles ADD CONSTRAINT Agent_Roles_PK primary key (Agent_Id, Role_Id);
	
	ALTER TABLE main.agent_roles ADD CONSTRAINT FK_Agent_Roles_Agent foreign key (Agent_Id) references main.Agents(id);
	ALTER TABLE main.agent_roles ADD CONSTRAINT FK_Agent_Roles_Role foreign key (Role_Id) references main.Roles(id);
	
/*******************************************-=[  ]=-*******************************************/




