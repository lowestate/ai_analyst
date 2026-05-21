--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2026-05-21 19:17:23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 27052)
-- Name: chat_checkpoints; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chat_checkpoints (
    chat_id character varying(255) NOT NULL,
    checkpoint_id character varying(255) NOT NULL,
    checkpoint_ns character varying(255) DEFAULT ''::character varying,
    data bytea NOT NULL,
    metadata jsonb,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.chat_checkpoints OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 26826)
-- Name: chats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chats (
    chat_id text NOT NULL,
    chat_desc text,
    filename text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    user_id integer,
    dataset_encoded bytea,
    deleted boolean DEFAULT false
);


ALTER TABLE public.chats OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 27219)
-- Name: llm_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.llm_requests (
    request_id character varying(100) NOT NULL,
    user_id integer,
    chat_id character varying,
    initiator character varying(50),
    model_name character varying(50),
    input_text text,
    input_tokens integer,
    output_tokens integer,
    duration_ms integer,
    request_status integer,
    error_message text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    used_tool character varying(255)
);


ALTER TABLE public.llm_requests OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 27022)
-- Name: plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.plans (
    plan_id integer NOT NULL,
    plan_name character varying(100) NOT NULL
);


ALTER TABLE public.plans OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 27021)
-- Name: plans_plan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.plans_plan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.plans_plan_id_seq OWNER TO postgres;

--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 216
-- Name: plans_plan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.plans_plan_id_seq OWNED BY public.plans.plan_id;


--
-- TOC entry 219 (class 1259 OID 27029)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    plan_id integer DEFAULT 1 NOT NULL,
    is_active boolean DEFAULT true,
    role character varying(50) DEFAULT 'user'::character varying,
    is_banned boolean DEFAULT false NOT NULL,
    strikes smallint DEFAULT 0
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 27028)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4707 (class 2604 OID 27025)
-- Name: plans plan_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plans ALTER COLUMN plan_id SET DEFAULT nextval('public.plans_plan_id_seq'::regclass);


--
-- TOC entry 4708 (class 2604 OID 27032)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4726 (class 2606 OID 27060)
-- Name: chat_checkpoints chat_checkpoints_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_checkpoints
    ADD CONSTRAINT chat_checkpoints_pkey PRIMARY KEY (chat_id);


--
-- TOC entry 4718 (class 2606 OID 26833)
-- Name: chats chat_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chat_sessions_pkey PRIMARY KEY (chat_id);


--
-- TOC entry 4728 (class 2606 OID 27226)
-- Name: llm_requests llm_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.llm_requests
    ADD CONSTRAINT llm_requests_pkey PRIMARY KEY (request_id);


--
-- TOC entry 4720 (class 2606 OID 27027)
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (plan_id);


--
-- TOC entry 4722 (class 2606 OID 27038)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4724 (class 2606 OID 27040)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4731 (class 2606 OID 27061)
-- Name: chat_checkpoints chat_checkpoints_chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chat_checkpoints
    ADD CONSTRAINT chat_checkpoints_chat_id_fkey FOREIGN KEY (chat_id) REFERENCES public.chats(chat_id) ON DELETE CASCADE;


--
-- TOC entry 4729 (class 2606 OID 27047)
-- Name: chats chats_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4732 (class 2606 OID 27232)
-- Name: llm_requests llm_requests_chat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.llm_requests
    ADD CONSTRAINT llm_requests_chat_id_fkey FOREIGN KEY (chat_id) REFERENCES public.chats(chat_id) ON DELETE CASCADE;


--
-- TOC entry 4733 (class 2606 OID 27227)
-- Name: llm_requests llm_requests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.llm_requests
    ADD CONSTRAINT llm_requests_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- TOC entry 4730 (class 2606 OID 27041)
-- Name: users users_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(plan_id) ON DELETE SET NULL;


--
-- TOC entry 4879 (class 0 OID 27022)
-- Dependencies: 217
-- Data for Name: plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.plans (plan_id, plan_name) FROM stdin;
1	free
2	pro
3	ultra
\.


-- Completed on 2026-05-21 19:17:24

--
-- PostgreSQL database dump complete
--

