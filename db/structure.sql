--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    avatar text,
    reader boolean DEFAULT false NOT NULL,
    encrypted_password text NOT NULL,
    reset_password_token text,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    confirmation_token text,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: carts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE carts (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    tax_cents integer DEFAULT 0 NOT NULL,
    tax_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    discount_cents integer DEFAULT 0 NOT NULL,
    discount_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    total_cents integer DEFAULT 0 NOT NULL,
    total_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    charged_at timestamp without time zone,
    account_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE items (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    subtotal_cents integer DEFAULT 0 NOT NULL,
    subtotal_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    discount_cents integer DEFAULT 0 NOT NULL,
    discount_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    total_cents integer DEFAULT 0 NOT NULL,
    total_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    cart_id uuid NOT NULL,
    subject_id uuid NOT NULL,
    subject_type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: que_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE que_jobs (
    priority smallint DEFAULT 100 NOT NULL,
    run_at timestamp with time zone DEFAULT now() NOT NULL,
    job_id bigint NOT NULL,
    job_class text NOT NULL,
    args json DEFAULT '[]'::json NOT NULL,
    error_count integer DEFAULT 0 NOT NULL,
    last_error text,
    queue text DEFAULT ''::text NOT NULL
);


--
-- Name: TABLE que_jobs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE que_jobs IS '3';


--
-- Name: que_jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE que_jobs_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: que_jobs_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE que_jobs_job_id_seq OWNED BY que_jobs.job_id;


--
-- Name: readings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE readings (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    price_cents integer DEFAULT 0 NOT NULL,
    price_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    photo text,
    account_id uuid NOT NULL,
    store_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: stores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE stores (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    photo text,
    account_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE taggings (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    subject_id uuid NOT NULL,
    subject_type character varying NOT NULL,
    tag_id uuid NOT NULL
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tags (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: job_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY que_jobs ALTER COLUMN job_id SET DEFAULT nextval('que_jobs_job_id_seq'::regclass);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: carts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: que_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY que_jobs
    ADD CONSTRAINT que_jobs_pkey PRIMARY KEY (queue, priority, run_at, job_id);


--
-- Name: readings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY readings
    ADD CONSTRAINT readings_pkey PRIMARY KEY (id);


--
-- Name: stores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: index_accounts_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_confirmation_token ON accounts USING btree (confirmation_token);


--
-- Name: index_accounts_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_created_at ON accounts USING btree (created_at);


--
-- Name: index_accounts_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_accounts_on_email ON accounts USING btree (email);


--
-- Name: index_accounts_on_reader; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_reader ON accounts USING btree (reader);


--
-- Name: index_accounts_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_reset_password_token ON accounts USING btree (reset_password_token);


--
-- Name: index_accounts_on_unconfirmed_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_unconfirmed_email ON accounts USING btree (unconfirmed_email);


--
-- Name: index_accounts_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_updated_at ON accounts USING btree (updated_at);


--
-- Name: index_carts_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_on_account_id ON carts USING btree (account_id);


--
-- Name: index_carts_on_charged_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_on_charged_at ON carts USING btree (charged_at);


--
-- Name: index_carts_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_on_created_at ON carts USING btree (created_at);


--
-- Name: index_carts_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_on_updated_at ON carts USING btree (updated_at);


--
-- Name: index_items_on_cart_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_cart_id ON items USING btree (cart_id);


--
-- Name: index_items_on_cart_id_and_subject_id_and_subject_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_cart_id_and_subject_id_and_subject_type ON items USING btree (cart_id, subject_id, subject_type);


--
-- Name: index_items_on_subject_id_and_subject_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_items_on_subject_id_and_subject_type ON items USING btree (subject_id, subject_type);


--
-- Name: index_readings_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_readings_on_account_id ON readings USING btree (account_id);


--
-- Name: index_readings_on_account_id_and_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_readings_on_account_id_and_store_id ON readings USING btree (account_id, store_id);


--
-- Name: index_readings_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_readings_on_created_at ON readings USING btree (created_at);


--
-- Name: index_readings_on_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_readings_on_store_id ON readings USING btree (store_id);


--
-- Name: index_readings_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_readings_on_updated_at ON readings USING btree (updated_at);


--
-- Name: index_stores_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stores_on_account_id ON stores USING btree (account_id);


--
-- Name: index_stores_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stores_on_created_at ON stores USING btree (created_at);


--
-- Name: index_stores_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_stores_on_name ON stores USING btree (name);


--
-- Name: index_stores_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stores_on_updated_at ON stores USING btree (updated_at);


--
-- Name: index_taggings_on_subject_id_and_subject_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_subject_id_and_subject_type ON taggings USING btree (subject_id, subject_type);


--
-- Name: index_taggings_on_subject_id_and_subject_type_and_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_taggings_on_subject_id_and_subject_type_and_tag_id ON taggings USING btree (subject_id, subject_type, tag_id);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_tag_id ON taggings USING btree (tag_id);


--
-- Name: index_tags_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tags_on_created_at ON tags USING btree (created_at);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tags_on_name ON tags USING btree (name);


--
-- Name: index_tags_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tags_on_updated_at ON tags USING btree (updated_at);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_0e339eeac9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY items
    ADD CONSTRAINT fk_rails_0e339eeac9 FOREIGN KEY (cart_id) REFERENCES carts(id);


--
-- Name: fk_rails_9fcd2e236b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT fk_rails_9fcd2e236b FOREIGN KEY (tag_id) REFERENCES tags(id);


--
-- Name: fk_rails_c06d3314bb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stores
    ADD CONSTRAINT fk_rails_c06d3314bb FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: fk_rails_c5c96624d2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY readings
    ADD CONSTRAINT fk_rails_c5c96624d2 FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: fk_rails_f37446ef7b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT fk_rails_f37446ef7b FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: fk_rails_ffe6792856; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY readings
    ADD CONSTRAINT fk_rails_ffe6792856 FOREIGN KEY (store_id) REFERENCES stores(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20160518004513');

INSERT INTO schema_migrations (version) VALUES ('20160518004514');

INSERT INTO schema_migrations (version) VALUES ('20160518010242');

INSERT INTO schema_migrations (version) VALUES ('20160626234226');

INSERT INTO schema_migrations (version) VALUES ('20160627000518');

INSERT INTO schema_migrations (version) VALUES ('20160627001953');

INSERT INTO schema_migrations (version) VALUES ('20160627002338');

INSERT INTO schema_migrations (version) VALUES ('20160627002403');

INSERT INTO schema_migrations (version) VALUES ('20160627004529');

INSERT INTO schema_migrations (version) VALUES ('20160627005543');

