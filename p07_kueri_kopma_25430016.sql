-- =====================================================================
-- p07_kueri_kopma_25430016.sql
-- Modul 7: Menjawab Pertanyaan dengan SELECT dan Fungsi Skalar
-- Studi kasus : Kopma         NPM : 25430016       Database : kopma_016
-- =====================================================================

USE kopma_016;

-- =====================================================================
-- D.1  PROYEKSI DAN PENYARINGAN
-- =====================================================================

-- [Q01] D.1-1 | KI-03
-- Tanya   : Barang apa yang stoknya sudah di bawah batas minimum?
-- Harapan : 1 baris -> MKN-001 | Roti Cokelat | stok 3 | minimum 10 | kurang 7
--           (stok roti 6 pada Modul 6 berkurang 3 oleh nota penjualan sampel)
-- Nyata   : 1 baris, yaitu MKN-001 (Roti Cokelat).
--           stok_barang = 3, stok_min_barang = 10, kurang = 7.
SELECT kode_barang, nama_barang, stok_barang, stok_min_barang,
       stok_min_barang - stok_barang AS kurang
FROM barang
WHERE stok_barang < stok_min_barang
ORDER BY kurang DESC;

-- [Q02] D.1-2a (operator IN)
-- Tanya   : Barang apa saja yang kategorinya ATK atau minuman?
-- Harapan : 6 baris. Urutan: ATK (Buku Tulis 58, Map Plastik Folio, Penghapus Putih,
--           Pulpen Gel 0.5) lalu minuman (Air Mineral 600, Teh Kotak 350).
-- Nyata   : 6 baris, yaitu:
--           ATK-002 Buku Tulis 58
--           ATK-004 Map Plastik Folio
--           ATK-003 Penghapus Putih
--           ATK-001 Pulpen Gel 0.5
--           MNM-001 Air Mineral 600
--           MNM-002 Teh Kotak 350.
SELECT kode_barang, nama_barang, kategori_barang, harga_jual_barang
FROM barang
WHERE kategori_barang IN ('ATK', 'minuman')
ORDER BY kategori_barang, nama_barang;

-- [Q03] D.1-2b (operator BETWEEN)
-- Tanya   : Nota apa saja yang terjadi pada 23 sampai 24 September 2026?
-- Harapan : 4 baris urut waktu -> PJ-2609-0140 (23/9 08:55), PJ-2609-0141 (23/9 14:20),
--           PJ-2609-0142 (24/9 10:15), PJ-2609-0143 (24/9 15:30).
--           Jam akhir ditulis eksplisit karena tgl_penjualan bertipe DATETIME.
-- Nyata   : 4 baris, yaitu:
--           PJ-2609-0140 | 2026-09-23 08:55:00
--           PJ-2609-0141 | 2026-09-23 14:20:00
--           PJ-2609-0142 | 2026-09-24 10:15:00
--           PJ-2609-0143 | 2026-09-24 15:30:00.
SELECT no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan
FROM penjualan
WHERE tgl_penjualan BETWEEN '2026-09-23 00:00:00' AND '2026-09-24 23:59:59'
ORDER BY tgl_penjualan;

-- [Q04] D.1-2c (operator IS NULL)
-- Tanya   : Anggota mana yang belum punya nomor HP?
-- Harapan : 2 baris -> A-0087 Fikri Ramadhan, A-0103 Rangga Mahendra.
-- Nyata   : 2 baris, yaitu:
--           A-0087 | Fikri Ramadhan | no_hp_anggota = NULL
--           A-0103 | Rangga Mahendra | no_hp_anggota = NULL.
SELECT no_anggota, nama_anggota, status_anggota, no_hp_anggota
FROM anggota
WHERE no_hp_anggota IS NULL
ORDER BY no_anggota;

-- ---------------------------------------------------------------------
-- Titik Analisis 1 (D.1): alias kolom tidak dikenal di WHERE
-- ---------------------------------------------------------------------

-- [Q05a] TA-1 | KI-03 | SENGAJA SALAH - jalankan sendiri, lalu catat galatnya
-- Tanya   : Sama dengan Q01, tetapi memakai alias 'kurang' di WHERE.
-- Harapan : GALAT. WHERE dievaluasi sebelum SELECT (Gambar 7.1), sehingga alias
--           'kurang' belum ada -> ERROR 1054 Unknown column 'kurang' in 'where clause'.
-- Nyata   : Galat #1054 - Unknown column 'kurang' in 'where clause'.
-- SELECT kode_barang, nama_barang, stok_barang, stok_min_barang,
--        stok_min_barang - stok_barang AS kurang
-- FROM barang
-- WHERE kurang > 0
-- ORDER BY kurang DESC;

-- [Q05b] TA-1 | KI-03 | perbaikan: ulangi ekspresi di WHERE (tanpa alias)
-- Tanya   : Barang yang kekurangan stok, ditulis tanpa memakai alias di WHERE.
-- Harapan : 1 baris, identik dengan Q01 (MKN-001, kurang 7).
-- Nyata   : 1 baris, yaitu MKN-001 (Roti Cokelat).
--           stok_barang = 3, stok_min_barang = 10, kurang = 7.
--           Hasil sama dengan Q01.
SELECT kode_barang, nama_barang, stok_barang, stok_min_barang,
       stok_min_barang - stok_barang AS kurang
FROM barang
WHERE stok_min_barang - stok_barang > 0
ORDER BY kurang DESC;

-- =====================================================================
-- D.2  POLA TEKS DAN NILAI KOSONG
-- =====================================================================

-- [Q06] D.2-3 (versi persis buku) | fungsi: CONCAT, DATE_FORMAT, IFNULL, CASE, LIKE
-- Tanya   : Anggota yang namanya mengandung huruf 'a', 5 terbaru, dengan label mudah dibaca.
-- Harapan : 5 baris. Perkiraan awal saya urut tanggal daftar terbaru:
--           Putri Ayu Wardani, Rangga Mahendra, Naufal Ardiansyah, Salsabila Nur Aini, Galih Prakoso.
--           Tetapi alias 'tgl_daftar_anggota' bernama sama dengan kolomnya, dan di ORDER BY
--           alias didahulukan daripada kolom. Jika benar, urutannya memakai TEKS 'dd-mm-yyyy',
--           sehingga yang muncul: Rangga, Maharani, Naufal/Salsabila, Fikri.
-- Nyata   : 5 baris. Urutan anggota yang ditampilkan adalah Rangga Mahendra (A-0103), Maharani Septiani (A-0094), Naufal Ardiansyah (A-0101), Salsabila Nur Aini (A-0102), dan Fikri Ramadhan (A-0087). Kolom tanggal ditampilkan dalam format dd-mm-yyyy. Kolom HP yang bernilai NULL diganti dengan tanda '-', sedangkan kolom keterangan menampilkan 'Diskon 5%' untuk anggota aktif dan 'Tanpa diskon' untuk anggota lainnya. Pengurutan tanggal tidak kronologis karena ORDER BY menggunakan alias tanggal yang telah diformat menjadi teks.

SELECT CONCAT(nama_anggota, ' (', no_anggota, ')')      AS anggota,
       DATE_FORMAT(tgl_daftar_anggota, '%d-%m-%Y')      AS tgl_daftar_anggota,
       IFNULL(no_hp_anggota, '-')                       AS hp,
       CASE status_anggota WHEN 'aktif' THEN 'Diskon 5%'
                           ELSE 'Tanpa diskon' END      AS keterangan
FROM anggota
WHERE nama_anggota LIKE '%a%'
ORDER BY tgl_daftar_anggota DESC
LIMIT 5;

-- [Q07] D.2-3 (versi diperbaiki: urut menurut tanggal sebenarnya)
-- Tanya   : Sama dengan Q06, tetapi benar-benar 5 anggota yang paling baru mendaftar.
-- Harapan : 5 baris urut tanggal daftar terbaru:
--           Putri Ayu Wardani (A-0104) 01-09-2026 | 085269304418 | Diskon 5%
--           Rangga Mahendra (A-0103)   25-08-2026 | -            | Diskon 5%
--           Naufal Ardiansyah (A-0101) 18-08-2026 | 081377200101 | Diskon 5%
--           Salsabila Nur Aini (A-0102) 18-08-2026 | 082280113402 | Diskon 5%
--           Galih Prakoso (A-0099)     05-03-2025 | 087815220934 | Tanpa diskon
-- Nyata   : 5 baris. Urutan anggota yang ditampilkan adalah Putri Ayu Wardani (A-0104), Rangga Mahendra (A-0103), Naufal Ardiansyah (A-0101), Salsabila Nur Aini (A-0102), dan Galih Prakoso (A-0099). Data telah diurutkan berdasarkan kolom tanggal pendaftaran asli secara menurun (DESC), sehingga anggota dengan tanggal pendaftaran terbaru ditampilkan terlebih dahulu. Penggunaan anggota.tgl_daftar_anggota pada ORDER BY memperbaiki kesalahan pengurutan pada Q06. Kolom no_anggota digunakan sebagai pengurutan tambahan jika tanggal pendaftaran sama.
SELECT CONCAT(nama_anggota, ' (', no_anggota, ')')      AS anggota,
       DATE_FORMAT(tgl_daftar_anggota, '%d-%m-%Y')      AS tgl_daftar_anggota,
       IFNULL(no_hp_anggota, '-')                       AS hp,
       CASE status_anggota WHEN 'aktif' THEN 'Diskon 5%'
                           ELSE 'Tanpa diskon' END      AS keterangan
FROM anggota
WHERE nama_anggota LIKE '%a%'
ORDER BY anggota.tgl_daftar_anggota DESC, no_anggota
LIMIT 5;

-- ---------------------------------------------------------------------
-- Titik Analisis 2 (D.2): NULL bukan nilai, bukan string kosong
-- ---------------------------------------------------------------------

-- [Q08a] TA-2 | SALAH tetapi berjalan
-- Tanya   : Anggota tanpa nomor HP, ditulis dengan '= NULL'.
-- Harapan : 0 baris (Empty set), tanpa galat. Perbandingan apa pun dengan NULL bernilai NULL, bukan TRUE.
-- Nyata   : 0 baris. MySQL mengembalikan hasil kosong tanpa galat
--           karena perbandingan no_hp_anggota = NULL tidak bernilai TRUE.
SELECT no_anggota, nama_anggota, no_hp_anggota
FROM anggota
WHERE no_hp_anggota = NULL;

-- [Q08b] TA-2 | benar
-- Tanya   : Anggota tanpa nomor HP, ditulis dengan IS NULL.
-- Harapan : 2 baris ->  A-0087 Fikri Ramadhan, A-0103 Rangga Mahendra (urutan dijamin oleh ORDER BY).
-- Nyata   : 2 baris, yaitu:
--           A-0087 | Fikri Ramadhan | no_hp_anggota = NULL
--           A-0103 | Rangga Mahendra | no_hp_anggota = NULL.
SELECT no_anggota, nama_anggota, no_hp_anggota
FROM anggota
WHERE no_hp_anggota IS NULL
ORDER BY no_anggota;

-- [Q08c] TA-2 | NULL versus string kosong
-- Tanya   : Bagaimana NULL dan '' diperlakukan oleh perbandingan?
-- Harapan : 1 baris -> null_sama_null = NULL | null_is_null = 1 | kosong_is_null = 0 | kosong_sama_kosong = 1
-- Nyata   : Menghasilkan nilai `NULL`, `1`, `0`, dan `1` secara berurutan
--           untuk ekspresi `NULL = NULL`, `NULL IS NULL`, `'' IS NULL`,
--           dan `'' = ''`.
SELECT NULL = NULL AS null_sama_null,
       NULL IS NULL AS null_is_null,
       '' IS NULL AS kosong_is_null,
       '' = '' AS kosong_sama_kosong;

-- =====================================================================
-- D.3  TANGGAL DAN PERHITUNGAN PER BARIS
-- =====================================================================

-- [Q09] D.3-4 | fungsi: DATEDIFF, CURDATE, CASE
-- Tanya   : Sudah berapa hari tiap anggota terdaftar, dan termasuk anggota baru atau lama?
-- Harapan : 7 baris urut lama_hari kecil ke besar. Kategori 'baru' (< 180 hari) untuk
--           A-0104, A-0103, A-0101, A-0102; kategori 'lama' untuk A-0099, A-0094, A-0087.
--           Pada 1 November 2026 jumlah harinya 61, 68, 75, 75, 606, 985, 1175.
--           Angka hari bertambah tiap hari karena CURDATE() mengikuti jam komputer;
--           kategorinya tetap sampai pertengahan Februari 2027.
-- Nyata   : Menghasilkan 7 baris anggota. Empat anggota berkategori `baru`,
--           yaitu A-0104 (61 hari), A-0103 (68 hari), A-0101 (75 hari),
--           dan A-0102 (75 hari). Tiga anggota lainnya berkategori `lama`,
--           yaitu A-0099 (606 hari), A-0094 (985 hari), dan A-0087
--           (1175 hari).

SELECT no_anggota, nama_anggota, tgl_daftar_anggota,
       DATEDIFF(CURDATE(), tgl_daftar_anggota) AS lama_hari,
       CASE WHEN DATEDIFF(CURDATE(), tgl_daftar_anggota) < 180 THEN 'baru'
            ELSE 'lama' END AS kategori
FROM anggota
ORDER BY lama_hari, no_anggota;

-- [Q10] D.3-5a
-- Tanya   : Berapa id_penjualan untuk nota PJ-2609-0142? (dibutuhkan agar Q11 cukup satu tabel)
-- Harapan : 1 baris -> id_penjualan 1 | PJ-2609-0142 | 2026-09-24 10:15:00 | bayar 30000.00
-- Nyata   : Menghasilkan 1 baris dengan `id_penjualan` 1, nomor nota
--           `PJ-2609-0142`, tanggal penjualan `2026-09-24 10:15:00`,
--           dan nilai pembayaran `30000.00`.
SELECT id_penjualan, no_nota_penjualan, tgl_penjualan, bayar_penjualan
FROM penjualan
WHERE no_nota_penjualan = 'PJ-2609-0142';

-- [Q11] D.3-5b | perhitungan per baris
-- Tanya   : Apa saja isi nota PJ-2609-0142 dan berapa subtotal tiap barisnya?
-- Harapan : 3 baris (id_penjualan 1):
--           id_barang 1 | qty 3 | harga 4000.00 | subtotal 12000.00
--           id_barang 2 | qty 2 | harga 6500.00 | subtotal 13000.00
--           id_barang 3 | qty 1 | harga 4000.00 | subtotal  4000.00
--           Jumlah manual 29000; bayar 30000 pada Q10 (selisih 1000 = kembalian).
-- Nyata   : Menghasilkan 3 baris detail penjualan dengan `id_penjualan` 1.
--           Subtotal setiap baris adalah `12000.00`, `13000.00`, dan
--           `4000.00`, sehingga total subtotal manualnya adalah `29000.00`.
SELECT id_penjualan, id_barang, qty_detail_penjualan AS qty,
       harga_satuan_detail_penjualan AS harga_satuan,
       qty_detail_penjualan * harga_satuan_detail_penjualan AS subtotal
FROM detail_penjualan
WHERE id_penjualan = 1
ORDER BY id_barang;

-- =====================================================================
-- E.  LATIHAN DAN MODIFIKASI
-- =====================================================================

-- [Q12] E-1 | fungsi: UPPER, CONCAT, FORMAT
-- Tanya   : Tampilkan nama barang huruf kapital dan harga berformat 'Rp4.000'.
-- Harapan : 8 baris urut kode_barang, mis. ATK-001 | PULPEN GEL 0.5 | Rp4.000 ... MNM-002 | TEH KOTAK 350 | Rp5.500.
--           Jika yang tampil 'Rp4,000' (koma), locale id_ID tidak dikenal server:
--           pakai baris cadangan di bawah (REPLACE).
-- Nyata   : Menghasilkan 8 baris barang yang diurutkan berdasarkan
--           `kode_barang`. Nama barang ditampilkan dalam huruf kapital dan
--           harga dalam format rupiah, misalnya `PULPEN GEL 0.5` dengan
--           harga `Rp4.000` dan `TEH KOTAK 350` dengan harga `Rp5.500`.
SELECT kode_barang,
       UPPER(nama_barang) AS nama_barang,
       CONCAT('Rp', FORMAT(harga_jual_barang, 0, 'id_ID')) AS harga
FROM barang
ORDER BY kode_barang;
-- Cadangan bila locale tidak didukung:
-- SELECT kode_barang, UPPER(nama_barang) AS nama_barang,
--        CONCAT('Rp', REPLACE(FORMAT(harga_jual_barang, 0), ',', '.')) AS harga
-- FROM barang ORDER BY kode_barang;

-- [Q13a] E-2 | SALAH SEMANTIK: OR tanpa tanda kurung
-- Tanya   : Barang ATK atau minuman yang stoknya di atas 40.
-- Harapan : Saya perkirakan 4 baris. TETAPI AND diproses sebelum OR, sehingga dibaca
--           'ATK (berapa pun stoknya) ATAU (minuman DAN stok > 40)'.
--           Hasil salah yang diperkirakan: 5 baris -> ATK-001 (114), ATK-002 (77), ATK-003 (57),
--           ATK-004 (37, SEHARUSNYA TIDAK ADA), MNM-001 (42).
-- Nyata   : Menghasilkan 5 baris barang, yaitu ATK-001, ATK-002, ATK-003,
--           ATK-004, dan MNM-001. Barang ATK-004 tetap ditampilkan meskipun
--           stoknya hanya 37 karena kondisi `AND` dan `OR` dievaluasi
--           sesuai prioritas operator.
SELECT kode_barang, nama_barang, kategori_barang, stok_barang
FROM barang
WHERE kategori_barang = 'ATK' OR kategori_barang = 'minuman' AND stok_barang > 40
ORDER BY kode_barang;

-- [Q13b] E-2 | perbaikan: beri tanda kurung
-- Tanya   : Sama dengan Q13a, dengan maksud yang benar.
-- Harapan : 4 baris -> ATK-001 (114), ATK-002 (77), ATK-003 (57), MNM-001 (42).
--           ATK-004 (37) dan MNM-002 (33) tidak muncul karena stok tidak di atas 40.
-- Nyata   : Menghasilkan 4 baris barang, yaitu ATK-001, ATK-002, ATK-003,
--           dan MNM-001. Semua barang yang ditampilkan memiliki kategori
--           ATK atau minuman serta stok lebih dari 40.
SELECT kode_barang, nama_barang, kategori_barang, stok_barang
FROM barang
WHERE (kategori_barang = 'ATK' OR kategori_barang = 'minuman') AND stok_barang > 40
ORDER BY kode_barang;

-- [Q14a] E-2 (tambahan) | SALAH SEMANTIK: BETWEEN pada kolom DATETIME
-- Tanya   : Nota pada 23 sampai 24 September 2026, ditulis dengan tanggal saja.
-- Harapan : Seharusnya 4 nota. Tetapi '2026-09-24' dibaca sebagai 24/9 pukul 00:00:00,
--           sehingga nota 24 September (10:15 dan 15:30) tidak ikut. Perkiraan: 2 baris
--           (PJ-2609-0140 dan PJ-2609-0141), tanpa galat.
-- Nyata   : Menghasilkan 2 baris penjualan, yaitu nota PJ-2609-0140 pada
--           `2026-09-23 08:55:00` dan PJ-2609-0141 pada
--           `2026-09-23 14:20:00`.
SELECT no_nota_penjualan, tgl_penjualan
FROM penjualan
WHERE tgl_penjualan BETWEEN '2026-09-23' AND '2026-09-24'
ORDER BY tgl_penjualan;

-- [Q14b] E-2 (tambahan) | perbaikan: rentang setengah terbuka
-- Tanya   : Sama dengan Q14a, dengan maksud yang benar.
-- Harapan : 4 baris -> PJ-2609-0140, PJ-2609-0141, PJ-2609-0142, PJ-2609-0143.
-- Nyata   : Menghasilkan 4 baris penjualan, yaitu PJ-2609-0140 pada
--           `2026-09-23 08:55:00`, PJ-2609-0141 pada `2026-09-23 14:20:00`,
--           PJ-2609-0142 pada `2026-09-24 10:15:00`, dan PJ-2609-0143
--           pada `2026-09-24 15:30:00`.
SELECT no_nota_penjualan, tgl_penjualan
FROM penjualan
WHERE tgl_penjualan >= '2026-09-23' AND tgl_penjualan < '2026-09-25'
ORDER BY tgl_penjualan;
