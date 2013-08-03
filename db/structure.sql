--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: _final_median(anyarray); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _final_median(anyarray) RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $_$
      WITH q AS
      (
        SELECT val
        FROM unnest($1) val
        WHERE VAL IS NOT NULL
        ORDER BY 1
      ),
      cnt AS
      (
        SELECT COUNT(*) AS c FROM q
      )
      SELECT AVG(val)::float8
      FROM
      (
        SELECT val FROM q
        LIMIT  2 - MOD((SELECT c FROM cnt), 2)
        OFFSET GREATEST(CEIL((SELECT c FROM cnt) / 2.0) - 1,0)
      ) q2;
    $_$;


--
-- Name: median(anyelement); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE median(anyelement) (
    SFUNC = array_append,
    STYPE = anyarray,
    INITCOND = '{}',
    FINALFUNC = _final_median
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: app_access_tokens; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE app_access_tokens (
    id integer NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    app_id integer NOT NULL
);


--
-- Name: app_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE app_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: app_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE app_access_tokens_id_seq OWNED BY app_access_tokens.id;


--
-- Name: apps; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE apps (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: apps_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE apps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: apps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE apps_id_seq OWNED BY apps.id;


--
-- Name: mailer_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mailer_events (
    id bigint NOT NULL,
    transaction_id integer,
    mailer character varying(255) NOT NULL,
    message_id character varying(255),
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    duration double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: mailer_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mailer_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mailer_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mailer_events_id_seq OWNED BY mailer_events.id;


--
-- Name: n_plus_one_queries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE n_plus_one_queries (
    id integer NOT NULL,
    transaction_id integer,
    culprit_table_name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: n_plus_one_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE n_plus_one_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: n_plus_one_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE n_plus_one_queries_id_seq OWNED BY n_plus_one_queries.id;


--
-- Name: n_plus_one_query_sql_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE n_plus_one_query_sql_events (
    id integer NOT NULL,
    n_plus_one_query_id integer NOT NULL,
    sql_event_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: n_plus_one_query_sql_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE n_plus_one_query_sql_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: n_plus_one_query_sql_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE n_plus_one_query_sql_events_id_seq OWNED BY n_plus_one_query_sql_events.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sources; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sources (
    id integer NOT NULL,
    app_id integer NOT NULL,
    controller character varying(255) NOT NULL,
    action character varying(255) NOT NULL,
    method_name character varying(255) NOT NULL,
    format_type character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sources_id_seq OWNED BY sources.id;


--
-- Name: sql_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sql_events (
    id bigint NOT NULL,
    transaction_id integer,
    sql text,
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    duration double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying(255)
);


--
-- Name: sql_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sql_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sql_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sql_events_id_seq OWNED BY sql_events.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE transactions (
    id bigint NOT NULL,
    path character varying(255),
    status integer,
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    db_runtime double precision,
    view_runtime double precision,
    duration double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    source_id integer NOT NULL,
    shinji_version character varying(255),
    framework character varying(255)
);


--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transactions_id_seq OWNED BY transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_digest character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: view_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE view_events (
    id bigint NOT NULL,
    transaction_id integer,
    identifier character varying(255) NOT NULL,
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    duration double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: view_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE view_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: view_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE view_events_id_seq OWNED BY view_events.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY app_access_tokens ALTER COLUMN id SET DEFAULT nextval('app_access_tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY apps ALTER COLUMN id SET DEFAULT nextval('apps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailer_events ALTER COLUMN id SET DEFAULT nextval('mailer_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY n_plus_one_queries ALTER COLUMN id SET DEFAULT nextval('n_plus_one_queries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY n_plus_one_query_sql_events ALTER COLUMN id SET DEFAULT nextval('n_plus_one_query_sql_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sources ALTER COLUMN id SET DEFAULT nextval('sources_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sql_events ALTER COLUMN id SET DEFAULT nextval('sql_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transactions ALTER COLUMN id SET DEFAULT nextval('transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY view_events ALTER COLUMN id SET DEFAULT nextval('view_events_id_seq'::regclass);


--
-- Name: apps_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY apps
    ADD CONSTRAINT apps_pkey PRIMARY KEY (id);


--
-- Name: mailer_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mailer_events
    ADD CONSTRAINT mailer_events_pkey PRIMARY KEY (id);


--
-- Name: n_plus_one_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY n_plus_one_queries
    ADD CONSTRAINT n_plus_one_queries_pkey PRIMARY KEY (id);


--
-- Name: n_plus_one_query_sql_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY n_plus_one_query_sql_events
    ADD CONSTRAINT n_plus_one_query_sql_events_pkey PRIMARY KEY (id);


--
-- Name: sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: sql_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sql_events
    ADD CONSTRAINT sql_events_pkey PRIMARY KEY (id);


--
-- Name: transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: user_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY app_access_tokens
    ADD CONSTRAINT user_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: view_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY view_events
    ADD CONSTRAINT view_events_pkey PRIMARY KEY (id);


--
-- Name: index_apps_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_apps_on_user_id ON apps USING btree (user_id);


--
-- Name: index_mailer_events_on_transaction_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mailer_events_on_transaction_id ON mailer_events USING btree (transaction_id);


--
-- Name: index_n_plus_one_queries_on_transaction_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_n_plus_one_queries_on_transaction_id ON n_plus_one_queries USING btree (transaction_id);


--
-- Name: index_n_plus_one_query_sql_events_on_n_plus_one_query_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_n_plus_one_query_sql_events_on_n_plus_one_query_id ON n_plus_one_query_sql_events USING btree (n_plus_one_query_id);


--
-- Name: index_sources_on_action; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sources_on_action ON sources USING btree (action);


--
-- Name: index_sources_on_app_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sources_on_app_id ON sources USING btree (app_id);


--
-- Name: index_sources_on_controller; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sources_on_controller ON sources USING btree (controller);


--
-- Name: index_sources_on_identifying_attributes; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_sources_on_identifying_attributes ON sources USING btree (app_id, controller, action, method_name, format_type);


--
-- Name: index_sources_on_method_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sources_on_method_name ON sources USING btree (method_name);


--
-- Name: index_sql_events_on_transaction_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sql_events_on_transaction_id ON sql_events USING btree (transaction_id);


--
-- Name: index_transactions_on_db_runtime; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_transactions_on_db_runtime ON transactions USING btree (db_runtime);


--
-- Name: index_transactions_on_duration; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_transactions_on_duration ON transactions USING btree (duration);


--
-- Name: index_transactions_on_source_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_transactions_on_source_id ON transactions USING btree (source_id);


--
-- Name: index_transactions_on_view_runtime; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_transactions_on_view_runtime ON transactions USING btree (view_runtime);


--
-- Name: index_view_events_on_transaction_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_view_events_on_transaction_id ON view_events USING btree (transaction_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130610061724');

INSERT INTO schema_migrations (version) VALUES ('20130610074217');

INSERT INTO schema_migrations (version) VALUES ('20130610091821');

INSERT INTO schema_migrations (version) VALUES ('20130611123234');

INSERT INTO schema_migrations (version) VALUES ('20130611140611');

INSERT INTO schema_migrations (version) VALUES ('20130611152546');

INSERT INTO schema_migrations (version) VALUES ('20130612142340');

INSERT INTO schema_migrations (version) VALUES ('20130613132118');

INSERT INTO schema_migrations (version) VALUES ('20130613152756');

INSERT INTO schema_migrations (version) VALUES ('20130615004449');

INSERT INTO schema_migrations (version) VALUES ('20130615020327');

INSERT INTO schema_migrations (version) VALUES ('20130616085600');

INSERT INTO schema_migrations (version) VALUES ('20130618082227');

INSERT INTO schema_migrations (version) VALUES ('20130618084139');

INSERT INTO schema_migrations (version) VALUES ('20130618115306');

INSERT INTO schema_migrations (version) VALUES ('20130618115452');

INSERT INTO schema_migrations (version) VALUES ('20130621124854');

INSERT INTO schema_migrations (version) VALUES ('20130623094219');

INSERT INTO schema_migrations (version) VALUES ('20130728030622');

INSERT INTO schema_migrations (version) VALUES ('20130728131519');

INSERT INTO schema_migrations (version) VALUES ('20130728141323');

INSERT INTO schema_migrations (version) VALUES ('20130803042630');
