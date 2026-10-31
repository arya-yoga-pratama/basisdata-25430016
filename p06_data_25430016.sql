-- =====================================================================
-- p06_data_25430016.sql
-- Milestone Proyek 6 - Data sampel Perpustakaan Lentera AYP
-- NPM : 25430016  (P = 8 -> maks. 10 eksemplar/transaksi, denda Rp8.000/hari)
-- DB  : perpus_016 (dibuat oleh p05_ddl_25430016.sql)
--
-- Cara menjalankan ulang dari basis data kosong (hasil selalu sama):
--   1. Jalankan p05_ddl_25430016.sql  (DROP TABLE IF EXISTS + CREATE ulang)
--   2. Jalankan p06_data_25430016.sql (berkas ini)
-- Tidak ada kolom AUTO_INCREMENT; semua kunci memakai kode alami,
-- sehingga hasilnya identik pada setiap pembangunan ulang.
--
-- Jumlah baris (target milestone: induk >= 5, transaksi utama >= 10 x P = 80):
--   petugas 6 | anggota 12 | buku 12 | eksemplar 49          (tabel induk)
--   peminjaman 80 (tersebar pada 8 tanggal) | detail_peminjaman 95
--   pengembalian 69 | denda 17                     (tabel transaksi)
-- =====================================================================

USE perpus_016;
SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- 1. DATA INDUK (urutan: induk dahulu, anak kemudian)
-- ---------------------------------------------------------------------
-- petugas: 6 baris (satu petugas Tidak Aktif sebagai contoh data historis, bukan dihapus)
INSERT INTO petugas (id_petugas, kode_petugas, nama_petugas, peran_petugas, status_petugas) VALUES
    ('PT001', 'PET-001', 'Siti Rahma', 'Petugas Perpustakaan', 'Aktif'),
    ('PT002', 'PET-002', 'Rudi Hartono', 'Petugas Perpustakaan', 'Aktif'),
    ('PT003', 'PET-003', 'Maya Lestari', 'Petugas Perpustakaan', 'Aktif'),
    ('PT004', 'PET-004', 'Dedi Kurniawan', 'Petugas Perpustakaan', 'Tidak Aktif'),
    ('PT005', 'PET-005', 'Hendra Wijaya', 'Kepala/Pengelola Perpustakaan', 'Aktif'),
    ('PT006', 'PET-006', 'Ayu Safitri', 'Petugas Perpustakaan', 'Aktif');

-- anggota: 12 baris (dua berstatus Tidak Aktif untuk menguji AB-02)
INSERT INTO anggota (nomor_anggota, nama_anggota, jenis_kelamin, alamat_anggota, no_hp_anggota, tanggal_daftar, status_anggota) VALUES
    ('A001', 'Andi Pratama', 'Laki-laki', 'Jl. Melati No. 10, Metro', '081234567890', '2026-09-21', 'Aktif'),
    ('A002', 'Rizka Amelia Putri', 'Perempuan', 'Jl. Kenanga No. 7, Bandar Lampung', '081379120045', '2026-09-22', 'Aktif'),
    ('A003', 'Bagas Setiawan', 'Laki-laki', 'Jl. Cempaka No. 21, Metro', '085267301188', '2026-09-25', 'Aktif'),
    ('A004', 'Dewi Kartika Sari', 'Perempuan', 'Jl. Anggrek No. 3, Pringsewu', '082175649012', '2026-09-28', 'Aktif'),
    ('A005', 'Hasan Basri', 'Laki-laki', 'Jl. Flamboyan No. 15, Bandar Lampung', '081541237788', '2026-09-30', 'Aktif'),
    ('A006', 'Nabila Zahra Ramadhani', 'Perempuan', 'Jl. Mawar No. 12, Metro', '087812340956', '2026-10-01', 'Aktif'),
    ('A007', 'Fajar Nugraha', 'Laki-laki', 'Jl. Dahlia No. 5, Bandar Lampung', '081290456731', '2026-10-02', 'Aktif'),
    ('A008', 'Intan Permata Dewi', 'Perempuan', 'Jl. Teratai No. 18, Metro', '082340981265', '2026-10-02', 'Aktif'),
    ('A009', 'Yoga Prakoso', 'Laki-laki', 'Jl. Kamboja No. 9, Pringsewu', '085372104459', '2026-10-03', 'Aktif'),
    ('A010', 'Citra Maharani', 'Perempuan', 'Jl. Seruni No. 27, Bandar Lampung', '081268730412', '2026-10-04', 'Aktif'),
    ('A011', 'Joko Susilo', 'Laki-laki', 'Jl. Kenari No. 14, Metro', '081911203874', '2026-02-10', 'Tidak Aktif'),
    ('A012', 'Lestari Wulandari', 'Perempuan', 'Jl. Pelita No. 31, Bandar Lampung', '082198765430', '2025-11-18', 'Tidak Aktif');

-- buku: 12 judul
INSERT INTO buku (id_buku, isbn_buku, judul_buku, penulis_buku, penerbit_buku, tahun_terbit_buku, kategori_buku) VALUES
    ('B001', '9786020000000', 'Dasar Pemrograman', 'Budi Santoso', 'Lentera Ilmu', 2024, 'Pemrograman'),
    ('B002', '9786020000017', 'Basis Data untuk Pemula', 'Ratna Kusuma', 'Lentera Ilmu', 2023, 'Basis Data'),
    ('B003', '9786020000024', 'Struktur Data dan Algoritma', 'Agus Wibowo', 'Pustaka Nusantara', 2022, 'Pemrograman'),
    ('B004', '9786020000031', 'Jaringan Komputer Praktis', 'Hendri Gunawan', 'Pustaka Nusantara', 2021, 'Jaringan'),
    ('B005', '9786020000048', 'Sejarah Kerajaan Nusantara', 'Sri Wahyuni', 'Penerbit Samudra', 2019, 'Sejarah'),
    ('B006', '9786020000055', 'Laskar Pelangi Lampung', 'Dimas Anggara', 'Penerbit Samudra', 2020, 'Fiksi'),
    ('B007', '9786020000062', 'Matematika Dasar SMA', 'Eko Prasetyo', 'Cahaya Edukasi', 2025, 'Pendidikan'),
    ('B008', '9786020000079', 'Ekonomi Mikro Terapan', 'Laila Fitriani', 'Cahaya Edukasi', 2022, 'Ekonomi'),
    ('B009', '9786020000086', 'Resep Nusantara Rumahan', 'Yulia Handayani', 'Dapur Kita', 2023, 'Kuliner'),
    ('B010', '9786020000093', 'Psikologi Remaja', 'Taufik Hidayat', 'Mitra Pustaka', 2021, 'Psikologi'),
    ('B011', '9786020000109', 'Pengantar Statistika', 'Maria Ulfa', 'Mitra Pustaka', 2024, 'Pendidikan'),
    ('B012', '9786020000116', 'Kumpulan Cerita Rakyat Sumatra', 'Anwar Syahputra', 'Penerbit Samudra', 2018, 'Fiksi');

-- eksemplar: 49 salinan fisik
--   E001-E036 : dipakai transaksi pada data ini
--   E037-E048 : cadangan, tidak pernah dipinjam pada data ini (dipakai skenario uji AB-03/AB-04)
--   E049      : berstatus Dalam Perbaikan
INSERT INTO eksemplar (id_eksemplar, id_buku, kode_eksemplar, kondisi_eksemplar, status_eksemplar, lokasi_eksemplar) VALUES
    ('E001', 'B001', 'EKS-B001-001', 'Baik', 'Tersedia', 'Rak B-02'),
    ('E002', 'B002', 'EKS-B002-001', 'Baik', 'Tersedia', 'Rak C-02'),
    ('E003', 'B003', 'EKS-B003-001', 'Baik', 'Tersedia', 'Rak D-02'),
    ('E004', 'B004', 'EKS-B004-001', 'Baik', 'Tersedia', 'Rak E-02'),
    ('E005', 'B005', 'EKS-B005-001', 'Baik', 'Tersedia', 'Rak F-02'),
    ('E006', 'B006', 'EKS-B006-001', 'Baik', 'Tersedia', 'Rak A-02'),
    ('E007', 'B007', 'EKS-B007-001', 'Rusak Ringan', 'Tersedia', 'Rak B-02'),
    ('E008', 'B008', 'EKS-B008-001', 'Baik', 'Tersedia', 'Rak C-02'),
    ('E009', 'B009', 'EKS-B009-001', 'Baik', 'Tersedia', 'Rak D-02'),
    ('E010', 'B010', 'EKS-B010-001', 'Baik', 'Tersedia', 'Rak E-02'),
    ('E011', 'B011', 'EKS-B011-001', 'Baik', 'Tersedia', 'Rak F-02'),
    ('E012', 'B012', 'EKS-B012-001', 'Baik', 'Tersedia', 'Rak A-02'),
    ('E013', 'B001', 'EKS-B001-002', 'Baik', 'Tersedia', 'Rak B-03'),
    ('E014', 'B002', 'EKS-B002-002', 'Rusak Ringan', 'Tersedia', 'Rak C-03'),
    ('E015', 'B003', 'EKS-B003-002', 'Baik', 'Tersedia', 'Rak D-03'),
    ('E016', 'B004', 'EKS-B004-002', 'Baik', 'Tersedia', 'Rak E-03'),
    ('E017', 'B005', 'EKS-B005-002', 'Baik', 'Tersedia', 'Rak F-03'),
    ('E018', 'B006', 'EKS-B006-002', 'Baik', 'Tersedia', 'Rak A-03'),
    ('E019', 'B007', 'EKS-B007-002', 'Baik', 'Tersedia', 'Rak B-03'),
    ('E020', 'B008', 'EKS-B008-002', 'Baik', 'Tersedia', 'Rak C-03'),
    ('E021', 'B009', 'EKS-B009-002', 'Rusak Ringan', 'Tersedia', 'Rak D-03'),
    ('E022', 'B010', 'EKS-B010-002', 'Baik', 'Tersedia', 'Rak E-03'),
    ('E023', 'B011', 'EKS-B011-002', 'Baik', 'Tersedia', 'Rak F-03'),
    ('E024', 'B012', 'EKS-B012-002', 'Baik', 'Tersedia', 'Rak A-03'),
    ('E025', 'B001', 'EKS-B001-003', 'Baik', 'Tersedia', 'Rak B-04'),
    ('E026', 'B002', 'EKS-B002-003', 'Baik', 'Tersedia', 'Rak C-04'),
    ('E027', 'B003', 'EKS-B003-003', 'Baik', 'Tersedia', 'Rak D-04'),
    ('E028', 'B004', 'EKS-B004-003', 'Rusak Ringan', 'Tersedia', 'Rak E-04'),
    ('E029', 'B005', 'EKS-B005-003', 'Baik', 'Tersedia', 'Rak F-04'),
    ('E030', 'B006', 'EKS-B006-003', 'Baik', 'Tersedia', 'Rak A-04'),
    ('E031', 'B007', 'EKS-B007-003', 'Baik', 'Tersedia', 'Rak B-04'),
    ('E032', 'B008', 'EKS-B008-003', 'Baik', 'Tersedia', 'Rak C-04'),
    ('E033', 'B009', 'EKS-B009-003', 'Baik', 'Tersedia', 'Rak D-04'),
    ('E034', 'B010', 'EKS-B010-003', 'Baik', 'Tersedia', 'Rak E-04'),
    ('E035', 'B011', 'EKS-B011-003', 'Rusak Ringan', 'Tersedia', 'Rak F-04'),
    ('E036', 'B012', 'EKS-B012-003', 'Baik', 'Tersedia', 'Rak A-04'),
    ('E037', 'B001', 'EKS-B001-004', 'Baik', 'Tersedia', 'Rak B-05'),
    ('E038', 'B002', 'EKS-B002-004', 'Baik', 'Tersedia', 'Rak C-05'),
    ('E039', 'B003', 'EKS-B003-004', 'Baik', 'Tersedia', 'Rak D-05'),
    ('E040', 'B004', 'EKS-B004-004', 'Baik', 'Tersedia', 'Rak E-05'),
    ('E041', 'B005', 'EKS-B005-004', 'Baik', 'Tersedia', 'Rak F-05'),
    ('E042', 'B006', 'EKS-B006-004', 'Rusak Ringan', 'Tersedia', 'Rak A-05'),
    ('E043', 'B007', 'EKS-B007-004', 'Baik', 'Tersedia', 'Rak B-05'),
    ('E044', 'B008', 'EKS-B008-004', 'Baik', 'Tersedia', 'Rak C-05'),
    ('E045', 'B009', 'EKS-B009-004', 'Baik', 'Tersedia', 'Rak D-05'),
    ('E046', 'B010', 'EKS-B010-004', 'Baik', 'Tersedia', 'Rak E-05'),
    ('E047', 'B011', 'EKS-B011-004', 'Baik', 'Tersedia', 'Rak F-05'),
    ('E048', 'B012', 'EKS-B012-004', 'Baik', 'Tersedia', 'Rak A-05'),
    ('E049', 'B003', 'EKS-B003-005', 'Rusak Ringan', 'Dalam Perbaikan', 'Rak D-01');

-- ---------------------------------------------------------------------
-- 2. DATA TRANSAKSI (urut kronologis; trigger DDL ikut berjalan)
--    status_peminjaman, status_detail, dan status_eksemplar TIDAK diisi manual:
--    diatur oleh trg_detail_ai dan trg_pengembalian_ai dari p05_ddl.
-- ---------------------------------------------------------------------

-- ===== 2026-10-05 =====
-- peminjaman 2026-10-05 (10 transaksi)
INSERT INTO peminjaman (id_peminjaman, nomor_anggota, id_petugas, tanggal_pinjam, tanggal_jatuh_tempo) VALUES
    ('PJM-20261005-001', 'A001', 'PT001', '2026-10-05', '2026-10-12'),
    ('PJM-20261005-002', 'A007', 'PT001', '2026-10-05', '2026-10-12'),
    ('PJM-20261005-003', 'A007', 'PT004', '2026-10-05', '2026-10-12'),
    ('PJM-20261005-004', 'A007', 'PT002', '2026-10-05', '2026-10-12'),
    ('PJM-20261005-005', 'A004', 'PT001', '2026-10-05', '2026-10-12'),
    ('PJM-20261005-006', 'A008', 'PT001', '2026-10-05', '2026-10-12'),
    ('PJM-20261005-007', 'A006', 'PT001', '2026-10-05', '2026-10-12'),
    ('PJM-20261005-008', 'A006', 'PT004', '2026-10-05', '2026-10-12'),
    ('PJM-20261005-009', 'A006', 'PT001', '2026-10-05', '2026-10-12'),
    ('PJM-20261005-010', 'A005', 'PT001', '2026-10-05', '2026-10-12');
-- detail peminjaman (13 eksemplar)
INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar) VALUES
    ('PJM-20261005-001', 'E001'),
    ('PJM-20261005-002', 'E011'),
    ('PJM-20261005-002', 'E004'),
    ('PJM-20261005-003', 'E031'),
    ('PJM-20261005-003', 'E016'),
    ('PJM-20261005-004', 'E009'),
    ('PJM-20261005-005', 'E034'),
    ('PJM-20261005-006', 'E022'),
    ('PJM-20261005-007', 'E033'),
    ('PJM-20261005-008', 'E035'),
    ('PJM-20261005-009', 'E036'),
    ('PJM-20261005-010', 'E012'),
    ('PJM-20261005-010', 'E003');

-- ===== 2026-10-06 =====
-- peminjaman 2026-10-06 (10 transaksi)
INSERT INTO peminjaman (id_peminjaman, nomor_anggota, id_petugas, tanggal_pinjam, tanggal_jatuh_tempo) VALUES
    ('PJM-20261006-001', 'A006', 'PT002', '2026-10-06', '2026-10-13'),
    ('PJM-20261006-002', 'A005', 'PT001', '2026-10-06', '2026-10-13'),
    ('PJM-20261006-003', 'A003', 'PT004', '2026-10-06', '2026-10-13'),
    ('PJM-20261006-004', 'A010', 'PT004', '2026-10-06', '2026-10-13'),
    ('PJM-20261006-005', 'A003', 'PT001', '2026-10-06', '2026-10-13'),
    ('PJM-20261006-006', 'A007', 'PT004', '2026-10-06', '2026-10-13'),
    ('PJM-20261006-007', 'A007', 'PT001', '2026-10-06', '2026-10-13'),
    ('PJM-20261006-008', 'A001', 'PT002', '2026-10-06', '2026-10-13'),
    ('PJM-20261006-009', 'A007', 'PT004', '2026-10-06', '2026-10-13'),
    ('PJM-20261006-010', 'A003', 'PT002', '2026-10-06', '2026-10-13');
-- detail peminjaman (13 eksemplar)
INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar) VALUES
    ('PJM-20261006-001', 'E017'),
    ('PJM-20261006-002', 'E002'),
    ('PJM-20261006-003', 'E014'),
    ('PJM-20261006-004', 'E024'),
    ('PJM-20261006-005', 'E032'),
    ('PJM-20261006-005', 'E027'),
    ('PJM-20261006-006', 'E015'),
    ('PJM-20261006-006', 'E007'),
    ('PJM-20261006-007', 'E030'),
    ('PJM-20261006-008', 'E019'),
    ('PJM-20261006-009', 'E023'),
    ('PJM-20261006-010', 'E006'),
    ('PJM-20261006-010', 'E013');

-- ===== 2026-10-07 =====
-- pengembalian 2026-10-07 (3 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261007-001', 'PJM-20261005-002', 'E004', 'PT001', '2026-10-07'),
    ('RET-20261007-002', 'PJM-20261005-004', 'E009', 'PT002', '2026-10-07'),
    ('RET-20261007-003', 'PJM-20261005-009', 'E036', 'PT003', '2026-10-07');

-- ===== 2026-10-08 =====
-- pengembalian 2026-10-08 (3 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261008-001', 'PJM-20261005-008', 'E035', 'PT002', '2026-10-08'),
    ('RET-20261008-002', 'PJM-20261006-008', 'E019', 'PT003', '2026-10-08'),
    ('RET-20261008-003', 'PJM-20261006-009', 'E023', 'PT006', '2026-10-08');

-- ===== 2026-10-09 =====
-- pengembalian 2026-10-09 (3 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261009-001', 'PJM-20261005-003', 'E031', 'PT003', '2026-10-09'),
    ('RET-20261009-002', 'PJM-20261006-003', 'E014', 'PT006', '2026-10-09'),
    ('RET-20261009-003', 'PJM-20261006-010', 'E006', 'PT001', '2026-10-09');

-- ===== 2026-10-10 =====
-- pengembalian 2026-10-10 (5 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261010-001', 'PJM-20261005-003', 'E016', 'PT006', '2026-10-10'),
    ('RET-20261010-002', 'PJM-20261005-010', 'E012', 'PT001', '2026-10-10'),
    ('RET-20261010-003', 'PJM-20261006-004', 'E024', 'PT002', '2026-10-10'),
    ('RET-20261010-004', 'PJM-20261006-005', 'E032', 'PT003', '2026-10-10'),
    ('RET-20261010-005', 'PJM-20261006-006', 'E007', 'PT006', '2026-10-10');

-- ===== 2026-10-11 =====
-- pengembalian 2026-10-11 (1 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261011-001', 'PJM-20261006-001', 'E017', 'PT001', '2026-10-11');

-- ===== 2026-10-12 =====
-- peminjaman 2026-10-12 (10 transaksi)
INSERT INTO peminjaman (id_peminjaman, nomor_anggota, id_petugas, tanggal_pinjam, tanggal_jatuh_tempo) VALUES
    ('PJM-20261012-001', 'A004', 'PT003', '2026-10-12', '2026-10-19'),
    ('PJM-20261012-002', 'A004', 'PT001', '2026-10-12', '2026-10-19'),
    ('PJM-20261012-003', 'A004', 'PT002', '2026-10-12', '2026-10-19'),
    ('PJM-20261012-004', 'A009', 'PT003', '2026-10-12', '2026-10-19'),
    ('PJM-20261012-005', 'A005', 'PT002', '2026-10-12', '2026-10-19'),
    ('PJM-20261012-006', 'A009', 'PT003', '2026-10-12', '2026-10-19'),
    ('PJM-20261012-007', 'A008', 'PT001', '2026-10-12', '2026-10-19'),
    ('PJM-20261012-008', 'A008', 'PT002', '2026-10-12', '2026-10-19'),
    ('PJM-20261012-009', 'A007', 'PT006', '2026-10-12', '2026-10-19'),
    ('PJM-20261012-010', 'A005', 'PT003', '2026-10-12', '2026-10-19');
-- detail peminjaman (14 eksemplar)
INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar) VALUES
    ('PJM-20261012-001', 'E018'),
    ('PJM-20261012-002', 'E028'),
    ('PJM-20261012-003', 'E009'),
    ('PJM-20261012-004', 'E008'),
    ('PJM-20261012-005', 'E031'),
    ('PJM-20261012-006', 'E012'),
    ('PJM-20261012-007', 'E032'),
    ('PJM-20261012-007', 'E010'),
    ('PJM-20261012-008', 'E020'),
    ('PJM-20261012-008', 'E007'),
    ('PJM-20261012-009', 'E017'),
    ('PJM-20261012-009', 'E014'),
    ('PJM-20261012-009', 'E004'),
    ('PJM-20261012-010', 'E019');
-- pengembalian 2026-10-12 (3 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261012-001', 'PJM-20261005-007', 'E033', 'PT002', '2026-10-12'),
    ('RET-20261012-002', 'PJM-20261006-007', 'E030', 'PT003', '2026-10-12'),
    ('RET-20261012-003', 'PJM-20261006-010', 'E013', 'PT006', '2026-10-12');

-- ===== 2026-10-13 =====
-- peminjaman 2026-10-13 (10 transaksi)
INSERT INTO peminjaman (id_peminjaman, nomor_anggota, id_petugas, tanggal_pinjam, tanggal_jatuh_tempo) VALUES
    ('PJM-20261013-001', 'A005', 'PT006', '2026-10-13', '2026-10-20'),
    ('PJM-20261013-002', 'A010', 'PT002', '2026-10-13', '2026-10-20'),
    ('PJM-20261013-003', 'A010', 'PT002', '2026-10-13', '2026-10-20'),
    ('PJM-20261013-004', 'A005', 'PT001', '2026-10-13', '2026-10-20'),
    ('PJM-20261013-005', 'A009', 'PT001', '2026-10-13', '2026-10-20'),
    ('PJM-20261013-006', 'A010', 'PT002', '2026-10-13', '2026-10-20'),
    ('PJM-20261013-007', 'A003', 'PT003', '2026-10-13', '2026-10-20'),
    ('PJM-20261013-008', 'A004', 'PT001', '2026-10-13', '2026-10-20'),
    ('PJM-20261013-009', 'A005', 'PT001', '2026-10-13', '2026-10-20'),
    ('PJM-20261013-010', 'A007', 'PT002', '2026-10-13', '2026-10-20');
-- detail peminjaman (14 eksemplar)
INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar) VALUES
    ('PJM-20261013-001', 'E024'),
    ('PJM-20261013-001', 'E026'),
    ('PJM-20261013-001', 'E035'),
    ('PJM-20261013-001', 'E005'),
    ('PJM-20261013-001', 'E013'),
    ('PJM-20261013-001', 'E025'),
    ('PJM-20261013-001', 'E023'),
    ('PJM-20261013-001', 'E029'),
    ('PJM-20261013-001', 'E033'),
    ('PJM-20261013-001', 'E021'),
    ('PJM-20261013-002', 'E036'),
    ('PJM-20261013-003', 'E030'),
    ('PJM-20261013-004', 'E006'),
    ('PJM-20261013-004', 'E016');

-- ===== 2026-10-14 =====
-- pengembalian 2026-10-14 (5 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261014-001', 'PJM-20261005-001', 'E001', 'PT001', '2026-10-14'),
    ('RET-20261014-002', 'PJM-20261005-005', 'E034', 'PT001', '2026-10-14'),
    ('RET-20261014-003', 'PJM-20261005-006', 'E022', 'PT002', '2026-10-14'),
    ('RET-20261014-004', 'PJM-20261006-006', 'E015', 'PT003', '2026-10-14'),
    ('RET-20261014-005', 'PJM-20261012-008', 'E020', 'PT006', '2026-10-14');
-- denda keterlambatan: hari_terlambat = tanggal_pengembalian - tanggal_jatuh_tempo; nominal = hari x 8000 (AB-07, AB-08)
INSERT INTO denda (id_denda, id_pengembalian, hari_terlambat, nominal_denda, status_bayar) VALUES
    ('D001', 'RET-20261014-001', 2, 16000, 'Belum Dibayar'),
    ('D002', 'RET-20261014-002', 2, 16000, 'Sudah Dibayar'),
    ('D003', 'RET-20261014-003', 2, 16000, 'Belum Dibayar'),
    ('D004', 'RET-20261014-004', 1, 8000, 'Sudah Dibayar');

-- ===== 2026-10-15 =====
-- pengembalian 2026-10-15 (1 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261015-001', 'PJM-20261013-001', 'E026', 'PT001', '2026-10-15');

-- ===== 2026-10-16 =====
-- pengembalian 2026-10-16 (4 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261016-001', 'PJM-20261012-009', 'E004', 'PT002', '2026-10-16'),
    ('RET-20261016-002', 'PJM-20261013-001', 'E005', 'PT003', '2026-10-16'),
    ('RET-20261016-003', 'PJM-20261013-001', 'E013', 'PT006', '2026-10-16'),
    ('RET-20261016-004', 'PJM-20261013-004', 'E016', 'PT001', '2026-10-16');

-- ===== 2026-10-17 =====
-- pengembalian 2026-10-17 (1 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261017-001', 'PJM-20261005-010', 'E003', 'PT003', '2026-10-17');
-- denda keterlambatan: hari_terlambat = tanggal_pengembalian - tanggal_jatuh_tempo; nominal = hari x 8000 (AB-07, AB-08)
INSERT INTO denda (id_denda, id_pengembalian, hari_terlambat, nominal_denda, status_bayar) VALUES
    ('D005', 'RET-20261017-001', 5, 40000, 'Sudah Dibayar');

-- ===== 2026-10-18 =====
-- pengembalian 2026-10-18 (5 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261018-001', 'PJM-20261012-005', 'E031', 'PT006', '2026-10-18'),
    ('RET-20261018-002', 'PJM-20261012-007', 'E032', 'PT001', '2026-10-18'),
    ('RET-20261018-003', 'PJM-20261013-001', 'E025', 'PT002', '2026-10-18'),
    ('RET-20261018-004', 'PJM-20261013-001', 'E029', 'PT003', '2026-10-18'),
    ('RET-20261018-005', 'PJM-20261013-004', 'E006', 'PT006', '2026-10-18');

-- ===== 2026-10-19 =====
-- peminjaman 2026-10-19 (10 transaksi)
INSERT INTO peminjaman (id_peminjaman, nomor_anggota, id_petugas, tanggal_pinjam, tanggal_jatuh_tempo) VALUES
    ('PJM-20261019-001', 'A010', 'PT001', '2026-10-19', '2026-10-26'),
    ('PJM-20261019-002', 'A006', 'PT003', '2026-10-19', '2026-10-26'),
    ('PJM-20261019-003', 'A010', 'PT006', '2026-10-19', '2026-10-26'),
    ('PJM-20261019-004', 'A007', 'PT003', '2026-10-19', '2026-10-26'),
    ('PJM-20261019-005', 'A004', 'PT001', '2026-10-19', '2026-10-26'),
    ('PJM-20261019-006', 'A001', 'PT001', '2026-10-19', '2026-10-26'),
    ('PJM-20261019-007', 'A003', 'PT002', '2026-10-19', '2026-10-26'),
    ('PJM-20261019-008', 'A005', 'PT002', '2026-10-19', '2026-10-26'),
    ('PJM-20261019-009', 'A004', 'PT003', '2026-10-19', '2026-10-26'),
    ('PJM-20261019-010', 'A005', 'PT001', '2026-10-19', '2026-10-26');
-- detail peminjaman (13 eksemplar)
INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar) VALUES
    ('PJM-20261019-001', 'E006'),
    ('PJM-20261019-001', 'E020'),
    ('PJM-20261019-002', 'E003'),
    ('PJM-20261019-003', 'E004'),
    ('PJM-20261019-004', 'E031'),
    ('PJM-20261019-005', 'E022'),
    ('PJM-20261019-005', 'E005'),
    ('PJM-20261019-006', 'E015'),
    ('PJM-20261019-007', 'E025'),
    ('PJM-20261019-008', 'E032'),
    ('PJM-20261019-009', 'E016'),
    ('PJM-20261019-010', 'E029'),
    ('PJM-20261019-010', 'E026');
-- pengembalian 2026-10-19 (4 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261019-001', 'PJM-20261006-005', 'E027', 'PT001', '2026-10-19'),
    ('RET-20261019-002', 'PJM-20261013-001', 'E023', 'PT002', '2026-10-19'),
    ('RET-20261019-003', 'PJM-20261013-001', 'E024', 'PT003', '2026-10-19'),
    ('RET-20261019-004', 'PJM-20261013-001', 'E033', 'PT006', '2026-10-19');
-- denda keterlambatan: hari_terlambat = tanggal_pengembalian - tanggal_jatuh_tempo; nominal = hari x 8000 (AB-07, AB-08)
INSERT INTO denda (id_denda, id_pengembalian, hari_terlambat, nominal_denda, status_bayar) VALUES
    ('D006', 'RET-20261019-001', 6, 48000, 'Belum Dibayar');

-- ===== 2026-10-20 =====
-- peminjaman 2026-10-20 (10 transaksi)
INSERT INTO peminjaman (id_peminjaman, nomor_anggota, id_petugas, tanggal_pinjam, tanggal_jatuh_tempo) VALUES
    ('PJM-20261020-001', 'A003', 'PT001', '2026-10-20', '2026-10-27'),
    ('PJM-20261020-002', 'A006', 'PT002', '2026-10-20', '2026-10-27'),
    ('PJM-20261020-003', 'A004', 'PT003', '2026-10-20', '2026-10-27'),
    ('PJM-20261020-004', 'A002', 'PT002', '2026-10-20', '2026-10-27'),
    ('PJM-20261020-005', 'A010', 'PT001', '2026-10-20', '2026-10-27'),
    ('PJM-20261020-006', 'A005', 'PT006', '2026-10-20', '2026-10-27'),
    ('PJM-20261020-007', 'A001', 'PT006', '2026-10-20', '2026-10-27'),
    ('PJM-20261020-008', 'A002', 'PT002', '2026-10-20', '2026-10-27'),
    ('PJM-20261020-009', 'A006', 'PT002', '2026-10-20', '2026-10-27'),
    ('PJM-20261020-010', 'A003', 'PT006', '2026-10-20', '2026-10-27');
-- detail peminjaman (7 eksemplar)
INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar) VALUES
    ('PJM-20261020-001', 'E023'),
    ('PJM-20261020-001', 'E034'),
    ('PJM-20261020-001', 'E027'),
    ('PJM-20261020-002', 'E013'),
    ('PJM-20261020-002', 'E033'),
    ('PJM-20261020-003', 'E024'),
    ('PJM-20261020-003', 'E001');
-- pengembalian 2026-10-20 (4 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261020-001', 'PJM-20261012-009', 'E017', 'PT002', '2026-10-20'),
    ('RET-20261020-002', 'PJM-20261013-001', 'E021', 'PT003', '2026-10-20'),
    ('RET-20261020-003', 'PJM-20261013-001', 'E035', 'PT006', '2026-10-20'),
    ('RET-20261020-004', 'PJM-20261013-003', 'E030', 'PT001', '2026-10-20');
-- denda keterlambatan: hari_terlambat = tanggal_pengembalian - tanggal_jatuh_tempo; nominal = hari x 8000 (AB-07, AB-08)
INSERT INTO denda (id_denda, id_pengembalian, hari_terlambat, nominal_denda, status_bayar) VALUES
    ('D007', 'RET-20261020-001', 1, 8000, 'Sudah Dibayar');

-- ===== 2026-10-21 =====
-- pengembalian 2026-10-21 (3 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261021-001', 'PJM-20261012-006', 'E012', 'PT003', '2026-10-21'),
    ('RET-20261021-002', 'PJM-20261019-001', 'E006', 'PT006', '2026-10-21'),
    ('RET-20261021-003', 'PJM-20261019-001', 'E020', 'PT001', '2026-10-21');
-- denda keterlambatan: hari_terlambat = tanggal_pengembalian - tanggal_jatuh_tempo; nominal = hari x 8000 (AB-07, AB-08)
INSERT INTO denda (id_denda, id_pengembalian, hari_terlambat, nominal_denda, status_bayar) VALUES
    ('D008', 'RET-20261021-001', 2, 16000, 'Sudah Dibayar');

-- ===== 2026-10-22 =====
-- peminjaman 2026-10-22 (10 transaksi)
INSERT INTO peminjaman (id_peminjaman, nomor_anggota, id_petugas, tanggal_pinjam, tanggal_jatuh_tempo) VALUES
    ('PJM-20261022-001', 'A010', 'PT003', '2026-10-22', '2026-10-29'),
    ('PJM-20261022-002', 'A006', 'PT002', '2026-10-22', '2026-10-29'),
    ('PJM-20261022-003', 'A009', 'PT006', '2026-10-22', '2026-10-29'),
    ('PJM-20261022-004', 'A007', 'PT003', '2026-10-22', '2026-10-29'),
    ('PJM-20261022-005', 'A003', 'PT002', '2026-10-22', '2026-10-29'),
    ('PJM-20261022-006', 'A001', 'PT003', '2026-10-22', '2026-10-29'),
    ('PJM-20261022-007', 'A003', 'PT002', '2026-10-22', '2026-10-29'),
    ('PJM-20261022-008', 'A007', 'PT006', '2026-10-22', '2026-10-29'),
    ('PJM-20261022-009', 'A007', 'PT002', '2026-10-22', '2026-10-29'),
    ('PJM-20261022-010', 'A007', 'PT003', '2026-10-22', '2026-10-29');
-- detail peminjaman (7 eksemplar)
INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar) VALUES
    ('PJM-20261022-001', 'E012'),
    ('PJM-20261022-001', 'E030'),
    ('PJM-20261022-002', 'E017'),
    ('PJM-20261022-002', 'E021'),
    ('PJM-20261022-002', 'E006'),
    ('PJM-20261022-003', 'E035'),
    ('PJM-20261022-003', 'E020');
-- pengembalian 2026-10-22 (5 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261022-001', 'PJM-20261012-002', 'E028', 'PT006', '2026-10-22'),
    ('RET-20261022-002', 'PJM-20261012-007', 'E010', 'PT001', '2026-10-22'),
    ('RET-20261022-003', 'PJM-20261012-008', 'E007', 'PT002', '2026-10-22'),
    ('RET-20261022-004', 'PJM-20261019-010', 'E029', 'PT003', '2026-10-22'),
    ('RET-20261022-005', 'PJM-20261020-002', 'E033', 'PT006', '2026-10-22');
-- denda keterlambatan: hari_terlambat = tanggal_pengembalian - tanggal_jatuh_tempo; nominal = hari x 8000 (AB-07, AB-08)
INSERT INTO denda (id_denda, id_pengembalian, hari_terlambat, nominal_denda, status_bayar) VALUES
    ('D009', 'RET-20261022-001', 3, 24000, 'Belum Dibayar'),
    ('D010', 'RET-20261022-002', 3, 24000, 'Sudah Dibayar'),
    ('D011', 'RET-20261022-003', 3, 24000, 'Sudah Dibayar');

-- ===== 2026-10-23 =====
-- pengembalian 2026-10-23 (2 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261023-001', 'PJM-20261019-009', 'E016', 'PT001', '2026-10-23'),
    ('RET-20261023-002', 'PJM-20261020-001', 'E023', 'PT002', '2026-10-23');

-- ===== 2026-10-24 =====
-- pengembalian 2026-10-24 (1 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261024-001', 'PJM-20261019-006', 'E015', 'PT002', '2026-10-24');

-- ===== 2026-10-25 =====
-- pengembalian 2026-10-25 (6 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261025-001', 'PJM-20261012-001', 'E018', 'PT003', '2026-10-25'),
    ('RET-20261025-002', 'PJM-20261012-009', 'E014', 'PT006', '2026-10-25'),
    ('RET-20261025-003', 'PJM-20261012-010', 'E019', 'PT001', '2026-10-25'),
    ('RET-20261025-004', 'PJM-20261019-003', 'E004', 'PT002', '2026-10-25'),
    ('RET-20261025-005', 'PJM-20261019-010', 'E026', 'PT003', '2026-10-25'),
    ('RET-20261025-006', 'PJM-20261022-003', 'E020', 'PT006', '2026-10-25');
-- denda keterlambatan: hari_terlambat = tanggal_pengembalian - tanggal_jatuh_tempo; nominal = hari x 8000 (AB-07, AB-08)
INSERT INTO denda (id_denda, id_pengembalian, hari_terlambat, nominal_denda, status_bayar) VALUES
    ('D012', 'RET-20261025-001', 6, 48000, 'Belum Dibayar'),
    ('D013', 'RET-20261025-002', 6, 48000, 'Belum Dibayar'),
    ('D014', 'RET-20261025-003', 6, 48000, 'Belum Dibayar');

-- ===== 2026-10-26 =====
-- peminjaman 2026-10-26 (10 transaksi)
INSERT INTO peminjaman (id_peminjaman, nomor_anggota, id_petugas, tanggal_pinjam, tanggal_jatuh_tempo) VALUES
    ('PJM-20261026-001', 'A003', 'PT003', '2026-10-26', '2026-11-02'),
    ('PJM-20261026-002', 'A002', 'PT001', '2026-10-26', '2026-11-02'),
    ('PJM-20261026-003', 'A009', 'PT001', '2026-10-26', '2026-11-02'),
    ('PJM-20261026-004', 'A008', 'PT006', '2026-10-26', '2026-11-02'),
    ('PJM-20261026-005', 'A003', 'PT006', '2026-10-26', '2026-11-02'),
    ('PJM-20261026-006', 'A001', 'PT006', '2026-10-26', '2026-11-02'),
    ('PJM-20261026-007', 'A010', 'PT002', '2026-10-26', '2026-11-02'),
    ('PJM-20261026-008', 'A004', 'PT006', '2026-10-26', '2026-11-02'),
    ('PJM-20261026-009', 'A004', 'PT006', '2026-10-26', '2026-11-02'),
    ('PJM-20261026-010', 'A005', 'PT001', '2026-10-26', '2026-11-02');
-- detail peminjaman (14 eksemplar)
INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar) VALUES
    ('PJM-20261026-001', 'E016'),
    ('PJM-20261026-001', 'E023'),
    ('PJM-20261026-002', 'E018'),
    ('PJM-20261026-003', 'E010'),
    ('PJM-20261026-004', 'E033'),
    ('PJM-20261026-004', 'E028'),
    ('PJM-20261026-004', 'E019'),
    ('PJM-20261026-005', 'E015'),
    ('PJM-20261026-006', 'E026'),
    ('PJM-20261026-006', 'E029'),
    ('PJM-20261026-007', 'E020'),
    ('PJM-20261026-007', 'E014'),
    ('PJM-20261026-008', 'E004'),
    ('PJM-20261026-008', 'E007');
-- pengembalian 2026-10-26 (1 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261026-001', 'PJM-20261019-007', 'E025', 'PT006', '2026-10-26');

-- ===== 2026-10-27 =====
-- pengembalian 2026-10-27 (1 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261027-001', 'PJM-20261020-001', 'E034', 'PT001', '2026-10-27');

-- ===== 2026-10-28 =====
-- pengembalian 2026-10-28 (5 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261028-001', 'PJM-20261019-002', 'E003', 'PT002', '2026-10-28'),
    ('RET-20261028-002', 'PJM-20261019-008', 'E032', 'PT003', '2026-10-28'),
    ('RET-20261028-003', 'PJM-20261022-002', 'E006', 'PT006', '2026-10-28'),
    ('RET-20261028-004', 'PJM-20261022-002', 'E021', 'PT001', '2026-10-28'),
    ('RET-20261028-005', 'PJM-20261026-001', 'E023', 'PT002', '2026-10-28');
-- denda keterlambatan: hari_terlambat = tanggal_pengembalian - tanggal_jatuh_tempo; nominal = hari x 8000 (AB-07, AB-08)
INSERT INTO denda (id_denda, id_pengembalian, hari_terlambat, nominal_denda, status_bayar) VALUES
    ('D015', 'RET-20261028-001', 2, 16000, 'Belum Dibayar'),
    ('D016', 'RET-20261028-002', 2, 16000, 'Belum Dibayar');

-- ===== 2026-10-30 =====
-- pengembalian 2026-10-30 (3 eksemplar)
INSERT INTO pengembalian (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian) VALUES
    ('RET-20261030-001', 'PJM-20261020-002', 'E013', 'PT006', '2026-10-30'),
    ('RET-20261030-002', 'PJM-20261026-002', 'E018', 'PT001', '2026-10-30'),
    ('RET-20261030-003', 'PJM-20261026-004', 'E028', 'PT002', '2026-10-30');
-- denda keterlambatan: hari_terlambat = tanggal_pengembalian - tanggal_jatuh_tempo; nominal = hari x 8000 (AB-07, AB-08)
INSERT INTO denda (id_denda, id_pengembalian, hari_terlambat, nominal_denda, status_bayar) VALUES
    ('D017', 'RET-20261030-001', 3, 24000, 'Belum Dibayar');

-- ---------------------------------------------------------------------
-- 3. PEMERIKSAAN JUMLAH BARIS (untuk tangkapan layar laporan)
-- ---------------------------------------------------------------------
SELECT 'petugas' AS tabel, COUNT(*) AS jumlah_baris FROM petugas
UNION ALL SELECT 'anggota', COUNT(*) FROM anggota
UNION ALL SELECT 'buku', COUNT(*) FROM buku
UNION ALL SELECT 'eksemplar', COUNT(*) FROM eksemplar
UNION ALL SELECT 'peminjaman', COUNT(*) FROM peminjaman
UNION ALL SELECT 'detail_peminjaman', COUNT(*) FROM detail_peminjaman
UNION ALL SELECT 'pengembalian', COUNT(*) FROM pengembalian
UNION ALL SELECT 'denda', COUNT(*) FROM denda;

-- Sebaran peminjaman per tanggal (syarat: minimal tiga tanggal berbeda)
SELECT tanggal_pinjam, COUNT(*) AS jumlah_transaksi
FROM peminjaman
GROUP BY tanggal_pinjam
ORDER BY tanggal_pinjam;