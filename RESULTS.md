# Nəticələr / Biznes Analitikası Yekunları

Bu fayl `queries/03_analytics_queries.sql`-dəki sorğuların `data/02_insert_data.sql`-dəki test datası üzərində icrasından alınan nəticələri və onlardan çıxan biznes yekunlarını əks etdirir.

## 1. Ümumi portfel

Cəmi 12 kredit verilib, ümumi portfel **335 000 AZN**, orta kredit məbləği **~27 917 AZN**. İlk kredit 2025-08-10, sonuncusu 2026-02-20 tarixlidir

## 2. Sahibkar seqmenti üzrə bölgü

| Seqment | Kredit sayı | Məbləğ |
|---|---|---|
| Kiçik-Orta sahibkar | 9 | 310 000 AZN (~93%) |
| Mikro sahibkar | 3 | 25 000 AZN (~7%) |

**Nəticə:** Portfel demək olar tamamilə Kiçik-Orta sahibkar seqmentinə söykənir. Mikro sahibkarlara verilən kreditlər həm say, həm məbləğ baxımından çox kiçikdir

## 3. Status bölgüsü

| Status | Kredit sayı | Məbləğ |
|---|---|---|
| Active | 9 | 308 000 AZN |
| Overdue | 1 | 12 000 AZN |
| Default | 1 | 5 000 AZN |
| Closed | 1 | 10 000 AZN |

**Nəticə:** Problemli kreditlər (Overdue + Default) portfelin cəmi ~5%-ni təşkil edir — nisbətən sağlam görünür. Amma hər iki problemli kredit Mikro sahibkar seqmentinə aiddir.



## 4. Ən böyük borcalanlar / seqment liderləri

- **Rank-1:** IronWorks Manufacturing — 125 000 AZN (2 kredit)
- **Rank-2:** Skyline Builders LLC — 70 000 AZN
- Mikro seqmentdə lider: Harvest Fields Farm — 12 000 AZN

**Nəticə:** Portfelin ~37%-i (125 000 / 335 000) tək bir müştəriyə aiddir. Bu müştərinin ödəmə qabiliyyəti xüsusi izlənməlidir.

## 5. Ödənilməmiş qalıq (CTE)

Ən yüksək qalıq borc — IronWorks Manufacturing-in krediti (87 000 AZN ödənilməyib). Yalnız bir kredit (1012, Olive Trade Co) tam bağlanıb (qalıq = 0).


## 6. Təkrar müraciət edən müştərilər

Birdən çox kredit alan 4 müştəri: Skyline Builders LLC, NovaByte Solutions, Olive Trade Co, IronWorks Manufacturing — hamısı Kiçik-Orta sahibkar seqmentindəndir.

**Nəticə:** Mikro sahibkarlar hələ "təkrar müştəri"yə çevrilməyib

## 7. Risk siqnalları (subquery)

Ortalamadan yüksək (>27 917 AZN) 5 kredit var, cəmi 240 000 AZN (portfelin ~72%-i). Heç ödəniş edilməmiş 2 kredit var: Harvest Fields Farm (Overdue) və Friendly Corner Market (Default) — hər ikisi Mikro sahibkar seqmentindədir.

**Ən önəmli nəticə:** Portfel həcmi Kiçik-Orta sahibkarlara söykənsə də, risk (ödəməmə) Mikro sahibkar seqmentində cəmləşib.
---

## Ümumi yekun

1. Portfel konsentrasiyası yüksəkdir — az sayda iri müştəri (xüsusən IronWorks Manufacturing) portfelin böyük hissəsini təşkil edir.
2. Risk profili seqmentlər arasında fərqlidir: Kiçik-Orta sahibkarlar böyük məbləğli, lakin nisbətən stabil; Mikro sahibkarlar kiçik məbləğli, lakin nisbətən riskli.
3. Mikro sahibkar seqmentində təkrar müraciət yoxdur — bu, ya məhsulun onlar üçün uyğun olmaması, ya da ilkin təcrübənin mənfi olması ilə bağlı ola bilər.
