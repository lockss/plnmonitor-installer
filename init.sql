SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 6 (class 2615 OID 2200)
-- Name: plnmonitor; Type: SCHEMA; Schema: -; Owner: plnmonitor
--
--CREATE ROLE plnmonitor LOGIN ENCRYPTED PASSWORD 'md5881a5f13bd547a394004e698b0bf7b83' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;

CREATE SCHEMA plnmonitor;

ALTER SCHEMA plnmonitor OWNER TO plnmonitor;

--CREATE DATABASE plnmonitor;
--ALTER DATABASE plnmonitor OWNER TO plnmonitor;

-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA plnmonitor; Type: COMMENT; Schema: -; Owner: plnmonitor
--

COMMENT ON SCHEMA plnmonitor IS 'standard public schema';


--
-- TOC entry 192 (class 3079 OID 12123)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 192
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = plnmonitor, pg_catalog;

--
-- TOC entry 206 (class 1255 OID 41080)
-- Name: new_au_insert(); Type: FUNCTION; Schema: plnmonitor; Owner: plnmonitor
--

CREATE FUNCTION new_au_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	 NEW.VERSION=1;
	 NEW.created_at = now();
	 INSERT INTO plnmonitor.au_version 
	 (name,plugin_name,tdb_year,access_type,content_size,recent_poll_agreement,creation_time,version, created_at, box, au_lockss_id, tdb_publisher, volume, disk_usage, last_completed_crawl, last_completed_poll, last_crawl, last_poll, crawl_pool, crawl_proxy, crawl_window, last_crawl_result, last_poll_result, publishing_platform, repository_path, subscription_status, substance_state, available_from_publisher)
	 VALUES
	 (NEW.name,NEW.plugin_name,NEW.tdb_year,NEW.access_type,NEW.content_size,NEW.recent_poll_agreement,NEW.creation_time,NEW.version,NEW.created_at,NEW.box, NEW.au_lockss_id, NEW.tdb_publisher, NEW.volume, NEW.disk_usage, NEW.last_completed_crawl, NEW.last_completed_poll, NEW.last_crawl, NEW.last_poll, NEW.crawl_pool, NEW.crawl_proxy, NEW.crawl_window, NEW.last_crawl_result, NEW.last_poll_result, NEW.publishing_platform, NEW.repository_path, NEW.subscription_status, NEW.substance_state, NEW.available_from_publisher);
	RETURN NEW;
END	$$;


ALTER FUNCTION plnmonitor.new_au_insert() OWNER TO plnmonitor;

--
-- TOC entry 208 (class 1255 OID 41081)
-- Name: new_au_update_version(); Type: FUNCTION; Schema: plnmonitor; Owner: plnmonitor
--

CREATE FUNCTION new_au_update_version() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	NEW.version=OLD.version+1;
	NEW.updated_at = now();	 
	INSERT INTO plnmonitor.au_version
	 (name,plugin_name,tdb_year,access_type,content_size,recent_poll_agreement,creation_time,version, created_at, updated_at,  box, au_lockss_id, tdb_publisher, volume, disk_usage, last_completed_crawl, last_completed_poll, last_crawl, last_poll, crawl_pool, crawl_proxy, crawl_window, last_crawl_result, last_poll_result, publishing_platform, repository_path, subscription_status, substance_state, available_from_publisher)
	 VALUES
	 (NEW.name,NEW.plugin_name,NEW.tdb_year,NEW.access_type,NEW.content_size,NEW.recent_poll_agreement,NEW.creation_time,NEW.version,NEW.created_at, NEW.updated_at,NEW.box, NEW.au_lockss_id, NEW.tdb_publisher, NEW.volume, NEW.disk_usage, NEW.last_completed_crawl, NEW.last_completed_poll, NEW.last_crawl, NEW.last_poll, NEW.crawl_pool, NEW.crawl_proxy, NEW.crawl_window, NEW.last_crawl_result, NEW.last_poll_result, NEW.publishing_platform, NEW.repository_path, NEW.subscription_status, NEW.substance_state, NEW.available_from_publisher);
	RETURN NEW;
END$$;


ALTER FUNCTION plnmonitor.new_au_update_version() OWNER TO plnmonitor;

--
-- TOC entry 207 (class 1255 OID 40977)
-- Name: new_box_data_insert(); Type: FUNCTION; Schema: plnmonitor; Owner: plnmonitor
--

CREATE FUNCTION new_box_data_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	 NEW.VERSION=1;
	 NEW.created_at = now();
	 INSERT INTO plnmonitor.lockss_box_data_version
	 (box,used,size,free,percentage,active_aus,version, created_at, repository_space_lockss_id, deleted_aus, inactive_aus, orphaned_aus)
	 VALUES
	 (NEW.box,NEW.used,NEW.size,NEW.free,NEW.percentage,NEW.active_aus,NEW.version,NEW.created_at, NEW.repository_space_lockss_id, NEW.deleted_aus, NEW.inactive_aus, NEW.orphaned_aus);
	RETURN NEW;
END$$;


ALTER FUNCTION plnmonitor.new_box_data_insert() OWNER TO plnmonitor;

--
-- TOC entry 205 (class 1255 OID 40975)
-- Name: new_box_data_update_version(); Type: FUNCTION; Schema: plnmonitor; Owner: plnmonitor
--

CREATE FUNCTION new_box_data_update_version() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	NEW.version=OLD.version+1;
	NEW.updated_at = now();

	INSERT INTO plnmonitor.lockss_box_data_version
	 (box,used,size,free,percentage,active_aus,version, created_at, updated_at, repository_space_lockss_id, deleted_aus, inactive_aus, orphaned_aus)
	 VALUES
	 (NEW.box,NEW.used,NEW.size,NEW.free,NEW.percentage,NEW.active_aus,NEW.version,NEW.created_at, NEW.updated_at, NEW.repository_space_lockss_id, NEW.deleted_aus, NEW.inactive_aus, NEW.orphaned_aus);
	RETURN NEW;

END
$$;


ALTER FUNCTION plnmonitor.new_box_data_update_version() OWNER TO plnmonitor;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 172 (class 1259 OID 16395)
-- Name: au_current; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE au_current (
    name text,
    plugin_name text,
    tdb_year text,
    access_type text,
    content_size bigint,
    recent_poll_agreement double precision,
    creation_time bigint,
    version integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    box integer,
    au_lockss_id text,
    tdb_publisher text,
    volume text,
    disk_usage bigint,
    last_completed_crawl bigint,
    last_completed_poll bigint,
    last_crawl bigint,
    last_poll bigint,
    crawl_pool text,
    crawl_proxy text,
    crawl_window text,
    last_crawl_result text,
    last_poll_result text,
    publishing_platform text,
    repository_path text,
    subscription_status text,
    substance_state text,
    available_from_publisher boolean,
    id integer NOT NULL
);


ALTER TABLE au_current OWNER TO plnmonitor;

--
-- TOC entry 182 (class 1259 OID 57355)
-- Name: AU_current_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "AU_current_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "AU_current_id_seq" OWNER TO plnmonitor;

--
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 182
-- Name: AU_current_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "AU_current_id_seq" OWNED BY au_current.id;


--
-- TOC entry 176 (class 1259 OID 16476)
-- Name: institution; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE institution (
    address text,
    name text,
    id integer NOT NULL,
    shortname text
);


ALTER TABLE institution OWNER TO plnmonitor;

--
-- TOC entry 185 (class 1259 OID 57387)
-- Name: Institutions_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "Institutions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Institutions_id_seq" OWNER TO plnmonitor;

--
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 185
-- Name: Institutions_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "Institutions_id_seq" OWNED BY institution.id;


--
-- TOC entry 178 (class 1259 OID 24576)
-- Name: lockss_box_data_current; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE lockss_box_data_current (
    box integer NOT NULL,
    used bigint,
    size bigint,
    free bigint,
    percentage double precision,
    active_aus integer,
    version integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    repository_space_lockss_id text,
    deleted_aus integer,
    inactive_aus integer,
    orphaned_aus integer,
    id integer NOT NULL
);


ALTER TABLE lockss_box_data_current OWNER TO plnmonitor;

--
-- TOC entry 189 (class 1259 OID 57490)
-- Name: LOCKSS_box_data_current_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "LOCKSS_box_data_current_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "LOCKSS_box_data_current_id_seq" OWNER TO plnmonitor;

--
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 189
-- Name: LOCKSS_box_data_current_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "LOCKSS_box_data_current_id_seq" OWNED BY lockss_box_data_current.id;


--
-- TOC entry 179 (class 1259 OID 32770)
-- Name: lockss_box_data_version; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE lockss_box_data_version (
    box integer NOT NULL,
    version integer NOT NULL,
    used bigint,
    size bigint,
    free bigint,
    percentage double precision,
    active_aus integer,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    repository_space_lockss_id text,
    deleted_aus integer,
    inactive_aus integer,
    orphaned_aus integer,
    id integer NOT NULL,
    data_current integer
);


ALTER TABLE lockss_box_data_version OWNER TO plnmonitor;

--
-- TOC entry 190 (class 1259 OID 57520)
-- Name: LOCKSS_box_data_version_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "LOCKSS_box_data_version_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "LOCKSS_box_data_version_id_seq" OWNER TO plnmonitor;

--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 190
-- Name: LOCKSS_box_data_version_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "LOCKSS_box_data_version_id_seq" OWNED BY lockss_box_data_version.id;


--
-- TOC entry 173 (class 1259 OID 16403)
-- Name: lockss_box; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE lockss_box (
    urldss text,
    ipaddress text NOT NULL,
    uiport text NOT NULL,
    pln integer,
    physical_address text,
    v3identity text,
    admin_email text,
    daemon_full_version text,
    java_version text,
    platform text,
    "current_time" bigint,
    uptime bigint,
    groups text,
    disks text,
    id integer NOT NULL
);


ALTER TABLE lockss_box OWNER TO plnmonitor;

--
-- TOC entry 183 (class 1259 OID 57366)
-- Name: LOCKSS_box_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "LOCKSS_box_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "LOCKSS_box_id_seq" OWNER TO plnmonitor;

--
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 183
-- Name: LOCKSS_box_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "LOCKSS_box_id_seq" OWNED BY lockss_box.id;


--
-- TOC entry 181 (class 1259 OID 41106)
-- Name: lockss_box_info; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE lockss_box_info (
    box integer,
    username text,
    password text,
    longitude double precision,
    latitude double precision,
    country text,
    institution integer,
    organizational_manager integer,
    technical_manager integer,
    physical_address text,
    id integer NOT NULL,
    name text
);


ALTER TABLE lockss_box_info OWNER TO plnmonitor;

--
-- TOC entry 188 (class 1259 OID 57452)
-- Name: LOCKSS_box_info_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "LOCKSS_box_info_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "LOCKSS_box_info_id_seq" OWNER TO plnmonitor;

--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 188
-- Name: LOCKSS_box_info_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "LOCKSS_box_info_id_seq" OWNED BY lockss_box_info.id;


--
-- TOC entry 174 (class 1259 OID 16414)
-- Name: peer; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE peer (
    last_poll bigint,
    polls_called bigint,
    last_invitation bigint,
    last_vote bigint,
    box integer,
    peer_lockss_id text,
    last_message bigint,
    invitation_count bigint,
    message_count bigint,
    message_type text,
    polls_rejected bigint,
    votes_cast bigint,
    id integer NOT NULL
);


ALTER TABLE peer OWNER TO plnmonitor;

--
-- TOC entry 186 (class 1259 OID 57397)
-- Name: Peers_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "Peers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Peers_id_seq" OWNER TO plnmonitor;

--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 186
-- Name: Peers_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "Peers_id_seq" OWNED BY peer.id;


--
-- TOC entry 177 (class 1259 OID 16482)
-- Name: person; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE person (
    name text,
    first_name text,
    email_address text,
    institution integer,
    id integer NOT NULL,
    phone text
);


ALTER TABLE person OWNER TO plnmonitor;

--
-- TOC entry 184 (class 1259 OID 57377)
-- Name: Person_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE "Person_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Person_id_seq" OWNER TO plnmonitor;

--
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 184
-- Name: Person_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE "Person_id_seq" OWNED BY person.id;


--
-- TOC entry 180 (class 1259 OID 32789)
-- Name: au_version; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE au_version (
    version integer NOT NULL,
    name text,
    plugin_name text,
    tdb_year text,
    access_type text,
    content_size bigint,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    box integer,
    recent_poll_agreement double precision,
    creation_time bigint,
    au_lockss_id text,
    tdb_publisher text,
    volume text,
    disk_usage bigint,
    last_completed_crawl bigint,
    last_completed_poll bigint,
    last_crawl bigint,
    last_poll bigint,
    crawl_pool text,
    crawl_proxy text,
    crawl_window text,
    last_crawl_result text,
    last_poll_result text,
    publishing_platform text,
    repository_path text,
    subscription_status text,
    substance_state text,
    available_from_publisher boolean,
    id integer NOT NULL,
    au_current integer
);


ALTER TABLE au_version OWNER TO plnmonitor;

--
-- TOC entry 191 (class 1259 OID 57543)
-- Name: au_version_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE au_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE au_version_id_seq OWNER TO plnmonitor;

--
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 191
-- Name: au_version_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE au_version_id_seq OWNED BY au_version.id;


--
-- TOC entry 175 (class 1259 OID 16417)
-- Name: pln; Type: TABLE; Schema: plnmonitor; Owner: plnmonitor; Tablespace: 
--

CREATE TABLE pln (
    name text,
    config_url text,
    id integer NOT NULL
);


ALTER TABLE pln OWNER TO plnmonitor;

--
-- TOC entry 187 (class 1259 OID 57440)
-- Name: pln_id_seq; Type: SEQUENCE; Schema: plnmonitor; Owner: plnmonitor
--

CREATE SEQUENCE pln_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pln_id_seq OWNER TO plnmonitor;

--
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 187
-- Name: pln_id_seq; Type: SEQUENCE OWNED BY; Schema: plnmonitor; Owner: plnmonitor
--

ALTER SEQUENCE pln_id_seq OWNED BY pln.id;


--
-- TOC entry 2215 (class 2604 OID 57357)
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY au_current ALTER COLUMN id SET DEFAULT nextval('"AU_current_id_seq"'::regclass);


--
-- TOC entry 2223 (class 2604 OID 57545)
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY au_version ALTER COLUMN id SET DEFAULT nextval('au_version_id_seq'::regclass);


--
-- TOC entry 2219 (class 2604 OID 57389)
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY institution ALTER COLUMN id SET DEFAULT nextval('"Institutions_id_seq"'::regclass);


--
-- TOC entry 2216 (class 2604 OID 57368)
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box ALTER COLUMN id SET DEFAULT nextval('"LOCKSS_box_id_seq"'::regclass);


--
-- TOC entry 2221 (class 2604 OID 57492)
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_data_current ALTER COLUMN id SET DEFAULT nextval('"LOCKSS_box_data_current_id_seq"'::regclass);


--
-- TOC entry 2222 (class 2604 OID 57522)
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_data_version ALTER COLUMN id SET DEFAULT nextval('"LOCKSS_box_data_version_id_seq"'::regclass);


--
-- TOC entry 2224 (class 2604 OID 57454)
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY lockss_box_info ALTER COLUMN id SET DEFAULT nextval('"LOCKSS_box_info_id_seq"'::regclass);


--
-- TOC entry 2217 (class 2604 OID 57399)
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY peer ALTER COLUMN id SET DEFAULT nextval('"Peers_id_seq"'::regclass);


--
-- TOC entry 2220 (class 2604 OID 57379)
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY person ALTER COLUMN id SET DEFAULT nextval('"Person_id_seq"'::regclass);


--
-- TOC entry 2218 (class 2604 OID 57442)
-- Name: id; Type: DEFAULT; Schema: plnmonitor; Owner: plnmonitor
--

ALTER TABLE ONLY pln ALTER COLUMN id SET DEFAULT nextval('pln_id_seq'::regclass);


--
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 182
-- Name: AU_current_id_seq; Type: SEQUENCE SET; Schema: plnmonitor; Owner: plnmonitor
--

SELECT pg_catalog.setval('"AU_current_id_seq"', 19, true);


--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 185
-- Name: Institutions_id_seq; Type: SEQUENCE SET; Schema: plnmonitor; Owner: plnmonitor
--

SELECT pg_catalog.setval('"Institutions_id_seq"', 6, true);


--
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 189
-- Name: LOCKSS_box_data_current_id_seq; Type: SEQUENCE SET; Schema: plnmonitor; Owner: plnmonitor
--

SELECT pg_catalog.setval('"LOCKSS_box_data_current_id_seq"', 14, true);


--
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 190
-- Name: LOCKSS_box_data_version_id_seq; Type: SEQUENCE SET; Schema: plnmonitor; Owner: plnmonitor
--

SELECT pg_catalog.setval('"LOCKSS_box_data_version_id_seq"', 221, true);


--
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 183
-- Name: LOCKSS_box_id_seq; Type: SEQUENCE SET; Schema: plnmonitor; Owner: plnmonitor
--

SELECT pg_catalog.setval('"LOCKSS_box_id_seq"', 12, true);


--
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 188
-- Name: LOCKSS_box_info_id_seq; Type: SEQUENCE SET; Schema: plnmonitor; Owner: plnmonitor
--

SELECT pg_catalog.setval('"LOCKSS_box_info_id_seq"', 7, true);


--
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 186
-- Name: Peers_id_seq; Type: SEQUENCE SET; Schema: plnmonitor; Owner: plnmonitor
--

SELECT pg_catalog.setval('"Peers_id_seq"', 11, true);


--
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 184
-- Name: Person_id_seq; Type: SEQUENCE SET; Schema: plnmonitor; Owner: plnmonitor
--

SELECT pg_catalog.setval('"Person_id_seq"', 10, true);

INSERT INTO pln VALUES ('SAFE', 'http://lockssadmin.ulb.ac.be/lockss.xml', 1);
--INSERT INTO user VALUES('admin', '$2a$10$l.qhKtMQd0ejggOp9NdVNuv6FBJdb3QGBavrvHkFAlqTRxP8XGAVi' ,'"ADMIN"');
