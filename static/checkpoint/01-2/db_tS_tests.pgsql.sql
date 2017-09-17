--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: movie; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE movie (
    mid integer NOT NULL,
    title text,
    year integer,
    director text
);


ALTER TABLE public.movie OWNER TO postgres;

--
-- Name: rating; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rating (
    rid integer NOT NULL,
    mid integer NOT NULL,
    stars integer,
    ratingdate date
);


ALTER TABLE public.rating OWNER TO postgres;

--
-- Name: reviewer; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE reviewer (
    rid integer NOT NULL,
    name text
);


ALTER TABLE public.reviewer OWNER TO postgres;

--
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY movie (mid, title, year, director) FROM stdin;
101	Gone with the Wind	1939	Victor Fleming
102	Star Wars	1977	George Lucas
103	The Sound of Music	1965	Robert Wise
104	E.T.	1982	Steven Spielberg
105	Titanic	1997	James Cameron
106	Snow White	1937	\N
107	Avatar	2009	James Cameron
108	Raiders of the Lost Ark	1981	Steven Spielberg
\.


--
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rating (rid, mid, stars, ratingdate) FROM stdin;
201	101	2	2011-01-22
201	101	4	2011-01-27
202	106	4	\N
203	103	2	2011-01-20
203	108	4	2011-01-12
203	108	2	2011-01-30
204	101	3	2011-01-09
205	103	3	2011-01-27
205	104	2	2011-01-22
205	108	4	\N
206	107	3	2011-01-15
206	106	5	2011-01-19
207	107	5	2011-01-20
208	104	3	2011-01-02
\.


--
-- Data for Name: reviewer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY reviewer (rid, name) FROM stdin;
201	Sarah Martinez
202	Daniel Lewis
203	Brittany Harris
204	Mike Anderson
205	Chris Jackson
206	Elizabeth Thomas
207	James Cameron
208	Ashley White
\.


--
-- Name: movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (mid);


--
-- Name: reviewer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY reviewer
    ADD CONSTRAINT reviewer_pkey PRIMARY KEY (rid);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: movie; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE movie FROM PUBLIC;
REVOKE ALL ON TABLE movie FROM postgres;
GRANT ALL ON TABLE movie TO postgres;
GRANT SELECT ON TABLE movie TO "db_tS_student";


--
-- Name: rating; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE rating FROM PUBLIC;
REVOKE ALL ON TABLE rating FROM postgres;
GRANT ALL ON TABLE rating TO postgres;
GRANT SELECT ON TABLE rating TO "db_tS_student";


--
-- Name: reviewer; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE reviewer FROM PUBLIC;
REVOKE ALL ON TABLE reviewer FROM postgres;
GRANT ALL ON TABLE reviewer TO postgres;
GRANT SELECT ON TABLE reviewer TO "db_tS_student";


--
-- PostgreSQL database dump complete
--

