-- =====================================================================
-- p06_data_kopma_25430016.sql
-- Modul 6 - Data sampel Kopma (studi kasus buku praktikum)
-- NPM : 25430016   |   Database : kopma_016
-- =====================================================================
USE kopma_016;
SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- D.1 DATA INDUK (INSERT banyak baris; id AUTO_INCREMENT dimulai dari 1)
-- ---------------------------------------------------------------------
-- petugas (id 1-5; K03 Rina = id 3 sesuai nota contoh pada buku)
INSERT INTO petugas (kode_petugas, nama_petugas, peran_petugas) VALUES
  ('K01', 'Dimas', 'kasir'),
  ('K02', 'Sari', 'kasir'),
  ('K03', 'Rina', 'kasir'),
  ('G01', 'Joko', 'gudang'),
  ('P01', 'Ketua Kopma', 'ketua');

-- barang (4 baris pertama sama dengan contoh buku; 4 baris berikutnya tambahan)
INSERT INTO barang (kode_barang, nama_barang, kategori_barang, harga_jual_barang, stok_barang, stok_min_barang) VALUES
  ('ATK-001', 'Pulpen Gel 0.5', 'ATK', 4000, 120, 20),
  ('ATK-002', 'Buku Tulis 58', 'ATK', 6500, 80, 20),
  ('MNM-001', 'Air Mineral 600', 'minuman', 4000, 48, 24),
  ('MKN-001', 'Roti Cokelat', 'makanan', 5000, 6, 10),
  ('ATK-003', 'Penghapus Putih', 'ATK', 2500, 60, 15),
  ('ATK-004', 'Map Plastik Folio', 'ATK', 3000, 40, 10),
  ('MNM-002', 'Teh Kotak 350', 'minuman', 5500, 36, 24),
  ('MKN-002', 'Keripik Singkong', 'makanan', 7000, 25, 10);

-- ---------------------------------------------------------------------
-- D.1 langkah 2: anggota (7 baris; 3 berstatus nonaktif) dan pemasok (3 baris)
-- Anggota nonaktif dirancang untuk Latihan E.1:
--   A-0087 : nonaktif, daftar 2023, tanpa penjualan   -> boleh diarsipkan
--   A-0094 : nonaktif, daftar 2024, MASIH punya nota  -> tidak boleh ikut terhapus
--   A-0099 : nonaktif, daftar 2025                    -> bukan 'sebelum 2025'
-- ---------------------------------------------------------------------
INSERT INTO anggota (no_anggota, nim_anggota, nama_anggota, prodi_anggota, no_hp_anggota, status_anggota, tgl_daftar_anggota) VALUES
  ('A-0101', '2543010101', 'Naufal Ardiansyah', 'Teknik Informatika', '081377200101', 'aktif', '2026-08-18'),
  ('A-0102', '2543010214', 'Salsabila Nur Aini', 'Sistem Informasi', '082280113402', 'aktif', '2026-08-18'),
  ('A-0103', '2543010327', 'Rangga Mahendra', 'Manajemen', NULL, 'aktif', '2026-08-25'),
  ('A-0104', '2543010433', 'Putri Ayu Wardani', 'Akuntansi', '085269304418', 'aktif', '2026-09-01'),
  ('A-0087', '2343020512', 'Fikri Ramadhan', 'Teknik Elektro', NULL, 'nonaktif', '2023-08-14'),
  ('A-0094', '2443020618', 'Maharani Septiani', 'Manajemen', '081911765320', 'nonaktif', '2024-02-20'),
  ('A-0099', '2543030725', 'Galih Prakoso', 'Sistem Informasi', '087815220934', 'nonaktif', '2025-03-05');

INSERT INTO pemasok (nama_pemasok, telepon_pemasok, alamat_pemasok) VALUES
  ('CV Sumber Tulis Lampung', '0721-481-2290', 'Jl. Teuku Umar No. 45, Bandar Lampung'),
  ('UD Segar Jaya Minuman', '0721-702-5518', 'Jl. Ki Maja No. 12, Bandar Lampung'),
  ('PT Cita Rasa Nusantara', '0721-266-9034', 'Jl. Pramuka No. 88, Bandar Lampung');

-- ---------------------------------------------------------------------
-- D.2 NOTA PENJUALAN
-- Harga satuan disalin dari barang.harga_jual_barang lewat INSERT ... SELECT (AB-04).
-- Nota contoh PJ-2609-0142 harus menjadi id_penjualan = 1 (dipakai buku), jadi diisi pertama.
-- bayar_penjualan = uang yang diterima kasir (>= total nota; diskon 5% dibahas di Modul 8+).
-- ---------------------------------------------------------------------
-- Nota contoh Modul 2 (langkah 3 dan 4 buku)
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0142', '2026-09-24 10:15:00', 3, 1, 30000);
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 3, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'ATK-001'
WHERE p.no_nota_penjualan = 'PJ-2609-0142';
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 2, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'ATK-002'
WHERE p.no_nota_penjualan = 'PJ-2609-0142';
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 1, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'MNM-001'
WHERE p.no_nota_penjualan = 'PJ-2609-0142';

-- Nota lain (id_penjualan 2 dst.), 22-25 September 2026
INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0138', '2026-09-22 09:40:00', 1, 2, 11000);
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 2, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'ATK-003'
WHERE p.no_nota_penjualan = 'PJ-2609-0138';
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 1, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'MNM-002'
WHERE p.no_nota_penjualan = 'PJ-2609-0138';

INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0139', '2026-09-22 13:05:00', 2, NULL, 15000);
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 1, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'MKN-001'
WHERE p.no_nota_penjualan = 'PJ-2609-0139';
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 2, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'MNM-001'
WHERE p.no_nota_penjualan = 'PJ-2609-0139';

INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0140', '2026-09-23 08:55:00', 1, 3, 20000);
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 3, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'ATK-004'
WHERE p.no_nota_penjualan = 'PJ-2609-0140';
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 1, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'ATK-001'
WHERE p.no_nota_penjualan = 'PJ-2609-0140';
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 1, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'ATK-003'
WHERE p.no_nota_penjualan = 'PJ-2609-0140';

INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0141', '2026-09-23 14:20:00', 3, NULL, 25000);
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 2, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'MKN-002'
WHERE p.no_nota_penjualan = 'PJ-2609-0141';
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 2, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'MNM-002'
WHERE p.no_nota_penjualan = 'PJ-2609-0141';

INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0143', '2026-09-24 15:30:00', 2, 6, 10000);
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 1, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'MKN-001'
WHERE p.no_nota_penjualan = 'PJ-2609-0143';
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 1, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'MNM-001'
WHERE p.no_nota_penjualan = 'PJ-2609-0143';

INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0144', '2026-09-25 10:05:00', 1, NULL, 15000);
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 1, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'ATK-002'
WHERE p.no_nota_penjualan = 'PJ-2609-0144';
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 2, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'ATK-001'
WHERE p.no_nota_penjualan = 'PJ-2609-0144';

INSERT INTO penjualan (no_nota_penjualan, tgl_penjualan, id_petugas, id_anggota, bayar_penjualan)
VALUES ('PJ-2609-0145', '2026-09-25 16:10:00', 3, 4, 20000);
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 1, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'MKN-001'
WHERE p.no_nota_penjualan = 'PJ-2609-0145';
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 2, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'MNM-001'
WHERE p.no_nota_penjualan = 'PJ-2609-0145';
INSERT INTO detail_penjualan (id_penjualan, id_barang, qty_detail_penjualan, harga_satuan_detail_penjualan)
SELECT p.id_penjualan, b.id_barang, 1, b.harga_jual_barang
FROM penjualan p JOIN barang b ON b.kode_barang = 'MKN-002'
WHERE p.no_nota_penjualan = 'PJ-2609-0145';

-- ---------------------------------------------------------------------
-- D.2 langkah 4: kurangi stok sesuai qty yang terjual (WHERE memakai kolom kunci id_barang)
-- Urutan id_barang mengikuti urutan INSERT barang: 1 ATK-001, 2 ATK-002, 3 MNM-001, 4 MKN-001,
-- 5 ATK-003, 6 ATK-004, 7 MNM-002, 8 MKN-002.
-- ---------------------------------------------------------------------
UPDATE barang SET stok_barang = stok_barang - 6 WHERE id_barang = 1;  -- ATK-001 terjual 6
UPDATE barang SET stok_barang = stok_barang - 3 WHERE id_barang = 2;  -- ATK-002 terjual 3
UPDATE barang SET stok_barang = stok_barang - 6 WHERE id_barang = 3;  -- MNM-001 terjual 6
UPDATE barang SET stok_barang = stok_barang - 3 WHERE id_barang = 4;  -- MKN-001 terjual 3
UPDATE barang SET stok_barang = stok_barang - 3 WHERE id_barang = 5;  -- ATK-003 terjual 3
UPDATE barang SET stok_barang = stok_barang - 3 WHERE id_barang = 6;  -- ATK-004 terjual 3
UPDATE barang SET stok_barang = stok_barang - 3 WHERE id_barang = 7;  -- MNM-002 terjual 3
UPDATE barang SET stok_barang = stok_barang - 3 WHERE id_barang = 8;  -- MKN-002 terjual 3

-- ---------------------------------------------------------------------
-- PEMBELIAN dari pemasok (AB-06: roti dan keripik di bawah/dekat stok minimum dipesan)
-- Stok awal pada tabel barang sudah memperhitungkan pembelian berstatus 'diterima'.
-- ---------------------------------------------------------------------
INSERT INTO pembelian (no_faktur_pembelian, tgl_pembelian, id_pemasok, status_pembelian)
VALUES ('FB-2609-0001', '2026-09-01', 1, 'diterima');
INSERT INTO detail_pembelian (id_pembelian, id_barang, qty_detail_pembelian, harga_beli_detail_pembelian)
SELECT p.id_pembelian, b.id_barang, 50, 2800
FROM pembelian p JOIN barang b ON b.kode_barang = 'ATK-001'
WHERE p.no_faktur_pembelian = 'FB-2609-0001';
INSERT INTO detail_pembelian (id_pembelian, id_barang, qty_detail_pembelian, harga_beli_detail_pembelian)
SELECT p.id_pembelian, b.id_barang, 40, 4500
FROM pembelian p JOIN barang b ON b.kode_barang = 'ATK-002'
WHERE p.no_faktur_pembelian = 'FB-2609-0001';
INSERT INTO detail_pembelian (id_pembelian, id_barang, qty_detail_pembelian, harga_beli_detail_pembelian)
SELECT p.id_pembelian, b.id_barang, 60, 1600
FROM pembelian p JOIN barang b ON b.kode_barang = 'ATK-003'
WHERE p.no_faktur_pembelian = 'FB-2609-0001';

INSERT INTO pembelian (no_faktur_pembelian, tgl_pembelian, id_pemasok, status_pembelian)
VALUES ('FB-2609-0002', '2026-09-15', 2, 'diterima');
INSERT INTO detail_pembelian (id_pembelian, id_barang, qty_detail_pembelian, harga_beli_detail_pembelian)
SELECT p.id_pembelian, b.id_barang, 48, 2800
FROM pembelian p JOIN barang b ON b.kode_barang = 'MNM-001'
WHERE p.no_faktur_pembelian = 'FB-2609-0002';
INSERT INTO detail_pembelian (id_pembelian, id_barang, qty_detail_pembelian, harga_beli_detail_pembelian)
SELECT p.id_pembelian, b.id_barang, 24, 3900
FROM pembelian p JOIN barang b ON b.kode_barang = 'MNM-002'
WHERE p.no_faktur_pembelian = 'FB-2609-0002';

INSERT INTO pembelian (no_faktur_pembelian, tgl_pembelian, id_pemasok, status_pembelian)
VALUES ('FB-2609-0003', '2026-09-23', 3, 'dipesan');
INSERT INTO detail_pembelian (id_pembelian, id_barang, qty_detail_pembelian, harga_beli_detail_pembelian)
SELECT p.id_pembelian, b.id_barang, 30, 3500
FROM pembelian p JOIN barang b ON b.kode_barang = 'MKN-001'
WHERE p.no_faktur_pembelian = 'FB-2609-0003';
INSERT INTO detail_pembelian (id_pembelian, id_barang, qty_detail_pembelian, harga_beli_detail_pembelian)
SELECT p.id_pembelian, b.id_barang, 20, 4800
FROM pembelian p JOIN barang b ON b.kode_barang = 'MKN-002'
WHERE p.no_faktur_pembelian = 'FB-2609-0003';

-- ---------------------------------------------------------------------
-- PEMERIKSAAN HASIL (untuk tangkapan layar laporan)
-- ---------------------------------------------------------------------
SELECT 'petugas' AS tabel, COUNT(*) AS jumlah_baris FROM petugas
UNION ALL SELECT 'anggota', COUNT(*) FROM anggota
UNION ALL SELECT 'barang', COUNT(*) FROM barang
UNION ALL SELECT 'pemasok', COUNT(*) FROM pemasok
UNION ALL SELECT 'penjualan', COUNT(*) FROM penjualan
UNION ALL SELECT 'detail_penjualan', COUNT(*) FROM detail_penjualan
UNION ALL SELECT 'pembelian', COUNT(*) FROM pembelian
UNION ALL SELECT 'detail_pembelian', COUNT(*) FROM detail_pembelian;

-- Nota contoh beserta subtotal tiap baris
SELECT p.no_nota_penjualan, b.nama_barang, d.qty_detail_penjualan AS qty,
       d.harga_satuan_detail_penjualan AS harga_satuan,
       d.qty_detail_penjualan * d.harga_satuan_detail_penjualan AS subtotal
FROM penjualan p
JOIN detail_penjualan d ON d.id_penjualan = p.id_penjualan
JOIN barang b ON b.id_barang = d.id_barang
WHERE p.no_nota_penjualan = 'PJ-2609-0142';

-- Stok akhir per barang dibanding stok minimum
SELECT kode_barang, nama_barang, stok_barang, stok_min_barang FROM barang ORDER BY id_barang;