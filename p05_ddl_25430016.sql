-- =====================================================================
-- Database : perpus_016  (Perpustakaan Lentera AYP)
-- NPM      : 25430016  (P = 8 -> maks. 10 eksemplar/transaksi, denda Rp8.000/hari)
-- DBMS     : MySQL 8.0.16+ atau MariaDB 10.2.1+ (butuh CHECK + trigger + InnoDB)
--
-- Acuan    : p02_kebutuhan_data (aturan bisnis AB-01..AB-10, KI-01..KI-08,
--            kamus data, kebutuhan non-fungsional), p03_erd (8 entitas),
--            p04_normalisasi (skema relasional hasil normalisasi).
--
-- Urutan skrip:
--   1. Buat database
--   2. Buat tabel (8 entitas sesuai ERD Modul 3)
--   3. Buat trigger (aturan bisnis yang tidak bisa dijamin PK/FK/UNIQUE)
--   4. Buat view (membatasi data pribadi anggota)
--   5. Isi data fiktif
--   6. Query pengecekan (KI-01 s.d. KI-08)
--   7. Uji penolakan aturan bisnis (dikomentari)
--   8. Role hak akses (opsional, dikomentari)
--
-- Catatan: skrip ini memakai DROP TABLE IF EXISTS agar dapat dijalankan ulang.
-- Data lama pada tabel-tabel perpus_016 akan terhapus.
-- =====================================================================

CREATE DATABASE IF NOT EXISTS perpus_016
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE perpus_016;

-- ---------------------------------------------------------------------
-- Hapus tabel lama (urutan dari tabel anak ke tabel induk)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS denda;
DROP TABLE IF EXISTS pengembalian;
DROP TABLE IF EXISTS detail_peminjaman;
DROP TABLE IF EXISTS peminjaman;
DROP TABLE IF EXISTS eksemplar;
DROP TABLE IF EXISTS buku;
DROP TABLE IF EXISTS petugas;
DROP TABLE IF EXISTS anggota;

-- =====================================================================
-- 2. DEFINISI TABEL
-- =====================================================================

-- ---------------------------------------------------------------------
-- ANGGOTA  (PB-01)
-- ---------------------------------------------------------------------
CREATE TABLE anggota (
    nomor_anggota   VARCHAR(10)  NOT NULL,
    nama_anggota    VARCHAR(100) NOT NULL,
    jenis_kelamin   VARCHAR(10)  NOT NULL,
    alamat_anggota  VARCHAR(200) NOT NULL,
    no_hp_anggota   VARCHAR(15)  NOT NULL,
    tanggal_daftar  DATE         NOT NULL,
    status_anggota  VARCHAR(12)  NOT NULL DEFAULT 'Aktif',

   -- AB-01: Setiap anggota memiliki nomor_anggota yang unik sebagai identitas anggota.
    CONSTRAINT pk_anggota PRIMARY KEY (nomor_anggota),
    CONSTRAINT ck_anggota_jk     CHECK (jenis_kelamin IN ('Laki-laki', 'Perempuan')),
    CONSTRAINT ck_anggota_hp     CHECK (no_hp_anggota REGEXP '^[0-9]{10,15}$'),
    CONSTRAINT ck_anggota_status CHECK (status_anggota IN ('Aktif', 'Tidak Aktif'))
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- BUKU  (PB-02) - satu baris = satu judul
-- Indeks pada isbn_buku dan judul_buku untuk mendukung pencarian < 3 detik
-- (id_buku sudah terindeks sebagai PK). isbn_buku tidak dibuat UNIQUE
-- karena p02/p04 tidak menetapkannya sebagai kunci unik.
-- ---------------------------------------------------------------------
CREATE TABLE buku (
    id_buku            VARCHAR(10)  NOT NULL,
    isbn_buku          VARCHAR(13)  NULL,            -- "diisi jika tersedia"
    judul_buku         VARCHAR(150) NOT NULL,
    penulis_buku       VARCHAR(100) NOT NULL,
    penerbit_buku      VARCHAR(100) NOT NULL,
    tahun_terbit_buku  YEAR         NOT NULL,
    kategori_buku      VARCHAR(50)  NOT NULL,
    CONSTRAINT pk_buku PRIMARY KEY (id_buku),
    KEY idx_buku_isbn  (isbn_buku),
    KEY idx_buku_judul (judul_buku)
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- EKSEMPLAR  (PB-02) - satu baris = satu salinan fisik (AB-09)
-- kode_eksemplar UNIQUE mengikuti kamus data ("Harus unik").
-- ---------------------------------------------------------------------
CREATE TABLE eksemplar (
    id_eksemplar       VARCHAR(10) NOT NULL,
    id_buku            VARCHAR(10) NOT NULL,
    kode_eksemplar     VARCHAR(20) NOT NULL,
    kondisi_eksemplar  VARCHAR(15) NOT NULL DEFAULT 'Baik',
    status_eksemplar   VARCHAR(20) NOT NULL DEFAULT 'Tersedia',
    lokasi_eksemplar   VARCHAR(30) NOT NULL,
    CONSTRAINT pk_eksemplar PRIMARY KEY (id_eksemplar),
    CONSTRAINT uq_eksemplar_kode UNIQUE (kode_eksemplar),
    -- AB-09: setiap eksemplar terhubung dengan satu judul buku.
    CONSTRAINT fk_eksemplar_buku FOREIGN KEY (id_buku)
        REFERENCES buku (id_buku)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT ck_eksemplar_kondisi CHECK (kondisi_eksemplar IN ('Baik', 'Rusak Ringan', 'Rusak Berat')),
    CONSTRAINT ck_eksemplar_status  CHECK (status_eksemplar IN ('Tersedia', 'Dipinjam', 'Dalam Perbaikan', 'Hilang'))
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- PETUGAS  (PB-07)
-- kode_petugas UNIQUE mengikuti kamus data ("Harus unik").
-- ---------------------------------------------------------------------
-- AB-10: Setiap petugas memiliki id_petugas unik dan peran_petugas wajib tercatat.
CREATE TABLE petugas (
    id_petugas      VARCHAR(10)  NOT NULL,
    kode_petugas    VARCHAR(10)  NOT NULL,
    nama_petugas    VARCHAR(100) NOT NULL,
    peran_petugas   VARCHAR(40)  NOT NULL,
    status_petugas  VARCHAR(12)  NOT NULL DEFAULT 'Aktif',
    CONSTRAINT pk_petugas PRIMARY KEY (id_petugas),
    CONSTRAINT uq_petugas_kode UNIQUE (kode_petugas),
    CONSTRAINT ck_petugas_peran  CHECK (peran_petugas IN ('Petugas Perpustakaan', 'Kepala/Pengelola Perpustakaan')),
    CONSTRAINT ck_petugas_status CHECK (status_petugas IN ('Aktif', 'Tidak Aktif'))
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- PEMINJAMAN  (PB-03) - data utama transaksi (AB-05: semua kolom wajib)
-- ---------------------------------------------------------------------
CREATE TABLE peminjaman (
    id_peminjaman        VARCHAR(20) NOT NULL,
    nomor_anggota        VARCHAR(10) NOT NULL,
    id_petugas           VARCHAR(10) NOT NULL,
    tanggal_pinjam       DATE        NOT NULL,
    tanggal_jatuh_tempo  DATE        NOT NULL,
    status_peminjaman    VARCHAR(15) NOT NULL DEFAULT 'Berlangsung',
    CONSTRAINT pk_peminjaman PRIMARY KEY (id_peminjaman),
    CONSTRAINT fk_peminjaman_anggota FOREIGN KEY (nomor_anggota)
        REFERENCES anggota (nomor_anggota)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_peminjaman_petugas FOREIGN KEY (id_petugas)
        REFERENCES petugas (id_petugas)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT ck_peminjaman_tanggal CHECK (tanggal_jatuh_tempo >= tanggal_pinjam),
    CONSTRAINT ck_peminjaman_status  CHECK (status_peminjaman IN ('Berlangsung', 'Selesai')),
    KEY idx_peminjaman_jatuh_tempo (tanggal_jatuh_tempo)
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- DETAIL_PEMINJAMAN  (PB-03) - entitas asosiatif Peminjaman x Eksemplar
-- PK komposit sekaligus FK
-- ---------------------------------------------------------------------
CREATE TABLE detail_peminjaman (
    id_peminjaman  VARCHAR(20) NOT NULL,
    id_eksemplar   VARCHAR(10) NOT NULL,
    status_detail  VARCHAR(15) NOT NULL DEFAULT 'Dipinjam',
    CONSTRAINT pk_detail_peminjaman PRIMARY KEY (id_peminjaman, id_eksemplar),
    CONSTRAINT fk_detail_peminjaman FOREIGN KEY (id_peminjaman)
        REFERENCES peminjaman (id_peminjaman)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_detail_eksemplar FOREIGN KEY (id_eksemplar)
        REFERENCES eksemplar (id_eksemplar)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT ck_detail_status CHECK (status_detail IN ('Dipinjam', 'Dikembalikan'))
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- PENGEMBALIAN  (PB-04)
-- FK gabungan (id_peminjaman, id_eksemplar) -> detail_peminjaman (AB-06)
-- UNIQUE pada pasangan tersebut: satu detail maksimal satu pengembalian
-- ---------------------------------------------------------------------
CREATE TABLE pengembalian (
    id_pengembalian       VARCHAR(20) NOT NULL,
    id_peminjaman         VARCHAR(20) NOT NULL,
    id_eksemplar          VARCHAR(10) NOT NULL,
    id_petugas            VARCHAR(10) NOT NULL,
    tanggal_pengembalian  DATE        NOT NULL,
    CONSTRAINT pk_pengembalian PRIMARY KEY (id_pengembalian),
    CONSTRAINT uq_pengembalian_detail UNIQUE (id_peminjaman, id_eksemplar),

    -- AB-06: Memastikan pengembalian merujuk pada detail peminjaman yang benar berdasarkan pasangan id_peminjaman dan id_eksemplar.
    CONSTRAINT fk_pengembalian_detail FOREIGN KEY (id_peminjaman, id_eksemplar)
        REFERENCES detail_peminjaman (id_peminjaman, id_eksemplar)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_pengembalian_petugas FOREIGN KEY (id_petugas)
        REFERENCES petugas (id_petugas)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    KEY idx_pengembalian_tanggal (tanggal_pengembalian)
) ENGINE = InnoDB;

-- ---------------------------------------------------------------------
-- DENDA  (PB-05)
-- id_pengembalian: FK sekaligus UNIQUE (satu pengembalian maks. satu denda)
-- CHECK nominal_denda = hari_terlambat x Rp8.000 (AB-08)
-- hari_terlambat bernilai nol atau lebih (kamus data no. 33)
-- ---------------------------------------------------------------------
CREATE TABLE denda (
    id_denda         VARCHAR(10)  NOT NULL,
    id_pengembalian  VARCHAR(20)  NOT NULL,
    hari_terlambat   INT UNSIGNED NOT NULL,
    nominal_denda    INT UNSIGNED NOT NULL,
    status_bayar     VARCHAR(15)  NOT NULL DEFAULT 'Belum Dibayar',
    CONSTRAINT pk_denda PRIMARY KEY (id_denda),
    CONSTRAINT uq_denda_pengembalian UNIQUE (id_pengembalian),

    -- AB-07: Pencatatan denda dilakukan berdasarkan keterlambatan pengembalian yang telah dicatat.
    CONSTRAINT fk_denda_pengembalian FOREIGN KEY (id_pengembalian)
        REFERENCES pengembalian (id_pengembalian)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    -- AB-08: Nominal denda dihitung berdasarkan jumlah hari keterlambatan dikalikan tarif Rp8.000 per hari
    CONSTRAINT ck_denda_nominal CHECK (nominal_denda = hari_terlambat * 8000),
    CONSTRAINT ck_denda_status  CHECK (status_bayar IN ('Belum Dibayar', 'Sudah Dibayar'))
) ENGINE = InnoDB;

-- =====================================================================
-- 3. TRIGGER ATURAN BISNIS
-- Aturan di bawah tidak dapat dijamin hanya dengan PK/FK/UNIQUE.
-- =====================================================================
DELIMITER $$

-- AB-02: hanya anggota berstatus Aktif yang dapat meminjam
CREATE TRIGGER trg_peminjaman_bi
BEFORE INSERT ON peminjaman
FOR EACH ROW
BEGIN
    DECLARE v_status VARCHAR(12);

    SELECT status_anggota INTO v_status
    FROM anggota
    WHERE nomor_anggota = NEW.nomor_anggota;

    IF v_status IS NULL OR v_status <> 'Aktif' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'AB-02: Hanya anggota berstatus Aktif yang dapat meminjam buku.';
    END IF;
END$$

-- AB-04: maksimal 10 eksemplar per transaksi
-- AB-03: eksemplar hanya dapat dipinjam jika berstatus Tersedia
--        dan tidak sedang tercatat dalam peminjaman aktif
CREATE TRIGGER trg_detail_bi
BEFORE INSERT ON detail_peminjaman
FOR EACH ROW
BEGIN
    DECLARE v_jumlah INT;
    DECLARE v_aktif  INT;
    DECLARE v_status VARCHAR(20);

    SELECT COUNT(*) INTO v_jumlah
    FROM detail_peminjaman
    WHERE id_peminjaman = NEW.id_peminjaman;

    IF v_jumlah >= 10 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'AB-04: Satu transaksi peminjaman maksimal 10 eksemplar.';
    END IF;

    SELECT status_eksemplar INTO v_status
    FROM eksemplar
    WHERE id_eksemplar = NEW.id_eksemplar;

    IF v_status IS NULL OR v_status <> 'Tersedia' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'AB-03: Eksemplar tidak berstatus Tersedia sehingga tidak dapat dipinjam.';
    END IF;

    SELECT COUNT(*) INTO v_aktif
    FROM detail_peminjaman
    WHERE id_eksemplar = NEW.id_eksemplar
      AND status_detail = 'Dipinjam';

    IF v_aktif > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'AB-03: Eksemplar masih tercatat dalam transaksi peminjaman aktif.';
    END IF;
END$$

-- Status eksemplar otomatis menjadi Dipinjam saat peminjaman dicatat
CREATE TRIGGER trg_detail_ai
AFTER INSERT ON detail_peminjaman
FOR EACH ROW
BEGIN
    UPDATE eksemplar
    SET status_eksemplar = 'Dipinjam'
    WHERE id_eksemplar = NEW.id_eksemplar;
END$$

-- Tanggal pengembalian tidak boleh lebih awal dari tanggal pinjam
CREATE TRIGGER trg_pengembalian_bi
BEFORE INSERT ON pengembalian
FOR EACH ROW
BEGIN
    DECLARE v_pinjam DATE;

    SELECT tanggal_pinjam INTO v_pinjam
    FROM peminjaman
    WHERE id_peminjaman = NEW.id_peminjaman;

    IF v_pinjam IS NOT NULL AND NEW.tanggal_pengembalian < v_pinjam THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Tanggal pengembalian tidak boleh lebih awal dari tanggal peminjaman.';
    END IF;
END$$

-- Saat pengembalian dicatat: status detail, eksemplar, dan peminjaman diperbarui
CREATE TRIGGER trg_pengembalian_ai
AFTER INSERT ON pengembalian
FOR EACH ROW
BEGIN
    UPDATE detail_peminjaman
    SET status_detail = 'Dikembalikan'
    WHERE id_peminjaman = NEW.id_peminjaman
      AND id_eksemplar  = NEW.id_eksemplar;

    UPDATE eksemplar
    SET status_eksemplar = 'Tersedia'
    WHERE id_eksemplar = NEW.id_eksemplar;

    UPDATE peminjaman
    SET status_peminjaman = 'Selesai'
    WHERE id_peminjaman = NEW.id_peminjaman
      AND NOT EXISTS (
            SELECT 1
            FROM detail_peminjaman
            WHERE id_peminjaman = NEW.id_peminjaman
              AND status_detail = 'Dipinjam'
          );
END$$

-- AB-07: hari_terlambat pada denda harus sama dengan selisih tanggal
-- pengembalian dan tanggal jatuh tempo (0 jika tidak terlambat)
CREATE TRIGGER trg_denda_bi
BEFORE INSERT ON denda
FOR EACH ROW
BEGIN
    DECLARE v_hari INT;

    SELECT GREATEST(DATEDIFF(pg.tanggal_pengembalian, p.tanggal_jatuh_tempo), 0) INTO v_hari
    FROM pengembalian pg
    JOIN peminjaman p ON p.id_peminjaman = pg.id_peminjaman
    WHERE pg.id_pengembalian = NEW.id_pengembalian;

    IF v_hari IS NOT NULL AND NEW.hari_terlambat <> v_hari THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'AB-07: hari_terlambat tidak sesuai dengan tanggal jatuh tempo dan tanggal pengembalian.';
    END IF;
END$$

-- Riwayat transaksi tidak boleh dihapus (p02 bagian 7, 9.3, 9.6; TA-1).
-- Data yang tidak aktif cukup diubah statusnya.
-- AB-02: Hanya anggota berstatus Aktif yang dapat melakukan peminjaman.
CREATE TRIGGER trg_peminjaman_bd
BEFORE DELETE ON peminjaman
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Data peminjaman tidak boleh dihapus karena merupakan riwayat transaksi.';
END$$

-- AB-04: maksimal 10 eksemplar per transaksi
-- AB-03: eksemplar hanya dapat dipinjam jika berstatus Tersedia dan tidak sedang tercatat dalam peminjaman aktif
CREATE TRIGGER trg_detail_bd
BEFORE DELETE ON detail_peminjaman
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Detail peminjaman tidak boleh dihapus karena merupakan riwayat transaksi.';
END$$

CREATE TRIGGER trg_pengembalian_bd
BEFORE DELETE ON pengembalian
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Data pengembalian tidak boleh dihapus karena merupakan riwayat transaksi.';
END$$

CREATE TRIGGER trg_denda_bd
BEFORE DELETE ON denda
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Data denda tidak boleh dihapus karena merupakan riwayat transaksi.';
END$$

DELIMITER ;

-- =====================================================================
-- 4. VIEW
-- Data pribadi anggota (alamat dan no. HP) dibatasi (p02 bagian 9.4-9.5).
-- View di bawah tidak memuat kedua kolom tersebut sehingga aman dipakai
-- untuk layanan katalog dan laporan umum.
-- =====================================================================
CREATE OR REPLACE VIEW v_katalog_buku AS
SELECT b.id_buku, b.isbn_buku, b.judul_buku, b.penulis_buku, b.kategori_buku,
       e.id_eksemplar, e.lokasi_eksemplar, e.status_eksemplar
FROM buku b
JOIN eksemplar e ON e.id_buku = b.id_buku;

CREATE OR REPLACE VIEW v_anggota_laporan AS
SELECT nomor_anggota, nama_anggota, status_anggota
FROM anggota;

-- =====================================================================
-- 5. DATA FIKTIF
-- Urutan insert mengikuti ketergantungan FK. Status eksemplar,
-- status_detail, dan status_peminjaman diperbarui otomatis oleh trigger.
-- =====================================================================

-- ---------------------------------------------------------------------
-- ANGGOTA (10) - A008 berstatus Tidak Aktif
-- ---------------------------------------------------------------------
INSERT INTO anggota
    (nomor_anggota, nama_anggota, jenis_kelamin, alamat_anggota, no_hp_anggota, tanggal_daftar, status_anggota)
VALUES
('A001', 'Andi Pratama',     'Laki-laki', 'Jl. Melati No. 10, Metro',          '081234567890', '2026-09-01', 'Aktif'),
('A002', 'Putri Ayu Lestari','Perempuan', 'Jl. Kenanga No. 5, Metro',          '081298765432', '2026-09-02', 'Aktif'),
('A003', 'Rahmat Hidayat',   'Laki-laki', 'Jl. Mawar No. 22, Bandar Lampung',  '085212345678', '2026-09-05', 'Aktif'),
('A004', 'Sinta Maharani',   'Perempuan', 'Jl. Anggrek No. 7, Metro',          '081377788899', '2026-09-10', 'Aktif'),
('A005', 'Dimas Prasetyo',   'Laki-laki', 'Jl. Cempaka No. 15, Pringsewu',     '087855566677', '2026-09-12', 'Aktif'),
('A006', 'Maya Anggraini',   'Perempuan', 'Jl. Dahlia No. 3, Metro',           '082112233445', '2026-09-15', 'Aktif'),
('A007', 'Fajar Nugroho',    'Laki-laki', 'Jl. Flamboyan No. 18, Bandar Lampung','081511223344','2026-09-20', 'Aktif'),
('A008', 'Citra Dewi',       'Perempuan', 'Jl. Teratai No. 9, Metro',          '085766554433', '2026-08-25', 'Tidak Aktif'),
('A009', 'Eko Saputra',      'Laki-laki', 'Jl. Kamboja No. 12, Metro',         '081933322211', '2026-09-25', 'Aktif'),
('A010', 'Nadia Rahmawati',  'Perempuan', 'Jl. Seruni No. 6, Metro',           '089644455566', '2026-10-01', 'Aktif');

-- ---------------------------------------------------------------------
-- PETUGAS (10) - PT003 Kepala/Pengelola, PT008 Tidak Aktif
-- ---------------------------------------------------------------------
INSERT INTO petugas
    (id_petugas, kode_petugas, nama_petugas, peran_petugas, status_petugas)
VALUES
('PT001', 'PET-001', 'Siti Rahma',        'Petugas Perpustakaan',          'Aktif'),
('PT002', 'PET-002', 'Hendra Kurniawan',  'Petugas Perpustakaan',          'Aktif'),
('PT003', 'PET-003', 'Dewi Lestari',      'Kepala/Pengelola Perpustakaan', 'Aktif'),
('PT004', 'PET-004', 'Rizky Maulana',     'Petugas Perpustakaan',          'Aktif'),
('PT005', 'PET-005', 'Fitri Handayani',   'Petugas Perpustakaan',          'Aktif'),
('PT006', 'PET-006', 'Agus Setiawan',     'Petugas Perpustakaan',          'Aktif'),
('PT007', 'PET-007', 'Nurul Aini',        'Petugas Perpustakaan',          'Aktif'),
('PT008', 'PET-008', 'Bambang Wijaya',    'Petugas Perpustakaan',          'Tidak Aktif'),
('PT009', 'PET-009', 'Lina Marlina',      'Petugas Perpustakaan',          'Aktif'),
('PT010', 'PET-010', 'Yoga Saputra',      'Petugas Perpustakaan',          'Aktif');

-- ---------------------------------------------------------------------
-- BUKU (10) - ISBN fiktif
-- ---------------------------------------------------------------------
INSERT INTO buku
    (id_buku, isbn_buku, judul_buku, penulis_buku, penerbit_buku, tahun_terbit_buku, kategori_buku)
VALUES
('B001', '9786020000000', 'Dasar Pemrograman',        'Budi Santoso',      'Lentera Ilmu',     2024, 'Pemrograman'),
('B002', '9786020000017', 'Basis Data Relasional',    'Ratna Wulandari',   'Lentera Ilmu',     2023, 'Basis Data'),
('B003', '9786020000024', 'Struktur Data dan Algoritma','Hendra Gunawan',  'Cahaya Pustaka',   2022, 'Pemrograman'),
('B004', '9786020000031', 'Jaringan Komputer Dasar',  'Taufik Hidayat',    'Nusa Teknik',      2021, 'Jaringan'),
('B005', '9786020000048', 'Sistem Operasi Modern',    'Maria Susanti',     'Cahaya Pustaka',   2023, 'Sistem Komputer'),
('B006', '9786020000055', 'Statistika untuk Pemula',  'Yusuf Ramadhan',    'Mitra Edukasi',    2020, 'Matematika'),
('B007', '9786020000062', 'Pengantar Akuntansi',      'Lestari Wahyuni',   'Mitra Edukasi',    2022, 'Ekonomi'),
('B008', '9786020000079', 'Sejarah Indonesia Modern', 'Darmawan Putra',    'Pustaka Nusantara',2019, 'Sejarah'),
('B009', '9786020000086', 'Cerita Rakyat Nusantara',  'Sri Rahayu',        'Pustaka Nusantara',2018, 'Sastra'),
('B010', '9786020000093', 'Kewirausahaan Digital',    'Andika Permana',    'Lentera Ilmu',     2025, 'Ekonomi');

-- ---------------------------------------------------------------------
-- EKSEMPLAR (18) - E015 sedang diperbaiki (Rusak Berat)
-- Status awal Tersedia; trigger mengubahnya sesuai transaksi di bawah.
-- ---------------------------------------------------------------------
INSERT INTO eksemplar
    (id_eksemplar, id_buku, kode_eksemplar, kondisi_eksemplar, status_eksemplar, lokasi_eksemplar)
VALUES
('E001', 'B001', 'EKS-B001-001', 'Baik',         'Tersedia',        'Rak A-01'),
('E002', 'B001', 'EKS-B001-002', 'Baik',         'Tersedia',        'Rak A-01'),
('E003', 'B001', 'EKS-B001-003', 'Rusak Ringan', 'Tersedia',        'Rak A-01'),
('E004', 'B002', 'EKS-B002-001', 'Baik',         'Tersedia',        'Rak A-02'),
('E005', 'B002', 'EKS-B002-002', 'Baik',         'Tersedia',        'Rak A-02'),
('E006', 'B003', 'EKS-B003-001', 'Rusak Ringan', 'Tersedia',        'Rak A-03'),
('E007', 'B003', 'EKS-B003-002', 'Baik',         'Tersedia',        'Rak A-03'),
('E008', 'B004', 'EKS-B004-001', 'Baik',         'Tersedia',        'Rak B-01'),
('E009', 'B005', 'EKS-B005-001', 'Baik',         'Tersedia',        'Rak B-02'),
('E010', 'B006', 'EKS-B006-001', 'Baik',         'Tersedia',        'Rak C-01'),
('E011', 'B007', 'EKS-B007-001', 'Baik',         'Tersedia',        'Rak C-02'),
('E012', 'B008', 'EKS-B008-001', 'Baik',         'Tersedia',        'Rak D-01'),
('E013', 'B009', 'EKS-B009-001', 'Baik',         'Tersedia',        'Rak D-02'),
('E014', 'B009', 'EKS-B009-002', 'Baik',         'Tersedia',        'Rak D-02'),
('E015', 'B004', 'EKS-B004-002', 'Rusak Berat',  'Dalam Perbaikan', 'Rak B-01'),
('E016', 'B005', 'EKS-B005-002', 'Baik',         'Tersedia',        'Rak B-02'),
('E017', 'B006', 'EKS-B006-002', 'Baik',         'Tersedia',        'Rak C-01'),
('E018', 'B010', 'EKS-B010-001', 'Baik',         'Tersedia',        'Rak E-01');

-- ---------------------------------------------------------------------
-- PEMINJAMAN (10) - masa pinjam 7 hari
-- ---------------------------------------------------------------------
INSERT INTO peminjaman
    (id_peminjaman, nomor_anggota, id_petugas, tanggal_pinjam, tanggal_jatuh_tempo, status_peminjaman)
VALUES
('PJM-20260928-001', 'A002', 'PT002', '2026-09-28', '2026-10-05', 'Berlangsung'),
('PJM-20260930-001', 'A003', 'PT001', '2026-09-30', '2026-10-07', 'Berlangsung'),
('PJM-20261002-001', 'A005', 'PT004', '2026-10-02', '2026-10-09', 'Berlangsung'),
('PJM-20261003-001', 'A006', 'PT002', '2026-10-03', '2026-10-10', 'Berlangsung'),
('PJM-20261005-001', 'A001', 'PT001', '2026-10-05', '2026-10-12', 'Berlangsung'),
('PJM-20261006-001', 'A009', 'PT005', '2026-10-06', '2026-10-13', 'Berlangsung'),
('PJM-20261008-001', 'A004', 'PT001', '2026-10-08', '2026-10-15', 'Berlangsung'),
('PJM-20261009-001', 'A010', 'PT009', '2026-10-09', '2026-10-16', 'Berlangsung'),
('PJM-20261012-001', 'A007', 'PT004', '2026-10-12', '2026-10-19', 'Berlangsung'),
('PJM-20261014-001', 'A002', 'PT010', '2026-10-14', '2026-10-21', 'Berlangsung');

-- ---------------------------------------------------------------------
-- DETAIL_PEMINJAMAN (16) - status_detail default 'Dipinjam'
-- ---------------------------------------------------------------------
INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar)
VALUES
('PJM-20260928-001', 'E004'),
('PJM-20260928-001', 'E006'),
('PJM-20260930-001', 'E008'),
('PJM-20261002-001', 'E009'),
('PJM-20261002-001', 'E010'),
('PJM-20261002-001', 'E011'),
('PJM-20261003-001', 'E012'),
('PJM-20261005-001', 'E001'),
('PJM-20261006-001', 'E002'),
('PJM-20261006-001', 'E013'),
('PJM-20261008-001', 'E014'),
('PJM-20261008-001', 'E016'),
('PJM-20261009-001', 'E005'),
('PJM-20261012-001', 'E007'),
('PJM-20261012-001', 'E017'),
('PJM-20261014-001', 'E003');

-- ---------------------------------------------------------------------
-- PENGEMBALIAN (11)
-- Belum dikembalikan: E013, E016 (sudah lewat jatuh tempo), E007, E017, E003
-- ---------------------------------------------------------------------
INSERT INTO pengembalian
    (id_pengembalian, id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian)
VALUES
('RET-20261006-001', 'PJM-20260928-001', 'E004', 'PT001', '2026-10-06'),
('RET-20261008-001', 'PJM-20260928-001', 'E006', 'PT002', '2026-10-08'),
('RET-20261009-001', 'PJM-20261002-001', 'E009', 'PT004', '2026-10-09'),
('RET-20261010-001', 'PJM-20260930-001', 'E008', 'PT001', '2026-10-10'),
('RET-20261011-001', 'PJM-20261003-001', 'E012', 'PT002', '2026-10-11'),
('RET-20261012-001', 'PJM-20261002-001', 'E010', 'PT004', '2026-10-12'),
('RET-20261014-001', 'PJM-20261005-001', 'E001', 'PT001', '2026-10-14'),
('RET-20261015-001', 'PJM-20261006-001', 'E002', 'PT005', '2026-10-15'),
('RET-20261016-001', 'PJM-20261002-001', 'E011', 'PT009', '2026-10-16'),
('RET-20261017-001', 'PJM-20261008-001', 'E014', 'PT001', '2026-10-17'),
('RET-20261018-001', 'PJM-20261009-001', 'E005', 'PT010', '2026-10-18');

-- ---------------------------------------------------------------------
-- DENDA (10) - Rp8.000 x hari_terlambat
-- RET-20261009-001 tepat waktu, sehingga tidak memiliki catatan denda.
-- ---------------------------------------------------------------------
INSERT INTO denda
    (id_denda, id_pengembalian, hari_terlambat, nominal_denda, status_bayar)
VALUES
('D001', 'RET-20261014-001', 2, 16000, 'Belum Dibayar'),
('D002', 'RET-20261006-001', 1,  8000, 'Sudah Dibayar'),
('D003', 'RET-20261008-001', 3, 24000, 'Sudah Dibayar'),
('D004', 'RET-20261010-001', 3, 24000, 'Sudah Dibayar'),
('D005', 'RET-20261011-001', 1,  8000, 'Sudah Dibayar'),
('D006', 'RET-20261012-001', 3, 24000, 'Belum Dibayar'),
('D007', 'RET-20261015-001', 2, 16000, 'Belum Dibayar'),
('D008', 'RET-20261016-001', 7, 56000, 'Belum Dibayar'),
('D009', 'RET-20261017-001', 2, 16000, 'Belum Dibayar'),
('D010', 'RET-20261018-001', 2, 16000, 'Belum Dibayar');

-- =====================================================================
-- 6. QUERY PENGECEKAN KEBUTUHAN INFORMASI
-- =====================================================================

-- KI-01: daftar anggota aktif
SELECT nomor_anggota, nama_anggota, no_hp_anggota, status_anggota
FROM anggota
WHERE status_anggota = 'Aktif'
ORDER BY nomor_anggota;

-- KI-02: katalog dan ketersediaan buku
SELECT isbn_buku, judul_buku, penulis_buku, kategori_buku,
       id_eksemplar, lokasi_eksemplar, status_eksemplar
FROM v_katalog_buku
ORDER BY id_buku, id_eksemplar;

-- KI-03: riwayat peminjaman anggota (ganti nomor anggota sesuai kebutuhan)
SELECT a.nomor_anggota, a.nama_anggota, p.id_peminjaman, p.tanggal_pinjam, d.id_eksemplar
FROM anggota a
JOIN peminjaman p        ON p.nomor_anggota = a.nomor_anggota
JOIN detail_peminjaman d ON d.id_peminjaman = p.id_peminjaman
WHERE a.nomor_anggota = 'A002'
ORDER BY p.tanggal_pinjam, d.id_eksemplar;

-- KI-04: daftar peminjaman yang masih berlangsung
SELECT a.nomor_anggota, a.nama_anggota, p.id_peminjaman, d.id_eksemplar,
       p.tanggal_pinjam, p.tanggal_jatuh_tempo, p.status_peminjaman
FROM peminjaman p
JOIN anggota a            ON a.nomor_anggota = p.nomor_anggota
JOIN detail_peminjaman d  ON d.id_peminjaman = p.id_peminjaman
WHERE d.status_detail = 'Dipinjam'
ORDER BY p.tanggal_jatuh_tempo;

-- KI-05: daftar pengembalian dalam periode tertentu (ubah rentang tanggal)
SELECT id_pengembalian, id_peminjaman, id_eksemplar, tanggal_pengembalian
FROM pengembalian
WHERE tanggal_pengembalian BETWEEN '2026-10-01' AND '2026-10-18'
ORDER BY tanggal_pengembalian, id_pengembalian;

-- KI-06: peminjaman terlambat (sudah maupun belum dikembalikan)
-- Yang belum dikembalikan dihitung terhadap tanggal hari ini (CURDATE()).
SELECT a.nomor_anggota, a.nama_anggota, p.id_peminjaman, d.id_eksemplar,
       p.tanggal_jatuh_tempo, pg.tanggal_pengembalian,
       DATEDIFF(COALESCE(pg.tanggal_pengembalian, CURDATE()), p.tanggal_jatuh_tempo) AS hari_terlambat
FROM peminjaman p
JOIN anggota a            ON a.nomor_anggota = p.nomor_anggota
JOIN detail_peminjaman d  ON d.id_peminjaman = p.id_peminjaman
LEFT JOIN pengembalian pg ON pg.id_peminjaman = d.id_peminjaman
                         AND pg.id_eksemplar  = d.id_eksemplar
WHERE DATEDIFF(COALESCE(pg.tanggal_pengembalian, CURDATE()), p.tanggal_jatuh_tempo) > 0
ORDER BY hari_terlambat DESC, p.id_peminjaman;

-- KI-07: rekapitulasi denda (daftar, lalu ringkasan per status bayar)
SELECT id_denda, id_pengembalian, hari_terlambat, nominal_denda, status_bayar
FROM denda
ORDER BY id_denda;

SELECT status_bayar, COUNT(*) AS jumlah_denda, SUM(nominal_denda) AS total_nominal
FROM denda
GROUP BY status_bayar;

-- KI-08: buku yang paling banyak dipinjam
SELECT b.id_buku, b.judul_buku, COUNT(*) AS jumlah_dipinjam
FROM detail_peminjaman d
JOIN eksemplar e ON e.id_eksemplar = d.id_eksemplar
JOIN buku b      ON b.id_buku      = e.id_buku
GROUP BY b.id_buku, b.judul_buku
ORDER BY jumlah_dipinjam DESC, b.id_buku
LIMIT 5;

-- =====================================================================
-- 7. UJI ATURAN BISNIS
-- Hapus tanda komentar pada satu blok, lalu jalankan. Setiap blok memakai
-- transaksi dan ROLLBACK sehingga data seed tidak berubah.
-- Pernyataan bertanda "GAGAL" harus menghasilkan error dari trigger.
-- =====================================================================
--
-- AB-02: anggota Tidak Aktif tidak boleh meminjam
-- START TRANSACTION;
-- INSERT INTO peminjaman VALUES ('PJM-20261018-001','A008','PT001','2026-10-18','2026-10-25','Berlangsung');  -- GAGAL
-- ROLLBACK;
--
-- AB-03: E003 masih dipinjam, E015 sedang diperbaiki
-- START TRANSACTION;
-- INSERT INTO peminjaman VALUES ('PJM-20261018-002','A001','PT001','2026-10-18','2026-10-25','Berlangsung');
-- INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar) VALUES ('PJM-20261018-002','E003');  -- GAGAL
-- INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar) VALUES ('PJM-20261018-002','E015');  -- GAGAL
-- ROLLBACK;
--
-- AB-04: eksemplar ke-11 dalam satu transaksi ditolak
-- START TRANSACTION;
-- INSERT INTO peminjaman VALUES ('PJM-20261018-003','A001','PT001','2026-10-18','2026-10-25','Berlangsung');
-- INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar) VALUES
--   ('PJM-20261018-003','E001'),('PJM-20261018-003','E002'),('PJM-20261018-003','E004'),
--   ('PJM-20261018-003','E005'),('PJM-20261018-003','E006'),('PJM-20261018-003','E008'),
--   ('PJM-20261018-003','E009'),('PJM-20261018-003','E010'),('PJM-20261018-003','E011'),
--   ('PJM-20261018-003','E012');                                                                    -- 10 eksemplar: berhasil
-- INSERT INTO detail_peminjaman (id_peminjaman, id_eksemplar) VALUES ('PJM-20261018-003','E014');  -- GAGAL (ke-11)
-- ROLLBACK;
--
-- AB-07: hari_terlambat tidak sesuai (RET-20261009-001 tepat waktu, seharusnya 0)
-- START TRANSACTION;
-- INSERT INTO denda VALUES ('D011','RET-20261009-001',2,16000,'Belum Dibayar');  -- GAGAL
-- ROLLBACK;
--
-- Riwayat transaksi tidak boleh dihapus
-- DELETE FROM denda WHERE id_denda = 'D001';  -- GAGAL
--
-- Tanggal pengembalian tidak boleh lebih awal dari tanggal pinjam
-- START TRANSACTION;
-- INSERT INTO pengembalian VALUES ('RET-20261018-002','PJM-20261012-001','E007','PT001','2026-10-11');  -- GAGAL
-- ROLLBACK;
--
-- Catatan: aturan "satu transaksi minimal memiliki 1 detail" tidak dapat
-- dijamin oleh FK/trigger sederhana, sehingga perlu ditangani di sisi
-- aplikasi atau prosedur tersimpan yang mencatat peminjaman dan detailnya
-- dalam satu transaksi.

-- =====================================================================
-- 8. ROLE HAK AKSES (OPSIONAL)
-- Mengikuti p02 bagian 9.5. Operasi DELETE tidak diberikan kepada siapa pun
-- (matriks CRUD). Hak "anggota hanya melihat data miliknya sendiri" harus
-- diterapkan di lapisan aplikasi karena MySQL tidak punya row-level security.
-- Butuh MySQL 8.0 / MariaDB 10.1+ dan akun dengan hak CREATE ROLE.
-- =====================================================================
-- CREATE ROLE IF NOT EXISTS role_anggota;
-- CREATE ROLE IF NOT EXISTS role_petugas;
-- CREATE ROLE IF NOT EXISTS role_kepala;
--
-- GRANT SELECT ON perpus_016.v_katalog_buku TO role_anggota;
--
-- GRANT SELECT, INSERT, UPDATE ON perpus_016.anggota           TO role_petugas;
-- GRANT SELECT, INSERT, UPDATE ON perpus_016.buku              TO role_petugas;
-- GRANT SELECT, INSERT, UPDATE ON perpus_016.eksemplar         TO role_petugas;
-- GRANT SELECT                 ON perpus_016.petugas           TO role_petugas;
-- GRANT SELECT, INSERT, UPDATE ON perpus_016.peminjaman        TO role_petugas;
-- GRANT SELECT, INSERT, UPDATE ON perpus_016.detail_peminjaman TO role_petugas;
-- GRANT SELECT, INSERT, UPDATE ON perpus_016.pengembalian      TO role_petugas;
-- GRANT SELECT, INSERT, UPDATE ON perpus_016.denda             TO role_petugas;
--
-- GRANT SELECT                 ON perpus_016.anggota           TO role_kepala;
-- GRANT SELECT                 ON perpus_016.buku              TO role_kepala;
-- GRANT SELECT                 ON perpus_016.eksemplar         TO role_kepala;
-- GRANT SELECT, INSERT, UPDATE ON perpus_016.petugas           TO role_kepala;
-- GRANT SELECT                 ON perpus_016.peminjaman        TO role_kepala;
-- GRANT SELECT                 ON perpus_016.detail_peminjaman TO role_kepala;
-- GRANT SELECT                 ON perpus_016.pengembalian      TO role_kepala;
-- GRANT SELECT                 ON perpus_016.denda             TO role_kepala;