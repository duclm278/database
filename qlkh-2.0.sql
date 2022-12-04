--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0
-- Dumped by pg_dump version 15.0

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
-- Name: DeTai; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."DeTai" (
    "DT#" text NOT NULL,
    "TenDT" text,
    "Cap" text,
    "KinhPhi" integer
);


ALTER TABLE public."DeTai" OWNER TO postgres;

--
-- Name: GiangVien; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GiangVien" (
    "GV#" text NOT NULL,
    "HoTen" text,
    "DiaChi" text,
    "NgaySinh" text
);


ALTER TABLE public."GiangVien" OWNER TO postgres;

--
-- Name: ThamGia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ThamGia" (
    "GV#" text NOT NULL,
    "DT#" text NOT NULL,
    "SoGio" integer
);


ALTER TABLE public."ThamGia" OWNER TO postgres;

--
-- Data for Name: DeTai; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."DeTai" ("DT#", "TenDT", "Cap", "KinhPhi") FROM stdin;
DT01	Tính toán lưới	Nhà nước	700
DT02	Phát hiện tri thức	Bộ	300
DT03	Phân loại văn bản	Bộ	270
DT04	Dịch tự động Anh Việt	Trường	30
\.


--
-- Data for Name: GiangVien; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."GiangVien" ("GV#", "HoTen", "DiaChi", "NgaySinh") FROM stdin;
GV01	Vũ Tuyết Trinh	Hoàng Mai, Hà Nội	10/10/1975
GV02	Nguyễn Nhật Quang	Hai Bà Trưng, Hà Nội	03/11/1976
GV03	Trần Đức Khánh	Đống Đa, Hà Nội	04/06/1977
GV04	Nguyễn Hồng Phương	Tây Hồ, Hà Nội	10/12/1983
GV05	Lê Thanh Hương	Hai Bà Trưng, Hà Nội	10/10/1976
\.


--
-- Data for Name: ThamGia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ThamGia" ("GV#", "DT#", "SoGio") FROM stdin;
GV01	DT01	100
GV01	DT02	80
GV01	DT03	80
GV02	DT01	120
GV02	DT03	140
GV03	DT03	150
GV04	DT04	180
\.


--
-- Name: DeTai DeTai_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."DeTai"
    ADD CONSTRAINT "DeTai_pkey" PRIMARY KEY ("DT#");


--
-- Name: GiangVien GiangVien_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GiangVien"
    ADD CONSTRAINT "GiangVien_pkey" PRIMARY KEY ("GV#");


--
-- Name: ThamGia ThamGia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ThamGia"
    ADD CONSTRAINT "ThamGia_pkey" PRIMARY KEY ("DT#", "GV#");


--
-- Name: ThamGia ThamGia_DT#_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ThamGia"
    ADD CONSTRAINT "ThamGia_DT#_fkey" FOREIGN KEY ("DT#") REFERENCES public."DeTai"("DT#") NOT VALID;


--
-- Name: ThamGia ThamGia_GV#_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ThamGia"
    ADD CONSTRAINT "ThamGia_GV#_fkey" FOREIGN KEY ("GV#") REFERENCES public."GiangVien"("GV#") NOT VALID;


--
-- PostgreSQL database dump complete
--

