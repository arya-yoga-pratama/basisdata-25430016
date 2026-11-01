-- =====================================================================
-- p07_kueri_25430016.sql
-- Milestone Proyek 7 - Kueri satu tabel Perpustakaan Lentera AYP
-- NPM : 25430016  (P = 8 -> maks. 10 eksemplar/transaksi, denda Rp8.000/hari)
-- DB  : perpus_016 (dibuat oleh p05_ddl_25430016.sql, diisi oleh p06_data_25430016.sql)
--
-- Prasyarat: jalankan p05_ddl lalu p06_data pada basis data kosong.
-- Seluruh "hasil diharapkan" di bawah dihitung dari data p06 apa adanya.
-- Skenario p06_uji memakai ROLLBACK, jadi tidak mengubah data ini.
--
-- Isi: 13 kueri, semuanya SATU TABEL (tanpa JOIN dan tanpa agregasi).
-- Operator/fungsi yang dipakai:
--   LIKE          : Q02, Q05, Q07
--   BETWEEN       : Q11, Q12
--   IN            : Q04, Q12
--   IS NULL       : Q06
--   CASE          : Q03, Q09
--   Fungsi tanggal: DATEDIFF (Q09), DATE_FORMAT (Q11)
--   Fungsi string : CONCAT, LEFT, RIGHT (Q02), UPPER (Q05)
--
-- Tanggal acuan laporan : 2026-11-01 (tanggal pengerjaan milestone ini).
-- Ditulis sebagai literal supaya hasilnya tetap sama bila dijalankan
-- di hari lain. Untuk laporan "hari ini" ganti '2026-11-01' dengan CURDATE().
--
-- ---------------------------------------------------------------------
-- PETA KI  (apakah bisa dijawab dengan SATU tabel?)
-- ---------------------------------------------------------------------
--  KI-01 Daftar anggota aktif ............ BISA satu tabel (anggota)   -> Q01-Q03
--  KI-02 Katalog dan ketersediaan buku ... BELUM satu tabel            -> Q04-Q07 (sebagian)
--        judul_buku ada di buku, status_eksemplar ada di eksemplar.
--        Menampilkan keduanya sekaligus butuh JOIN.
--  KI-03 Riwayat peminjaman anggota ...... BELUM satu tabel            -> Q10 (sebagian)
--        nama_anggota ada di anggota, id_eksemplar ada di detail_peminjaman.
--  KI-04 Peminjaman yang berlangsung ..... BELUM satu tabel            -> Q08 (sebagian)
--        nama_anggota (anggota) dan id_eksemplar (detail_peminjaman).
--  KI-05 Pengembalian periode tertentu ... BISA satu tabel (pengembalian) -> Q11-Q12
--  KI-06 Peminjaman terlambat ............ BELUM satu tabel            -> Q09 (sebagian)
--        butuh peminjaman + pengembalian + anggota. Yang belum dikembalikan
--        butuh LEFT JOIN (tanggal_pengembalian kosong = belum kembali).
--  KI-07 Rekapitulasi denda .............. BISA satu tabel (denda)     -> Q13
--        Q13 menampilkan baris dendanya. Rekap jumlah dan total nominal
--        per status membutuhkan agregasi (GROUP BY), dibahas setelah
--        materi agregasi.
--  KI-08 Buku paling banyak dipinjam ..... BELUM satu tabel            -> tidak ada kueri
--        judul_buku butuh JOIN detail_peminjaman - eksemplar - buku,
--        ditambah agregasi. Dijawab penuh pada Pertemuan 9-12.
--
-- KI yang BELUM bisa satu tabel (KI-02, 03, 04, 06, 08) dijawab penuh
-- pada Pertemuan 9-12 memakai JOIN. Kueri sebagian di bawah hanya
-- mengambil porsi yang masih berada dalam satu tabel.
-- =====================================================================

USE perpus_016;

-- =====================================================================
-- BAGIAN A - KI-01 Daftar anggota aktif  (tabel: anggota)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Q01 | KI-01 | BISA satu tabel
-- Pertanyaan : Siapa saja anggota yang berstatus Aktif, lengkap dengan
--              nomor HP-nya, supaya petugas bisa menghubungi mereka?
-- Hasil diharapkan: 10 baris, A001 s.d. A010, semua status_anggota = Aktif.
--              Baris pertama: A001 | Andi Pratama | 081234567890 | Aktif.
--              A011 dan A012 (Tidak Aktif) tidak muncul.
-- ---------------------------------------------------------------------
SELECT nomor_anggota, nama_anggota, no_hp_anggota, status_anggota
FROM anggota
WHERE status_anggota = 'Aktif'
ORDER BY nomor_anggota;

-- ---------------------------------------------------------------------
-- Q02 | KI-01 | BISA satu tabel | LIKE + fungsi string (CONCAT, LEFT, RIGHT)
-- Pertanyaan : Anggota aktif mana yang namanya mengandung "Dewi"?
--              Tampilkan nomor HP yang disamarkan karena data pribadi
--              dibatasi (p02 bagian 9.4).
-- Hasil diharapkan: 2 baris.
--              A004 | Dewi Kartika Sari   | 0821****012
--              A008 | Intan Permata Dewi  | 0823****265
-- ---------------------------------------------------------------------
SELECT nomor_anggota,
       nama_anggota,
       CONCAT(LEFT(no_hp_anggota, 4), '****', RIGHT(no_hp_anggota, 3)) AS no_hp_samar
FROM anggota
WHERE status_anggota = 'Aktif'
  AND nama_anggota LIKE '%Dewi%'
ORDER BY nomor_anggota;

-- ---------------------------------------------------------------------
-- Q03 | KI-01 | BISA satu tabel | CASE
-- Pertanyaan : Dari seluruh anggota, siapa yang boleh meminjam dan siapa
--              yang tidak? (aturan AB-02: hanya anggota Aktif yang boleh)
-- Hasil diharapkan: 12 baris.
--              A001 s.d. A010 -> 'Boleh meminjam'
--              A011 dan A012  -> 'Tidak boleh meminjam'
-- ---------------------------------------------------------------------
SELECT nomor_anggota,
       nama_anggota,
       status_anggota,
       CASE
           WHEN status_anggota = 'Aktif' THEN 'Boleh meminjam'
           ELSE 'Tidak boleh meminjam'
       END AS hak_pinjam
FROM anggota
ORDER BY nomor_anggota;

-- =====================================================================
-- BAGIAN B - KI-02 Katalog dan ketersediaan buku  (tabel: buku, eksemplar)
-- KI-02 BELUM bisa dijawab satu tabel -> dijawab penuh di Pertemuan 9-12.
-- Q04-Q06 mengambil sisi katalog (buku), Q07 sisi ketersediaan (eksemplar).
-- =====================================================================

-- ---------------------------------------------------------------------
-- Q04 | KI-02 (sebagian, sisi katalog) | IN
-- Pertanyaan : Buku apa saja yang masuk kategori Pemrograman, Basis Data,
--              atau Jaringan?
-- Hasil diharapkan: 4 baris, urut judul:
--              B002 | Basis Data untuk Pemula       | Ratna Kusuma   | Basis Data
--              B001 | Dasar Pemrograman             | Budi Santoso   | Pemrograman
--              B004 | Jaringan Komputer Praktis     | Hendri Gunawan | Jaringan
--              B003 | Struktur Data dan Algoritma   | Agus Wibowo    | Pemrograman
-- ---------------------------------------------------------------------
SELECT id_buku, isbn_buku, judul_buku, penulis_buku, kategori_buku
FROM buku
WHERE kategori_buku IN ('Pemrograman', 'Basis Data', 'Jaringan')
ORDER BY judul_buku;

-- ---------------------------------------------------------------------
-- Q05 | KI-02 (sebagian, sisi katalog) | LIKE + fungsi string (UPPER)
-- Pertanyaan : Buku mana yang judulnya mengandung kata "Data"?
--              Tampilkan juga judulnya dalam huruf kapital.
-- Hasil diharapkan: 2 baris.
--              B002 | Basis Data untuk Pemula      | BASIS DATA UNTUK PEMULA
--              B003 | Struktur Data dan Algoritma  | STRUKTUR DATA DAN ALGORITMA
-- ---------------------------------------------------------------------
SELECT id_buku, judul_buku, UPPER(judul_buku) AS judul_kapital
FROM buku
WHERE judul_buku LIKE '%Data%'
ORDER BY id_buku;

-- ---------------------------------------------------------------------
-- Q06 | KI-02 (sebagian, pemeriksaan kualitas data) | IS NULL
-- Pertanyaan : Apakah ada judul buku yang ISBN-nya belum diisi?
--              (isbn_buku boleh kosong, kamus data no. 9: "jika tersedia")
-- Hasil diharapkan: 0 baris (hanya header kolom, tanpa data).
--              Ini hasil BENAR, bukan galat: ke-12 buku sudah punya ISBN.
-- ---------------------------------------------------------------------
SELECT id_buku, judul_buku
FROM buku
WHERE isbn_buku IS NULL;

-- ---------------------------------------------------------------------
-- Q07 | KI-02 (sebagian, sisi ketersediaan) | LIKE
-- Pertanyaan : Eksemplar apa saja yang tersedia di deretan Rak A?
-- Hasil diharapkan: 4 baris, urut lokasi.
--              E006 | EKS-B006-001 | Rak A-02 | Tersedia
--              E018 | EKS-B006-002 | Rak A-03 | Tersedia
--              E042 | EKS-B006-004 | Rak A-05 | Tersedia
--              E048 | EKS-B012-004 | Rak A-05 | Tersedia
-- ---------------------------------------------------------------------
SELECT id_eksemplar, kode_eksemplar, lokasi_eksemplar, status_eksemplar
FROM eksemplar
WHERE status_eksemplar = 'Tersedia'
  AND lokasi_eksemplar LIKE 'Rak A-%'
ORDER BY lokasi_eksemplar, id_eksemplar;

-- =====================================================================
-- BAGIAN C - KI-04, KI-06, KI-03  (tabel: peminjaman)
-- Ketiganya BELUM bisa dijawab satu tabel -> Pertemuan 9-12.
-- =====================================================================

-- ---------------------------------------------------------------------
-- Q08 | KI-04 (sebagian) | BELUM satu tabel utuh
-- Pertanyaan : Transaksi peminjaman mana yang masih berlangsung?
-- Catatan    : nama_anggota (tabel anggota) dan id_eksemplar (tabel
--              detail_peminjaman) belum bisa ditampilkan tanpa JOIN.
-- Hasil diharapkan: 41 baris, urut jatuh tempo lalu id.
--              Baris pertama: PJM-20261005-002 | A007 | 2026-10-05 | 2026-10-12 | Berlangsung
--              Baris terakhir: PJM-20261026-010 | A005 | 2026-10-26 | 2026-11-02 | Berlangsung
--              (80 transaksi total = 41 Berlangsung + 39 Selesai)
-- ---------------------------------------------------------------------
SELECT id_peminjaman, nomor_anggota, tanggal_pinjam, tanggal_jatuh_tempo, status_peminjaman
FROM peminjaman
WHERE status_peminjaman = 'Berlangsung'
ORDER BY tanggal_jatuh_tempo, id_peminjaman;

-- ---------------------------------------------------------------------
-- Q09 | KI-06 (sebagian) | BELUM satu tabel utuh | fungsi tanggal (DATEDIFF) + CASE
-- Pertanyaan : Dari transaksi yang masih berlangsung, mana yang sudah
--              lewat jatuh tempo per 2026-11-01, dan sudah lewat berapa hari?
-- Catatan    : Ini hanya tingkat transaksi. Satu transaksi berstatus
--              Berlangsung bisa saja sudah sebagian dikembalikan. Daftar
--              keterlambatan per eksemplar (termasuk yang sudah kembali
--              terlambat) butuh JOIN peminjaman - pengembalian - anggota.
-- Hasil diharapkan: 41 baris, urut selisih_hari terbesar.
--              32 baris berketerangan 'Terlambat'
--              9 baris berketerangan 'Masih dalam masa pinjam' (jatuh tempo 2026-11-02)
--              Baris pertama: PJM-20261005-002 | A007 | 2026-10-12 | 20 | Terlambat
-- ---------------------------------------------------------------------
SELECT id_peminjaman,
       nomor_anggota,
       tanggal_jatuh_tempo,
       DATEDIFF('2026-11-01', tanggal_jatuh_tempo) AS selisih_hari,
       CASE
           WHEN DATEDIFF('2026-11-01', tanggal_jatuh_tempo) > 0 THEN 'Terlambat'
           WHEN DATEDIFF('2026-11-01', tanggal_jatuh_tempo) = 0 THEN 'Jatuh tempo hari ini'
           ELSE 'Masih dalam masa pinjam'
       END AS keterangan
FROM peminjaman
WHERE status_peminjaman = 'Berlangsung'
ORDER BY selisih_hari DESC, id_peminjaman;

-- ---------------------------------------------------------------------
-- Q10 | KI-03 (sebagian) | BELUM satu tabel utuh
-- Pertanyaan : Apa saja riwayat transaksi peminjaman anggota A007?
-- Catatan    : nama_anggota dan id_eksemplar butuh JOIN (Pertemuan 9-12).
-- Hasil diharapkan: 13 baris, urut tanggal pinjam lalu id.
--              Baris pertama: PJM-20261005-002 | A007 | 2026-10-05 | 2026-10-12 | Berlangsung
--              Baris terakhir: PJM-20261022-010 | A007 | 2026-10-22 | 2026-10-29 | Berlangsung
--              Rincian status: 7 Berlangsung, 6 Selesai.
-- ---------------------------------------------------------------------
SELECT id_peminjaman, nomor_anggota, tanggal_pinjam, tanggal_jatuh_tempo, status_peminjaman
FROM peminjaman
WHERE nomor_anggota = 'A007'
ORDER BY tanggal_pinjam, id_peminjaman;

-- =====================================================================
-- BAGIAN D - KI-05 Pengembalian dalam periode tertentu  (tabel: pengembalian)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Q11 | KI-05 | BISA satu tabel | BETWEEN + fungsi tanggal (DATE_FORMAT)
-- Pertanyaan : Pengembalian apa saja yang tercatat dari 14 sampai 20 Oktober 2026?
--              Tampilkan tanggalnya dalam format hari-bulan-tahun.
-- Catatan    : tanggal_pengembalian bertipe DATE, jadi BETWEEN sudah
--              mencakup tanggal akhir (20 Oktober ikut terhitung).
-- Hasil diharapkan: 24 baris, urut tanggal lalu id.
--              Baris pertama: RET-20261014-001 | PJM-20261005-001 | E001 | 14-10-2026
--              Baris terakhir: RET-20261020-004 | PJM-20261013-003 | E030 | 20-10-2026
--              Rincian per tanggal: 14 Okt = 5, 15 = 1, 16 = 4, 17 = 1,
--              18 = 5, 19 = 4, 20 = 4.
-- ---------------------------------------------------------------------
SELECT id_pengembalian,
       id_peminjaman,
       id_eksemplar,
       DATE_FORMAT(tanggal_pengembalian, '%d-%m-%Y') AS tgl_kembali
FROM pengembalian
WHERE tanggal_pengembalian BETWEEN '2026-10-14' AND '2026-10-20'
ORDER BY tanggal_pengembalian, id_pengembalian;

-- ---------------------------------------------------------------------
-- Q12 | KI-05 | BISA satu tabel | IN + BETWEEN
-- Pertanyaan : Pengembalian apa saja yang ditangani petugas PT003 atau PT006
--              pada 12 sampai 18 Oktober 2026?
-- Catatan    : id_petugas dipakai sebagai filter tambahan di atas KI-05.
-- Hasil diharapkan: 10 baris, urut id.
--              Baris pertama: RET-20261012-002 | PJM-20261006-007 | E030 | PT003 | 2026-10-12
--              Baris terakhir: RET-20261018-005 | PJM-20261013-004 | E006 | PT006 | 2026-10-18
-- ---------------------------------------------------------------------
SELECT id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian
FROM pengembalian
WHERE id_petugas IN ('PT003', 'PT006')
  AND tanggal_pengembalian BETWEEN '2026-10-12' AND '2026-10-18'
ORDER BY id_pengembalian;

-- =====================================================================
-- BAGIAN E - KI-07 Rekapitulasi denda  (tabel: denda)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Q13 | KI-07 | BISA satu tabel
-- Pertanyaan : Denda mana yang belum dibayar?
-- Hasil diharapkan: 10 baris, urut id_denda.
--              D001 (2 hari, 16000), D003 (2, 16000), D006 (6, 48000),
--              D009 (3, 24000), D012 (6, 48000), D013 (6, 48000),
--              D014 (6, 48000), D015 (2, 16000), D016 (2, 16000),
--              D017 (3, 24000). Semua status_bayar = Belum Dibayar.
-- ---------------------------------------------------------------------
SELECT id_denda, id_pengembalian, hari_terlambat, nominal_denda, status_bayar
FROM denda
WHERE status_bayar = 'Belum Dibayar'
ORDER BY id_denda;
