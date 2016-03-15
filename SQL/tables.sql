
--- Drop All
/*
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
Drop Table IF EXISTS main.roles cascade;
Drop Table IF EXISTS main.agent_roles cascade;
Drop Table IF EXISTS main.agent_phones cascade;
Drop Table IF EXISTS main.phone_types cascade;
Drop Table IF EXISTS main.agents cascade;
Drop Table IF EXISTS main.logins cascade;
Drop Table IF EXISTS main.domains cascade;
Drop Table IF EXISTS main.languages cascade;
*/

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
/*******************************************-=[ languages ]=-*******************************************/

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
	
	ALTER SEQUENCE main.domain_id_seq OWNED BY main.languages.id;
/*******************************************-=[ domains ]=-*******************************************/


/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.login_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.logins(
			guid uuid,
			Id INT primary key default nextval('main.login_id_seq'),
			username VARCHAR(50),
			eMail VARCHAR(50),
			password varchar(64) NOT NULL,
			password_salt varchar(20) NOT NULL,
			created timestamp NOT NULL default now(),
			attempt varchar(15) NOT NULL DEFAULT '0',
			Status smallINT not null default 0
		);
		
	ALTER SEQUENCE main.login_id_seq OWNED BY main.languages.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/

	CREATE TABLE IF NOT EXISTS main.reset_tokens (
		token varchar(40) NOT NULL, --COMMENT 'The Unique Token Generated',
		uid INT NOT NULL, --COMMENT 'The User Id',
		requested varchar(20) NOT NULL --COMMENT 'The Date when token was created'
	) ;

/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.user_devices_id_seq MINVALUE 5;
	
	CREATE TABLE IF NOT EXISTS main.user_devices (
	  id  INT primary key default nextval('main.user_devices_id_seq'),
	  uid INT NOT NULL, --COMMENT 'The user''s ID',
	  token varchar(15) NOT NULL, --COMMENT 'A unique token for the user''s device',
	  last_access varchar(20) NOT NULL
	);
	
	ALTER SEQUENCE main.user_devices_id_seq OWNED BY main.languages.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.agent_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.agents(
			guid uuid,
			Id INT primary key default nextval('main.agent_id_seq'),
			Domain_Id INT not null,
			Login_id INT not null,
			First_Name VARCHAR(50) not null,
			Last_Name VARCHAR(50),
			EMail VARCHAR(50) not null,
			Phone VARCHAR(50) not null,
			Status smallINT not null default 0
		);

	ALTER TABLE main.agents ADD CONSTRAINT FK_Agent_Domain foreign key (Domain_Id) references main.Domains (Id);
	ALTER TABLE main.agents ADD CONSTRAINT UK_Agents unique (Domain_Id,EMail);
	ALTER TABLE main.agents ADD CONSTRAINT UK_AgentsLogin unique (Login_id);
	
	ALTER SEQUENCE main.agent_id_seq OWNED BY main.languages.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE TABLE IF NOT EXISTS  main.phone_types (
	Id INT primary key,
	language_id INT not null default 0,
	phone_type VARCHAR(25) not null unique
	);
	INSERT INTO main.phone_types values (1, 0,'personal');
	
	
	CREATE SEQUENCE main.agent_phone_id_seq MINVALUE 5;
	
	CREATE TABLE IF NOT EXISTS  main.agent_phones (
	Id INT primary key default nextval('main.agent_phone_id_seq'),
	Agent_Id INT not null,
	phone_type_id INT not null default 1,  --- Personal
	Number VARCHAR(25) not null
	);
	
	ALTER TABLE  main.agent_phones ADD CONSTRAINT FK_Phones_Agent foreign key (Agent_Id) references main.agents (Id);
	ALTER TABLE  main.agent_phones ADD CONSTRAINT FK_AgPhones_Type foreign key (phone_type_id) references main.agent_phones (Id);
	
	ALTER SEQUENCE main.agent_phone_id_seq OWNED BY main.languages.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.localisation_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.localisations(
			Id INT primary key default nextval('main.localisation_id_seq'),
			Resource_Id INT not null, -- Domain, Agent, Object, etc... Id
			Resource_Type char(1),  -- D = Domain, U = Agent Name, L = Lang, O = Object type, C = City, R = Region, T = Text, F = Flat_Type, M = Material
			Lang_Id INT not null default 0,
			Domain_Id INT not null default 0, --- If no localisation for current domain - use default
			Local_Text VARCHAR(4000) not null,
			Short_text VARCHAR(5) not null
		);


	ALTER TABLE main.localisations ADD CONSTRAINT FK_Local_Lang foreign key (Lang_Id) references main.Languages (Id);
	ALTER TABLE main.localisations ADD CONSTRAINT FK_Local_Domain foreign key (Domain_Id) references main.Domains (Id);
	
	ALTER SEQUENCE main.localisation_id_seq OWNED BY main.languages.id;
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
	
	ALTER SEQUENCE main.text_id_seq OWNED BY main.languages.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.object_type_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.object_types(
			Id INT primary key default nextval('main.object_type_id_seq'),
			Obj_Name  VARCHAR(50),
			Short_Name  VARCHAR(5)
		);
		
	ALTER SEQUENCE main.object_type_id_seq OWNED BY main.languages.id;
	
	INSERT INTO main.object_types (Obj_Name, Short_Name) 
		   values ('Квартира','К'),  ('Будинок','Б') , ('Ділянка', 'Д');

/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.city_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.cities (
		Id INT primary key default nextval('main.city_id_seq'),
			City_Name VARCHAR(50) not null,
			City_Short_Name VARCHAR(5) not null
		);

	INSERT INTO main.cities(Id, City_Name, City_Short_Name) values (1, 'Вінниця', 'Вн');
	
	ALTER SEQUENCE main.city_id_seq OWNED BY main.languages.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.region_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.regions (
			Id INT primary key default nextval('main.region_id_seq'),
			City_Id INT not null,
			Region_Name VARCHAR(50) not null,
			Region_Description VARCHAR(500)
		);

	ALTER TABLE main.regions ADD CONSTRAINT FK_Reg_City foreign key (City_Id) references main.Cities(Id);
	
	ALTER SEQUENCE main.region_id_seq OWNED BY main.languages.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.street_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.streets (
			Id INT primary key default nextval('main.street_id_seq'),
			Region_Id INT not null,
			Street_Name VARCHAR(50) not null,
			Street_Description VARCHAR(500)
		);

	ALTER TABLE main.streets ADD CONSTRAINT FK_Street_Region foreign key (Region_Id) references main.Regions(Id);
	
	ALTER SEQUENCE main.street_id_seq OWNED BY main.languages.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.flat_types_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS main.flat_types (
		Id INT primary key default nextval('main.flat_types_id_seq'),
		Full_Type VARCHAR(50),
		Short_Type nchar(3)
	);
	
	ALTER SEQUENCE main.flat_types_id_seq OWNED BY main.languages.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.material_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.materials (
		Id INT primary key default nextval('main.material_id_seq'),
		Material_Name VARCHAR(50),
		Short_Name nchar(3)
	);
	
	ALTER SEQUENCE main.material_id_seq OWNED BY main.languages.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.object_id_seq MINVALUE 5;

		---- All Areas is in square meters
	CREATE TABLE IF NOT EXISTS  main.objects(
		Id INT primary key default nextval('main.object_id_seq'),
		Domain_Id INT not null,
		Agent_Id INT not null,
		Phone_Id INT,
		Shared_Option smallINT not null default 0, -- 0 = Private, 1 = Domain, 2 = Public
		Obj_Type INT not null, --- House, Flat 
		Land_Area float, 
		Apart_Area float, 
		Living_Area float, 
		Kitchen_Area float , 
		Rooms smallINT,
		Rooms_Type_Id smallINT, -- 
		Region_Id INT,
		Street_Id INT,
		Building_Number VARCHAR(5),
		Flat_Number INT,
		Flat_Type_Id smallINT,
		FloorNumber smallINT,
		Floors smallINT,
		Building_Type_Id  smallINT, -- material
		HasPhone smallINT,
		Orienter VARCHAR(200),
		Short_Description VARCHAR(500),
		Full_Description VARCHAR(4000),
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
	
	ALTER SEQUENCE main.object_id_seq OWNED BY main.languages.id;
	
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.client_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.clients(
			Id INT primary key default nextval('main.client_id_seq'),
			Domain_Id INT not null,
			Agent_Id INT not null,
			Last_Name  VARCHAR(50),
			First_Name  VARCHAR(50),
			Mid_Name VARCHAR(50),
			Birth_Date Date,
			Client_Type smallINT, -- 1 - Byer, 2 - Seller, 3- Both, 4 - Rent(look), 5- Rent(give)
			Tel1  VARCHAR(20),
			Tel2  VARCHAR(20),
			Tel3 VARCHAR(20),
			Contract_Id VARCHAR(20),
			Contract_Date Date,
			Agent_Phone_Id INT,
			Document_Type_Id smallINT,
			Document_Series VARCHAR(10),
			Document_Number VARCHAR(10),
			Document_Issued Date,
			StreetId INT,
			Building_No VARCHAR(5),
			Flat_No INT,
			Is_For_Rent smallINT,
			Short_description VARCHAR(200),
			Full_Description  VARCHAR(500)
			);

	ALTER TABLE main.clients ADD CONSTRAINT FK_Clients_Agent foreign key (Agent_Id) references main.Agents(id);
	ALTER TABLE main.clients ADD CONSTRAINT FK_Clients_Domains foreign key (Domain_Id) references main.Domains(id);
	ALTER TABLE main.clients ADD CONSTRAINT FK_Clients_Ag_Phone foreign key (Agent_Phone_Id) references main.Agent_Phones(id);
	ALTER TABLE main.clients ADD CONSTRAINT FK_Clients_Streets foreign key (StreetId) references main.Streets(id);
	
	ALTER SEQUENCE main.client_id_seq OWNED BY main.languages.id;
/*******************************************-=[  ]=-*******************************************/

/*******************************************-=[  ]=-*******************************************/
	CREATE SEQUENCE main.role_id_seq MINVALUE 5;

	CREATE TABLE IF NOT EXISTS  main.roles(
			Id INT primary key default nextval('main.role_id_seq'),
			Role_Name VARCHAR(16) not null,
			Role_Level  smallINT not null default 0, -- user cannot grant access of => rights to other users.
			Status smallINT not null default 0
		);

	ALTER TABLE main.roles ADD CONSTRAINT UK_Roles unique (Role_Name);
	
	ALTER SEQUENCE main.role_id_seq OWNED BY main.languages.id;
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

/*******************************************-=[  ]=-*******************************************/





INSERT INTO main.agents (id, Domain_Id, First_Name, Last_Name,Email, Phone, Status, Login_id)
VALUES (0, 0, 'test', 'test', 'test@test.test', '1234567', 1, 0);

INSERT INTO main.logins(id,  username, password, password_salt, Email, Phone, status)
values (0, 'test', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', '0000', 'test@test.test', '1234567', 0);


