# SME Business Loans Analytics — Oracle SQL

Kiçik/Orta Sahibkarlıq (SME) biznes kreditləri üzrə bank/maliyyə institutunun portfel analitikası layihəsi. Oracle SQL üzərində aggregate funksiyalar, `GROUP BY`/`HAVING`, window (analytic) funksiyalar, CTE (`WITH ... AS`) və subquery istifadə olunub.

Layihə tamamilə SQL sorğularından ibarətdir (heç bir tətbiq kodu, Python və s. yoxdur).

## Ssenari

Kiçik və orta sahibkarlara (SME) biznes krediti verən bir maliyyə institutu üçün müştəri (borcalan), kredit məhsulu, kredit mütəxəssisi (loan officer) və ödəniş datası əsasında aşağıdakı biznes analitiki suallarına cavab axtarılır:

- Ümumi kredit portfeli və orta kredit məbləği nə qədərdir?
- Hansı sahibkar seqmenti (Mikro sahibkar / Kiçik-Orta sahibkar) ən çox kredit alıb?
- Kreditlər status üzrə (Active / Closed / Overdue / Default) necə bölünür?
- Aylar üzrə kredit emissiyası necə dəyişir — hansı ay əvvəlkindən çoxdur?
- Ən böyük borcalanlar kimlərdir, hər sahibkar seqmentində lider kimdir?
- Hər kreditin ödənilmiş/qalıq borcu nə qədərdir?
- Təkrar müraciət edən (birdən çox krediti olan) müştərilər kimlərdir?
- Ortadan yüksək məbləğli və heç ödəniş edilməmiş (potensial risk) kreditlər hansılardır?

## Struktur

```
sme-sql-analytics/
├── schema/
│   └── 01_create_tables.sql       -- Cədvəllərin yaradılması (DDL)
├── data/
│   └── 02_insert_data.sql         -- Test datası (DML)
├── queries/
│   └── 03_analytics_queries.sql   -- Bütün analitik sorğular (aggregate, group by/having,
│                                      window functions, CTE, subquery)
├── run_all.sql                    -- Bütün faylları sıra ilə işə salır
├── RESULTS.md                     -- Sorğu nəticələrindən çıxan biznes yekunları
└── README.md
```

## Verilənlər bazası modeli (ER)

```
clients ───< loans >─── loan_officers
                │
                ├──── credit_products
                │
                └──< loan_payments
```

- **clients** — kredit alan SME şirkətləri (sahibkar seqmenti: Mikro sahibkar / Kiçik-Orta sahibkar, şəhər)
- **loan_officers** — kredit mütəxəssisləri (filial üzrə)
- **credit_products** — kredit məhsulları (Dövriyyə vəsaiti, Avadanlıq, Overdraft, Ticarət maliyyələşməsi) və faiz dərəcələri
- **loans** — verilmiş kreditlər (məbləğ, tarix, müddət, status)
- **loan_payments** — kreditlər üzrə edilmiş ödənişlər

## İstifadə olunan SQL texnikaları

Bütün sorğular `queries/03_analytics_queries.sql` faylındadır, bölmələr üzrə (aşağıdakı sıra ilə) ayrılıb:

| Texnika | Nümunə |
|---|---|
| Aggregate funksiyalar | `SUM`, `AVG`, `COUNT`, `MIN`, `MAX` |
| Group by / Having | sahibkar seqmenti, status və ay üzrə qruplaşdırma |
| Window funksiyalar | `RANK() OVER`, `ROW_NUMBER() OVER`, `SUM() OVER`, `LAG() OVER` |
| CTE | `WITH loan_repayments AS (...)` |
| Subquery | `WHERE ... > (SELECT AVG...)`, `NOT IN` |

## İşə salınma qaydası

Oracle mühitində (SQL*Plus, SQLcl və ya SQL Developer):

```sql
@run_all.sql
```

və ya faylları ayrı-ayrılıqda, göstərilən sıra ilə (`schema` → `data` → `queries`) icra edə bilərsiniz.

## Qeyd

Layihə orta səviyyədə saxlanılıb — məqsəd əsas analitik SQL bacarıqlarını (aggregate, group by, window functions, CTE, subquery) real biznes kredit portfeli kontekstində nümayiş etdirməkdir. `MODEL` clause, `PIVOT`/`UNPIVOT`, recursive CTE kimi çox mürəkkəb texnikalar qəsdən istifadə olunmayıb.
