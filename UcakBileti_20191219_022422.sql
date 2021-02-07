--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 12rc1

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

--
-- Name: UcakBileti; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "UcakBileti" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Turkish_Turkey.1254' LC_CTYPE = 'Turkish_Turkey.1254';


ALTER DATABASE "UcakBileti" OWNER TO postgres;

\connect "UcakBileti"

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

--
-- Name: KayitTarihiTrigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."KayitTarihiTrigger"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."KayitTarihi" = CURRENT_TIMESTAMP::TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."KayitTarihiTrigger"() OWNER TO postgres;

--
-- Name: biletEkleTrigger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."biletEkleTrigger"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."Tarih" = CURRENT_TIMESTAMP::TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."biletEkleTrigger"() OWNER TO postgres;

--
-- Name: biletlistele(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.biletlistele(kullanid integer) RETURNS TABLE("BiletID" integer, "Tarih" timestamp without time zone, "KoltukNo" integer, "HavaAlani" character varying, "Sirket" character varying, "Sure" character varying, "Pilot" character varying, "Ucak" character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "Bilet"."BiletID", "Ucus"."Tarih", "Bilet"."KoltukNo" ,"HavaAlani"."Ismi", "Sirket"."SirketIsmi", "Ucus"."UcusSuresi", "Pilot"."Isim", "Ucak"."UcakKodu"
FROM "Bilet"
INNER JOIN "Ucus" ON "Ucus"."UcusID" = "Bilet"."UcusID"
INNER JOIN "HavaAlani" ON "HavaAlani"."HavaAlaniID" = "Ucus"."VarisHavaAlani"
INNER JOIN "Sirket" ON "Ucus"."Sirket" = "Sirket"."SirketID"
INNER JOIN "Pilot" ON "Ucus"."Pilot" = "Pilot"."PilotID"
INNER JOIN "Ucak" ON "Ucak"."UcakID" = "Ucus"."Ucak"
WHERE "Bilet"."KullaniciID" = kullanID;
END;
$$;


ALTER FUNCTION public.biletlistele(kullanid integer) OWNER TO postgres;

--
-- Name: geriBildirimTarihi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."geriBildirimTarihi"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."OlusturulmaTarihi" = CURRENT_TIMESTAMP::TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."geriBildirimTarihi"() OWNER TO postgres;

--
-- Name: koltukNumarasiAta(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."koltukNumarasiAta"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."KoltukNo" = floor(random() * 100 + 1)::int;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."koltukNumarasiAta"() OWNER TO postgres;

--
-- Name: kullaniciIsim(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."kullaniciIsim"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."KullaniciAdi" = LOWER(NEW."KullaniciAdi");
    NEW."KullaniciAdi" = LTRIM(NEW."KullaniciAdi");
    NEW."GuvenlikCevap" = LOWER(NEW."GuvenlikCevap");
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."kullaniciIsim"() OWNER TO postgres;

--
-- Name: kullanicilistele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kullanicilistele() RETURNS TABLE("ID" integer, "Adi" character, "Soyadi" character varying, "KullaniciAdi" character varying, "Sifre" character varying, "E-mail" character varying, "Telefon" character varying, "KayitTarihi" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "Kullanici"."KullaniciID", "Kullanici"."Adi", "Kullanici"."Soyadi", "Kullanici"."KullaniciAdi", "Kullanici"."Sifre", "Kullanici"."E-mail", "Kullanici"."Telefon", "Kullanici"."KayitTarihi" FROM "Kullanici";
END;
$$;


ALTER FUNCTION public.kullanicilistele() OWNER TO postgres;

--
-- Name: ucuslistele(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ucuslistele() RETURNS TABLE("UcusID" integer, "Tarih" timestamp without time zone, "Sirket" character varying, "Ucak" character varying, "HavaAlani" character varying, "Pilot" character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT "Ucus"."UcusID", "Ucus"."Tarih", "Sirket"."SirketIsmi", "Ucak"."UcakKodu", "HavaAlani"."Ismi", "Pilot"."Isim" AS "PilotIsmi" FROM "Ucus"
INNER JOIN "Sirket" ON "Ucus"."Sirket" = "Sirket"."SirketID"
INNER JOIN "HavaAlani" ON "Ucus"."VarisHavaAlani" = "HavaAlani"."HavaAlaniID"
INNER JOIN "Ucak" ON "Ucus"."Ucak" = "Ucak"."UcakID"
INNER JOIN "Pilot" ON "Ucus"."Pilot" = "Pilot"."PilotID";
END;
$$;


ALTER FUNCTION public.ucuslistele() OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: Bilet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bilet" (
    "BiletID" integer NOT NULL,
    "UcusID" integer NOT NULL,
    "KullaniciID" integer NOT NULL,
    "Tarih" timestamp without time zone NOT NULL,
    "KoltukNo" integer NOT NULL
);


ALTER TABLE public."Bilet" OWNER TO postgres;

--
-- Name: Bilet_BiletID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bilet_BiletID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Bilet_BiletID_seq" OWNER TO postgres;

--
-- Name: Bilet_BiletID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bilet_BiletID_seq" OWNED BY public."Bilet"."BiletID";


--
-- Name: GeriBildirim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GeriBildirim" (
    "MesajID" integer NOT NULL,
    "KullaniciID" integer NOT NULL,
    "Metin" character varying(200),
    "OlusturulmaTarihi" timestamp without time zone
);


ALTER TABLE public."GeriBildirim" OWNER TO postgres;

--
-- Name: GeriBildirim_MesajID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."GeriBildirim_MesajID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."GeriBildirim_MesajID_seq" OWNER TO postgres;

--
-- Name: GeriBildirim_MesajID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."GeriBildirim_MesajID_seq" OWNED BY public."GeriBildirim"."MesajID";


--
-- Name: HavaAlani; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."HavaAlani" (
    "HavaAlaniID" integer NOT NULL,
    "Ismi" character varying(50) NOT NULL,
    "Ulke" integer NOT NULL
);


ALTER TABLE public."HavaAlani" OWNER TO postgres;

--
-- Name: HavaAlani_HavaAlaniID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."HavaAlani_HavaAlaniID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."HavaAlani_HavaAlaniID_seq" OWNER TO postgres;

--
-- Name: HavaAlani_HavaAlaniID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."HavaAlani_HavaAlaniID_seq" OWNED BY public."HavaAlani"."HavaAlaniID";


--
-- Name: Kullanici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kullanici" (
    "KullaniciID" integer NOT NULL,
    "Adi" character(20) NOT NULL,
    "Soyadi" character varying(20) NOT NULL,
    "Sifre" character varying(15),
    "KayitTarihi" timestamp without time zone,
    "KullaniciTuru" character(1) DEFAULT 'K'::bpchar,
    "KullaniciAdi" character varying(10) NOT NULL,
    "GuvenlikCevap" character varying(50) NOT NULL,
    "Meslek" character varying(50),
    "E-mail" character varying(50),
    "Telefon" character varying(50)
);


ALTER TABLE public."Kullanici" OWNER TO postgres;

--
-- Name: Kullanici_KullaniciID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Kullanici_KullaniciID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Kullanici_KullaniciID_seq" OWNER TO postgres;

--
-- Name: Kullanici_KullaniciID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Kullanici_KullaniciID_seq" OWNED BY public."Kullanici"."KullaniciID";


--
-- Name: Pilot; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Pilot" (
    "PilotID" integer NOT NULL,
    "Isim" character varying(20) NOT NULL,
    "Soyisim" character varying(20) NOT NULL,
    "Tecrube" character varying(20) DEFAULT 'Caylak'::character varying NOT NULL
);


ALTER TABLE public."Pilot" OWNER TO postgres;

--
-- Name: Pilot_PilotID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Pilot_PilotID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Pilot_PilotID_seq" OWNER TO postgres;

--
-- Name: Pilot_PilotID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Pilot_PilotID_seq" OWNED BY public."Pilot"."PilotID";


--
-- Name: Rapor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rapor" (
    "RaporID" integer NOT NULL,
    "YoneticiID" integer,
    "Konu" character varying(50),
    "Metin" character varying(200)
);


ALTER TABLE public."Rapor" OWNER TO postgres;

--
-- Name: Rapor_RaporID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Rapor_RaporID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Rapor_RaporID_seq" OWNER TO postgres;

--
-- Name: Rapor_RaporID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Rapor_RaporID_seq" OWNED BY public."Rapor"."RaporID";


--
-- Name: Rota; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rota" (
    "RotaID" integer NOT NULL,
    "UgradigiUlkeler" character varying(50) NOT NULL
);


ALTER TABLE public."Rota" OWNER TO postgres;

--
-- Name: Rota_RotaID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Rota_RotaID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Rota_RotaID_seq" OWNER TO postgres;

--
-- Name: Rota_RotaID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Rota_RotaID_seq" OWNED BY public."Rota"."RotaID";


--
-- Name: Sirket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sirket" (
    "SirketID" integer NOT NULL,
    "SirketIsmi" character varying(50) NOT NULL,
    "KurulusTarihi" integer NOT NULL
);


ALTER TABLE public."Sirket" OWNER TO postgres;

--
-- Name: Sirket_SirketID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Sirket_SirketID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Sirket_SirketID_seq" OWNER TO postgres;

--
-- Name: Sirket_SirketID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Sirket_SirketID_seq" OWNED BY public."Sirket"."SirketID";


--
-- Name: Ucak; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ucak" (
    "UcakID" integer NOT NULL,
    "Uretici" integer NOT NULL,
    "UcakKodu" character varying(20) NOT NULL,
    "KoltukSayisi" integer NOT NULL
);


ALTER TABLE public."Ucak" OWNER TO postgres;

--
-- Name: Ucak_UcakID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ucak_UcakID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ucak_UcakID_seq" OWNER TO postgres;

--
-- Name: Ucak_UcakID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ucak_UcakID_seq" OWNED BY public."Ucak"."UcakID";


--
-- Name: Ucus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ucus" (
    "UcusID" integer NOT NULL,
    "Tarih" timestamp without time zone NOT NULL,
    "Sirket" integer NOT NULL,
    "VarisHavaAlani" integer NOT NULL,
    "Pilot" integer,
    "Rota" integer NOT NULL,
    "Ucak" integer NOT NULL,
    "UcusSuresi" character varying(20)
);


ALTER TABLE public."Ucus" OWNER TO postgres;

--
-- Name: Ucus_UcusID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ucus_UcusID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ucus_UcusID_seq" OWNER TO postgres;

--
-- Name: Ucus_UcusID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ucus_UcusID_seq" OWNED BY public."Ucus"."UcusID";


--
-- Name: Ulke; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ulke" (
    "UlkeID" integer NOT NULL,
    "Ulkeismi" character varying(50),
    "Kita" character varying(20)
);


ALTER TABLE public."Ulke" OWNER TO postgres;

--
-- Name: Ulke_UlkeID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Ulke_UlkeID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Ulke_UlkeID_seq" OWNER TO postgres;

--
-- Name: Ulke_UlkeID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Ulke_UlkeID_seq" OWNED BY public."Ulke"."UlkeID";


--
-- Name: Uretici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Uretici" (
    "UreticiID" integer NOT NULL,
    "UreticiIsmi" character varying(50),
    "KurulusTarihi" character varying(20)
);


ALTER TABLE public."Uretici" OWNER TO postgres;

--
-- Name: Uretici_UreticiID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Uretici_UreticiID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Uretici_UreticiID_seq" OWNER TO postgres;

--
-- Name: Uretici_UreticiID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Uretici_UreticiID_seq" OWNED BY public."Uretici"."UreticiID";


--
-- Name: Yonetici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yonetici" (
    "KullaniciID" integer NOT NULL,
    "RaporSayisi" integer DEFAULT 0
);


ALTER TABLE public."Yonetici" OWNER TO postgres;

--
-- Name: Yonetici_KullaniciID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Yonetici_KullaniciID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Yonetici_KullaniciID_seq" OWNER TO postgres;

--
-- Name: Yonetici_KullaniciID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Yonetici_KullaniciID_seq" OWNED BY public."Yonetici"."KullaniciID";


--
-- Name: Bilet BiletID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilet" ALTER COLUMN "BiletID" SET DEFAULT nextval('public."Bilet_BiletID_seq"'::regclass);


--
-- Name: GeriBildirim MesajID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GeriBildirim" ALTER COLUMN "MesajID" SET DEFAULT nextval('public."GeriBildirim_MesajID_seq"'::regclass);


--
-- Name: HavaAlani HavaAlaniID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HavaAlani" ALTER COLUMN "HavaAlaniID" SET DEFAULT nextval('public."HavaAlani_HavaAlaniID_seq"'::regclass);


--
-- Name: Kullanici KullaniciID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kullanici" ALTER COLUMN "KullaniciID" SET DEFAULT nextval('public."Kullanici_KullaniciID_seq"'::regclass);


--
-- Name: Pilot PilotID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pilot" ALTER COLUMN "PilotID" SET DEFAULT nextval('public."Pilot_PilotID_seq"'::regclass);


--
-- Name: Rapor RaporID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rapor" ALTER COLUMN "RaporID" SET DEFAULT nextval('public."Rapor_RaporID_seq"'::regclass);


--
-- Name: Rota RotaID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rota" ALTER COLUMN "RotaID" SET DEFAULT nextval('public."Rota_RotaID_seq"'::regclass);


--
-- Name: Sirket SirketID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sirket" ALTER COLUMN "SirketID" SET DEFAULT nextval('public."Sirket_SirketID_seq"'::regclass);


--
-- Name: Ucak UcakID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ucak" ALTER COLUMN "UcakID" SET DEFAULT nextval('public."Ucak_UcakID_seq"'::regclass);


--
-- Name: Ucus UcusID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ucus" ALTER COLUMN "UcusID" SET DEFAULT nextval('public."Ucus_UcusID_seq"'::regclass);


--
-- Name: Ulke UlkeID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ulke" ALTER COLUMN "UlkeID" SET DEFAULT nextval('public."Ulke_UlkeID_seq"'::regclass);


--
-- Name: Uretici UreticiID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uretici" ALTER COLUMN "UreticiID" SET DEFAULT nextval('public."Uretici_UreticiID_seq"'::regclass);


--
-- Name: Yonetici KullaniciID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yonetici" ALTER COLUMN "KullaniciID" SET DEFAULT nextval('public."Yonetici_KullaniciID_seq"'::regclass);


--
-- Data for Name: Bilet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Bilet" VALUES (2, 4, 1, '2019-01-01 00:00:00', 82);
INSERT INTO public."Bilet" VALUES (7, 5, 5, '2019-12-19 01:32:33.966034', 2);
INSERT INTO public."Bilet" VALUES (11, 7, 5, '2019-12-19 01:41:14.107178', 49);
INSERT INTO public."Bilet" VALUES (12, 10, 5, '2019-12-19 01:48:03.812554', 8);


--
-- Data for Name: GeriBildirim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."GeriBildirim" VALUES (2, 5, 'asdasd', '2019-12-17 15:53:52.246809');
INSERT INTO public."GeriBildirim" VALUES (3, 5, 'formdenemesi', '2019-12-17 16:00:33.748764');
INSERT INTO public."GeriBildirim" VALUES (4, 5, 'yavyeterbe', '2019-12-17 16:00:42.531382');
INSERT INTO public."GeriBildirim" VALUES (5, 5, 'asdasd', '2019-12-17 23:21:12.566925');
INSERT INTO public."GeriBildirim" VALUES (6, 5, 'kjjjj', '2019-12-17 23:22:34.534318');
INSERT INTO public."GeriBildirim" VALUES (7, 5, 'dfghbhdfbh', '2019-12-19 01:32:42.719592');
INSERT INTO public."GeriBildirim" VALUES (8, 5, 'dghöp', '2019-12-19 01:34:42.99148');
INSERT INTO public."GeriBildirim" VALUES (9, 5, 'dfgdfghhb', '2019-12-19 01:41:56.266074');


--
-- Data for Name: HavaAlani; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."HavaAlani" VALUES (1, 'Derry havaalanı', 1);
INSERT INTO public."HavaAlani" VALUES (2, 'Campbeltown havaalani', 2);
INSERT INTO public."HavaAlani" VALUES (3, 'Ronaldsway havaalanı', 3);
INSERT INTO public."HavaAlani" VALUES (4, 'Islay Glenegedale havaalani', 4);
INSERT INTO public."HavaAlani" VALUES (5, 'Donegal havaalanı', 5);
INSERT INTO public."HavaAlani" VALUES (6, 'madrid havaalani', 6);
INSERT INTO public."HavaAlani" VALUES (7, 'Alicante havaalani', 7);
INSERT INTO public."HavaAlani" VALUES (8, 'Bilbao havaalani', 8);
INSERT INTO public."HavaAlani" VALUES (9, 'Rotterdam havaalani', 9);
INSERT INTO public."HavaAlani" VALUES (10, 'Groningen havaalani', 10);
INSERT INTO public."HavaAlani" VALUES (11, 'Maastricht havaalani', 11);
INSERT INTO public."HavaAlani" VALUES (12, 'Faro havaalani', 12);
INSERT INTO public."HavaAlani" VALUES (13, 'Lizbon havaalani', 13);
INSERT INTO public."HavaAlani" VALUES (14, 'Berlin havaalani', 14);
INSERT INTO public."HavaAlani" VALUES (15, 'Stuttgart havaalani', 15);
INSERT INTO public."HavaAlani" VALUES (16, 'Napoli havaalani', 14);
INSERT INTO public."HavaAlani" VALUES (17, 'Cagliari havaalani', 11);
INSERT INTO public."HavaAlani" VALUES (18, 'Westray havaalani', 4);


--
-- Data for Name: Kullanici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kullanici" VALUES (1, 'alper               ', 'berber', '123123', '2019-01-01 00:00:00', 'Y', 'alper', 'limon', NULL, NULL, NULL);
INSERT INTO public."Kullanici" VALUES (5, 'isim                ', 'soyisim', 'sif', '2019-01-04 00:00:00', 'K', 'kadi', 'cevap', NULL, NULL, NULL);
INSERT INTO public."Kullanici" VALUES (9, 'alper               ', 'berber', 'deneme', '2019-12-16 19:52:05.357061', 'K', 'alper2', 'limon', 'ogrenci', 'asdqwe', '456789');
INSERT INTO public."Kullanici" VALUES (11, 'asdasdasd           ', 'jsfgdfhfhbj', 'sifre123123', '2019-12-19 01:40:41.031596', 'K', 'form123123', 'duman', 'jıjlklklk', 'dfkgdfg', '88888');


--
-- Data for Name: Pilot; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Pilot" VALUES (2, 'ahmet ', 'güler', '5 YIL');
INSERT INTO public."Pilot" VALUES (3, 'rıfat', 'ozgun', '2 YIL');
INSERT INTO public."Pilot" VALUES (4, 'burak', 'yilmaz', 'Caylak');
INSERT INTO public."Pilot" VALUES (5, 'bekir', 'irtegun', '4 YIL');
INSERT INTO public."Pilot" VALUES (6, 'melih', 'alan', '12 YIL');
INSERT INTO public."Pilot" VALUES (1, 'Çağlar', 'yilmaz', '33 YIL');


--
-- Data for Name: Rapor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Rapor" VALUES (1, 1, 'form1', 'deneme');
INSERT INTO public."Rapor" VALUES (15, 1, 'ghj', 'deneme 00:29');
INSERT INTO public."Rapor" VALUES (16, 1, 'form', 'deneemrmqefmwef');
INSERT INTO public."Rapor" VALUES (17, 1, 'sdfgsgd', 'fghnfghn');


--
-- Data for Name: Rota; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Rota" VALUES (1, 'Bulgaristan, Sirbistan');
INSERT INTO public."Rota" VALUES (2, 'Yunanistan, Italya, Fransa');
INSERT INTO public."Rota" VALUES (3, 'Suriye, Irak, Iran');
INSERT INTO public."Rota" VALUES (4, 'Tunus, Cezayir, Libya');
INSERT INTO public."Rota" VALUES (5, 'Romanya, macaristan, Almanya');
INSERT INTO public."Rota" VALUES (6, 'Sırbistan, Belcika, Ingiltere');


--
-- Data for Name: Sirket; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Sirket" VALUES (1, 'Air Canada', 1965);
INSERT INTO public."Sirket" VALUES (2, 'Hainan Airlines', 1923);
INSERT INTO public."Sirket" VALUES (3, 'Air New Zealand', 1965);
INSERT INTO public."Sirket" VALUES (4, 'Korean Air', 1942);
INSERT INTO public."Sirket" VALUES (5, 'Thai Airlines', 1966);
INSERT INTO public."Sirket" VALUES (6, 'Malaysia Airlines', 1978);
INSERT INTO public."Sirket" VALUES (7, 'THY', 1933);
INSERT INTO public."Sirket" VALUES (8, 'Asiana Airlines', 1932);
INSERT INTO public."Sirket" VALUES (9, 'Qatar Airways', 1910);
INSERT INTO public."Sirket" VALUES (10, 'Emirates', 1985);


--
-- Data for Name: Ucak; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Ucak" VALUES (2, 1, 'Airbus A340', 60);
INSERT INTO public."Ucak" VALUES (1, 99, 'Airbus A330', 60);
INSERT INTO public."Ucak" VALUES (3, 2, 'Boeing 737-800', 60);
INSERT INTO public."Ucak" VALUES (4, 2, 'Boeing 737-700', 60);
INSERT INTO public."Ucak" VALUES (6, 2, 'Boeing 737-700 ER', 60);
INSERT INTO public."Ucak" VALUES (7, 2, 'Boeing 737-900 ER', 60);
INSERT INTO public."Ucak" VALUES (5, 3, 'Apache', 5);


--
-- Data for Name: Ucus; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Ucus" VALUES (4, '2019-12-31 21:00:00', 1, 6, 1, 3, 4, '4 Saat');
INSERT INTO public."Ucus" VALUES (5, '2019-01-01 19:02:00', 1, 1, 1, 1, 1, 'asdasd');
INSERT INTO public."Ucus" VALUES (7, '2019-01-01 19:02:00', 1, 1, 1, 1, 1, 'dene123');
INSERT INTO public."Ucus" VALUES (10, '2019-12-19 01:45:36', 3, 10, 4, 3, 7, '1.5 saat');
INSERT INTO public."Ucus" VALUES (11, '2019-12-24 09:30:49', 7, 7, 3, 2, 5, '1.5 saat');


--
-- Data for Name: Ulke; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Ulke" VALUES (1, 'Romanya', 'Avrupa');
INSERT INTO public."Ulke" VALUES (2, 'Macaristan', 'Avrupa');
INSERT INTO public."Ulke" VALUES (3, 'Japonya', 'Asya');
INSERT INTO public."Ulke" VALUES (4, 'Rusya', 'Asya');
INSERT INTO public."Ulke" VALUES (5, 'Belarus', 'Avrupa');
INSERT INTO public."Ulke" VALUES (6, 'Yunanistan', 'Avrupa');
INSERT INTO public."Ulke" VALUES (7, 'Ispanya', 'Avrupa');
INSERT INTO public."Ulke" VALUES (8, 'Portekiz', 'Avrupa');
INSERT INTO public."Ulke" VALUES (9, 'Fransa', 'Avrupa');
INSERT INTO public."Ulke" VALUES (10, 'Almanya', 'Avrupa');
INSERT INTO public."Ulke" VALUES (11, 'Meksika', 'Amerika');
INSERT INTO public."Ulke" VALUES (12, 'Kanada', 'Amerika');
INSERT INTO public."Ulke" VALUES (13, 'Brezilya', 'Amerika');
INSERT INTO public."Ulke" VALUES (14, 'Peru', 'Amerika');
INSERT INTO public."Ulke" VALUES (15, 'Bolivya', 'Amerika');
INSERT INTO public."Ulke" VALUES (16, 'Arjantin', 'Amerika');


--
-- Data for Name: Uretici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Uretici" VALUES (1, 'Airbus', '1911');
INSERT INTO public."Uretici" VALUES (2, 'Boeing', '1928');
INSERT INTO public."Uretici" VALUES (3, 'ATR', '1981');
INSERT INTO public."Uretici" VALUES (4, 'Bombardier', '1952');
INSERT INTO public."Uretici" VALUES (99, 'Embraer', '1968');
INSERT INTO public."Uretici" VALUES (5, 'McDonnel Douglas', '1967');
INSERT INTO public."Uretici" VALUES (6, 'Fokker', '1912');
INSERT INTO public."Uretici" VALUES (7, 'Tupolev', '1944');


--
-- Data for Name: Yonetici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Yonetici" VALUES (1, 52);


--
-- Name: Bilet_BiletID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bilet_BiletID_seq"', 13, true);


--
-- Name: GeriBildirim_MesajID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."GeriBildirim_MesajID_seq"', 9, true);


--
-- Name: HavaAlani_HavaAlaniID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."HavaAlani_HavaAlaniID_seq"', 19, false);


--
-- Name: Kullanici_KullaniciID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Kullanici_KullaniciID_seq"', 11, true);


--
-- Name: Pilot_PilotID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Pilot_PilotID_seq"', 7, false);


--
-- Name: Rapor_RaporID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Rapor_RaporID_seq"', 17, true);


--
-- Name: Rota_RotaID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Rota_RotaID_seq"', 7, false);


--
-- Name: Sirket_SirketID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Sirket_SirketID_seq"', 11, false);


--
-- Name: Ucak_UcakID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ucak_UcakID_seq"', 7, true);


--
-- Name: Ucus_UcusID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ucus_UcusID_seq"', 11, true);


--
-- Name: Ulke_UlkeID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Ulke_UlkeID_seq"', 16, true);


--
-- Name: Uretici_UreticiID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Uretici_UreticiID_seq"', 7, true);


--
-- Name: Yonetici_KullaniciID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Yonetici_KullaniciID_seq"', 1, false);


--
-- Name: Bilet BiletPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilet"
    ADD CONSTRAINT "BiletPK" PRIMARY KEY ("BiletID");


--
-- Name: GeriBildirim GeriBildirimPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GeriBildirim"
    ADD CONSTRAINT "GeriBildirimPK" PRIMARY KEY ("MesajID");


--
-- Name: HavaAlani HavaAlaniPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HavaAlani"
    ADD CONSTRAINT "HavaAlaniPK" PRIMARY KEY ("HavaAlaniID");


--
-- Name: Kullanici KullaniciPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kullanici"
    ADD CONSTRAINT "KullaniciPK" PRIMARY KEY ("KullaniciID");


--
-- Name: Kullanici Kullanici_KullaniciAdi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kullanici"
    ADD CONSTRAINT "Kullanici_KullaniciAdi_key" UNIQUE ("KullaniciAdi");


--
-- Name: Pilot PilotPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pilot"
    ADD CONSTRAINT "PilotPK" PRIMARY KEY ("PilotID");


--
-- Name: Rapor RaporPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rapor"
    ADD CONSTRAINT "RaporPK" PRIMARY KEY ("RaporID");


--
-- Name: Rota RotaPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rota"
    ADD CONSTRAINT "RotaPK" PRIMARY KEY ("RotaID");


--
-- Name: Sirket SirketPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sirket"
    ADD CONSTRAINT "SirketPK" PRIMARY KEY ("SirketID");


--
-- Name: Ucak UcakPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ucak"
    ADD CONSTRAINT "UcakPK" PRIMARY KEY ("UcakID");


--
-- Name: Ucak UcakUnique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ucak"
    ADD CONSTRAINT "UcakUnique" UNIQUE ("UcakKodu");


--
-- Name: Ucus UcusPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ucus"
    ADD CONSTRAINT "UcusPK" PRIMARY KEY ("UcusID");


--
-- Name: Ulke UlkePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ulke"
    ADD CONSTRAINT "UlkePK" PRIMARY KEY ("UlkeID");


--
-- Name: Uretici UreticiPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uretici"
    ADD CONSTRAINT "UreticiPK" PRIMARY KEY ("UreticiID");


--
-- Name: Yonetici YoneticiPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yonetici"
    ADD CONSTRAINT "YoneticiPK" PRIMARY KEY ("KullaniciID");


--
-- Name: Kullanici KullaniciEklendiginde; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "KullaniciEklendiginde" BEFORE INSERT ON public."Kullanici" FOR EACH ROW EXECUTE PROCEDURE public."KayitTarihiTrigger"();


--
-- Name: Bilet biletKoltukAtama; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "biletKoltukAtama" BEFORE INSERT ON public."Bilet" FOR EACH ROW EXECUTE PROCEDURE public."koltukNumarasiAta"();


--
-- Name: Bilet biletTarih; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "biletTarih" BEFORE INSERT ON public."Bilet" FOR EACH ROW EXECUTE PROCEDURE public."biletEkleTrigger"();


--
-- Name: GeriBildirim geriBildirimTarihAta; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "geriBildirimTarihAta" BEFORE INSERT ON public."GeriBildirim" FOR EACH ROW EXECUTE PROCEDURE public."geriBildirimTarihi"();


--
-- Name: Kullanici inputKucultme; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "inputKucultme" BEFORE INSERT ON public."Kullanici" FOR EACH ROW EXECUTE PROCEDURE public."kullaniciIsim"();


--
-- Name: Bilet biletFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilet"
    ADD CONSTRAINT "biletFK" FOREIGN KEY ("KullaniciID") REFERENCES public."Kullanici"("KullaniciID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Bilet biletFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bilet"
    ADD CONSTRAINT "biletFK1" FOREIGN KEY ("UcusID") REFERENCES public."Ucus"("UcusID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: HavaAlani havaalaniFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."HavaAlani"
    ADD CONSTRAINT "havaalaniFK" FOREIGN KEY ("Ulke") REFERENCES public."Ulke"("UlkeID");


--
-- Name: GeriBildirim mesajFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GeriBildirim"
    ADD CONSTRAINT "mesajFK" FOREIGN KEY ("KullaniciID") REFERENCES public."Kullanici"("KullaniciID");


--
-- Name: Rapor raporFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rapor"
    ADD CONSTRAINT "raporFK" FOREIGN KEY ("YoneticiID") REFERENCES public."Yonetici"("KullaniciID");


--
-- Name: Ucak ucakFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ucak"
    ADD CONSTRAINT "ucakFK" FOREIGN KEY ("Uretici") REFERENCES public."Uretici"("UreticiID");


--
-- Name: Ucus ucusFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ucus"
    ADD CONSTRAINT "ucusFK" FOREIGN KEY ("Sirket") REFERENCES public."Sirket"("SirketID");


--
-- Name: Ucus ucusFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ucus"
    ADD CONSTRAINT "ucusFK1" FOREIGN KEY ("Pilot") REFERENCES public."Pilot"("PilotID");


--
-- Name: Ucus ucusFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ucus"
    ADD CONSTRAINT "ucusFK2" FOREIGN KEY ("VarisHavaAlani") REFERENCES public."HavaAlani"("HavaAlaniID");


--
-- Name: Ucus ucusFK4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ucus"
    ADD CONSTRAINT "ucusFK4" FOREIGN KEY ("Rota") REFERENCES public."Rota"("RotaID");


--
-- Name: Ucus ucusFK5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ucus"
    ADD CONSTRAINT "ucusFK5" FOREIGN KEY ("Ucak") REFERENCES public."Ucak"("UcakID");


--
-- Name: Yonetici yoneticiFK; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yonetici"
    ADD CONSTRAINT "yoneticiFK" FOREIGN KEY ("KullaniciID") REFERENCES public."Kullanici"("KullaniciID");


--
-- PostgreSQL database dump complete
--

