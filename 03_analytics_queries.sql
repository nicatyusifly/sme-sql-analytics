/*
==================================================================
  ANALİTİK SORĞULAR
  Mövzu: Kiçik/Orta Sahibkarlıq (SME) Biznes Kreditləri Portfeli
  (Aggregate, Group By/Having, Window Functions, CTE, Subquery)
==================================================================
*/


-- ------------------------------------------------------------------
-- 1. AGGREGATE FUNKSİYALAR
-- ------------------------------------------------------------------

-- Ümumi kredit portfelinin həcmini, orta kredit məbləğini,  verilmiş kreditlərin sayını və ilk/son kredit tarixini hesabla.
SELECT
    COUNT(*)                            AS total_loans,
    ROUND(SUM(loan_amount), 2)         AS total_portfolio,
    ROUND(AVG(loan_amount), 2)         AS avg_loan_amount,
    MIN(issue_date)                     AS first_loan_date,
    MAX(issue_date)                     AS last_loan_date
FROM loans;


-- ------------------------------------------------------------------
-- 2. GROUP BY / HAVING
-- ------------------------------------------------------------------

-- Sahibkar seqmentləri üzrə ümumi kredit məbləğini hesabla və 40 000 AZN-dən çox olan seqmentləri müəyyən et.
SELECT
    c.segment,
    COUNT(l.loan_id)                    AS loans_count,
    ROUND(SUM(l.loan_amount), 2)       AS segment_total
FROM loans l
JOIN clients c ON c.client_id = l.client_id
GROUP BY c.segment
HAVING SUM(l.loan_amount) > 40000
ORDER BY segment_total DESC;


-- Kreditləri statuslarına (Active, Closed, Overdue, Default) görə qruplaşdır və say/məbləğ bölgüsünü göstər.
SELECT
    status,
    COUNT(*)                            AS loans_count,
    ROUND(SUM(loan_amount), 2)         AS total_amount
FROM loans
GROUP BY status
ORDER BY total_amount DESC;


-- Hər kredit mütəxəssisi (loan officer) üzrə verdiyi  kreditlərin sayını və ümumi məbləğini hesabla.
-- Məqsəd: Kredit mütəxəssislərinin iş yükünü və performansını müqayisə etmək, ən çox kredit məhsulu satan əməkdaşı  müəyyən etmək 
SELECT
   o.officer_name,
    o.branch,
    COUNT(l.loan_id)                    AS verilen_kredit_sayi,
    ROUND(SUM(l.loan_amount), 2)       AS verilen_kredit_mebleqi
FROM loans l
JOIN loan_officers o ON o.officer_id = l.officer_id
GROUP BY o.officer_name, o.branch
ORDER BY verilen_kredit_mebleqi DESC;

-- ------------------------------------------------------------------
-- 3. WINDOW (ANALYTIC) FUNKSİYALAR
-- ------------------------------------------------------------------

-- Müştəriləri aldıqları ümumi kredit məbləğinə görə sırala.
-- (Ən böyük borcalanlar)
SELECT
    c.company_name,
    c.segment,
    ROUND(SUM(l.loan_amount), 2)                            AS total_borrowed,
    RANK() OVER (
        ORDER BY SUM(l.loan_amount) DESC
    )                                                        AS borrower_rank
FROM clients c
JOIN loans l ON l.client_id = c.client_id
GROUP BY c.company_name, c.segment
ORDER BY borrower_rank;


-- Vaxt üzrə kredit portfelinin (bu ana qədər verilmiş bütün kreditlərin cəmi, kumulyativ məbləğ) necə artdığını hesabla.
SELECT
    loan_id,
    issue_date,
    loan_amount,
    ROUND(SUM(loan_amount)
        OVER (ORDER BY issue_date, loan_id), 2)               AS bu_ana_qeder_umumi_mebleq
FROM loans
ORDER BY issue_date, loan_id;


-- Hər ayda verilmiş kreditlərin məbləğini əvvəlki ayla müqayisə et (artıb, yoxsa azalıb).
SELECT
    TRUNC(issue_date, 'MM')                                              AS ay,
    ROUND(SUM(loan_amount), 2)                                          AS bu_ay_verilen_kredit,
    ROUND(LAG(SUM(loan_amount))
        OVER (ORDER BY TRUNC(issue_date, 'MM')), 2)                     AS evvelki_ay_verilen_kredit,
    ROUND(SUM(loan_amount)
        - LAG(SUM(loan_amount))
            OVER (ORDER BY TRUNC(issue_date, 'MM')), 2)                 AS ferq
FROM loans
GROUP BY TRUNC(issue_date, 'MM')
ORDER BY ay;


-- Hər sahibkar seqmentində ən böyük krediti alan müştərini tap. (Top-1 per segment)
SELECT segment, company_name, total_borrowed
FROM (
    SELECT
        c.segment,
        c.company_name,
        SUM(l.loan_amount)                             AS total_borrowed,
        ROW_NUMBER() OVER (
            PARTITION BY c.segment
            ORDER BY SUM(l.loan_amount) DESC
        )                                               AS rn
    FROM clients c
    JOIN loans l ON l.client_id = c.client_id
    GROUP BY c.segment, c.company_name
)
WHERE rn = 1
ORDER BY segment;


-- ------------------------------------------------------------------
-- 4. CTE (COMMON TABLE EXPRESSION) - WITH ... AS
-- ------------------------------------------------------------------

-- Hər kredit üzrə ödənilmiş məbləği və geri qalan (ödənilməmiş)  borcu hesabla.
WITH loan_repayments AS (
    SELECT
        l.loan_id,
        l.loan_amount,
        NVL(SUM(p.amount_paid), 0) AS total_paid
    FROM loans l
    LEFT JOIN loan_payments p ON p.loan_id = l.loan_id
    GROUP BY l.loan_id, l.loan_amount
)
SELECT
    loan_id,
    loan_amount,
    total_paid,
    loan_amount - total_paid AS outstanding_balance
FROM loan_repayments
ORDER BY outstanding_balance DESC;


-- Birdən çox aktiv/keçmiş krediti olan (təkrar müraciət edən) müştəriləri tap.
WITH client_loan_counts AS (
    SELECT
        client_id,
        COUNT(*) AS loan_count
    FROM loans
    GROUP BY client_id
)
SELECT
    c.company_name,
    c.segment,
    clc.loan_count
FROM client_loan_counts clc
JOIN clients c ON c.client_id = clc.client_id
WHERE clc.loan_count > 1
ORDER BY clc.loan_count DESC;


-- ------------------------------------------------------------------
-- 5. SUBQUERY
-- ------------------------------------------------------------------

-- Ortalama kredit məbləğindən böyük olan kreditləri tap. (potensial yüksək-riskli, iri kreditlər)
SELECT
    loan_id,
    client_id,
    loan_amount,
    status
FROM loans
WHERE loan_amount > (
    SELECT AVG(loan_amount) FROM loans
)
ORDER BY loan_amount DESC;


-- Heç bir ödəniş edilməmiş kreditləri tap. 
SELECT
    l.loan_id,
    c.company_name,
    l.loan_amount,
    l.status
FROM loans l
JOIN clients c ON c.client_id = l.client_id
WHERE l.loan_id NOT IN (
    SELECT DISTINCT loan_id FROM loan_payments
);
