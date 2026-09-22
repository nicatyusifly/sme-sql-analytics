/*
==================================================================
  TEST DATASI (INSERT)
==================================================================
*/

INSERT INTO clients VALUES (1, 'Skyline Builders LLC',    'Kiçik-Orta sahibkar', 'Baki',     DATE '2019-03-10');
INSERT INTO clients VALUES (2, 'Green Bean Cafe',          'Mikro sahibkar',      'Baki',     DATE '2021-06-15');
INSERT INTO clients VALUES (3, 'NovaByte Solutions',       'Kiçik-Orta sahibkar', 'Baki',     DATE '2020-01-22');
INSERT INTO clients VALUES (4, 'Harvest Fields Farm',      'Mikro sahibkar',      'Gence',    DATE '2018-09-05');
INSERT INTO clients VALUES (5, 'Olive Trade Co',           'Kiçik-Orta sahibkar', 'Sumqayit', DATE '2017-11-30');
INSERT INTO clients VALUES (6, 'IronWorks Manufacturing',  'Kiçik-Orta sahibkar', 'Baki',     DATE '2015-04-18');
INSERT INTO clients VALUES (7, 'Coastline Textiles',       'Kiçik-Orta sahibkar', 'Sumqayit', DATE '2019-08-12');
INSERT INTO clients VALUES (8, 'Friendly Corner Market',   'Mikro sahibkar',      'Baki',     DATE '2022-02-01');

INSERT INTO loan_officers VALUES (1, 'Elvin Aliyev',    'Baki filiali');
INSERT INTO loan_officers VALUES (2, 'Leyla Ibrahimova','Baki filiali');
INSERT INTO loan_officers VALUES (3, 'Kamran Rzayev',   'Sumqayit filiali');

INSERT INTO credit_products VALUES (1, 'Dovriyye Vesaiti Krediti', 'Dövriyyə vəsaiti',       16.50);
INSERT INTO credit_products VALUES (2, 'Avadanlıq Lizinqi',        'Avadanlıq',               14.00);
INSERT INTO credit_products VALUES (3, 'Overdraft',                'Overdraft',               19.00);
INSERT INTO credit_products VALUES (4, 'Ticaret Maliyyelesmesi',   'Ticarət maliyyələşməsi',  15.00);

INSERT INTO loans VALUES (1001, 1, 1, 2, 45000.00,  DATE '2025-08-10', 24, 'Active');
INSERT INTO loans VALUES (1002, 2, 2, 1, 8000.00,   DATE '2025-09-05', 12, 'Active');
INSERT INTO loans VALUES (1003, 3, 1, 1, 20000.00,  DATE '2025-10-01', 18, 'Active');
INSERT INTO loans VALUES (1004, 4, 3, 4, 12000.00,  DATE '2025-10-20', 12, 'Overdue');
INSERT INTO loans VALUES (1005, 5, 2, 3, 15000.00,  DATE '2025-11-02', 6,  'Active');
INSERT INTO loans VALUES (1006, 6, 1, 2, 90000.00,  DATE '2025-11-15', 36, 'Active');
INSERT INTO loans VALUES (1007, 1, 1, 1, 25000.00,  DATE '2025-12-01', 12, 'Active');
INSERT INTO loans VALUES (1008, 7, 3, 4, 30000.00,  DATE '2025-12-18', 18, 'Active');
INSERT INTO loans VALUES (1009, 8, 2, 3, 5000.00,   DATE '2026-01-10', 6,  'Default');
INSERT INTO loans VALUES (1010, 3, 1, 2, 40000.00,  DATE '2026-01-25', 24, 'Active');
INSERT INTO loans VALUES (1011, 6, 1, 1, 35000.00,  DATE '2026-02-05', 12, 'Active');
INSERT INTO loans VALUES (1012, 5, 2, 1, 10000.00,  DATE '2026-02-20', 12, 'Closed');

INSERT INTO loan_payments VALUES (1, 1001, DATE '2025-09-10', 2200.00);
INSERT INTO loan_payments VALUES (2, 1001, DATE '2025-10-10', 2200.00);
INSERT INTO loan_payments VALUES (3, 1002, DATE '2025-10-05', 750.00);
INSERT INTO loan_payments VALUES (4, 1003, DATE '2025-11-01', 1300.00);
INSERT INTO loan_payments VALUES (5, 1003, DATE '2025-12-01', 1300.00);
INSERT INTO loan_payments VALUES (6, 1005, DATE '2025-12-02', 2700.00);
INSERT INTO loan_payments VALUES (7, 1006, DATE '2025-12-15', 3000.00);
INSERT INTO loan_payments VALUES (8, 1007, DATE '2026-01-01', 2300.00);
INSERT INTO loan_payments VALUES (9, 1008, DATE '2026-01-18', 1900.00);
INSERT INTO loan_payments VALUES (10, 1010, DATE '2026-02-25', 1900.00);
INSERT INTO loan_payments VALUES (11, 1011, DATE '2026-03-05', 3200.00);
INSERT INTO loan_payments VALUES (12, 1012, DATE '2026-03-20', 10000.00);

COMMIT;
