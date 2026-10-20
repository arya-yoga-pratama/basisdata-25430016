-- =====================================================
-- Modul 5: DDL dan Constraint
-- NPM       : 25430016
-- Studi kasus: Kopma
-- Database  : kopma_016
-- =====================================================

USE kopma_016;

-- Hapus tabel anak terlebih dahulu agar skrip dapat
-- dijalankan ulang. Hanya berlaku di database kopma_016.
DROP TABLE IF EXISTS detail_pembelian;
DROP TABLE IF EXISTS pembelian;
DROP TABLE IF EXISTS detail_penjualan;
DROP TABLE IF EXISTS penjualan;
DROP TABLE IF EXISTS pemasok;
DROP TABLE IF EXISTS barang;
DROP TABLE IF EXISTS anggota;
DROP TABLE IF EXISTS petugas;

-- =====================================================
-- 1. TABEL PETUGAS
-- =====================================================
CREATE TABLE petugas (
    id_petugas SMALLINT NOT NULL AUTO_INCREMENT,
    kode_petugas CHAR(3) NOT NULL,
    nama_petugas VARCHAR(100) NOT NULL,
    peran_petugas ENUM('kasir', 'gudang', 'ketua') NOT NULL,

    PRIMARY KEY (id_petugas),
    UNIQUE KEY uq_petugas_kode (kode_petugas)
) ENGINE=InnoDB;

-- =====================================================
-- 2. TABEL ANGGOTA
-- =====================================================
CREATE TABLE anggota (
    id_anggota INT NOT NULL AUTO_INCREMENT,
    no_anggota CHAR(6) NOT NULL,
    nim_anggota CHAR(10) NOT NULL,
    nama_anggota VARCHAR(100) NOT NULL,
    prodi_anggota VARCHAR(60) NOT NULL,
    no_hp_anggota VARCHAR(15) NULL,
    status_anggota ENUM('aktif', 'nonaktif')
        NOT NULL DEFAULT 'aktif',
    tgl_daftar_anggota DATE NOT NULL,

    PRIMARY KEY (id_anggota),
    UNIQUE KEY uq_anggota_no (no_anggota),
    UNIQUE KEY uq_anggota_nim (nim_anggota)
) ENGINE=InnoDB;

-- =====================================================
-- 3. TABEL BARANG
-- =====================================================
CREATE TABLE barang (
    id_barang INT NOT NULL AUTO_INCREMENT,
    kode_barang VARCHAR(10) NOT NULL,
    nama_barang VARCHAR(100) NOT NULL,
    kategori_barang ENUM('ATK', 'makanan', 'minuman') NOT NULL,
    harga_jual_barang DECIMAL(12,2) NOT NULL,
    stok_barang INT NOT NULL DEFAULT 0,
    stok_min_barang INT NOT NULL DEFAULT 5,

    PRIMARY KEY (id_barang),
    UNIQUE KEY uq_barang_kode (kode_barang),

    CONSTRAINT ck_barang_stok
        CHECK (stok_barang >= 0),

    CONSTRAINT ck_barang_harga
        CHECK (harga_jual_barang >= 0)
) ENGINE=InnoDB;

-- =====================================================
-- 4. TABEL PEMASOK
-- =====================================================
CREATE TABLE pemasok (
    id_pemasok INT NOT NULL AUTO_INCREMENT,
    nama_pemasok VARCHAR(100) NOT NULL,
    telepon_pemasok VARCHAR(15) NULL,
    alamat_pemasok VARCHAR(200) NULL,

    PRIMARY KEY (id_pemasok)
) ENGINE=InnoDB;

-- =====================================================
-- 5. TABEL PENJUALAN
-- =====================================================
CREATE TABLE penjualan (
    id_penjualan INT NOT NULL AUTO_INCREMENT,
    no_nota_penjualan CHAR(12) NOT NULL,
    tgl_penjualan DATETIME NOT NULL,
    id_petugas SMALLINT NOT NULL,
    id_anggota INT NULL,
    bayar_penjualan DECIMAL(12,2) NOT NULL,

    PRIMARY KEY (id_penjualan),
    UNIQUE KEY uq_penjualan_nota (no_nota_penjualan),

    CONSTRAINT fk_penjualan_petugas
        FOREIGN KEY (id_petugas)
        REFERENCES petugas (id_petugas),

    CONSTRAINT fk_penjualan_anggota
        FOREIGN KEY (id_anggota)
        REFERENCES anggota (id_anggota)
) ENGINE=InnoDB;

-- =====================================================
-- 6. TABEL DETAIL PENJUALAN
-- =====================================================
CREATE TABLE detail_penjualan (
    id_penjualan INT NOT NULL,
    id_barang INT NOT NULL,
    qty_detail_penjualan SMALLINT NOT NULL,
    harga_satuan_detail_penjualan DECIMAL(12,2) NOT NULL,

    PRIMARY KEY (id_penjualan, id_barang),

    CONSTRAINT fk_detail_penjualan
        FOREIGN KEY (id_penjualan)
        REFERENCES penjualan (id_penjualan)
        ON DELETE CASCADE,

    CONSTRAINT fk_detail_barang
        FOREIGN KEY (id_barang)
        REFERENCES barang (id_barang),

    CONSTRAINT ck_detail_qty
        CHECK (qty_detail_penjualan > 0)
) ENGINE=InnoDB;

-- =====================================================
-- 7. TABEL PEMBELIAN
-- =====================================================
CREATE TABLE pembelian (
    id_pembelian INT NOT NULL AUTO_INCREMENT,
    no_faktur_pembelian VARCHAR(20) NOT NULL,
    tgl_pembelian DATE NOT NULL,
    id_pemasok INT NOT NULL,
    status_pembelian ENUM('dipesan', 'diterima')
        NOT NULL DEFAULT 'dipesan',

    PRIMARY KEY (id_pembelian),

    CONSTRAINT fk_pembelian_pemasok
        FOREIGN KEY (id_pemasok)
        REFERENCES pemasok (id_pemasok)
) ENGINE=InnoDB;

-- =====================================================
-- 8. TABEL DETAIL PEMBELIAN
-- =====================================================
CREATE TABLE detail_pembelian (
    id_pembelian INT NOT NULL,
    id_barang INT NOT NULL,
    qty_detail_pembelian INT NOT NULL,
    harga_beli_detail_pembelian DECIMAL(12,2) NOT NULL,

    PRIMARY KEY (id_pembelian, id_barang),

    CONSTRAINT fk_dbeli_pembelian
        FOREIGN KEY (id_pembelian)
        REFERENCES pembelian (id_pembelian)
        ON DELETE CASCADE,

    CONSTRAINT fk_dbeli_barang
        FOREIGN KEY (id_barang)
        REFERENCES barang (id_barang),

    CONSTRAINT ck_dbeli_qty
        CHECK (qty_detail_pembelian > 0)
) ENGINE=InnoDB;

-- =====================================================
-- PENGISIAN DATA FIKTIF (10 DATA PER TABEL)
-- Urutan: tabel induk terlebih dahulu, lalu tabel anak
-- =====================================================

-- 1. Data petugas
INSERT INTO petugas (id_petugas, kode_petugas, nama_petugas, peran_petugas) VALUES
(1, 'K01', 'Rina Wulandari', 'kasir'),
(2, 'K02', 'Budi Santoso', 'kasir'),
(3, 'K03', 'Siti Aminah', 'kasir'),
(4, 'K04', 'Dimas Ardiansyah', 'kasir'),
(5, 'G01', 'Agus Salim', 'gudang'),
(6, 'G02', 'Lestari Ningsih', 'gudang'),
(7, 'G03', 'Rizky Fauzan', 'gudang'),
(8, 'T01', 'Hendra Wijaya', 'ketua'),
(9, 'K05', 'Maya Anggraini', 'kasir'),
(10, 'G04', 'Yoga Prasetyo', 'gudang');

-- 2. Data anggota
INSERT INTO anggota (id_anggota, no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota) VALUES
(1, 'AGT001', '2215061001', 'Aditya Pratama', 'Teknik Informatika', '081234567801', 'aktif', '2025-08-18'),
(2, 'AGT002', '2215061002', 'Bunga Maharani', 'Sistem Informasi', '081234567802', 'aktif', '2025-08-18'),
(3, 'AGT003', '2215061003', 'Cahyo Nugroho', 'Teknik Elektro', '081234567803', 'aktif', '2025-08-20'),
(4, 'AGT004', '2215061004', 'Dewi Lestari', 'Manajemen', '081234567804', 'aktif', '2025-08-25'),
(5, 'AGT005', '2215061005', 'Eko Saputra', 'Akuntansi', '081234567805', 'aktif', '2025-09-01'),
(6, 'AGT006', '2215061006', 'Fitri Handayani', 'Agribisnis', '081234567806', 'aktif', '2025-09-03'),
(7, 'AGT007', '2215061007', 'Gilang Ramadhan', 'Teknik Sipil', '081234567807', 'nonaktif', '2024-08-19'),
(8, 'AGT008', '2215061008', 'Hana Permata', 'Ilmu Komunikasi', NULL, 'aktif', '2025-09-10'),
(9, 'AGT009', '2215061009', 'Indra Kurniawan', 'Teknik Mesin', '081234567809', 'aktif', '2025-09-15'),
(10, 'AGT010', '2215061010', 'Jasmine Putri', 'Hukum', '081234567810', 'nonaktif', '2024-09-02');

-- 3. Data barang
INSERT INTO barang (id_barang, kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang) VALUES
(1, 'BRG001', 'Buku Tulis', 'ATK', 5000.00, 20, 5),
(2, 'BRG002', 'Pulpen Hitam', 'ATK', 3000.00, 50, 10),
(3, 'BRG003', 'Pensil 2B', 'ATK', 2500.00, 40, 10),
(4, 'BRG004', 'Penggaris 30 cm', 'ATK', 4000.00, 4, 5),
(5, 'BRG005', 'Roti Cokelat', 'makanan', 6000.00, 30, 10),
(6, 'BRG006', 'Keripik Singkong', 'makanan', 8000.00, 24, 6),
(7, 'BRG007', 'Mie Instan Cup', 'makanan', 7500.00, 36, 8),
(8, 'BRG008', 'Air Mineral 600 ml', 'minuman', 3500.00, 60, 12),
(9, 'BRG009', 'Teh Botol', 'minuman', 5000.00, 48, 12),
(10, 'BRG010', 'Kopi Sachet', 'minuman', 2500.00, 80, 20);

-- 4. Data pemasok
INSERT INTO pemasok (id_pemasok, nama_pemasok, telepon_pemasok, alamat_pemasok) VALUES
(1, 'CV Sumber Makmur', '0215550101', 'Jl. Merdeka No. 12, Jakarta'),
(2, 'PT Karya Tulis Nusantara', '0215550102', 'Jl. Kenanga No. 5, Tangerang'),
(3, 'UD Berkah Jaya', '0711550103', 'Jl. Sudirman No. 21, Palembang'),
(4, 'PT Roti Sejahtera', '0225550104', 'Jl. Braga No. 8, Bandung'),
(5, 'CV Aneka Snack Mandiri', '0215550105', 'Jl. Raya Bekasi No. 77, Bekasi'),
(6, 'CV Alat Tulis Prima', '0215550106', 'Jl. Melati No. 3, Depok'),
(7, 'UD Segar Abadi', '0711550107', 'Jl. Veteran No. 45, Palembang'),
(8, 'PT Tirta Murni', '0215550108', 'Jl. Industri No. 10, Cikarang'),
(9, 'CV Kopi Nusa', '0274550109', 'Jl. Malioboro No. 19, Yogyakarta'),
(10, 'Toko Grosir Sentosa', '0215550110', NULL);

-- 5. Data penjualan
INSERT INTO penjualan (id_penjualan, no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan) VALUES
(1, 'NT2610120001', '2026-10-12 08:15:00', 1, 1, 20000.00),
(2, 'NT2610130001', '2026-10-13 09:30:00', 2, 2, 10000.00),
(3, 'NT2610140001', '2026-10-14 10:05:00', 3, NULL, 10000.00),
(4, 'NT2610150001', '2026-10-15 11:20:00', 4, 3, 6000.00),
(5, 'NT2610160001', '2026-10-16 12:45:00', 1, 4, 20000.00),
(6, 'NT2610160002', '2026-10-16 13:10:00', 9, NULL, 15000.00),
(7, 'NT2610170001', '2026-10-17 14:00:00', 2, 5, 20000.00),
(8, 'NT2610180001', '2026-10-18 09:50:00', 3, 6, 10000.00),
(9, 'NT2610190001', '2026-10-19 10:30:00', 4, 8, 15000.00),
(10, 'NT2610190002', '2026-10-19 15:25:00', 1, NULL, 5000.00);

-- 6. Data detail penjualan
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan) VALUES
(1, 1, 3, 5000.00),
(2, 2, 2, 3000.00),
(3, 8, 2, 3500.00),
(4, 5, 1, 6000.00),
(5, 7, 2, 7500.00),
(6, 9, 3, 5000.00),
(7, 6, 2, 8000.00),
(8, 3, 4, 2500.00),
(9, 10, 5, 2500.00),
(10, 4, 1, 4000.00);

-- 7. Data pembelian
INSERT INTO pembelian (id_pembelian, no_faktur_pembelian, tgl_pembelian, id_pemasok, status_pembelian) VALUES
(1, 'PB/2026/10/0001', '2026-10-01', 1, 'diterima'),
(2, 'PB/2026/10/0002', '2026-10-02', 2, 'diterima'),
(3, 'PB/2026/10/0003', '2026-10-03', 3, 'diterima'),
(4, 'PB/2026/10/0004', '2026-10-05', 4, 'diterima'),
(5, 'PB/2026/10/0005', '2026-10-06', 5, 'diterima'),
(6, 'PB/2026/10/0006', '2026-10-08', 6, 'diterima'),
(7, 'PB/2026/10/0007', '2026-10-09', 7, 'diterima'),
(8, 'PB/2026/10/0008', '2026-10-12', 8, 'diterima'),
(9, 'PB/2026/10/0009', '2026-10-15', 9, 'dipesan'),
(10, 'PB/2026/10/0010', '2026-10-17', 10, 'dipesan');

-- 8. Data detail pembelian
INSERT INTO detail_pembelian (id_pembelian, id_barang, qty_detail_pembelian, harga_beli_detail_pembelian) VALUES
(1, 2, 100, 2000.00),
(2, 1, 60, 3500.00),
(3, 6, 48, 5500.00),
(4, 5, 40, 4200.00),
(5, 7, 48, 5500.00),
(6, 3, 80, 1700.00),
(7, 9, 72, 3800.00),
(8, 8, 120, 2400.00),
(9, 10, 200, 1700.00),
(10, 4, 30, 2800.00);

-- =====================================================
-- PEMERIKSAAN HASIL
-- =====================================================
SHOW TABLES;

SHOW CREATE TABLE penjualan;