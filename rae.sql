--
-- PostgreSQL database dump
--

\restrict loT9gq5kDPamqQisI4K7dfyVqouvpwK0HQNuILeUq0XqxYfdIcWhEFCEPh29eW8

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-07-30 21:19:04

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16451)
-- Name: artefactos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artefactos (
    id_artefacto integer NOT NULL,
    tipo character varying(45) NOT NULL,
    peso numeric(10,2) NOT NULL,
    categoria character varying(45) NOT NULL,
    estado character varying(250) NOT NULL,
    id_empresa integer NOT NULL
);


ALTER TABLE public.artefactos OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16450)
-- Name: artefactos_id_artefacto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.artefactos_id_artefacto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.artefactos_id_artefacto_seq OWNER TO postgres;

--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 223
-- Name: artefactos_id_artefacto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.artefactos_id_artefacto_seq OWNED BY public.artefactos.id_artefacto;


--
-- TOC entry 229 (class 1259 OID 16476)
-- Name: certificados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certificados (
    id_certificados integer NOT NULL,
    id_empresa integer NOT NULL,
    id_recepcion integer NOT NULL,
    cod_certificado integer NOT NULL,
    fecha_emision timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.certificados OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16475)
-- Name: certificados_cod_certificado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.certificados ALTER COLUMN cod_certificado ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.certificados_cod_certificado_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 16474)
-- Name: certificados_id_certificados_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.certificados_id_certificados_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.certificados_id_certificados_seq OWNER TO postgres;

--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 227
-- Name: certificados_id_certificados_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.certificados_id_certificados_seq OWNED BY public.certificados.id_certificados;


--
-- TOC entry 220 (class 1259 OID 16421)
-- Name: empresa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empresa (
    id_empresa integer NOT NULL,
    nombre character varying(100) NOT NULL,
    nit character varying(20) NOT NULL,
    correo character varying(45) NOT NULL,
    telefono character varying(45),
    ciudad character varying(45),
    estado character varying(45) NOT NULL,
    contrasena character varying(255),
    CONSTRAINT empresa_estado_check CHECK (((estado)::text = ANY ((ARRAY['Activa'::character varying, 'Pendiente'::character varying])::text[])))
);


ALTER TABLE public.empresa OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16420)
-- Name: empresa_id_empresa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empresa_id_empresa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empresa_id_empresa_seq OWNER TO postgres;

--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 219
-- Name: empresa_id_empresa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empresa_id_empresa_seq OWNED BY public.empresa.id_empresa;


--
-- TOC entry 226 (class 1259 OID 16464)
-- Name: recepciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recepciones (
    id_recepcion integer NOT NULL,
    id_artefacto integer NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_usuario integer NOT NULL,
    estado character varying(45)
);


ALTER TABLE public.recepciones OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16463)
-- Name: recepciones_id_recepcion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recepciones_id_recepcion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recepciones_id_recepcion_seq OWNER TO postgres;

--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 225
-- Name: recepciones_id_recepcion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recepciones_id_recepcion_seq OWNED BY public.recepciones.id_recepcion;


--
-- TOC entry 222 (class 1259 OID 16438)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    contrasena character varying(100) CONSTRAINT "usuarios_contraseña_not_null" NOT NULL,
    id_empresa integer,
    estado character varying(45) DEFAULT 'Activo'::character varying,
    rol character varying(20) DEFAULT 'USUARIO'::character varying
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16437)
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_usuario_seq OWNED BY public.usuarios.id_usuario;


--
-- TOC entry 4881 (class 2604 OID 16454)
-- Name: artefactos id_artefacto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artefactos ALTER COLUMN id_artefacto SET DEFAULT nextval('public.artefactos_id_artefacto_seq'::regclass);


--
-- TOC entry 4884 (class 2604 OID 16479)
-- Name: certificados id_certificados; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificados ALTER COLUMN id_certificados SET DEFAULT nextval('public.certificados_id_certificados_seq'::regclass);


--
-- TOC entry 4877 (class 2604 OID 16424)
-- Name: empresa id_empresa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa ALTER COLUMN id_empresa SET DEFAULT nextval('public.empresa_id_empresa_seq'::regclass);


--
-- TOC entry 4882 (class 2604 OID 16467)
-- Name: recepciones id_recepcion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recepciones ALTER COLUMN id_recepcion SET DEFAULT nextval('public.recepciones_id_recepcion_seq'::regclass);


--
-- TOC entry 4878 (class 2604 OID 16441)
-- Name: usuarios id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuarios_id_usuario_seq'::regclass);


--
-- TOC entry 5057 (class 0 OID 16451)
-- Dependencies: 224
-- Data for Name: artefactos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.artefactos (id_artefacto, tipo, peso, categoria, estado, id_empresa) FROM stdin;
2	Transformador	1500.70	Industrial	Eliminado	1
3	Extintor	10.90	Seguridad	Eliminado	1
4	Laptop	2.50	Electrónico	Recibido	1
5	televisor	40.00	Reutilizable	pendiente	29
6	celular	1.00	Reutilizable	Eliminado	33
7	tv	0.00	celular	bueno	1
8	celular	0.00	redmi	dañado	1
9	lapton	0.00	lapton	bueno	1
10	all in one	0.00	pc	bueno	1
11	Laptop	2.50	Electrónico	activo	1
1	Laptop	2.80	Electrónico	Eliminado	1
12	pc	0.00	pc	bien	1
\.


--
-- TOC entry 5062 (class 0 OID 16476)
-- Dependencies: 229
-- Data for Name: certificados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.certificados (id_certificados, id_empresa, id_recepcion, cod_certificado, fecha_emision) FROM stdin;
4	22	2	1003	2026-03-07 00:00:42.639
\.


--
-- TOC entry 5053 (class 0 OID 16421)
-- Dependencies: 220
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.empresa (id_empresa, nombre, nit, correo, telefono, ciudad, estado, contrasena) FROM stdin;
11	Empresa Industrial S.A.	900123456-8	contacto@empresa.com	3001234567	Bogotá	Activa	\N
12	ensistemas.	900123456-10	ens@empresa.com	3001234568	Bogotá	Activa	\N
15	Empresa Demo	900123456	valbuena@empresa.com	3001234567	Bogotá	Activa	\N
17	caracol	900123458	cara@empresa.com	3001234567	Bogotá	Activa	\N
22	rcn	90012340	empresa@test.com	3101234567	Bogotá	Activa	$2b$10$e3hKxDU/wJmIQB4TTWMTSewmKuKBi5NUAs6pNSoStD5d3b.Nlk9.q
25	canal-1	90012307	empresa@canal.com	3101234569	Bogotá	Activa	$2b$10$xVhtReIbGQjFsnTraj7iXeluyBBcrEB0J7CBPhJhm7Z.yXgjExrFi
26	Ensistemas	1234567	urielrozo2015@gmail.com	3127481897	Bogota, D.C.	Pendiente	$2b$10$N04x6UwX3S/PSX8qpN1KYOs/NQFd6MNCJdP86P7SJk6RLCMTcOEzq
27	señal	90012300	señal@canal.com	3101234569	Bogotá	Activa	$2b$10$XfbgaH8F46LZ3.DONtktAexmHXk.mJ2IjLk2RCk5pXABfYUHc6Tty
29	Ensistemas1	12345677	urielrozo2016@gmail.com	3127481897	Bogota, D.C.	Pendiente	$2b$10$jC4AXIEfCsO9VFIUzk9y6.LBF95YIqk7xWQywWcDeFsYKxgk25wHu
30	centroAndino	1053325233	valbuenaelisabeth@gmail.com	3101234567	Bogotá	Activa	$2b$10$aD6Cl7SECW6dBmm0FGvhDuBbdhywIt0X2mPjdTKYbpwcFnATfBS8e
31	CentroAndino	1053325235	info@servicioandino.com	3101234567	Bogotá	Activa	$2b$10$jKMFeEwm2QbVh9kq9BJnq.jyqzQHenhTvghiOg0wUiWREnyaS4bmK
32	Andino1	1053325238	info1@servicioandino.com	3101234567	Bogotá	Activa	$2b$10$YLKeI4UimMJfbjDTqrNO4OPV.9zlQizm9sTA1rBLy6/RySE1YMjyS
33	uniminuto	66666666666	uniminuto@prueba.com	322453653	bogota	Pendiente	$2b$10$ODdDevDuKDl08hhs..wTIu7TesNellrYEtMDUscGtZuv4QWtME1aq
\.


--
-- TOC entry 5059 (class 0 OID 16464)
-- Dependencies: 226
-- Data for Name: recepciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recepciones (id_recepcion, id_artefacto, fecha, id_usuario, estado) FROM stdin;
1	1	2026-03-03 10:30:00	1	Eliminado
2	3	2026-03-04 21:48:32.899	3	recibido
3	4	2026-03-07 10:30:00	11	recibido
5	1	2026-05-01 10:32:39.564	1	recibido
6	1	2026-05-01 15:39:33.287	25	recibido
7	1	2026-05-01 15:45:59.69	1	recibido
\.


--
-- TOC entry 5055 (class 0 OID 16438)
-- Dependencies: 222
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id_usuario, nombre, correo, contrasena, id_empresa, estado, rol) FROM stdin;
5	daniel	garcia@gmail	prueba	1	Activo	USUARIO
7	camilo	cami@gmail	123	4	Activo	USUARIO
4	Valbuena	valeb@gmail	123	4	Deshabilitado	USUARIO
8	Charris	charris@gmail	123	6	Activo	USUARIO
3	elisabeth1	mire@gmail	123	6	Deshabilitado	USUARIO
9	elisabeth6	Elisabe@gmail	123	6	Deshabilitado	USUARIO
10	Maria Lopez	maria@email.com	$2b$10$uJuNi/kO4ATk8fzQ99n3euehw4oV3YNEi8ALIEJEC0TvcpgyeOCw2	1	Deshabilitado	USUARIO
11	Juan Pérez	juan.perez@ejemplo.com	$2b$10$Thdl.kf4vA6nzQMzv3QPauDQJy9UW1FKJgF7n66rEXMHStHrSPjK6	22	Activo	USUARIO
12	Juan Pérez	juan.casas@ejemplo.com	$2b$10$J4uCL9btXd2Bj9a0ArQNnuWIP/CjRt09fCi9d.dSNWHJXWDWFEeDG	25	Activo	USUARIO
13	elisabeth1	cahrris@ejemplo.com	$2b$10$BiHgJBFnZfYQPo2f6SMwRutYM55rQTUobkLbIUdulsDCkSk1AfWde	27	Activo	USUARIO
14	Ensistemas	urielrozo2015@gmail.com	$2b$10$CQ1FN..WF1umU4QGYv.7zO8S1GFIaV.Lh2Z/rmptDSNRFtCu7SyKK	29	Activo	USUARIO
15	Elisabethmireya	info@servicioandino.com	$2b$10$Jq91kBkLKP.Y4l6kN0Z1vOzi7zDvMpivp6lMXw/SXR.slma6dIdiG	31	Activo	USUARIO
16	Juan	juan@ejemplo.com	$2b$10$fRxkR6rGw6aP0vrWSrQKF.sfYFu1/YYkg1oDEqc97LUOkQts/9yvO	32	Activo	USUARIO
17	Carlos Parada	uniminuto@prueba.com	$2b$10$7fE51FLN6hzixAazr6UlROQTEIn2T3BXsc33qaHcuWfS4L3VS4A5e	33	Activo	USUARIO
18	Elisabeth  valbuena	valbuenaelisabethgmail.com	$2b$10$uC1unh9C8Yc9J2RgHgsKquwHmrR3kYaShZ9ER9hmbPAPpDFeIj/Di	\N	Activo	USUARIO
19	elisabeth valbuena	valbuena@gmail.com	$2b$10$SRn1fuWKobxWzcIacy/75eum6PmjxOW3bpoBdnYMOWokwMAb9Pjnq	\N	Activo	USUARIO
20	mireya valbuena	valbuenaelisabeth@gmail.com	$2b$10$3nb7RjlCtzBbc7N0.w2pZ.iIm2B.8gmVAJytFs9GueHnmEKoz1aQO	\N	Activo	USUARIO
21	carlos parada	carlos	$2b$10$2vHjTMp5LjtrrD9JNxkn1eqNIDBR9ZKgr/asd62JVZsjA7DFZdR7e	\N	Activo	USUARIO
22	Admin Principal	admin@gmail.com	$2b$10$MiQrn0dDLuTOmRJEvrosmOC6Qj/vstXiEsMj4HLe/0NBnHZ5EAmnK	1	activo	admin
24	Admin Principal	administrador@gmail.com	$2b$10$4Ex3KUpF7yklXS56mpO7jOyO0VBv5wXC85lk5c.l8G8wadxyeLfnW	1	activo	admin
25	vendedor	vendedor@gmail.com	$2b$10$ZDGJxKngJIBXOU.lgqyZ0uIgpMqgA2pKxxZR8ZzhW8gRayGvMCBRK	3	activo	VENDEDOR
\.


--
-- TOC entry 5073 (class 0 OID 0)
-- Dependencies: 223
-- Name: artefactos_id_artefacto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.artefactos_id_artefacto_seq', 12, true);


--
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 228
-- Name: certificados_cod_certificado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.certificados_cod_certificado_seq', 1003, true);


--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 227
-- Name: certificados_id_certificados_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.certificados_id_certificados_seq', 4, true);


--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 219
-- Name: empresa_id_empresa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empresa_id_empresa_seq', 33, true);


--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 225
-- Name: recepciones_id_recepcion_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recepciones_id_recepcion_seq', 7, true);


--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuarios_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_usuario_seq', 25, true);


--
-- TOC entry 4898 (class 2606 OID 16462)
-- Name: artefactos artefactos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artefactos
    ADD CONSTRAINT artefactos_pkey PRIMARY KEY (id_artefacto);


--
-- TOC entry 4902 (class 2606 OID 16488)
-- Name: certificados certificados_cod_certificado_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificados
    ADD CONSTRAINT certificados_cod_certificado_key UNIQUE (cod_certificado);


--
-- TOC entry 4904 (class 2606 OID 16486)
-- Name: certificados certificados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificados
    ADD CONSTRAINT certificados_pkey PRIMARY KEY (id_certificados);


--
-- TOC entry 4888 (class 2606 OID 16436)
-- Name: empresa empresa_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_correo_key UNIQUE (correo);


--
-- TOC entry 4890 (class 2606 OID 16434)
-- Name: empresa empresa_nit_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_nit_key UNIQUE (nit);


--
-- TOC entry 4892 (class 2606 OID 16432)
-- Name: empresa empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (id_empresa);


--
-- TOC entry 4900 (class 2606 OID 16473)
-- Name: recepciones recepciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recepciones
    ADD CONSTRAINT recepciones_pkey PRIMARY KEY (id_recepcion);


--
-- TOC entry 4894 (class 2606 OID 16449)
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- TOC entry 4896 (class 2606 OID 16447)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


-- Completed on 2026-07-30 21:19:05

--
-- PostgreSQL database dump complete
--

\unrestrict loT9gq5kDPamqQisI4K7dfyVqouvpwK0HQNuILeUq0XqxYfdIcWhEFCEPh29eW8

