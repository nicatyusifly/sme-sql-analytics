/*
==================================================================
  SXEM (SCHEMA) YARADILMASI
  Mövzu: Kiçik/Orta Sahibkarlıq (SME) üçün Biznes Kreditləri
  Bankın/maliyyə institutunun kredit portfeli analitikası
==================================================================
*/

CREATE TABLE clients (
    client_id         NUMBER PRIMARY KEY,
    company_name      VARCHAR2(100) NOT NULL,
    segment           VARCHAR2(30),      -- 'Mikro sahibkar', 'Kiçik-Orta sahibkar'
    city              VARCHAR2(50),
    registration_date DATE
);

CREATE TABLE loan_officers (
    officer_id        NUMBER PRIMARY KEY,
    officer_name      VARCHAR2(100) NOT NULL,
    branch            VARCHAR2(50)
);

CREATE TABLE credit_products (
    product_id        NUMBER PRIMARY KEY,
    product_name      VARCHAR2(100) NOT NULL,
    product_type      VARCHAR2(50),      -- 'Dövriyyə vəsaiti', 'Avadanlıq', 'Overdraft', 'Ticarət maliyyələşməsi'
    interest_rate     NUMBER(5,2) NOT NULL
);

CREATE TABLE loans (
    loan_id           NUMBER PRIMARY KEY,
    client_id         NUMBER REFERENCES clients(client_id),
    officer_id        NUMBER REFERENCES loan_officers(officer_id),
    product_id        NUMBER REFERENCES credit_products(product_id),
    loan_amount       NUMBER(12,2) NOT NULL,
    issue_date        DATE NOT NULL,
    term_months       NUMBER NOT NULL,
    status            VARCHAR2(20)       -- 'Active', 'Closed', 'Overdue', 'Default'
);

CREATE TABLE loan_payments (
    payment_id        NUMBER PRIMARY KEY,
    loan_id           NUMBER REFERENCES loans(loan_id),
    payment_date      DATE NOT NULL,
    amount_paid       NUMBER(12,2) NOT NULL
);
