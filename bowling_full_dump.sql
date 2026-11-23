--
-- PostgreSQL database dump
--

\restrict zdtsN6VtHc9LssOTAf1nhldtqjZ0Tftu9xZ3TvkrZcKQ2YJAWTT7hu6MjIxX8iP

-- Dumped from database version 17.11 (Ubuntu 17.11-1.pgdg24.04+2)
-- Dumped by pg_dump version 17.11 (Ubuntu 17.11-1.pgdg24.04+2)

-- Started on 2026-11-23 04:15:24 +03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 17002)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 17004)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id integer NOT NULL,
    fname character varying(100) NOT NULL,
    lname character varying(100) NOT NULL,
    phone_number character varying(20) NOT NULL,
    bonus_balance numeric(10,2) DEFAULT 0.00,
    CONSTRAINT client_bonus_balance_check CHECK ((bonus_balance >= (0)::numeric))
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17003)
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_id_seq OWNER TO postgres;

--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 217
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;


--
-- TOC entry 221 (class 1259 OID 17027)
-- Name: discount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount (
    id integer NOT NULL,
    type_discount character varying(50) NOT NULL,
    magnitude numeric(5,2) NOT NULL,
    condition_for_obtaining text NOT NULL,
    CONSTRAINT discount_magnitude_check CHECK (((magnitude >= (0)::numeric) AND (magnitude <= (100)::numeric))),
    CONSTRAINT discount_type_discount_check CHECK (((type_discount)::text = ANY ((ARRAY['льготная'::character varying, 'по дню недели'::character varying, 'накопительная бонусная'::character varying])::text[])))
);


ALTER TABLE public.discount OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17026)
-- Name: discount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.discount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.discount_id_seq OWNER TO postgres;

--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 220
-- Name: discount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.discount_id_seq OWNED BY public.discount.id;


--
-- TOC entry 225 (class 1259 OID 17045)
-- Name: footwear; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.footwear (
    id integer NOT NULL,
    shoe_size numeric(3,1) NOT NULL,
    total_quantity integer NOT NULL,
    available_quantity integer NOT NULL,
    CONSTRAINT footwear_check CHECK (((available_quantity >= 0) AND (available_quantity <= total_quantity))),
    CONSTRAINT footwear_shoe_size_check CHECK (((shoe_size >= 25.0) AND (shoe_size <= 50.0))),
    CONSTRAINT footwear_total_quantity_check CHECK ((total_quantity >= 0))
);


ALTER TABLE public.footwear OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17044)
-- Name: footwear_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.footwear_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.footwear_id_seq OWNER TO postgres;

--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 224
-- Name: footwear_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.footwear_id_seq OWNED BY public.footwear.id;


--
-- TOC entry 229 (class 1259 OID 17080)
-- Name: game; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game (
    id integer NOT NULL,
    team_name character varying(150) NOT NULL,
    client_id integer NOT NULL,
    reservation_id integer,
    discount_id integer,
    track_number integer NOT NULL,
    type_footwear character varying(50) NOT NULL,
    text text,
    total_order numeric(10,2) DEFAULT 0.00 NOT NULL,
    CONSTRAINT game_total_order_check CHECK ((total_order >= (0)::numeric)),
    CONSTRAINT game_type_footwear_check CHECK (((type_footwear)::text = ANY ((ARRAY['своя обувь'::character varying, 'аренда'::character varying])::text[])))
);


ALTER TABLE public.game OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17113)
-- Name: game_footwear; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_footwear (
    game_id integer NOT NULL,
    footwear_id integer NOT NULL,
    quantity_rented integer DEFAULT 1 NOT NULL,
    CONSTRAINT game_footwear_quantity_rented_check CHECK ((quantity_rented > 0))
);


ALTER TABLE public.game_footwear OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17079)
-- Name: game_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.game_id_seq OWNER TO postgres;

--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 228
-- Name: game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_id_seq OWNED BY public.game.id;


--
-- TOC entry 231 (class 1259 OID 17130)
-- Name: oversees_g; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oversees_g (
    worker_id integer NOT NULL,
    game_id integer NOT NULL
);


ALTER TABLE public.oversees_g OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17145)
-- Name: oversees_r; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oversees_r (
    worker_id integer NOT NULL,
    reservation_id integer NOT NULL
);


ALTER TABLE public.oversees_r OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17057)
-- Name: reservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation (
    id integer NOT NULL,
    client_id integer NOT NULL,
    track_number integer NOT NULL,
    registration_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    booking_status character varying(50) DEFAULT 'ожидает предоплаты'::character varying NOT NULL,
    booking_duration integer NOT NULL,
    time_type timestamp without time zone NOT NULL,
    prepayment numeric(10,2) DEFAULT 0.00 NOT NULL,
    CONSTRAINT reservation_booking_duration_check CHECK ((booking_duration = ANY (ARRAY[1, 2]))),
    CONSTRAINT reservation_booking_status_check CHECK (((booking_status)::text = ANY ((ARRAY['ожидает предоплаты'::character varying, 'внесена предоплата'::character varying, 'оплачено полностью'::character varying, 'завершено'::character varying, 'аннулировано'::character varying])::text[]))),
    CONSTRAINT reservation_prepayment_check CHECK ((prepayment >= (0)::numeric))
);


ALTER TABLE public.reservation OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17056)
-- Name: reservation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reservation_id_seq OWNER TO postgres;

--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 226
-- Name: reservation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservation_id_seq OWNED BY public.reservation.id;


--
-- TOC entry 219 (class 1259 OID 17014)
-- Name: track; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.track (
    number_track integer NOT NULL,
    review text,
    operational_status character varying(50) DEFAULT 'рабочая'::character varying NOT NULL,
    capacity integer NOT NULL,
    crib_bumpers boolean DEFAULT false NOT NULL,
    CONSTRAINT track_capacity_check CHECK ((capacity > 0)),
    CONSTRAINT track_number_track_check CHECK ((number_track > 0)),
    CONSTRAINT track_operational_status_check CHECK (((operational_status)::text = ANY ((ARRAY['рабочая'::character varying, 'нерабочая'::character varying, 'на ремонте'::character varying])::text[])))
);


ALTER TABLE public.track OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17163)
-- Name: v_active_reservations; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_active_reservations AS
 SELECT r.id AS reservation_id,
    (((c.fname)::text || ' '::text) || (c.lname)::text) AS client_name,
    c.phone_number,
    r.track_number,
    r.time_type AS game_start,
    r.booking_duration,
    r.booking_status
   FROM (public.reservation r
     JOIN public.client c ON ((r.client_id = c.id)))
  WHERE ((r.booking_status)::text <> ALL ((ARRAY['аннулировано'::character varying, 'завершено'::character varying])::text[]));


ALTER VIEW public.v_active_reservations OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17038)
-- Name: workers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workers (
    id integer NOT NULL,
    job_title character varying(100) NOT NULL
);


ALTER TABLE public.workers OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17037)
-- Name: workers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.workers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workers_id_seq OWNER TO postgres;

--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 222
-- Name: workers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.workers_id_seq OWNED BY public.workers.id;


--
-- TOC entry 3339 (class 2604 OID 17007)
-- Name: client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- TOC entry 3343 (class 2604 OID 17030)
-- Name: discount id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount ALTER COLUMN id SET DEFAULT nextval('public.discount_id_seq'::regclass);


--
-- TOC entry 3345 (class 2604 OID 17048)
-- Name: footwear id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.footwear ALTER COLUMN id SET DEFAULT nextval('public.footwear_id_seq'::regclass);


--
-- TOC entry 3350 (class 2604 OID 17083)
-- Name: game id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game ALTER COLUMN id SET DEFAULT nextval('public.game_id_seq'::regclass);


--
-- TOC entry 3346 (class 2604 OID 17060)
-- Name: reservation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation ALTER COLUMN id SET DEFAULT nextval('public.reservation_id_seq'::regclass);


--
-- TOC entry 3344 (class 2604 OID 17041)
-- Name: workers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers ALTER COLUMN id SET DEFAULT nextval('public.workers_id_seq'::regclass);


--
-- TOC entry 3556 (class 0 OID 17004)
-- Dependencies: 218
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, fname, lname, phone_number, bonus_balance) FROM stdin;
\.


--
-- TOC entry 3559 (class 0 OID 17027)
-- Dependencies: 221
-- Data for Name: discount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount (id, type_discount, magnitude, condition_for_obtaining) FROM stdin;
\.


--
-- TOC entry 3563 (class 0 OID 17045)
-- Dependencies: 225
-- Data for Name: footwear; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.footwear (id, shoe_size, total_quantity, available_quantity) FROM stdin;
\.


--
-- TOC entry 3567 (class 0 OID 17080)
-- Dependencies: 229
-- Data for Name: game; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game (id, team_name, client_id, reservation_id, discount_id, track_number, type_footwear, text, total_order) FROM stdin;
\.


--
-- TOC entry 3568 (class 0 OID 17113)
-- Dependencies: 230
-- Data for Name: game_footwear; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_footwear (game_id, footwear_id, quantity_rented) FROM stdin;
\.


--
-- TOC entry 3569 (class 0 OID 17130)
-- Dependencies: 231
-- Data for Name: oversees_g; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oversees_g (worker_id, game_id) FROM stdin;
\.


--
-- TOC entry 3570 (class 0 OID 17145)
-- Dependencies: 232
-- Data for Name: oversees_r; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.oversees_r (worker_id, reservation_id) FROM stdin;
\.


--
-- TOC entry 3565 (class 0 OID 17057)
-- Dependencies: 227
-- Data for Name: reservation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservation (id, client_id, track_number, registration_date, booking_status, booking_duration, time_type, prepayment) FROM stdin;
\.


--
-- TOC entry 3557 (class 0 OID 17014)
-- Dependencies: 219
-- Data for Name: track; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.track (number_track, review, operational_status, capacity, crib_bumpers) FROM stdin;
\.


--
-- TOC entry 3561 (class 0 OID 17038)
-- Dependencies: 223
-- Data for Name: workers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workers (id, job_title) FROM stdin;
\.


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 217
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_seq', 1, false);


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 220
-- Name: discount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.discount_id_seq', 1, false);


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 224
-- Name: footwear_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.footwear_id_seq', 1, false);


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 228
-- Name: game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_id_seq', 1, false);


--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 226
-- Name: reservation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservation_id_seq', 1, false);


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 222
-- Name: workers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.workers_id_seq', 1, false);


--
-- TOC entry 3369 (class 2606 OID 17013)
-- Name: client client_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_phone_number_key UNIQUE (phone_number);


--
-- TOC entry 3371 (class 2606 OID 17011)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- TOC entry 3375 (class 2606 OID 17036)
-- Name: discount discount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount
    ADD CONSTRAINT discount_pkey PRIMARY KEY (id);


--
-- TOC entry 3379 (class 2606 OID 17053)
-- Name: footwear footwear_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.footwear
    ADD CONSTRAINT footwear_pkey PRIMARY KEY (id);


--
-- TOC entry 3381 (class 2606 OID 17055)
-- Name: footwear footwear_shoe_size_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.footwear
    ADD CONSTRAINT footwear_shoe_size_key UNIQUE (shoe_size);


--
-- TOC entry 3392 (class 2606 OID 17119)
-- Name: game_footwear game_footwear_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_footwear
    ADD CONSTRAINT game_footwear_pkey PRIMARY KEY (game_id, footwear_id);


--
-- TOC entry 3387 (class 2606 OID 17090)
-- Name: game game_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_pkey PRIMARY KEY (id);


--
-- TOC entry 3389 (class 2606 OID 17092)
-- Name: game game_reservation_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_reservation_id_key UNIQUE (reservation_id);


--
-- TOC entry 3394 (class 2606 OID 17134)
-- Name: oversees_g oversees_g_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oversees_g
    ADD CONSTRAINT oversees_g_pkey PRIMARY KEY (worker_id, game_id);


--
-- TOC entry 3396 (class 2606 OID 17149)
-- Name: oversees_r oversees_r_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oversees_r
    ADD CONSTRAINT oversees_r_pkey PRIMARY KEY (worker_id, reservation_id);


--
-- TOC entry 3385 (class 2606 OID 17068)
-- Name: reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (id);


--
-- TOC entry 3373 (class 2606 OID 17025)
-- Name: track track_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.track
    ADD CONSTRAINT track_pkey PRIMARY KEY (number_track);


--
-- TOC entry 3377 (class 2606 OID 17043)
-- Name: workers workers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_pkey PRIMARY KEY (id);


--
-- TOC entry 3390 (class 1259 OID 17162)
-- Name: idx_game_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_game_client ON public.game USING btree (client_id);


--
-- TOC entry 3382 (class 1259 OID 17160)
-- Name: idx_reservation_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservation_client ON public.reservation USING btree (client_id);


--
-- TOC entry 3383 (class 1259 OID 17161)
-- Name: idx_reservation_track_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservation_track_time ON public.reservation USING btree (track_number, time_type);


--
-- TOC entry 3399 (class 2606 OID 17093)
-- Name: game game_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id) ON DELETE CASCADE;


--
-- TOC entry 3400 (class 2606 OID 17103)
-- Name: game game_discount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_discount_id_fkey FOREIGN KEY (discount_id) REFERENCES public.discount(id) ON DELETE SET NULL;


--
-- TOC entry 3403 (class 2606 OID 17125)
-- Name: game_footwear game_footwear_footwear_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_footwear
    ADD CONSTRAINT game_footwear_footwear_id_fkey FOREIGN KEY (footwear_id) REFERENCES public.footwear(id) ON DELETE RESTRICT;


--
-- TOC entry 3404 (class 2606 OID 17120)
-- Name: game_footwear game_footwear_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_footwear
    ADD CONSTRAINT game_footwear_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE CASCADE;


--
-- TOC entry 3401 (class 2606 OID 17098)
-- Name: game game_reservation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_reservation_id_fkey FOREIGN KEY (reservation_id) REFERENCES public.reservation(id) ON DELETE SET NULL;


--
-- TOC entry 3402 (class 2606 OID 17108)
-- Name: game game_track_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_track_number_fkey FOREIGN KEY (track_number) REFERENCES public.track(number_track) ON DELETE RESTRICT;


--
-- TOC entry 3405 (class 2606 OID 17140)
-- Name: oversees_g oversees_g_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oversees_g
    ADD CONSTRAINT oversees_g_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE CASCADE;


--
-- TOC entry 3406 (class 2606 OID 17135)
-- Name: oversees_g oversees_g_worker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oversees_g
    ADD CONSTRAINT oversees_g_worker_id_fkey FOREIGN KEY (worker_id) REFERENCES public.workers(id) ON DELETE CASCADE;


--
-- TOC entry 3407 (class 2606 OID 17155)
-- Name: oversees_r oversees_r_reservation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oversees_r
    ADD CONSTRAINT oversees_r_reservation_id_fkey FOREIGN KEY (reservation_id) REFERENCES public.reservation(id) ON DELETE CASCADE;


--
-- TOC entry 3408 (class 2606 OID 17150)
-- Name: oversees_r oversees_r_worker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oversees_r
    ADD CONSTRAINT oversees_r_worker_id_fkey FOREIGN KEY (worker_id) REFERENCES public.workers(id) ON DELETE CASCADE;


--
-- TOC entry 3397 (class 2606 OID 17069)
-- Name: reservation reservation_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id) ON DELETE CASCADE;


--
-- TOC entry 3398 (class 2606 OID 17074)
-- Name: reservation reservation_track_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_track_number_fkey FOREIGN KEY (track_number) REFERENCES public.track(number_track) ON DELETE RESTRICT;


--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2026-11-23 04:15:24 +03

--
-- PostgreSQL database dump complete
--

\unrestrict zdtsN6VtHc9LssOTAf1nhldtqjZ0Tftu9xZ3TvkrZcKQ2YJAWTT7hu6MjIxX8iP

