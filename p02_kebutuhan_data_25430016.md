# Dokumen Kebutuhan Data - Perpustakaan Lentera AYP

## 1. Latar Belakang dan Aktivitas Organisasi

Perpustakaan Lentera AYP merupakan organisasi fiktif yang menyediakan layanan perpustakaan bagi mahasiswa. Kegiatan utama perpustakaan meliputi pengelolaan data anggota, pengelolaan katalog dan eksemplar buku, pencatatan peminjaman, pencatatan pengembalian, pengelolaan denda, serta penyusunan laporan.

Dalam menjalankan kegiatan tersebut, perpustakaan perlu mengelola berbagai data yang berkaitan dengan anggota, buku, eksemplar, petugas, peminjaman, pengembalian, dan denda. Analisis kebutuhan data dilakukan untuk menentukan data yang perlu dikelola, aturan bisnis yang berlaku, serta informasi yang perlu dihasilkan dari aktivitas perpustakaan.

### 1.1 Aktivitas Utama Organisasi

| No | Aktivitas |
|---|---|
| 1 | Mengelola data anggota |
| 2 | Mengelola data buku dan eksemplar |
| 3 | Mencatat peminjaman buku |
| 4 | Mencatat pengembalian buku |
| 5 | Mengelola denda keterlambatan |
| 6 | Menyusun laporan perpustakaan |
| 7 | Mengelola data petugas |

### 1.2 Parameter Proyek

| Parameter | Nilai |
|---|---:|
| NPM | 25430016 |
| Dua digit terakhir NPM | 16 |
| Perhitungan P | (16 mod 9) + 1 |
| P | **8** |
| Maksimal item per transaksi | **P + 2 = 10** |
| Parameter denda harian | **Rp8.000** |
| Perkiraan volume transaksi harian | **40 + (5 × P) = 80 transaksi/hari** |

## 2. Aktor dan Proses Bisnis

### 2.1 Aktor

| No | Aktor | Peran |
|---|---|---|
| 1 | Anggota | Menggunakan layanan pendaftaran, peminjaman, dan pengembalian buku |
| 2 | Petugas Perpustakaan | Mengelola data anggota, buku, eksemplar, peminjaman, pengembalian, dan denda |
| 3 | Kepala/Pengelola Perpustakaan | Mengelola data petugas serta melihat informasi dan laporan kegiatan perpustakaan |

### 2.2 Proses Bisnis

| Kode | Proses Bisnis | Aktor Utama | Deskripsi |
|---|---|---|---|
| PB-01 | Mengelola Data Anggota | Petugas | Mencatat, membaca, dan mengubah data anggota |
| PB-02 | Mengelola Katalog Buku | Petugas | Mengelola data buku dan eksemplar |
| PB-03 | Mencatat Peminjaman | Petugas | Mencatat transaksi peminjaman buku anggota |
| PB-04 | Mencatat Pengembalian | Petugas | Mencatat transaksi pengembalian buku |
| PB-05 | Mengelola Denda | Petugas | Menghitung dan mencatat denda keterlambatan |
| PB-06 | Menyusun Laporan Perpustakaan | Kepala/Pengelola | Melihat dan menyusun informasi kegiatan perpustakaan |
| PB-07 | Mengelola Data Petugas | Kepala/Pengelola | Mencatat, membaca, dan mengubah data petugas |

## 3. Dokumen Sumber yang Dianalisis

Dokumen sumber digunakan untuk mengidentifikasi elemen data yang muncul dalam aktivitas Perpustakaan Lentera AYP. Dokumen sumber yang dianalisis terdiri dari dokumen transaksi dan dokumen pendukung yang digunakan dalam proses pengelolaan perpustakaan.

### 3.1 Daftar Dokumen Sumber

| No | Dokumen/Data Sumber | Proses Terkait | Tujuan |
|---|---|---|---|
| 1 | Formulir Pendaftaran Anggota | PB-01 Mengelola Data Anggota | Mencatat data anggota saat melakukan pendaftaran |
| 2 | Data Katalog Buku | PB-02 Mengelola Katalog Buku | Mencatat data judul buku yang dimiliki perpustakaan |
| 3 | Data Eksemplar Buku | PB-02 Mengelola Katalog Buku | Mencatat setiap salinan fisik buku beserta status dan lokasinya |
| 4 | Data Petugas | PB-07 Mengelola Data Petugas | Mencatat identitas dan peran petugas perpustakaan |
| 5 | Slip Peminjaman Buku | PB-03 Mencatat Peminjaman | Mencatat informasi transaksi peminjaman buku |
| 6 | Catatan Pengembalian | PB-04 Mencatat Pengembalian | Mencatat informasi transaksi pengembalian buku |
| 7 | Kuitansi Denda | PB-05 Mengelola Denda | Mencatat informasi denda akibat keterlambatan pengembalian |

### 3.2 Formulir Pendaftaran Anggota

| Elemen Data | Contoh Nilai |
|---|---|
| Nomor Anggota | A001 |
| Nama Anggota | Andi Pratama |
| NPM | 25430021 |
| Kelas | 3A |
| No. HP | 081234567890 |
| Status Anggota | Aktif |

**Analisis:**  
Formulir pendaftaran digunakan untuk memperoleh data awal anggota. Elemen data yang diidentifikasi dari formulir ini menjadi dasar untuk entitas **Anggota**, terutama nomor anggota, nama, NPM, kelas, nomor HP, dan status anggota.

### 3.3 Data Katalog Buku

| Elemen Data | Contoh Nilai |
|---|---|
| ID Buku | B001 |
| ISBN | 9786020000000 |
| Judul Buku | Dasar Pemrograman |
| Pengarang | Budi Santoso |
| Kategori Buku | Pemrograman |

**Analisis:**  
Data katalog buku digunakan untuk mencatat informasi yang melekat pada suatu judul buku. Data tersebut menjadi dasar untuk entitas **Buku**. Satu data buku mewakili satu judul buku dan dapat memiliki beberapa eksemplar fisik.

### 3.4 Data Eksemplar Buku

| Elemen Data | Contoh Nilai |
|---|---|
| ID Eksemplar | E001 |
| ID Buku | B001 |
| Status Eksemplar | Tersedia |
| Lokasi Eksemplar | Rak A-01 |

**Analisis:**  
Data eksemplar digunakan untuk mencatat setiap salinan fisik dari suatu judul buku. `id_buku` digunakan untuk menghubungkan eksemplar dengan data **Buku**. Data status dan lokasi digunakan untuk mengetahui kondisi serta keberadaan fisik setiap eksemplar.

### 3.5 Data Petugas

| Elemen Data | Contoh Nilai |
|---|---|
| ID Petugas | PT001 |
| Nama Petugas | Siti Rahma |
| Peran Petugas | Petugas Perpustakaan |

**Analisis:**  
Data petugas digunakan untuk mencatat identitas dan peran petugas yang terlibat dalam pengelolaan perpustakaan. Data tersebut menjadi dasar untuk entitas **Petugas**.

### 3.6 Slip Peminjaman Buku

| Elemen Data | Contoh Nilai |
|---|---|
| Nomor Peminjaman | PJM-20261005-001 |
| Nomor Anggota | A001 |
| Nama Anggota | Andi Pratama |
| ID Eksemplar | E001 |
| Judul Buku | Dasar Pemrograman |
| Tanggal Peminjaman | 05-10-2026 |
| Tanggal Jatuh Tempo | 12-10-2026 |
| ID Petugas | PT001 |
| Nama Petugas | Siti Rahma |

**Analisis:**  
Slip peminjaman digunakan sebagai sumber data untuk mencatat transaksi peminjaman. Nomor peminjaman, nomor anggota, ID petugas, tanggal peminjaman, dan tanggal jatuh tempo menjadi bagian dari entitas **Peminjaman**. ID eksemplar menjadi bagian dari **Detail_Peminjaman**.

Nama anggota dan judul buku yang tercantum pada slip merupakan informasi yang dapat diperoleh dari data anggota dan data buku melalui hubungan antarentitas, sehingga tidak perlu disimpan kembali sebagai elemen baru pada transaksi.

Satu transaksi peminjaman dapat memiliki beberapa eksemplar buku. Batas jumlah eksemplar dalam satu transaksi mengikuti parameter proyek, yaitu maksimal **10 eksemplar**.

### 3.7 Catatan Pengembalian

| Elemen Data | Contoh Nilai |
|---|---|
| ID Pengembalian | RET-20261012-001 |
| ID Peminjaman | PJM-20261005-001 |
| Tanggal Pengembalian | 12-10-2026 |

**Analisis:**  
Catatan pengembalian digunakan untuk mencatat bahwa suatu transaksi peminjaman telah dikembalikan. ID peminjaman digunakan untuk menghubungkan pengembalian dengan transaksi peminjaman yang telah dilakukan sebelumnya.

### 3.8 Kuitansi Denda

| Elemen Data | Contoh Nilai |
|---|---|
| ID Denda | D001 |
| ID Pengembalian | RET-20261012-001 |
| Hari Terlambat | 2 |
| Nominal Denda | Rp16.000 |

**Analisis:**  
Kuitansi denda digunakan sebagai sumber data untuk mencatat denda yang muncul akibat keterlambatan pengembalian. Data ID denda, ID pengembalian, jumlah hari keterlambatan, dan nominal denda menjadi dasar untuk entitas **Denda**.

Nominal denda dihitung berdasarkan jumlah hari keterlambatan dan parameter denda harian proyek sebesar **Rp8.000 per hari**.

## 4. Entitas Kandidat dan Elemen Data

Berdasarkan aktivitas organisasi, proses bisnis, dan dokumen sumber yang dianalisis, diperoleh beberapa entitas kandidat yang diperlukan untuk mengelola data Perpustakaan Lentera AYP.

### 4.1 Daftar Entitas Kandidat

| No | Entitas | Fungsi |
|---|---|---|
| 1 | Anggota | Menyimpan data anggota perpustakaan |
| 2 | Buku | Menyimpan data judul buku yang dimiliki perpustakaan |
| 3 | Eksemplar | Menyimpan data setiap salinan fisik dari suatu buku |
| 4 | Petugas | Menyimpan data petugas perpustakaan |
| 5 | Peminjaman | Menyimpan data transaksi peminjaman |
| 6 | Detail_Peminjaman | Menyimpan data eksemplar yang dipinjam dalam suatu transaksi |
| 7 | Pengembalian | Menyimpan data transaksi pengembalian |
| 8 | Denda | Menyimpan data denda akibat keterlambatan pengembalian |

### 4.2 Elemen Data Kandidat

| Entitas | Elemen Data |
|---|---|
| Anggota | `nomor_anggota`, `nama_anggota`, `npm_anggota`, `kelas_anggota`, `no_hp_anggota`, `status_anggota` |
| Buku | `id_buku`, `isbn`, `judul_buku`, `pengarang`, `kategori_buku` |
| Eksemplar | `id_eksemplar`, `id_buku`, `status_eksemplar`, `lokasi_eksemplar` |
| Petugas | `id_petugas`, `nama_petugas`, `peran_petugas` |
| Peminjaman | `id_peminjaman`, `nomor_anggota`, `id_petugas`, `tanggal_pinjam`, `tanggal_jatuh_tempo` |
| Detail_Peminjaman | `id_peminjaman`, `id_eksemplar` |
| Pengembalian | `id_pengembalian`, `id_peminjaman`, `tanggal_pengembalian` |
| Denda | `id_denda`, `id_pengembalian`, `hari_terlambat`, `nominal_denda` |

### 4.3 Analisis Entitas Buku dan Eksemplar

Entitas **Buku** dan **Eksemplar** dipisahkan karena satu judul buku dapat memiliki lebih dari satu eksemplar fisik.

Entitas **Buku** menyimpan informasi yang melekat pada suatu judul buku, seperti ISBN, judul, pengarang, dan kategori. Sementara itu, entitas **Eksemplar** menyimpan informasi mengenai setiap salinan fisik buku, seperti ID eksemplar, ID buku, status, dan lokasi.

Dengan pemisahan tersebut, satu judul buku dapat memiliki beberapa eksemplar yang berbeda. Setiap eksemplar dapat memiliki status dan lokasi yang berbeda.

Contoh:

| ID Buku | Judul Buku | ID Eksemplar | Status | Lokasi |
|---|---|---|---|---|
| B001 | Dasar Pemrograman | E001 | Tersedia | Rak A-01 |
| B001 | Dasar Pemrograman | E002 | Dipinjam | Rak A-01 |
| B001 | Dasar Pemrograman | E003 | Tersedia | Rak A-01 |

### 4.4 Analisis Data Transaksi

Data transaksi dipisahkan dari data master karena transaksi perlu mempertahankan riwayat kegiatan perpustakaan.

Entitas **Peminjaman** menyimpan informasi utama transaksi, sedangkan **Detail_Peminjaman** menyimpan eksemplar yang termasuk dalam transaksi tersebut. Dengan struktur tersebut, satu transaksi peminjaman dapat mencatat beberapa eksemplar buku.

Entitas **Pengembalian** digunakan untuk mencatat kejadian pengembalian berdasarkan transaksi peminjaman sebelumnya. Data keterlambatan pengembalian kemudian digunakan sebagai dasar untuk pencatatan **Denda**.

### 4.5 Analisis Referensi Antarentitas

Beberapa elemen data digunakan sebagai penghubung antarentitas.

- `nomor_anggota` pada **Peminjaman** mengacu pada data `nomor_anggota` pada **Anggota**.
- `id_petugas` pada **Peminjaman** mengacu pada data `id_petugas` pada **Petugas**.
- `id_buku` pada **Eksemplar** mengacu pada data `id_buku` pada **Buku**.
- `id_peminjaman` pada **Detail_Peminjaman** mengacu pada data `id_peminjaman` pada **Peminjaman**.
- `id_eksemplar` pada **Detail_Peminjaman** mengacu pada data `id_eksemplar` pada **Eksemplar**.
- `id_peminjaman` pada **Pengembalian** mengacu pada data `id_peminjaman` pada **Peminjaman**.
- `id_pengembalian` pada **Denda** mengacu pada data `id_pengembalian` pada **Pengembalian**.

### 4.6 Analisis Elemen Data yang Ditampilkan pada Dokumen

Beberapa informasi yang ditampilkan pada dokumen sumber tidak perlu dibuat sebagai elemen baru apabila informasi tersebut sudah tersedia pada entitas lain.

Contohnya, **nama anggota, NPM, dan kelas** yang ditampilkan pada Slip Peminjaman dapat diperoleh berdasarkan `nomor_anggota` dari entitas **Anggota**. Demikian juga **nama petugas** dapat diperoleh berdasarkan `id_petugas` dari entitas **Petugas**, sedangkan **judul buku** dapat diperoleh melalui hubungan **Eksemplar** dengan **Buku**.

Dengan demikian, informasi tersebut tetap dapat ditampilkan pada slip atau laporan tanpa perlu disimpan kembali sebagai elemen data pada entitas transaksi.

## 5. Aturan Bisnis

Aturan bisnis digunakan untuk menentukan ketentuan yang harus dipenuhi dalam pengelolaan data dan pelaksanaan layanan Perpustakaan Lentera AYP.

| Kode | Aturan Bisnis | Sumber |
|---|---|---|
| AB-01 | Setiap anggota harus memiliki `nomor_anggota` yang unik dan harus terdaftar sebelum melakukan peminjaman. | Rancangan proyek |
| AB-02 | Hanya anggota dengan `status_anggota` = Aktif yang dapat melakukan peminjaman buku. | Rancangan proyek |
| AB-03 | Eksemplar hanya dapat dipinjam apabila `status_eksemplar` = Tersedia. | Rancangan proyek |
| AB-04 | Satu transaksi peminjaman dapat berisi maksimal 10 eksemplar buku. | Parameter proyek |
| AB-05 | Setiap transaksi peminjaman harus mencatat anggota, petugas, tanggal peminjaman, dan tanggal jatuh tempo. | Rancangan proyek |
| AB-06 | Setiap transaksi pengembalian harus terhubung dengan transaksi peminjaman yang sudah ada. | Rancangan proyek |
| AB-07 | Apabila tanggal pengembalian melewati tanggal jatuh tempo, jumlah hari keterlambatan harus dicatat. | Rancangan proyek |
| AB-08 | Denda keterlambatan dihitung sebesar Rp8.000 untuk setiap hari keterlambatan. | Parameter proyek |
| AB-09 | Setiap eksemplar harus terhubung dengan satu judul buku, sedangkan satu judul buku dapat memiliki lebih dari satu eksemplar. | Tema proyek |
| AB-10 | Setiap petugas harus memiliki `id_petugas` yang unik dan memiliki `peran_petugas` yang tercatat. | Rancangan proyek |

## 6. Kebutuhan Informasi

Kebutuhan informasi digunakan untuk menentukan informasi yang perlu tersedia bagi pengguna dalam mendukung kegiatan operasional dan pengelolaan Perpustakaan Lentera AYP.

| Kode | Kebutuhan Informasi | Elemen Data yang Digunakan | Pengguna |
|---|---|---|---|
| KI-01 | Daftar anggota aktif | nomor_anggota, nama_anggota, npm_anggota, kelas_anggota, status_anggota | Petugas |
| KI-02 | Katalog dan ketersediaan buku | isbn, judul_buku, pengarang, kategori_buku, id_eksemplar, lokasi_eksemplar, status_eksemplar | Anggota, Petugas |
| KI-03 | Riwayat peminjaman anggota | nomor_anggota, nama_anggota, id_peminjaman, tanggal_pinjam, id_eksemplar | Petugas |
| KI-04 | Daftar peminjaman yang masih berlangsung | nomor_anggota, nama_anggota, id_eksemplar, tanggal_pinjam, tanggal_jatuh_tempo | Petugas |
| KI-05 | Daftar pengembalian dalam periode tertentu | id_pengembalian, id_peminjaman, tanggal_pengembalian | Petugas, Kepala/Pengelola |
| KI-06 | Daftar peminjaman yang terlambat | nomor_anggota, nama_anggota, id_peminjaman, tanggal_jatuh_tempo, tanggal_pengembalian, hari_terlambat | Petugas |
| KI-07 | Rekapitulasi denda | id_denda, id_pengembalian, hari_terlambat, nominal_denda | Petugas, Kepala/Pengelola |
| KI-08 | Buku yang paling banyak dipinjam | id_buku, judul_buku, id_eksemplar, id_peminjaman | Kepala/Pengelola |

## 7. Matriks CRUD

Matriks CRUD digunakan untuk memeriksa hubungan antara proses bisnis dengan entitas data yang dikelola. Keterangan yang digunakan adalah:

- **C (Create)** = membuat atau menambahkan data
- **R (Read)** = membaca atau menggunakan data
- **U (Update)** = mengubah data
- **D (Delete)** = menghapus data

Pada rancangan Perpustakaan Lentera AYP, operasi Delete tidak digunakan untuk data yang berkaitan dengan riwayat transaksi. Data yang sudah tidak aktif tetap dipertahankan agar riwayat peminjaman, pengembalian, dan denda dapat ditelusuri.

| Proses | Anggota | Buku | Eksemplar | Petugas | Peminjaman | Detail_Peminjaman | Pengembalian | Denda |
|---|---|---|---|---|---|---|---|---|
| PB-01 Mengelola Data Anggota | C/R/U |  |  |  |  |  |  |  |
| PB-02 Mengelola Katalog Buku |  | C/R/U | C/R/U |  |  |  |  |  |
| PB-03 Mencatat Peminjaman | R | R | R/U | R | C/R | C/R |  |  |
| PB-04 Mencatat Pengembalian |  |  | R/U | R | R | R | C/R |  |
| PB-05 Mengelola Denda |  |  |  | R | R |  | R | C/R/U |
| PB-06 Menyusun Laporan Perpustakaan | R | R | R | R | R | R | R | R |
| PB-07 Mengelola Data Petugas |  |  |  | C/R/U |  |  |  |  |

### 7.1 Pemeriksaan CRUD

Berdasarkan matriks CRUD, seluruh entitas memiliki operasi Create:

| Entitas | Proses yang Membuat Data |
|---|---|
| Anggota | PB-01 |
| Buku | PB-02 |
| Eksemplar | PB-02 |
| Petugas | PB-07 |
| Peminjaman | PB-03 |
| Detail_Peminjaman | PB-03 |
| Pengembalian | PB-04 |
| Denda | PB-05 |

Tidak terdapat entitas yang tidak memiliki operasi Create. Dengan demikian, seluruh entitas memiliki proses yang jelas untuk menghasilkan data.

Operasi Delete tidak digunakan pada rancangan ini untuk menjaga data historis. Apabila data sudah tidak aktif, status data dapat diperbarui tanpa menghapus riwayat transaksi yang sudah terjadi.

## 8. Kamus Data Awal

Kamus data awal digunakan untuk menjelaskan elemen data yang diperlukan dalam pengelolaan Perpustakaan Lentera AYP. Setiap elemen data dilengkapi dengan arti, contoh nilai, sumber data, aturan pengisian, dan pihak yang bertanggung jawab.

| No | Elemen Data | Arti | Contoh | Sumber | Aturan | Penanggung Jawab |
|---:|---|---|---|---|---|---|
| 1 | `nomor_anggota` | Nomor identitas unik anggota perpustakaan | A001 | Formulir Pendaftaran Anggota | Harus unik dan tidak boleh kosong | Petugas Perpustakaan |
| 2 | `nama_anggota` | Nama lengkap anggota perpustakaan | Andi Pratama | Formulir Pendaftaran Anggota | Tidak boleh kosong | Petugas Perpustakaan |
| 3 | `npm_anggota` | Nomor pokok mahasiswa anggota | 25430021 | Formulir Pendaftaran Anggota | Mengikuti NPM anggota dan tidak boleh kosong | Petugas Perpustakaan |
| 4 | `kelas_anggota` | Kelas mahasiswa anggota | 3A | Formulir Pendaftaran Anggota | Diisi sesuai data kelas anggota | Petugas Perpustakaan |
| 5 | `no_hp_anggota` | Nomor telepon anggota yang dapat digunakan untuk komunikasi | 081234567890 | Formulir Pendaftaran Anggota | Harus merupakan nomor kontak yang valid | Petugas Perpustakaan |
| 6 | `status_anggota` | Status keaktifan anggota perpustakaan | Aktif | Formulir Pendaftaran Anggota | Nilai yang digunakan antara lain Aktif dan Tidak Aktif | Petugas Perpustakaan |
| 7 | `id_buku` | Identitas unik untuk data judul buku | B001 | Data Katalog Buku | Harus unik dan tidak boleh kosong | Petugas Perpustakaan |
| 8 | `isbn` | Nomor identifikasi standar suatu buku | 9786020000000 | Data Katalog Buku | Diisi sesuai ISBN buku jika tersedia | Petugas Perpustakaan |
| 9 | `judul_buku` | Judul buku yang tercatat pada katalog | Dasar Pemrograman | Data Katalog Buku | Tidak boleh kosong | Petugas Perpustakaan |
| 10 | `pengarang` | Nama pengarang buku | Budi Santoso | Data Katalog Buku | Diisi sesuai informasi pada buku | Petugas Perpustakaan |
| 11 | `kategori_buku` | Kategori atau kelompok buku | Pemrograman | Data Katalog Buku | Diisi sesuai kategori yang digunakan perpustakaan | Petugas Perpustakaan |
| 12 | `id_eksemplar` | Identitas unik setiap salinan fisik buku | E001 | Data Eksemplar Buku | Harus unik dan terhubung dengan satu `id_buku` | Petugas Perpustakaan |
| 13 | `status_eksemplar` | Kondisi atau status ketersediaan eksemplar | Tersedia | Data Eksemplar Buku | Status harus mengikuti kondisi eksemplar | Petugas Perpustakaan |
| 14 | `lokasi_eksemplar` | Lokasi fisik eksemplar di perpustakaan | Rak A-01 | Data Eksemplar Buku | Diisi sesuai lokasi penyimpanan buku | Petugas Perpustakaan |
| 15 | `id_petugas` | Identitas unik petugas perpustakaan | PT001 | Data Petugas | Harus unik dan tidak boleh kosong | Kepala/Pengelola Perpustakaan |
| 16 | `nama_petugas` | Nama lengkap petugas perpustakaan | Siti Rahma | Data Petugas | Tidak boleh kosong | Kepala/Pengelola Perpustakaan |
| 17 | `peran_petugas` | Peran atau jabatan petugas dalam perpustakaan | Petugas Perpustakaan | Data Petugas | Harus menunjukkan peran petugas | Kepala/Pengelola Perpustakaan |
| 18 | `id_peminjaman` | Identitas unik transaksi peminjaman | PJM-20261005-001 | Slip Peminjaman Buku | Harus unik dan tidak boleh kosong | Petugas Perpustakaan |
| 19 | `tanggal_pinjam` | Tanggal ketika transaksi peminjaman dilakukan | 05-10-2026 | Slip Peminjaman Buku | Tidak boleh kosong dan menjadi tanggal awal transaksi | Petugas Perpustakaan |
| 20 | `tanggal_jatuh_tempo` | Tanggal batas pengembalian buku | 12-10-2026 | Slip Peminjaman Buku | Harus setelah atau sesuai tanggal peminjaman | Petugas Perpustakaan |
| 21 | `id_pengembalian` | Identitas unik transaksi pengembalian | RET-20261012-001 | Catatan Pengembalian | Harus unik dan tidak boleh kosong | Petugas Perpustakaan |
| 22 | `tanggal_pengembalian` | Tanggal ketika buku dikembalikan | 12-10-2026 | Catatan Pengembalian | Tidak boleh lebih awal dari tanggal peminjaman | Petugas Perpustakaan |
| 23 | `id_denda` | Identitas unik data denda | D001 | Kuitansi Denda | Harus unik dan tidak boleh kosong | Petugas Perpustakaan |
| 24 | `hari_terlambat` | Jumlah hari keterlambatan pengembalian | 2 | Kuitansi Denda | Bernilai nol atau lebih | Petugas Perpustakaan |
| 25 | `nominal_denda` | Jumlah uang yang dikenakan karena keterlambatan | Rp16.000 | Kuitansi Denda | Dihitung berdasarkan hari keterlambatan dan parameter denda | Petugas Perpustakaan |

## 9. Kebutuhan Data Non-Fungsional

Kebutuhan non-fungsional digunakan untuk menentukan karakteristik pengelolaan data yang tidak hanya berkaitan dengan isi data, tetapi juga volume, penyimpanan, keamanan, privasi, dan hak akses terhadap data.

### 9.1 Volume Data

Berdasarkan parameter proyek, nilai P dihitung dari dua digit terakhir NPM:

**P = (16 mod 9) + 1 = 8**

Dengan demikian, perkiraan volume transaksi harian adalah:

**40 + (5 × P) = 40 + (5 × 8) = 80 transaksi/hari**

Perkiraan tersebut digunakan sebagai dasar untuk mempertimbangkan kebutuhan pengelolaan dan penyimpanan data transaksi perpustakaan.

### 9.2 Batas Jumlah Item dalam Transaksi

Berdasarkan parameter proyek, maksimal jumlah eksemplar dalam satu transaksi peminjaman adalah:

**P + 2 = 8 + 2 = 10 eksemplar**

Batas tersebut digunakan sebagai salah satu aturan dalam proses peminjaman dan dicatat pada aturan bisnis AB-04.

### 9.3 Retensi Data

Data transaksi peminjaman, pengembalian, dan denda perlu dipertahankan agar riwayat kegiatan perpustakaan tetap dapat ditelusuri.

Data historis tidak dihapus ketika transaksi telah selesai. Data tetap disimpan dan dapat digunakan untuk kebutuhan pelaporan, pemeriksaan riwayat anggota, serta evaluasi kegiatan perpustakaan.

Sebagai rancangan proyek, data transaksi direncanakan untuk dipertahankan selama minimal **5 tahun**.

### 9.4 Privasi Data

Beberapa data yang dikelola merupakan data pribadi anggota, antara lain:

- `nama_anggota`
- `npm_anggota`
- `kelas_anggota`
- `no_hp_anggota`

Data tersebut tidak boleh ditampilkan atau diberikan kepada pihak yang tidak memiliki hak akses.

Khusus `no_hp_anggota`, akses dibatasi hanya untuk **Petugas Perpustakaan** dan **Kepala/Pengelola Perpustakaan** sesuai kebutuhan pengelolaan data.

### 9.5 Hak Akses Data

Hak akses data dibedakan berdasarkan peran pengguna:

| Pengguna | Hak Akses |
|---|---|
| Anggota | Melihat informasi katalog dan ketersediaan buku serta menggunakan layanan perpustakaan |
| Petugas Perpustakaan | Mengelola data anggota, buku, eksemplar, peminjaman, pengembalian, dan denda |
| Kepala/Pengelola Perpustakaan | Mengelola data petugas serta melihat informasi dan laporan perpustakaan |

Akses terhadap data pribadi anggota dibatasi sesuai dengan kebutuhan pekerjaan masing-masing pengguna.

### 9.6 Keamanan dan Konsistensi Data

Data yang berkaitan dengan transaksi harus dipertahankan secara konsisten agar riwayat peminjaman, pengembalian, dan denda dapat ditelusuri.

Data transaksi tidak dihapus setelah transaksi selesai. Apabila data master sudah tidak aktif, status data dapat diperbarui tanpa menghapus riwayat transaksi.

Selain itu, setiap identitas utama seperti `nomor_anggota`, `id_buku`, `id_eksemplar`, `id_petugas`, `id_peminjaman`, `id_pengembalian`, dan `id_denda` harus bersifat unik.

### 9.7 Ringkasan Kebutuhan Non-Fungsional

| Aspek | Kebutuhan |
|---|---|
| Volume transaksi | Perkiraan 80 transaksi/hari |
| Maksimal item transaksi | 10 eksemplar per transaksi |
| Retensi data | Minimal 5 tahun sebagai rancangan proyek |
| Privasi | Data pribadi anggota dibatasi aksesnya |
| Akses operasional | Petugas mengelola data operasional |
| Akses laporan | Kepala/Pengelola melihat informasi dan laporan |
| Riwayat transaksi | Peminjaman, pengembalian, dan denda dipertahankan |
| Keunikan data | Identitas utama setiap data harus unik |

## 10. Antisipasi Masalah Kualitas Data

Kualitas data perlu diperhatikan agar data yang disimpan dapat digunakan secara konsisten untuk operasional dan penyusunan laporan perpustakaan. Beberapa masalah kualitas data yang mungkin terjadi pada Perpustakaan Lentera AYP antara lain sebagai berikut.

| No | Potensi Masalah | Contoh | Dampak | Antisipasi |
|---:|---|---|---|---|
| 1 | Data anggota tidak lengkap | Nama atau NPM anggota kosong | Data anggota sulit digunakan untuk identifikasi | Data wajib diperiksa sebelum disimpan |
| 2 | Nomor anggota ganda | Dua anggota memiliki `nomor_anggota` yang sama | Anggota dapat tertukar | `nomor_anggota` harus unik |
| 3 | Data buku tidak konsisten | Penulisan judul atau nama pengarang berbeda-beda | Pencarian dan laporan katalog menjadi tidak konsisten | Data buku diperiksa sebelum disimpan atau diubah |
| 4 | ID eksemplar ganda | Dua eksemplar memiliki `id_eksemplar` yang sama | Eksemplar sulit dibedakan | `id_eksemplar` harus unik |
| 5 | Status eksemplar tidak diperbarui | Buku sudah dipinjam tetapi masih berstatus Tersedia | Buku dapat dianggap masih tersedia | Status diperbarui saat peminjaman dan pengembalian |
| 6 | Tanggal transaksi tidak valid | Tanggal pengembalian lebih awal dari tanggal peminjaman | Riwayat transaksi menjadi tidak logis | Tanggal transaksi harus diperiksa sebelum disimpan |
| 7 | Data denda tidak sesuai | `hari_terlambat` tidak sesuai dengan tanggal pengembalian | Nominal denda dapat menjadi salah | Hari keterlambatan dihitung berdasarkan tanggal transaksi |
| 8 | Data historis berubah atau hilang | Riwayat peminjaman dihapus setelah transaksi selesai | Riwayat transaksi tidak dapat ditelusuri | Data transaksi historis dipertahankan dan tidak dihapus |

### 10.1 Prioritas Penanganan Masalah

Masalah yang perlu mendapat perhatian utama adalah duplikasi identitas, ketidaksesuaian status eksemplar, kesalahan tanggal transaksi, dan perubahan data historis.

Duplikasi identitas dapat menyebabkan data antaranggota, buku, atau eksemplar tertukar. Ketidaksesuaian status eksemplar dapat menyebabkan informasi ketersediaan buku menjadi tidak akurat. Kesalahan tanggal dapat memengaruhi perhitungan keterlambatan dan denda. Sementara itu, penghapusan atau perubahan data historis dapat menyebabkan riwayat transaksi tidak dapat ditelusuri.

Oleh karena itu, data identitas harus dibuat unik, data transaksi harus diperiksa sebelum disimpan, status eksemplar harus diperbarui sesuai transaksi, dan data historis harus dipertahankan.

### Analisis Tambahan

#### TA-1 — Data Historis

Data yang digunakan dalam transaksi perpustakaan perlu mempertahankan kondisi yang terjadi pada saat transaksi berlangsung. Data historis diperlukan agar riwayat peminjaman, pengembalian, dan denda tetap dapat ditelusuri.

Pada proyek Perpustakaan Lentera AYP, data transaksi seperti `id_peminjaman`, `tanggal_pinjam`, `tanggal_jatuh_tempo`, `id_pengembalian`, `tanggal_pengembalian`, `hari_terlambat`, dan `nominal_denda` disimpan sebagai bagian dari data transaksi.

Data transaksi tidak dihapus setelah transaksi selesai. Hal ini dilakukan agar informasi historis tetap tersedia untuk pemeriksaan dan penyusunan laporan.

#### TA-2 — Data Turunan

Beberapa nilai dalam sistem perpustakaan dapat diperoleh melalui proses perhitungan dari data yang sudah tersedia.

Contohnya adalah `hari_terlambat`, yang dapat ditentukan berdasarkan perbedaan antara `tanggal_pengembalian` dan `tanggal_jatuh_tempo`. Selanjutnya, `nominal_denda` dapat dihitung berdasarkan jumlah hari keterlambatan dan parameter denda harian.

Pada rancangan ini, `hari_terlambat` dan `nominal_denda` tetap dicatat pada entitas **Denda** agar hasil perhitungan yang digunakan pada transaksi dapat ditelusuri kembali.

Dengan demikian, data denda dapat digunakan untuk menampilkan riwayat dan laporan denda tanpa harus menghitung ulang seluruh transaksi setiap kali informasi diperlukan.

#### TA-3 — Pemeriksaan Matriks CRUD

Matriks CRUD digunakan untuk memeriksa apakah setiap entitas memiliki proses yang dapat membuat, membaca, atau mengubah data sesuai kebutuhan.

Hasil pemeriksaan menunjukkan bahwa seluruh entitas dalam rancangan memiliki operasi Create:

- **Anggota** dibuat melalui PB-01.
- **Buku** dibuat melalui PB-02.
- **Eksemplar** dibuat melalui PB-02.
- **Petugas** dibuat melalui PB-07.
- **Peminjaman** dibuat melalui PB-03.
- **Detail_Peminjaman** dibuat melalui PB-03.
- **Pengembalian** dibuat melalui PB-04.
- **Denda** dibuat melalui PB-05.

Tidak terdapat entitas yang tidak memiliki proses Create. Dengan demikian, seluruh entitas memiliki alasan keberadaan dan proses bisnis yang menghasilkan datanya.

Operasi Delete tidak digunakan karena data transaksi perlu dipertahankan sebagai riwayat. Untuk data yang sudah tidak aktif, perubahan status digunakan tanpa menghapus data historis.

## Requirement yang Masih Kabur

### Requirement 1 — Keamanan Data Anggota

**Pernyataan awal:**  
"Data anggota harus aman."

**Perbaikan:**  
Data `no_hp_anggota` hanya dapat diakses oleh Petugas Perpustakaan dan Kepala/Pengelola Perpustakaan.

**Pengujian:**  
Pengguna yang tidak memiliki hak akses tidak dapat melihat data `no_hp_anggota`.

### Requirement 2 — Kecepatan Pencarian Buku

**Pernyataan awal:**  
"Sistem harus cepat mencari buku."

**Perbaikan:**  
Pencarian buku berdasarkan `id_buku`, `isbn`, atau `judul_buku` harus menampilkan hasil maksimal dalam waktu 3 detik.

**Pengujian:**  
Melakukan pencarian berdasarkan salah satu parameter tersebut dan mengukur waktu sampai hasil pencarian ditampilkan.

### Requirement 3 — Keakuratan Laporan Stok

**Pernyataan awal:**  
"Laporan stok harus akurat."

**Perbaikan:**  
Informasi ketersediaan buku harus sesuai dengan status terbaru setiap `Eksemplar` setelah transaksi peminjaman atau pengembalian dicatat.

**Pengujian:**  
Setelah transaksi peminjaman atau pengembalian dicatat, memeriksa apakah status `Eksemplar` dan informasi ketersediaan buku telah berubah sesuai dengan transaksi.