--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: main; Type: SCHEMA; Schema: -; Owner: amuletgrey_estate
--

CREATE SCHEMA main;


ALTER SCHEMA main OWNER TO amuletgrey_estate;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = main, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: field_types; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE field_types (
    id integer NOT NULL,
    is_multi smallint DEFAULT 0 NOT NULL,
    field_type character varying(25) NOT NULL
);


ALTER TABLE field_types OWNER TO amuletgrey_estate;

--
-- Name: agent_phone_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE agent_phone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE agent_phone_id_seq OWNER TO amuletgrey_estate;

--
-- Name: agent_phone_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE agent_phone_id_seq OWNED BY field_types.id;


--
-- Name: agent_fields; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE agent_fields (
    id integer DEFAULT nextval('agent_phone_id_seq'::regclass) NOT NULL,
    agent_id integer NOT NULL,
    field_type_id integer DEFAULT 1 NOT NULL,
    f_value character varying(255) NOT NULL
);


ALTER TABLE agent_fields OWNER TO amuletgrey_estate;

--
-- Name: agents; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE agents (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    domain_id integer NOT NULL,
    login_id integer,
    guid uuid,
    email character varying(50) NOT NULL,
    phone character varying(50) NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    profile_picture character varying(250),
    "position" character varying(50)
);


ALTER TABLE agents OWNER TO amuletgrey_estate;

--
-- Name: agent_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE agent_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE agent_id_seq OWNER TO amuletgrey_estate;

--
-- Name: agent_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE agent_id_seq OWNED BY agents.id;


--
-- Name: agent_roles; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE agent_roles (
    agent_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE agent_roles OWNER TO amuletgrey_estate;

--
-- Name: articles; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE articles (
    id integer NOT NULL,
    name character varying(50),
    guid uuid,
    domain_id integer NOT NULL,
    lang_id integer DEFAULT 804 NOT NULL,
    category character varying(50),
    subcategory character varying(50),
    picture character varying(255),
    date1 date,
    date2 date,
    text1 character varying(500),
    text2 character varying(500),
    article_text text,
    order_value integer DEFAULT 0 NOT NULL
);


ALTER TABLE articles OWNER TO amuletgrey_estate;

--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE articles_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE articles_id_seq OWNER TO amuletgrey_estate;

--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE articles_id_seq OWNED BY articles.id;


--
-- Name: cities; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE cities (
    id integer NOT NULL,
    city_name character varying(50) NOT NULL,
    city_short_name character varying(5) NOT NULL
);


ALTER TABLE cities OWNER TO amuletgrey_estate;

--
-- Name: city_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE city_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE city_id_seq OWNER TO amuletgrey_estate;

--
-- Name: city_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE city_id_seq OWNED BY cities.id;


--
-- Name: clients; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE clients (
    id integer NOT NULL,
    domain_id integer NOT NULL,
    agent_id integer NOT NULL,
    name character varying(50),
    mid_name character varying(50),
    birth_date date,
    client_type smallint,
    tel1 character varying(20),
    tel2 character varying(20),
    tel3 character varying(20),
    contract_id character varying(20),
    contract_date date,
    agent_phone_id integer,
    document_type_id smallint,
    document_series character varying(10),
    document_number character varying(10),
    document_issued date,
    streetid integer,
    building_no character varying(5),
    flat_no integer,
    is_for_rent smallint,
    short_description character varying(200),
    full_description character varying(500)
);


ALTER TABLE clients OWNER TO amuletgrey_estate;

--
-- Name: client_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE client_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE client_id_seq OWNER TO amuletgrey_estate;

--
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE client_id_seq OWNED BY clients.id;


--
-- Name: domains; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE domains (
    id integer NOT NULL,
    domain_name character varying(50) NOT NULL,
    default_lang_id integer DEFAULT 804 NOT NULL,
    site_domain_name character varying(50)
);


ALTER TABLE domains OWNER TO amuletgrey_estate;

--
-- Name: domain_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE domain_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE domain_id_seq OWNER TO amuletgrey_estate;

--
-- Name: domain_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE domain_id_seq OWNED BY domains.id;


--
-- Name: flat_types; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE flat_types (
    id integer NOT NULL,
    full_type character varying(50),
    short_type character(3)
);


ALTER TABLE flat_types OWNER TO amuletgrey_estate;

--
-- Name: flat_types_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE flat_types_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE flat_types_id_seq OWNER TO amuletgrey_estate;

--
-- Name: flat_types_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE flat_types_id_seq OWNED BY flat_types.id;


--
-- Name: languages; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE languages (
    id integer NOT NULL,
    shortest_name character(2),
    short_name character(3),
    full_name character varying(50)
);


ALTER TABLE languages OWNER TO amuletgrey_estate;

--
-- Name: language_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE language_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE language_id_seq OWNER TO amuletgrey_estate;

--
-- Name: language_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE language_id_seq OWNED BY languages.id;


--
-- Name: localisations; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE localisations (
    id integer NOT NULL,
    resource_id integer NOT NULL,
    resource_type character(1),
    lang_id integer DEFAULT 804 NOT NULL,
    domain_id integer DEFAULT 0 NOT NULL,
    local_text character varying(250) NOT NULL,
    short_text character varying(25) NOT NULL
);


ALTER TABLE localisations OWNER TO amuletgrey_estate;

--
-- Name: localisation_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE localisation_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE localisation_id_seq OWNER TO amuletgrey_estate;

--
-- Name: localisation_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE localisation_id_seq OWNED BY localisations.id;


--
-- Name: logins; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE logins (
    id integer NOT NULL,
    username character varying(50),
    guid uuid,
    email character varying(50),
    password character varying(64) NOT NULL,
    password_salt character varying(20) NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    attempt character varying(15) DEFAULT '0'::character varying NOT NULL,
    status smallint DEFAULT 0 NOT NULL
);


ALTER TABLE logins OWNER TO amuletgrey_estate;

--
-- Name: login_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE login_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE login_id_seq OWNER TO amuletgrey_estate;

--
-- Name: login_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE login_id_seq OWNED BY logins.id;


--
-- Name: materials; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE materials (
    id integer NOT NULL,
    material_name character varying(50),
    short_name character(3)
);


ALTER TABLE materials OWNER TO amuletgrey_estate;

--
-- Name: material_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE material_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE material_id_seq OWNER TO amuletgrey_estate;

--
-- Name: material_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE material_id_seq OWNED BY materials.id;


--
-- Name: objects; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE objects (
    id integer NOT NULL,
    domain_id integer NOT NULL,
    agent_id integer NOT NULL,
    phone_id integer,
    shared_option smallint DEFAULT 0 NOT NULL,
    obj_type integer NOT NULL,
    land_area double precision,
    apart_area double precision,
    living_area double precision,
    kitchen_area double precision,
    rooms smallint,
    rooms_type_id smallint,
    region_id integer,
    street_id integer,
    building_number character varying(5),
    flat_number integer,
    flat_type_id smallint,
    floornumber smallint,
    floors smallint,
    building_type_id smallint,
    hasphone smallint,
    orienter character varying(200),
    short_description character varying(500),
    full_description character varying(4000),
    price double precision,
    contacts character varying(500),
    tel1 character varying(30),
    tel2 character varying(30),
    tel3 character varying(30),
    obj_date date
);


ALTER TABLE objects OWNER TO amuletgrey_estate;

--
-- Name: object_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE object_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE object_id_seq OWNER TO amuletgrey_estate;

--
-- Name: object_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE object_id_seq OWNED BY objects.id;


--
-- Name: object_types; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE object_types (
    id integer NOT NULL,
    obj_name character varying(50),
    short_name character varying(5)
);


ALTER TABLE object_types OWNER TO amuletgrey_estate;

--
-- Name: object_type_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE object_type_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE object_type_id_seq OWNER TO amuletgrey_estate;

--
-- Name: object_type_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE object_type_id_seq OWNED BY object_types.id;


--
-- Name: phrases; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE phrases (
    id integer NOT NULL,
    name character varying(50),
    domain_id integer NOT NULL,
    lang_id integer DEFAULT 804 NOT NULL,
    category character varying(50),
    subcategory character varying(50),
    text character varying(250)
);


ALTER TABLE phrases OWNER TO amuletgrey_estate;

--
-- Name: phrases_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE phrases_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE phrases_id_seq OWNER TO amuletgrey_estate;

--
-- Name: phrases_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE phrases_id_seq OWNED BY phrases.id;


--
-- Name: regions; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE regions (
    id integer NOT NULL,
    city_id integer NOT NULL,
    region_name character varying(50) NOT NULL,
    region_description character varying(500)
);


ALTER TABLE regions OWNER TO amuletgrey_estate;

--
-- Name: region_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE region_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE region_id_seq OWNER TO amuletgrey_estate;

--
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE region_id_seq OWNED BY regions.id;


--
-- Name: reset_tokens; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE reset_tokens (
    token character varying(40) NOT NULL,
    uid integer NOT NULL,
    requested character varying(20) NOT NULL
);


ALTER TABLE reset_tokens OWNER TO amuletgrey_estate;

--
-- Name: roles; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    role_name character varying(16) NOT NULL,
    role_level smallint DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL
);


ALTER TABLE roles OWNER TO amuletgrey_estate;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE role_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE role_id_seq OWNER TO amuletgrey_estate;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE role_id_seq OWNED BY roles.id;


--
-- Name: streets; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE streets (
    id integer NOT NULL,
    region_id integer NOT NULL,
    street_name character varying(50) NOT NULL,
    street_description character varying(500)
);


ALTER TABLE streets OWNER TO amuletgrey_estate;

--
-- Name: street_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE street_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE street_id_seq OWNER TO amuletgrey_estate;

--
-- Name: street_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE street_id_seq OWNED BY streets.id;


--
-- Name: texts; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE texts (
    id integer NOT NULL,
    domain_id integer DEFAULT 0 NOT NULL,
    text_name character varying(32),
    ttext character varying(4000)
);


ALTER TABLE texts OWNER TO amuletgrey_estate;

--
-- Name: text_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE text_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE text_id_seq OWNER TO amuletgrey_estate;

--
-- Name: text_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE text_id_seq OWNED BY texts.id;


--
-- Name: user_devices; Type: TABLE; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE TABLE user_devices (
    id integer NOT NULL,
    uid integer NOT NULL,
    token character varying(15) NOT NULL,
    last_access character varying(20) NOT NULL
);


ALTER TABLE user_devices OWNER TO amuletgrey_estate;

--
-- Name: user_devices_id_seq; Type: SEQUENCE; Schema: main; Owner: amuletgrey_estate
--

CREATE SEQUENCE user_devices_id_seq
    START WITH 5
    INCREMENT BY 1
    MINVALUE 5
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_devices_id_seq OWNER TO amuletgrey_estate;

--
-- Name: user_devices_id_seq; Type: SEQUENCE OWNED BY; Schema: main; Owner: amuletgrey_estate
--

ALTER SEQUENCE user_devices_id_seq OWNED BY user_devices.id;


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY agents ALTER COLUMN id SET DEFAULT nextval('agent_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY articles ALTER COLUMN id SET DEFAULT nextval('articles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY cities ALTER COLUMN id SET DEFAULT nextval('city_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('client_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY domains ALTER COLUMN id SET DEFAULT nextval('domain_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY flat_types ALTER COLUMN id SET DEFAULT nextval('flat_types_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY languages ALTER COLUMN id SET DEFAULT nextval('language_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY localisations ALTER COLUMN id SET DEFAULT nextval('localisation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY logins ALTER COLUMN id SET DEFAULT nextval('login_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY materials ALTER COLUMN id SET DEFAULT nextval('material_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY object_types ALTER COLUMN id SET DEFAULT nextval('object_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY objects ALTER COLUMN id SET DEFAULT nextval('object_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY phrases ALTER COLUMN id SET DEFAULT nextval('phrases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY regions ALTER COLUMN id SET DEFAULT nextval('region_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY streets ALTER COLUMN id SET DEFAULT nextval('street_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY texts ALTER COLUMN id SET DEFAULT nextval('text_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY user_devices ALTER COLUMN id SET DEFAULT nextval('user_devices_id_seq'::regclass);


--
-- Data for Name: agent_fields; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY agent_fields (id, agent_id, field_type_id, f_value) FROM stdin;
1	3	6	http://dom.ria.ua
2	3	3	http://vk.com/id31747196
3	3	2	https://www.facebook.com/100007186382429
4	1	3	http://vk.com/id188877433
5	1	2	https://www.facebook.com/100002635164478
6	5	3	http://vk.com/id293757707
\.


--
-- Name: agent_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('agent_id_seq', 5, true);


--
-- Name: agent_phone_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('agent_phone_id_seq', 6, true);


--
-- Data for Name: agent_roles; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY agent_roles (agent_id, role_id) FROM stdin;
\.


--
-- Data for Name: agents; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY agents (id, name, domain_id, login_id, guid, email, phone, status, profile_picture, "position") FROM stdin;
3	Марина	1	3	\N	Marina121r@gmail.com	1	1	img/team/1.jpg	Провідний Спеціаліст
2	Сніжанна	1	\N	\N	2@gmail.com	1	1	img/uploads/Snijanna.jpg	Спеціаліст
4	Ірина	1	1	\N	1@gmail.com	1	1	img/team/3.jpg	Провідний Спеціаліст
1	Наталя	1	\N	\N	3@gmail.com	1	0	img/uploads/Nata.jpg	Директор
\.


--
-- Data for Name: articles; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY articles (id, name, guid, domain_id, lang_id, category, subcategory, picture, date1, date2, text1, text2, article_text, order_value) FROM stdin;
5	sales	\N	1	804	services	\N	shopping-cart	\N	\N	Продаж	null	Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.	1
6	advertisement	\N	1	804	services	\N	laptop	\N	\N	Реклама	null	Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.	2
7	guard	\N	1	804	services	\N	lock	\N	\N	Супровід	null	Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.	3
8	first	\N	1	804	history	\N	img/about/1.jpg	\N	\N	2009-2011	Our Humble Beginnings	Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.	1
9	second	\N	1	804	history	\N	img/about/2.jpg	\N	\N	March 2011	An Agency is Born	Lorem ipsum dolor sit amet, consectetur adipisicing elit. Minima maxime quam architecto quo inventore harum ex magni, dicta impedit.	2
\.


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('articles_id_seq', 9, true);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY cities (id, city_name, city_short_name) FROM stdin;
1	Вінниця	Вн
\.


--
-- Name: city_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('city_id_seq', 5, false);


--
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('client_id_seq', 5, false);


--
-- Data for Name: clients; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY clients (id, domain_id, agent_id, name, mid_name, birth_date, client_type, tel1, tel2, tel3, contract_id, contract_date, agent_phone_id, document_type_id, document_series, document_number, document_issued, streetid, building_no, flat_no, is_for_rent, short_description, full_description) FROM stdin;
\.


--
-- Name: domain_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('domain_id_seq', 5, false);


--
-- Data for Name: domains; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY domains (id, domain_name, default_lang_id, site_domain_name) FROM stdin;
0	[Default]	804	\N
1	121 RE	804	\N
\.


--
-- Data for Name: field_types; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY field_types (id, is_multi, field_type) FROM stdin;
1	5	phone
2	0	social_facebook
3	0	social_vk
4	0	social_odnoklassniki
5	0	social_twitter
6	0	social_ria
7	0	social_olx
\.


--
-- Data for Name: flat_types; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY flat_types (id, full_type, short_type) FROM stdin;
\.


--
-- Name: flat_types_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('flat_types_id_seq', 5, false);


--
-- Name: language_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('language_id_seq', 5, false);


--
-- Data for Name: languages; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY languages (id, shortest_name, short_name, full_name) FROM stdin;
804	UA	UKR	Українська
\.


--
-- Name: localisation_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('localisation_id_seq', 5, false);


--
-- Data for Name: localisations; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY localisations (id, resource_id, resource_type, lang_id, domain_id, local_text, short_text) FROM stdin;
\.


--
-- Name: login_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('login_id_seq', 5, false);


--
-- Data for Name: logins; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY logins (id, username, guid, email, password, password_salt, created, attempt, status) FROM stdin;
\.


--
-- Name: material_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('material_id_seq', 5, false);


--
-- Data for Name: materials; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY materials (id, material_name, short_name) FROM stdin;
\.


--
-- Name: object_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('object_id_seq', 5, false);


--
-- Name: object_type_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('object_type_id_seq', 7, true);


--
-- Data for Name: object_types; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY object_types (id, obj_name, short_name) FROM stdin;
5	Квартира	К
6	Будинок	Б
7	Ділянка	Д
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY objects (id, domain_id, agent_id, phone_id, shared_option, obj_type, land_area, apart_area, living_area, kitchen_area, rooms, rooms_type_id, region_id, street_id, building_number, flat_number, flat_type_id, floornumber, floors, building_type_id, hasphone, orienter, short_description, full_description, price, contacts, tel1, tel2, tel3, obj_date) FROM stdin;
\.


--
-- Data for Name: phrases; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY phrases (id, name, domain_id, lang_id, category, subcategory, text) FROM stdin;
\.


--
-- Name: phrases_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('phrases_id_seq', 5, false);


--
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('region_id_seq', 5, false);


--
-- Data for Name: regions; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY regions (id, city_id, region_name, region_description) FROM stdin;
\.


--
-- Data for Name: reset_tokens; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY reset_tokens (token, uid, requested) FROM stdin;
\.


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('role_id_seq', 5, false);


--
-- Data for Name: roles; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY roles (id, role_name, role_level, status) FROM stdin;
\.


--
-- Name: street_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('street_id_seq', 5, false);


--
-- Data for Name: streets; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY streets (id, region_id, street_name, street_description) FROM stdin;
\.


--
-- Name: text_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('text_id_seq', 5, false);


--
-- Data for Name: texts; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY texts (id, domain_id, text_name, ttext) FROM stdin;
\.


--
-- Data for Name: user_devices; Type: TABLE DATA; Schema: main; Owner: amuletgrey_estate
--

COPY user_devices (id, uid, token, last_access) FROM stdin;
\.


--
-- Name: user_devices_id_seq; Type: SEQUENCE SET; Schema: main; Owner: amuletgrey_estate
--

SELECT pg_catalog.setval('user_devices_id_seq', 5, false);


--
-- Name: agent_fields_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY agent_fields
    ADD CONSTRAINT agent_fields_pkey PRIMARY KEY (id);


--
-- Name: agent_roles_pk; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY agent_roles
    ADD CONSTRAINT agent_roles_pk PRIMARY KEY (agent_id, role_id);


--
-- Name: agents_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY agents
    ADD CONSTRAINT agents_pkey PRIMARY KEY (id);


--
-- Name: articles_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: cities_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: domains_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY domains
    ADD CONSTRAINT domains_pkey PRIMARY KEY (id);


--
-- Name: field_types_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY field_types
    ADD CONSTRAINT field_types_pkey PRIMARY KEY (id);


--
-- Name: flat_types_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY flat_types
    ADD CONSTRAINT flat_types_pkey PRIMARY KEY (id);


--
-- Name: languages_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: localisations_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY localisations
    ADD CONSTRAINT localisations_pkey PRIMARY KEY (id);


--
-- Name: logins_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY logins
    ADD CONSTRAINT logins_pkey PRIMARY KEY (id);


--
-- Name: materials_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


--
-- Name: object_types_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY object_types
    ADD CONSTRAINT object_types_pkey PRIMARY KEY (id);


--
-- Name: objects_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: phrases_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY phrases
    ADD CONSTRAINT phrases_pkey PRIMARY KEY (id);


--
-- Name: regions_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: streets_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY streets
    ADD CONSTRAINT streets_pkey PRIMARY KEY (id);


--
-- Name: texts_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY texts
    ADD CONSTRAINT texts_pkey PRIMARY KEY (id);


--
-- Name: uk_agents; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY agents
    ADD CONSTRAINT uk_agents UNIQUE (domain_id, email);


--
-- Name: uk_roles; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT uk_roles UNIQUE (role_name);


--
-- Name: user_devices_pkey; Type: CONSTRAINT; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

ALTER TABLE ONLY user_devices
    ADD CONSTRAINT user_devices_pkey PRIMARY KEY (id);


--
-- Name: client_first_name; Type: INDEX; Schema: main; Owner: amuletgrey_estate; Tablespace: 
--

CREATE INDEX client_first_name ON clients USING btree (name varchar_pattern_ops);


--
-- Name: fk_agent_domain; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY agents
    ADD CONSTRAINT fk_agent_domain FOREIGN KEY (domain_id) REFERENCES domains(id);


--
-- Name: fk_agent_roles_role; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY agent_roles
    ADD CONSTRAINT fk_agent_roles_role FOREIGN KEY (role_id) REFERENCES roles(id);


--
-- Name: fk_agfield_types; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY agent_fields
    ADD CONSTRAINT fk_agfield_types FOREIGN KEY (field_type_id) REFERENCES field_types(id);


--
-- Name: fk_article_domain; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT fk_article_domain FOREIGN KEY (domain_id) REFERENCES domains(id);


--
-- Name: fk_articles_lang; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT fk_articles_lang FOREIGN KEY (lang_id) REFERENCES languages(id);


--
-- Name: fk_clients_streets; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT fk_clients_streets FOREIGN KEY (streetid) REFERENCES streets(id);


--
-- Name: fk_domain_lang; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY domains
    ADD CONSTRAINT fk_domain_lang FOREIGN KEY (default_lang_id) REFERENCES languages(id);


--
-- Name: fk_local_domain; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY localisations
    ADD CONSTRAINT fk_local_domain FOREIGN KEY (domain_id) REFERENCES domains(id);


--
-- Name: fk_local_lang; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY localisations
    ADD CONSTRAINT fk_local_lang FOREIGN KEY (lang_id) REFERENCES languages(id);


--
-- Name: fk_object_regions; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY objects
    ADD CONSTRAINT fk_object_regions FOREIGN KEY (region_id) REFERENCES regions(id);


--
-- Name: fk_object_streets; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY objects
    ADD CONSTRAINT fk_object_streets FOREIGN KEY (street_id) REFERENCES streets(id);


--
-- Name: fk_phrase_domain; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY phrases
    ADD CONSTRAINT fk_phrase_domain FOREIGN KEY (domain_id) REFERENCES domains(id);


--
-- Name: fk_phrases_lang; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY phrases
    ADD CONSTRAINT fk_phrases_lang FOREIGN KEY (lang_id) REFERENCES languages(id);


--
-- Name: fk_reg_city; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT fk_reg_city FOREIGN KEY (city_id) REFERENCES cities(id);


--
-- Name: fk_street_region; Type: FK CONSTRAINT; Schema: main; Owner: amuletgrey_estate
--

ALTER TABLE ONLY streets
    ADD CONSTRAINT fk_street_region FOREIGN KEY (region_id) REFERENCES regions(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

