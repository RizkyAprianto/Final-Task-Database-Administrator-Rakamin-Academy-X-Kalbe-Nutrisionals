--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9
-- Dumped by pg_dump version 14.9

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
-- Name: app; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA app;


ALTER SCHEMA app OWNER TO postgres;

--
-- Name: updateshipmentid(); Type: FUNCTION; Schema: app; Owner: postgres
--

CREATE FUNCTION app.updateshipmentid() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE 
    done BOOLEAN DEFAULT FALSE;
    shipment_id_counter INT DEFAULT 1;
    current_sending_time TIMESTAMP;
    new_shipment_id VARCHAR(10);
    
    -- Cursor untuk mengambil data dengan SendingTime tidak null
    cur CURSOR FOR
        SELECT sending_time
        FROM delivery
        WHERE sending_time IS NOT NULL;
    
BEGIN
    OPEN cur;
    
    LOOP
        FETCH cur INTO current_sending_time;
        EXIT WHEN NOT FOUND;
        
        -- Menghasilkan nilai ShipmentID dengan format yymmdd01, yymmdd02, dst.
        new_shipment_id := TO_CHAR(current_sending_time, 'YYMMDD') || to_char(shipment_id_counter, 'FM00');
        
        -- Menyimpan nilai ShipmentID ke dalam kolom ShipmentID
        UPDATE delivery 
        SET shipment_id = new_shipment_id
        WHERE sending_time = current_sending_time;
        
        -- Increment counter ShipmentID
        shipment_id_counter := shipment_id_counter + 1;
    END LOOP;
    
    CLOSE cur;
    
    RETURN;
EXCEPTION
    WHEN OTHERS THEN
        -- Tangani kesalahan jika terjadi
        RAISE WARNING 'Error in UpdateShipmentID(): %', SQLERRM;
        RETURN;
END;
$$;


ALTER FUNCTION app.updateshipmentid() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: delivery; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.delivery (
    delivery_id integer NOT NULL,
    product_id integer NOT NULL,
    store_id integer NOT NULL,
    shipment_id character varying(255),
    sending_time timestamp without time zone,
    delivered_time timestamp without time zone,
    received_by character varying(255)
);


ALTER TABLE app.delivery OWNER TO postgres;

--
-- Name: detail_delivery; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.detail_delivery (
    detail_delivery_id integer NOT NULL,
    delivery_id integer NOT NULL,
    driver_id integer NOT NULL,
    truck_id integer NOT NULL,
    qty integer,
    unit character varying(255)
);


ALTER TABLE app.detail_delivery OWNER TO postgres;

--
-- Name: driver; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.driver (
    driver_id integer NOT NULL,
    shipping_driver character varying(255),
    shipping_codriver character varying(255)
);


ALTER TABLE app.driver OWNER TO postgres;

--
-- Name: operator; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.operator (
    operator_id integer NOT NULL,
    operator_name character varying(255)
);


ALTER TABLE app.operator OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.product (
    product_id integer NOT NULL,
    product_name character varying(255)
);


ALTER TABLE app.product OWNER TO postgres;

--
-- Name: store; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.store (
    store_id integer NOT NULL,
    store_destination character varying(255),
    "store_address; " character varying(50)
);


ALTER TABLE app.store OWNER TO postgres;

--
-- Name: truck; Type: TABLE; Schema: app; Owner: postgres
--

CREATE TABLE app.truck (
    truck_id integer NOT NULL,
    shipping_vehicle character varying(255),
    no_police character varying(255)
);


ALTER TABLE app.truck OWNER TO postgres;

--
-- Data for Name: delivery; Type: TABLE DATA; Schema: app; Owner: postgres
--

COPY app.delivery (delivery_id, product_id, store_id, shipment_id, sending_time, delivered_time, received_by) FROM stdin;
1	1	1	23050103	2023-05-01 10:00:00	2023-05-01 13:30:00	Dian Ayu
2	5	1	23050103	2023-05-01 10:00:00	2023-05-01 13:30:00	Dian Ayu
3	11	1	23050103	2023-05-01 10:00:00	2023-05-01 13:30:00	Dian Ayu
4	1	2	23050106	2023-05-01 11:00:00	2023-05-01 13:00:00	Eriawan
5	2	2	23050106	2023-05-01 11:00:00	2023-05-01 13:00:00	Eriawan
6	52	2	23050106	2023-05-01 11:00:00	2023-05-01 13:00:00	Eriawan
7	35	3	23050213	2023-05-02 09:00:00	2023-05-02 12:00:00	Aji
8	36	3	23050213	2023-05-02 09:00:00	2023-05-02 12:00:00	Aji
9	42	3	23050213	2023-05-02 09:00:00	2023-05-02 12:00:00	Aji
10	24	3	23050213	2023-05-02 09:00:00	2023-05-02 12:00:00	Aji
11	49	4	23050213	2023-05-02 09:00:00	2023-05-02 14:00:00	Jamal
12	52	4	23050213	2023-05-02 09:00:00	2023-05-02 14:00:00	Jamal
13	53	4	23050213	2023-05-02 09:00:00	2023-05-02 14:00:00	Jamal
14	4	1	23050314	2023-05-03 09:00:00	2023-05-01 13:30:00	Louis
\.


--
-- Data for Name: detail_delivery; Type: TABLE DATA; Schema: app; Owner: postgres
--

COPY app.detail_delivery (detail_delivery_id, delivery_id, driver_id, truck_id, qty, unit) FROM stdin;
1	1	1	1	5	box
2	2	1	1	5	box
3	3	1	1	10	box
4	4	2	2	3	box
5	5	2	2	2	box
6	6	2	2	8	box
7	7	3	1	10	box
8	8	3	1	5	box
9	9	3	1	12	box
10	10	3	1	10	box
11	11	3	1	5	box
12	12	3	1	4	box
13	13	3	1	6	box
\.


--
-- Data for Name: driver; Type: TABLE DATA; Schema: app; Owner: postgres
--

COPY app.driver (driver_id, shipping_driver, shipping_codriver) FROM stdin;
1	Dimas Ahmad	Andi Wahyu
2	Hari Saputra	Dadang Bima
3	Ginanjar	Hari Saputra
\.


--
-- Data for Name: operator; Type: TABLE DATA; Schema: app; Owner: postgres
--

COPY app.operator (operator_id, operator_name) FROM stdin;
1	Ahmad Agus
2	Fitrianto
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: app; Owner: postgres
--

COPY app.product (product_id, product_name) FROM stdin;
1	Hydro Coco 250ml
2	Hydro Coco 330ml
3	Hydro Coco 500ml
4	Hydro Coco 1 liter
5	Hydro Coco Vita-D 330ml
6	Milna Biskuit Bayi Original
7	Milna Biskuit Bayi Beras Merah
8	Milna Biskuit Bayi Kacang Hijau
9	Milna Biskuit Bayi Jeruk
10	Milna Biskuit Bayi Pisang
11	Milna Biskuit Bayi Apel
12	Milna Biskuit Bayi Apel Jeruk
13	Milna Bubur Bayi Beras Merah Untuk 6 - 12 Bulan
14	Milna Bubur Bayi Pisang Untuk 6 - 12 Bulan
15	Milna Bubur Bayi Sup Ayam Wortel Untuk 6 - 12 Bulan
16	Milna Bubur Bayi Sup Daging Brokoli Untuk 6 - 12 Bulan
17	Milna Bubur Bayi Tim Hati Ayam Bayam Untuk 6 - 12 Bulan
18	Milna Bubur Bayi Ayam Jagung Manis Untuk 8 - 12 Bulan
19	Milna Bubur Bayi Daging Kacang Polong Untuk 8 - 12 Bulan
20	Milna Bubur Bayi Hati Ayam Brokoli Untuk 8 - 12 Bulan
21	Milna Bubur Organik Pisang
22	Milna Bubur Organik Kacang Hijau
23	Milna Bubur Organik Beras Merah
24	Milna Bubur Organik Multigrain
25	Milna Bubur Bayi WGAIN Ayam Kacang Polong
26	Milna Bubur Bayi WGAIN Ayam Wortel Brokoli
27	Milna Bubur Bayi WGAIN Ayam Manis Teriyaki
28	Milna Bubur Bayi WGAIN Ayam Bayam
29	Milna Goodmil Peach Stroberi Jeruk
30	Milna Goodmil Wortel Labu
31	Milna Goodmil Beras Merah Semur Ayam
32	Milna Goodmil Beras Merah Pisang
33	Milna Goodmil Beras Merah Ayam
34	Milna Goodmil Hypoallergenic Beras Merah
35	Milna Nature Delight Apel Peach
36	Milna Nature Delight Apel Labu Wortel
37	Milna Nature Delight Apel Pisang Stroberi
38	Milna Biskuit Bayi Finger
39	Milna Nature Puffs Organic Pisang
40	Milna Nature Puffs Organic Keju
41	Milna Nature Puffs Organic Apel & Mix Berries
42	Milna Rice Crackers Apple Orange
43	Milna Rice Crackers Banana Berries
44	Milna Rice Crackers Sweet Potato Carrot
45	Nutrive Benecol Blackcurrant
46	Nutrive Benecol Strawberry
47	Nutrive Benecol Orange
48	Nutrive Benecol Lychee
49	Entrasol Active Vanilla latte
50	Entrasol Active Mochaccino
51	Entrasol Active Chocolate
52	Entrasol Gold Original
53	Entrasol Gold Chocolate
54	Entrasol Gold Vanilla
55	Entrasol UHT Vanilla Latte
56	Entrasol UHT Chocolate
57	Entrasol Cereal Vanilla Vegie
58	Entrasol Cereal Chocolate
59	Entrasol Platinum Vanilla
60	Entrasol Platinum Chocolate
\.


--
-- Data for Name: store; Type: TABLE DATA; Schema: app; Owner: postgres
--

COPY app.store (store_id, store_destination, "store_address; ") FROM stdin;
1	Apotek Agus Sari	Jln Angga Jaya no 21;
2	Toko Maju Bersama	Jln Agus Salim no 22;
3	Toko Anak Sehat	Jln Imam Bonjol no 33;
4	Apotek Agung	Pasar Senen no 301;
\.


--
-- Data for Name: truck; Type: TABLE DATA; Schema: app; Owner: postgres
--

COPY app.truck (truck_id, shipping_vehicle, no_police) FROM stdin;
1	Box A001	B 1234 GA
2	Box A002	B 3214 JS
\.


--
-- Name: delivery delivery_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.delivery
    ADD CONSTRAINT delivery_pkey PRIMARY KEY (delivery_id);


--
-- Name: detail_delivery detail_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.detail_delivery
    ADD CONSTRAINT detail_pkey PRIMARY KEY (detail_delivery_id);


--
-- Name: driver driver_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (driver_id);


--
-- Name: operator operator_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.operator
    ADD CONSTRAINT operator_pkey PRIMARY KEY (operator_id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- Name: store store_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.store
    ADD CONSTRAINT store_pkey PRIMARY KEY (store_id);


--
-- Name: truck truck_pkey; Type: CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.truck
    ADD CONSTRAINT truck_pkey PRIMARY KEY (truck_id);


--
-- Name: product_idx; Type: INDEX; Schema: app; Owner: postgres
--

CREATE INDEX product_idx ON app.product USING btree (product_id, product_name);


--
-- Name: detail_delivery fk_delivery; Type: FK CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.detail_delivery
    ADD CONSTRAINT fk_delivery FOREIGN KEY (delivery_id) REFERENCES app.delivery(delivery_id);


--
-- Name: detail_delivery fk_driver; Type: FK CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.detail_delivery
    ADD CONSTRAINT fk_driver FOREIGN KEY (driver_id) REFERENCES app.driver(driver_id);


--
-- Name: delivery fk_product; Type: FK CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.delivery
    ADD CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES app.product(product_id);


--
-- Name: delivery fk_store; Type: FK CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.delivery
    ADD CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES app.store(store_id);


--
-- Name: detail_delivery fk_truck; Type: FK CONSTRAINT; Schema: app; Owner: postgres
--

ALTER TABLE ONLY app.detail_delivery
    ADD CONSTRAINT fk_truck FOREIGN KEY (truck_id) REFERENCES app.truck(truck_id);


--
-- Name: SCHEMA app; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA app TO backend_user;


--
-- Name: TABLE delivery; Type: ACL; Schema: app; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE app.delivery TO backend_user;


--
-- Name: TABLE detail_delivery; Type: ACL; Schema: app; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE app.detail_delivery TO backend_user;


--
-- Name: TABLE driver; Type: ACL; Schema: app; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE app.driver TO backend_user;


--
-- Name: TABLE operator; Type: ACL; Schema: app; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE app.operator TO backend_user;


--
-- Name: TABLE product; Type: ACL; Schema: app; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE app.product TO backend_user;


--
-- Name: TABLE truck; Type: ACL; Schema: app; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE app.truck TO backend_user;


--
-- PostgreSQL database dump complete
--

