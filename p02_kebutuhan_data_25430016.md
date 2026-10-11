# Dokumen Kebutuhan Data - Perpustakaan Lentera AYP

## 1. Latar Belakang dan Aktivitas Organisasi

Perpustakaan Lentera AYP merupakan organisasi fiktif yang menyediakan layanan perpustakaan bagi masyarakat umum. Kegiatan utama perpustakaan meliputi pengelolaan data anggota, pengelolaan katalog dan eksemplar buku, pencatatan peminjaman dan pengembalian buku, pengelolaan denda keterlambatan, serta penyusunan laporan kegiatan perpustakaan.

Dalam menjalankan aktivitasnya, Perpustakaan Lentera AYP membutuhkan pengelolaan data yang terstruktur agar setiap kegiatan dapat berjalan dengan baik. Data yang dikelola meliputi data anggota, buku, eksemplar buku, petugas, peminjaman, detail peminjaman, pengembalian, dan denda. Analisis kebutuhan data dilakukan untuk mengidentifikasi data yang diperlukan, menetapkan aturan bisnis yang berlaku, serta menentukan informasi yang dibutuhkan untuk mendukung kegiatan operasional perpustakaan.

### 1.1 Aktivitas Utama Organisasi

| No | Aktivitas |
|---|---|
| 1 | Mengelola data anggota perpustakaan |
| 2 | Mengelola data buku dan eksemplar buku |
| 3 | Mencatat transaksi peminjaman buku |
| 4 | Mencatat transaksi pengembalian buku |
| 5 | Mengelola denda keterlambatan pengembalian buku |
| 6 | Mengelola data petugas perpustakaan |
| 7 | Menyusun laporan kegiatan perpustakaan |

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
| 1 | Anggota | Melakukan pendaftaran serta menggunakan layanan peminjaman dan pengembalian buku. |
| 2 | Petugas Perpustakaan | Mengelola data anggota, buku, eksemplar buku, serta mencatat transaksi peminjaman, pengembalian, dan denda. |
| 3 | Kepala/Pengelola Perpustakaan | Mengelola data petugas serta memantau informasi dan laporan kegiatan perpustakaan untuk mendukung pengelolaan layanan. |

### 2.2 Proses Bisnis

| Kode | Proses Bisnis | Aktor Utama | Deskripsi |
|---|---|---|---|
| PB-01 | Mengelola Data Anggota | Petugas | Mencatat, melihat, dan memperbarui data anggota perpustakaan. |
| PB-02 | Mengelola Katalog Buku | Petugas | Mengelola data buku dan eksemplar buku, termasuk informasi identitas, kondisi, status, dan lokasi eksemplar. |
| PB-03 | Mencatat Peminjaman | Petugas | Mencatat transaksi peminjaman yang mencakup data anggota, petugas, tanggal peminjaman, tanggal jatuh tempo, dan eksemplar buku yang dipinjam. |
| PB-04 | Mencatat Pengembalian | Petugas | Mencatat pengembalian eksemplar buku berdasarkan transaksi peminjaman yang telah dilakukan. |
| PB-05 | Mengelola Denda | Petugas | Menghitung dan mencatat denda berdasarkan jumlah hari keterlambatan pengembalian serta mencatat status pembayarannya. |
| PB-06 | Menyusun Laporan Perpustakaan | Kepala/Pengelola | Melihat dan menyusun laporan berdasarkan data anggota, koleksi buku, peminjaman, pengembalian, dan denda. |
| PB-07 | Mengelola Data Petugas | Kepala/Pengelola | Mencatat, melihat, dan memperbarui data petugas perpustakaan. |

## 3. Dokumen Sumber yang Dianalisis

Dokumen sumber digunakan sebagai dasar untuk mengidentifikasi elemen data yang dibutuhkan dalam aktivitas Perpustakaan Lentera AYP. Dokumen yang dianalisis mencakup dokumen transaksi dan dokumen pendukung yang berkaitan dengan pengelolaan anggota, buku, peminjaman, pengembalian, dan denda. Hasil analisis dokumen sumber digunakan untuk menentukan kebutuhan data yang akan dikelola, aturan bisnis yang harus diterapkan, serta informasi yang perlu dihasilkan oleh sistem perpustakaan.

### 3.1 Daftar Dokumen Sumber

| No | Dokumen/Data Sumber | Proses Terkait | Tujuan |
|---|---|---|---|
| 1 | Formulir Pendaftaran Anggota | PB-01 Mengelola Data Anggota | Mengumpulkan dan mencatat data anggota saat pendaftaran. |
| 2 | Data Katalog Buku | PB-02 Mengelola Katalog Buku | Mencatat identitas dan informasi setiap judul buku yang dimiliki perpustakaan. |
| 3 | Data Eksemplar Buku | PB-02 Mengelola Katalog Buku | Mencatat setiap salinan fisik buku beserta kondisi, status, dan lokasinya. |
| 4 | Data Petugas | PB-07 Mengelola Data Petugas | Mencatat identitas, kode, dan peran petugas perpustakaan. |
| 5 | Slip Peminjaman Buku | PB-03 Mencatat Peminjaman | Mencatat informasi transaksi peminjaman, termasuk anggota, petugas, tanggal peminjaman, tanggal jatuh tempo, dan buku yang dipinjam. |
| 6 | Catatan Pengembalian | PB-04 Mencatat Pengembalian | Mencatat informasi pengembalian buku berdasarkan transaksi peminjaman. |
| 7 | Kuitansi Denda | PB-05 Mengelola Denda | Mencatat informasi denda keterlambatan dan status pembayarannya. |

### 3.2 Formulir Pendaftaran Anggota

| Elemen Data | Contoh Nilai |
|---|---|
| Nomor Anggota | A001 |
| Nama Anggota | Andi Pratama |
| Jenis Kelamin | Laki-laki |
| Alamat Anggota | Jl. Melati No. 10, Metro |
| No. HP Anggota | 081234567890 |
| Tanggal Daftar | 11-10-2026 |
| Status Anggota | Aktif |

**Analisis:**

Formulir pendaftaran digunakan untuk memperoleh data awal anggota Perpustakaan Lentera AYP. Elemen data yang diidentifikasi dari formulir ini menjadi dasar pembentukan entitas **Anggota**, yang mencakup nomor anggota, nama anggota, jenis kelamin, alamat, nomor HP, tanggal daftar, dan status anggota. Data tersebut digunakan untuk mengidentifikasi anggota serta mendukung proses peminjaman dan pengembalian buku.

### 3.3 Data Katalog Buku

| Elemen Data | Contoh Nilai |
|---|---|
| ID Buku | B001 |
| ISBN Buku | 9786020000000 |
| Judul Buku | Dasar Pemrograman |
| Penulis Buku | Budi Santoso |
| Penerbit Buku | Lentera Ilmu |
| Tahun Terbit Buku | 2024 |
| Kategori Buku | Pemrograman |

**Analisis:**

Data katalog buku digunakan untuk mencatat informasi yang melekat pada suatu judul buku. Data tersebut menjadi dasar pembentukan entitas **Buku**, yang mencakup identitas dan informasi bibliografis buku. Satu data buku mewakili satu judul buku dan dapat memiliki beberapa eksemplar fisik yang dicatat secara terpisah dalam entitas **Eksemplar**.

### 3.4 Data Eksemplar Buku

| Elemen Data | Contoh Nilai |
|---|---|
| ID Eksemplar | E001 |
| ID Buku | B001 |
| Kode Eksemplar | EKS-B001-001 |
| Kondisi Eksemplar | Baik |
| Status Eksemplar | Tersedia |
| Lokasi Eksemplar | Rak A-01 |

**Analisis:**

Data eksemplar digunakan untuk mencatat setiap salinan fisik dari suatu judul buku. `id_buku` digunakan untuk menghubungkan eksemplar dengan entitas **Buku**, sedangkan `id_eksemplar` digunakan untuk mengidentifikasi setiap salinan fisik secara unik. Kode, kondisi, status, dan lokasi eksemplar digunakan untuk membedakan salinan buku serta mengetahui kondisi, ketersediaan, dan tempat penyimpanannya.

### 3.5 Data Petugas

| Elemen Data | Contoh Nilai |
|---|---|
| ID Petugas | PT001 |
| Kode Petugas | PET-001 |
| Nama Petugas | Siti Rahma |
| Peran Petugas | Petugas Perpustakaan |
| Status Petugas | Aktif |

**Analisis:**

Data petugas digunakan untuk mencatat identitas, kode, peran, dan status petugas yang terlibat dalam pengelolaan Perpustakaan Lentera AYP. Data tersebut menjadi dasar pembentukan entitas **Petugas**. Informasi ini digunakan untuk mengidentifikasi petugas yang bertanggung jawab dalam pencatatan transaksi peminjaman, pengembalian, dan pengelolaan data perpustakaan.

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

Slip peminjaman digunakan sebagai sumber data untuk mencatat transaksi peminjaman buku. Nomor peminjaman, nomor anggota, ID petugas, tanggal peminjaman, tanggal jatuh tempo, dan status peminjaman menjadi bagian dari entitas **Peminjaman**. Sementara itu, ID eksemplar menjadi bagian dari entitas **Detail_Peminjaman** untuk mencatat eksemplar yang dipinjam dalam setiap transaksi.

Nama anggota dan judul buku yang tercantum pada slip merupakan informasi yang diperoleh dari data **Anggota** dan **Buku** melalui hubungan antarentitas. Oleh karena itu, kedua informasi tersebut tidak perlu disimpan kembali sebagai atribut pada entitas **Peminjaman**.

Satu transaksi peminjaman dapat mencakup beberapa eksemplar buku. Jumlah eksemplar yang dapat dipinjam dalam satu transaksi mengikuti parameter proyek, yaitu maksimal **10 eksemplar**.

### 3.7 Catatan Pengembalian

| Elemen Data | Contoh Nilai |
|---|---|
| ID Pengembalian | RET-20261014-001 |
| ID Peminjaman | PJM-20261005-001 |
| ID Eksemplar | E001 |
| Tanggal Pengembalian | 14-10-2026 |
| ID Petugas | PT001 |
| Nama Petugas | Siti Rahma |

**Analisis:**

Catatan pengembalian digunakan untuk mencatat pengembalian eksemplar buku yang sebelumnya dipinjam oleh anggota. ID pengembalian digunakan untuk mengidentifikasi setiap catatan pengembalian, sedangkan ID peminjaman dan ID eksemplar digunakan untuk menghubungkan pengembalian dengan eksemplar yang tercatat dalam detail transaksi peminjaman. ID petugas digunakan untuk mencatat petugas yang menangani proses pengembalian.

Tanggal pengembalian digunakan untuk mengetahui kapan eksemplar buku dikembalikan dan menjadi dasar untuk menentukan apakah pengembalian mengalami keterlambatan. Pada contoh ini, buku dikembalikan pada tanggal 14-10-2026, sedangkan tanggal jatuh temponya adalah 12-10-2026. Dengan demikian, pengembalian mengalami keterlambatan selama 2 hari.

### 3.8 Kuitansi Denda

| Elemen Data | Contoh Nilai |
|---|---|
| ID Denda | D001 |
| ID Pengembalian | RET-20261014-001 |
| Hari Terlambat | 2 |
| Nominal Denda | Rp16.000 |
| Status Bayar | Belum Dibayar |

**Analisis:**

Kuitansi denda digunakan sebagai sumber data untuk mencatat denda yang timbul akibat keterlambatan pengembalian buku. Data ID denda, ID pengembalian, jumlah hari keterlambatan, nominal denda, dan status pembayaran menjadi dasar pembentukan entitas **Denda**. ID pengembalian digunakan untuk menghubungkan data denda dengan catatan pengembalian yang terkait.

Nominal denda dihitung berdasarkan jumlah hari keterlambatan dikalikan dengan parameter denda harian proyek sebesar **Rp8.000 per hari**. Dengan demikian, keterlambatan selama dua hari menghasilkan denda sebesar Rp16.000. Status pembayaran digunakan untuk mengetahui apakah denda tersebut sudah dibayar atau belum.

## 4. Entitas Kandidat dan Elemen Data

Berdasarkan aktivitas organisasi, proses bisnis, dan dokumen sumber yang dianalisis, diperoleh delapan entitas kandidat yang diperlukan untuk mengelola data Perpustakaan Lentera AYP. Entitas tersebut mencakup data master dan data transaksi yang saling berhubungan untuk mendukung kegiatan pendaftaran anggota, pengelolaan koleksi buku, peminjaman, pengembalian, dan pengelolaan denda.

### 4.1 Daftar Entitas Kandidat

| No | Entitas | Fungsi |
|---|---|---|
| 1 | Anggota | Menyimpan data anggota perpustakaan. |
| 2 | Buku | Menyimpan data judul dan informasi bibliografis buku. |
| 3 | Eksemplar | Menyimpan data setiap salinan fisik buku beserta kondisi, status, dan lokasinya. |
| 4 | Petugas | Menyimpan data identitas dan peran petugas perpustakaan. |
| 5 | Peminjaman | Menyimpan informasi utama transaksi peminjaman buku. |
| 6 | Detail_Peminjaman | Menyimpan data eksemplar yang dipinjam dalam suatu transaksi peminjaman. |
| 7 | Pengembalian | Menyimpan data pengembalian eksemplar berdasarkan detail transaksi peminjaman. |
| 8 | Denda | Menyimpan data denda keterlambatan pengembalian beserta status pembayarannya. |

### 4.2 Elemen Data Kandidat

| Entitas | Elemen Data |
|---|---|
| Anggota | `nomor_anggota`, `nama_anggota`, `jenis_kelamin`, `alamat_anggota`, `no_hp_anggota`, `tanggal_daftar`, `status_anggota` |
| Buku | `id_buku`, `isbn_buku`, `judul_buku`, `penulis_buku`, `penerbit_buku`, `tahun_terbit_buku`, `kategori_buku` |
| Eksemplar | `id_eksemplar`, `id_buku`, `kode_eksemplar`, `kondisi_eksemplar`, `status_eksemplar`, `lokasi_eksemplar` |
| Petugas | `id_petugas`, `kode_petugas`, `nama_petugas`, `peran_petugas`, `status_petugas` |
| Peminjaman | `id_peminjaman`, `nomor_anggota`, `id_petugas`, `tanggal_pinjam`, `tanggal_jatuh_tempo`, `status_peminjaman` |
| Detail_Peminjaman | `id_peminjaman`, `id_eksemplar`, `status_detail` |
| Pengembalian | `id_pengembalian`, `id_peminjaman`, `id_eksemplar`, `id_petugas`, `tanggal_pengembalian` |
| Denda | `id_denda`, `id_pengembalian`, `hari_terlambat`, `nominal_denda`, `status_bayar` |

### 4.3 Analisis Entitas Buku dan Eksemplar

Entitas **Buku** dan **Eksemplar** dipisahkan karena satu judul buku dapat memiliki beberapa eksemplar fisik.

Entitas **Buku** menyimpan informasi yang melekat pada suatu judul buku, seperti ISBN, judul, penulis, penerbit, tahun terbit, dan kategori. Sementara itu, entitas **Eksemplar** menyimpan informasi setiap salinan fisik buku, seperti kode eksemplar, kondisi, status, dan lokasi penyimpanan.

Melalui pemisahan tersebut, setiap salinan fisik dapat diidentifikasi secara terpisah meskipun berasal dari judul buku yang sama. Setiap eksemplar juga dapat memiliki status dan kondisi yang berbeda.

Contoh:

| ID Buku | Judul Buku | ID Eksemplar | Status Eksemplar | Lokasi Eksemplar |
|---|---|---|---|---|
| B001 | Dasar Pemrograman | E001 | Tersedia | Rak A-01 |
| B001 | Dasar Pemrograman | E002 | Dipinjam | Rak A-01 |
| B001 | Dasar Pemrograman | E003 | Tersedia | Rak A-01 |

### 4.4 Analisis Data Transaksi

Data transaksi dipisahkan dari data master karena transaksi perlu mencatat aktivitas perpustakaan yang terjadi dari waktu ke waktu.

Entitas **Peminjaman** menyimpan informasi utama transaksi, seperti anggota yang meminjam, petugas yang melayani, tanggal peminjaman, tanggal jatuh tempo, dan status peminjaman. Entitas **Detail_Peminjaman** mencatat setiap eksemplar yang termasuk dalam transaksi tersebut. Dengan struktur ini, satu transaksi peminjaman dapat mencakup beberapa eksemplar buku, dengan batas maksimal 10 eksemplar per transaksi.

Entitas **Pengembalian** mencatat pengembalian setiap eksemplar yang terdaftar pada detail peminjaman. Data tanggal pengembalian digunakan untuk menentukan ada atau tidaknya keterlambatan. Apabila terjadi keterlambatan, informasi tersebut dapat digunakan sebagai dasar pencatatan pada entitas **Denda**.

### 4.5 Analisis Referensi Antarentitas

Beberapa elemen data digunakan sebagai penghubung antarentitas melalui mekanisme *foreign key*. Hubungan referensi antarentitas pada Perpustakaan Lentera AYP adalah sebagai berikut.

- `nomor_anggota` pada **Peminjaman** mengacu pada `nomor_anggota` pada **Anggota**.
- `id_petugas` pada **Peminjaman** mengacu pada `id_petugas` pada **Petugas**.
- `id_buku` pada **Eksemplar** mengacu pada `id_buku` pada **Buku**.
- `id_peminjaman` pada **Detail_Peminjaman** mengacu pada `id_peminjaman` pada **Peminjaman**.
- `id_eksemplar` pada **Detail_Peminjaman** mengacu pada `id_eksemplar` pada **Eksemplar**.
- Pasangan `id_peminjaman` dan `id_eksemplar` pada **Pengembalian** mengacu pada pasangan atribut yang sama pada **Detail_Peminjaman**.
- `id_petugas` pada **Pengembalian** mengacu pada `id_petugas` pada **Petugas**.
- `id_pengembalian` pada **Denda** mengacu pada `id_pengembalian` pada **Pengembalian** dan harus bersifat unik (`UNIQUE`), sehingga satu catatan pengembalian hanya dapat memiliki maksimal satu catatan denda.

Referensi tersebut digunakan untuk menjaga keterkaitan data antarentitas dan memastikan bahwa transaksi yang dicatat merujuk pada data anggota, petugas, buku, eksemplar, atau pengembalian yang sesuai.

### 4.6 Analisis Elemen Data yang Ditampilkan pada Dokumen

Beberapa informasi yang ditampilkan pada dokumen sumber tidak perlu disimpan kembali sebagai atribut pada entitas transaksi apabila informasi tersebut sudah tersedia pada entitas lain dan dapat diperoleh melalui hubungan antarentitas.

Contohnya, **nama anggota** dapat diperoleh dari entitas **Anggota** berdasarkan `nomor_anggota`. **Nama petugas** dapat diperoleh dari entitas **Petugas** berdasarkan `id_petugas`, sedangkan **judul buku** dapat diperoleh dari entitas **Buku** melalui hubungan antara **Eksemplar** dan **Buku**.

Dengan demikian, informasi tersebut tetap dapat ditampilkan pada slip peminjaman, catatan pengembalian, atau laporan tanpa perlu disimpan kembali sebagai atribut pada entitas transaksi. Cara ini membantu mengurangi pengulangan data dan menjaga konsistensi informasi yang dikelola.

## 5. Aturan Bisnis

Aturan bisnis digunakan untuk menentukan ketentuan yang harus dipenuhi dalam pengelolaan data dan pelaksanaan layanan Perpustakaan Lentera AYP. Aturan ini menjadi dasar dalam menentukan hubungan antarentitas, validasi data, dan ketentuan transaksi yang diterapkan pada sistem perpustakaan.

| Kode | Aturan Bisnis | Sumber |
|---|---|---|
| AB-01 | Setiap anggota harus memiliki `nomor_anggota` yang unik dan terdaftar sebelum melakukan peminjaman buku. | Rancangan proyek |
| AB-02 | Hanya anggota dengan `status_anggota` = Aktif yang dapat melakukan peminjaman buku. | Rancangan proyek |
| AB-03 | Eksemplar hanya dapat dipinjam apabila `status_eksemplar` = Tersedia dan tidak sedang tercatat dalam transaksi peminjaman aktif. | Rancangan proyek |
| AB-04 | Satu transaksi peminjaman dapat berisi maksimal 10 eksemplar buku. | Parameter proyek |
| AB-05 | Setiap transaksi peminjaman harus mencatat anggota, petugas, tanggal peminjaman, tanggal jatuh tempo, dan status peminjaman. | Rancangan proyek |
| AB-06 | Setiap catatan pengembalian harus terhubung dengan eksemplar yang tercatat pada detail transaksi peminjaman yang valid. | Rancangan proyek |
| AB-07 | Keterlambatan pengembalian ditentukan berdasarkan tanggal pengembalian dan tanggal jatuh tempo. Untuk peminjaman yang belum dikembalikan, keterlambatan dihitung berdasarkan tanggal saat laporan dibuat. Pencatatan denda dilakukan berdasarkan keterlambatan pengembalian yang telah dicatat. | Rancangan proyek |
| AB-08 | Denda keterlambatan dihitung sebesar Rp8.000 untuk setiap hari keterlambatan. | Parameter proyek |
| AB-09 | Setiap eksemplar harus terhubung dengan satu judul buku, sedangkan satu judul buku dapat memiliki satu atau lebih eksemplar. | Tema proyek |
| AB-10 | Setiap petugas harus memiliki `id_petugas` yang unik serta `peran_petugas` yang tercatat. | Rancangan proyek |

## 6. Kebutuhan Informasi

Kebutuhan informasi digunakan untuk menentukan informasi yang perlu tersedia bagi pengguna dalam mendukung kegiatan operasional dan pengelolaan Perpustakaan Lentera AYP. Kebutuhan informasi ini menjadi dasar untuk menentukan data yang perlu diolah dan ditampilkan oleh sistem sesuai dengan aktivitas perpustakaan.

| Kode | Kebutuhan Informasi | Elemen Data yang Digunakan | Pengguna |
|---|---|---|---|
| KI-01 | Daftar anggota aktif | `nomor_anggota`, `nama_anggota`, `no_hp_anggota`, `status_anggota` | Petugas |
| KI-02 | Katalog dan ketersediaan buku | `isbn_buku`, `judul_buku`, `penulis_buku`, `kategori_buku`, `id_eksemplar`, `lokasi_eksemplar`, `status_eksemplar` | Anggota, Petugas |
| KI-03 | Riwayat peminjaman anggota | `nomor_anggota`, `nama_anggota`, `id_peminjaman`, `tanggal_pinjam`, `id_eksemplar` | Petugas |
| KI-04 | Daftar peminjaman yang masih berlangsung | `nomor_anggota`, `nama_anggota`, `id_peminjaman`, `id_eksemplar`, `tanggal_pinjam`, `tanggal_jatuh_tempo`, `status_peminjaman` | Petugas |
| KI-05 | Daftar pengembalian dalam periode tertentu | `id_pengembalian`, `id_peminjaman`, `id_eksemplar`, `tanggal_pengembalian` | Petugas, Kepala/Pengelola |
| KI-06 | Daftar peminjaman yang terlambat, baik yang sudah dikembalikan maupun yang belum dikembalikan | `nomor_anggota`, `nama_anggota`, `id_peminjaman`, `tanggal_jatuh_tempo`, `tanggal_pengembalian`, `hari_terlambat` | Petugas |
| KI-07 | Rekapitulasi denda | `id_denda`, `id_pengembalian`, `hari_terlambat`, `nominal_denda`, `status_bayar` | Petugas, Kepala/Pengelola |
| KI-08 | Buku yang paling banyak dipinjam | `id_buku`, `judul_buku`, `id_eksemplar`, `id_peminjaman` | Kepala/Pengelola |

Untuk KI-06, peminjaman yang belum dikembalikan ditandai dengan `tanggal_pengembalian` yang belum terisi. Hari keterlambatan dihitung berdasarkan selisih antara tanggal saat laporan dibuat dan `tanggal_jatuh_tempo`. Sementara itu, untuk peminjaman yang sudah dikembalikan, hari keterlambatan dihitung berdasarkan selisih antara `tanggal_pengembalian` dan `tanggal_jatuh_tempo`. Peminjaman yang belum melewati tanggal jatuh tempo tidak termasuk dalam daftar peminjaman yang terlambat.

## 7. Matriks CRUD
Matriks CRUD digunakan untuk memeriksa hubungan antara proses bisnis dengan entitas data yang dikelola. Keterangan yang digunakan adalah:

- **C (Create)** = membuat atau menambahkan data.
- **R (Read)** = membaca atau menggunakan data.
- **U (Update)** = mengubah data.
- **D (Delete)** = menghapus data.

Pada rancangan Perpustakaan Lentera AYP, operasi Delete tidak digunakan untuk data transaksi yang memiliki riwayat. Data yang sudah tidak aktif tetap dipertahankan agar riwayat peminjaman, pengembalian, dan denda dapat ditelusuri. Data yang tidak lagi digunakan dapat ditandai dengan status tidak aktif.

| Proses Bisnis | Anggota | Buku | Eksemplar | Petugas | Peminjaman | Detail_Peminjaman | Pengembalian | Denda |
|---|---|---|---|---|---|---|---|---|
| PB-01 Mengelola Data Anggota | C/R/U | – | – | – | – | – | – | – |
| PB-02 Mengelola Katalog Buku | – | C/R/U | C/R/U | – | – | – | – | – |
| PB-03 Mencatat Peminjaman | R | R | R/U | R | C/R | C/R | – | – |
| PB-04 Mencatat Pengembalian | – | – | R/U | R | R/U | R/U | C/R | – |
| PB-05 Mengelola Denda | – | – | – | R | R | R | R | C/R/U |
| PB-06 Menyusun Laporan Perpustakaan | R | R | R | R | R | R | R | R |
| PB-07 Mengelola Data Petugas | – | – | – | C/R/U | – | – | – | – |

Tanda **(–)** menunjukkan bahwa proses bisnis tersebut tidak melakukan operasi CRUD secara langsung terhadap entitas yang bersangkutan.

Setiap entitas memiliki proses yang bertanggung jawab untuk membuat datanya. Entitas Anggota dibuat melalui PB-01, Buku dan Eksemplar melalui PB-02, Peminjaman dan Detail_Peminjaman melalui PB-03, Pengembalian melalui PB-04, Denda melalui PB-05, serta Petugas melalui PB-07.

### 7.1 Pemeriksaan CRUD

Berdasarkan matriks CRUD yang telah dibuat, seluruh entitas memiliki operasi Create (C). Setiap entitas mempunyai proses bisnis yang bertanggung jawab untuk membuat atau menambahkan data ke dalam sistem.

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

Berdasarkan hasil pemeriksaan tersebut, tidak terdapat entitas yang kehilangan operasi Create. Dengan demikian, setiap entitas memiliki proses bisnis yang jelas untuk menghasilkan data.

Operasi Delete (D) tidak digunakan dalam rancangan ini untuk menjaga data historis perpustakaan. Apabila data sudah tidak aktif, status data dapat diperbarui tanpa menghapus riwayat transaksi yang telah terjadi. Dengan cara ini, data peminjaman, pengembalian, dan denda tetap dapat ditelusuri kembali apabila diperlukan.

## 8. Kamus Data Awal

Kamus data awal digunakan untuk menjelaskan elemen data yang diperlukan dalam pengelolaan Perpustakaan Lentera AYP. Setiap elemen data dilengkapi dengan arti, contoh nilai, sumber data, aturan pengisian, dan pihak yang bertanggung jawab. Kamus data ini disusun berdasarkan entitas dan elemen data yang telah ditentukan pada bagian sebelumnya.

| No. | Elemen Data | Arti | Contoh | Sumber | Aturan | Penanggung Jawab |
|---:|---|---|---|---|---|---|
| 1 | `nomor_anggota` | Nomor identitas unik anggota perpustakaan | A001 | Formulir Pendaftaran Anggota | Harus unik dan tidak boleh kosong | Petugas Perpustakaan |
| 2 | `nama_anggota` | Nama lengkap anggota perpustakaan | Andi Pratama | Formulir Pendaftaran Anggota | Tidak boleh kosong | Petugas Perpustakaan |
| 3 | `jenis_kelamin` | Jenis kelamin anggota perpustakaan | Laki-laki | Formulir Pendaftaran Anggota | Diisi sesuai data anggota | Petugas Perpustakaan |
| 4 | `alamat_anggota` | Alamat tempat tinggal anggota | Jl. Melati No. 10 | Formulir Pendaftaran Anggota | Tidak boleh kosong | Petugas Perpustakaan |
| 5 | `no_hp_anggota` | Nomor telepon anggota untuk komunikasi | 081234567890 | Formulir Pendaftaran Anggota | Diisi dengan nomor kontak yang valid | Petugas Perpustakaan |
| 6 | `tanggal_daftar` | Tanggal anggota terdaftar di perpustakaan | 11-10-2026 | Formulir Pendaftaran Anggota | Tidak boleh kosong | Petugas Perpustakaan |
| 7 | `status_anggota` | Status keaktifan anggota perpustakaan | Aktif | Formulir Pendaftaran Anggota | Diisi Aktif atau Tidak Aktif | Petugas Perpustakaan |
| 8 | `id_buku` | Identitas unik data judul buku | B001 | Data Katalog Buku | Harus unik dan tidak boleh kosong | Petugas Perpustakaan |
| 9 | `isbn_buku` | Nomor identifikasi standar buku | 9786020000000 | Data Katalog Buku | Diisi sesuai ISBN jika tersedia | Petugas Perpustakaan |
| 10 | `judul_buku` | Judul buku yang tercatat pada katalog | Dasar Pemrograman | Data Katalog Buku | Tidak boleh kosong | Petugas Perpustakaan |
| 11 | `penulis_buku` | Nama penulis buku | Budi Santoso | Data Katalog Buku | Diisi sesuai informasi pada buku | Petugas Perpustakaan |
| 12 | `penerbit_buku` | Nama penerbit buku | Lentera Ilmu | Data Katalog Buku | Diisi sesuai informasi pada buku | Petugas Perpustakaan |
| 13 | `tahun_terbit_buku` | Tahun penerbitan buku | 2024 | Data Katalog Buku | Diisi sesuai tahun terbit buku | Petugas Perpustakaan |
| 14 | `kategori_buku` | Kategori atau kelompok buku | Pemrograman | Data Katalog Buku | Mengikuti kategori perpustakaan | Petugas Perpustakaan |
| 15 | `id_eksemplar` | Identitas unik setiap salinan fisik buku | E001 | Data Eksemplar Buku | Harus unik dan tidak boleh kosong | Petugas Perpustakaan |
| 16 | `kode_eksemplar` | Kode inventaris salinan fisik buku | EKS-B001-001 | Data Eksemplar Buku | Harus unik | Petugas Perpustakaan |
| 17 | `kondisi_eksemplar` | Kondisi fisik salinan buku | Baik | Data Eksemplar Buku | Diisi sesuai kondisi fisik buku | Petugas Perpustakaan |
| 18 | `status_eksemplar` | Status ketersediaan salinan buku | Tersedia | Data Eksemplar Buku | Diisi sesuai status, misalnya Tersedia atau Dipinjam | Petugas Perpustakaan |
| 19 | `lokasi_eksemplar` | Lokasi penyimpanan fisik buku | Rak A-01 | Data Eksemplar Buku | Diisi sesuai lokasi buku | Petugas Perpustakaan |
| 20 | `id_petugas` | Identitas unik petugas perpustakaan | PT001 | Data Petugas | Harus unik dan tidak boleh kosong | Kepala/Pengelola Perpustakaan |
| 21 | `kode_petugas` | Kode identitas petugas perpustakaan | PET-001 | Data Petugas | Harus unik | Kepala/Pengelola Perpustakaan |
| 22 | `nama_petugas` | Nama lengkap petugas perpustakaan | Siti Rahma | Data Petugas | Tidak boleh kosong | Kepala/Pengelola Perpustakaan |
| 23 | `peran_petugas` | Peran petugas dalam kegiatan perpustakaan | Petugas Perpustakaan | Data Petugas | Harus sesuai peran yang diberikan | Kepala/Pengelola Perpustakaan |
| 24 | `status_petugas` | Status keaktifan petugas | Aktif | Data Petugas | Diisi Aktif atau Tidak Aktif | Kepala/Pengelola Perpustakaan |
| 25 | `id_peminjaman` | Identitas unik transaksi peminjaman | PJM-20261005-001 | Slip Peminjaman | Harus unik dan tidak boleh kosong | Petugas Perpustakaan |
| 26 | `tanggal_pinjam` | Tanggal transaksi peminjaman dilakukan | 05-10-2026 | Slip Peminjaman | Tidak boleh kosong | Petugas Perpustakaan |
| 27 | `tanggal_jatuh_tempo` | Batas waktu pengembalian buku | 12-10-2026 | Slip Peminjaman | Tidak boleh lebih awal dari tanggal peminjaman | Petugas Perpustakaan |
| 28 | `status_peminjaman` | Status transaksi peminjaman | Berlangsung | Data Peminjaman | Diisi sesuai status transaksi | Petugas Perpustakaan |
| 29 | `status_detail` | Status peminjaman untuk setiap eksemplar dalam transaksi | Dipinjam | Data Detail Peminjaman | Diisi sesuai status masing-masing eksemplar | Petugas Perpustakaan |
| 30 | `id_pengembalian` | Identitas unik transaksi pengembalian | RET-20261014-001 | Catatan Pengembalian | Harus unik dan tidak boleh kosong | Petugas Perpustakaan |
| 31 | `tanggal_pengembalian` | Tanggal buku dikembalikan | 14-10-2026 | Catatan Pengembalian | Tidak boleh lebih awal dari tanggal peminjaman | Petugas Perpustakaan |
| 32 | `id_denda` | Identitas unik data denda | D001 | Kuitansi Denda | Harus unik dan tidak boleh kosong | Petugas Perpustakaan |
| 33 | `hari_terlambat` | Jumlah hari keterlambatan pengembalian | 2 | Kuitansi Denda | Bernilai nol atau lebih | Petugas Perpustakaan |
| 34 | `nominal_denda` | Jumlah uang yang dikenakan karena keterlambatan | Rp16.000 | Kuitansi Denda | Dihitung berdasarkan hari keterlambatan dan tarif denda | Petugas Perpustakaan |
| 35 | `status_bayar` | Status pembayaran denda | Belum Dibayar | Kuitansi Denda | Diisi sesuai status pembayaran | Petugas Perpustakaan |

Kamus data awal tersebut menjadi acuan untuk menyamakan nama elemen, arti, aturan pengisian, dan sumber data pada setiap entitas. Dengan demikian, elemen data yang digunakan dalam rancangan basis data tetap konsisten dengan proses bisnis dan kebutuhan informasi perpustakaan.

## 9. Kebutuhan Data Non-Fungsional

Kebutuhan non-fungsional digunakan untuk menentukan karakteristik pengelolaan data yang tidak hanya berkaitan dengan isi data, tetapi juga volume, penyimpanan, keamanan, privasi, dan hak akses terhadap data.

### 9.1 Volume Data

Berdasarkan parameter proyek, nilai P dihitung dari dua digit terakhir NPM, yaitu 16.

**P = (16 mod 9) + 1 = 8**

Dengan demikian, perkiraan volume transaksi harian adalah:

**40 + (5 × P) = 40 + (5 × 8) = 80 transaksi/hari**

Perkiraan tersebut digunakan sebagai dasar untuk mempertimbangkan kebutuhan pengelolaan dan penyimpanan data transaksi perpustakaan.

### 9.2 Batas Jumlah Item dalam Transaksi

Berdasarkan parameter proyek, jumlah maksimal eksemplar dalam satu transaksi peminjaman adalah:

**P + 2 = 8 + 2 = 10 eksemplar**

Batas tersebut digunakan sebagai aturan dalam proses peminjaman dan dicantumkan pada aturan bisnis AB-04. Setiap eksemplar yang dipinjam harus tercatat dalam entitas `Detail_Peminjaman`.

### 9.3 Retensi Data

Data transaksi peminjaman, pengembalian, dan denda perlu dipertahankan agar riwayat kegiatan perpustakaan tetap dapat ditelusuri.

Data historis tidak dihapus ketika transaksi telah selesai. Data tetap disimpan dan dapat digunakan untuk kebutuhan pelaporan, pemeriksaan riwayat peminjaman anggota, serta evaluasi kegiatan perpustakaan.

Sebagai ketentuan dalam rancangan proyek, data transaksi direncanakan untuk dipertahankan selama minimal **5 tahun**. Ketentuan ini merupakan asumsi perancangan dan dapat disesuaikan dengan kebijakan penyimpanan data yang berlaku pada organisasi.

### 9.4 Privasi Data

Data yang dikelola oleh Perpustakaan Lentera AYP mencakup beberapa data pribadi anggota, antara lain:

- `nama_anggota`
- `alamat_anggota`
- `no_hp_anggota`
- `tanggal_daftar`
- `jenis_kelamin`

Data tersebut hanya boleh diakses oleh pihak yang berwenang sesuai dengan kebutuhan pekerjaan. Informasi pribadi anggota tidak boleh diberikan atau ditampilkan kepada pihak yang tidak memiliki hak akses.

Secara khusus, `no_hp_anggota` dan `alamat_anggota` hanya dapat diakses oleh Petugas Perpustakaan dan Kepala/Pengelola Perpustakaan apabila diperlukan untuk keperluan operasional. Anggota hanya dapat melihat informasi miliknya sendiri melalui layanan yang disediakan.

### 9.5 Hak Akses Data

Hak akses data dibedakan berdasarkan peran pengguna agar pengelolaan data tetap terkontrol.

| Pengguna | Hak Akses |
|---|---|
| Anggota | Melihat katalog dan ketersediaan buku serta informasi peminjamannya sendiri melalui layanan perpustakaan |
| Petugas Perpustakaan | Mengelola data anggota, buku, eksemplar, peminjaman, pengembalian, dan denda sesuai tugasnya |
| Kepala/Pengelola Perpustakaan | Mengelola data petugas, memantau kegiatan operasional, serta melihat informasi dan laporan perpustakaan |

Akses terhadap data pribadi anggota dibatasi sesuai kebutuhan masing-masing pengguna. Data pribadi tidak ditampilkan dalam laporan umum apabila tidak diperlukan.

### 9.6 Keamanan dan Konsistensi Data

Data yang berkaitan dengan transaksi harus dipertahankan secara konsisten agar riwayat peminjaman, pengembalian, dan denda dapat ditelusuri.

Data transaksi tidak dihapus setelah transaksi selesai. Apabila data master sudah tidak digunakan, status data dapat diperbarui menjadi tidak aktif tanpa menghapus riwayat transaksi yang berkaitan.

Setiap identitas utama, seperti `nomor_anggota`, `id_buku`, `id_eksemplar`, `id_petugas`, `id_peminjaman`, `id_pengembalian`, dan `id_denda`, harus bersifat unik dan tidak boleh kosong.

Selain itu, hubungan antardata harus dijaga melalui penggunaan kunci utama dan kunci asing. Contohnya, data eksemplar harus terhubung dengan data buku, sedangkan data peminjaman harus terhubung dengan anggota dan petugas yang menangani transaksi.

### 9.7 Ringkasan Kebutuhan Non-Fungsional

| Aspek | Kebutuhan |
|---|---|
| Volume transaksi | Perkiraan 80 transaksi per hari |
| Maksimal item transaksi | 10 eksemplar per transaksi peminjaman |
| Retensi data | Minimal 5 tahun sebagai ketentuan rancangan proyek |
| Privasi | Data pribadi anggota dibatasi aksesnya |
| Akses operasional | Petugas mengelola data operasional sesuai kewenangannya |
| Akses laporan | Kepala/Pengelola dapat memantau kegiatan dan melihat laporan perpustakaan |
| Riwayat transaksi | Data peminjaman, pengembalian, dan denda tetap dipertahankan |
| Keunikan data | Setiap identitas utama harus unik dan tidak boleh kosong |
| Konsistensi data | Hubungan antardata dijaga menggunakan kunci utama dan kunci asing |
| Keamanan akses | Hak akses dibedakan berdasarkan peran pengguna |

## 10. Antisipasi Masalah Kualitas Data

Kualitas data perlu diperhatikan agar data yang disimpan dapat digunakan secara konsisten untuk kegiatan operasional dan penyusunan laporan Perpustakaan Lentera AYP. Beberapa masalah kualitas data yang mungkin terjadi antara lain sebagai berikut.

| No. | Potensi Masalah | Contoh | Dampak | Antisipasi |
|---:|---|---|---|---|
| 1 | Data anggota tidak lengkap | Nama atau nomor telepon anggota kosong | Data anggota sulit digunakan untuk identifikasi dan komunikasi | Data wajib diperiksa sebelum disimpan |
| 2 | Nomor anggota ganda | Dua anggota memiliki `nomor_anggota` yang sama | Data anggota dapat tertukar | `nomor_anggota` harus unik |
| 3 | Data buku tidak konsisten | Penulisan judul atau nama penulis berbeda-beda | Pencarian dan laporan katalog menjadi tidak konsisten | Data buku diperiksa sebelum disimpan atau diubah |
| 4 | ID eksemplar ganda | Dua eksemplar memiliki `id_eksemplar` yang sama | Eksemplar sulit dibedakan | `id_eksemplar` harus unik |
| 5 | Status eksemplar tidak diperbarui | Buku sudah dipinjam tetapi masih berstatus Tersedia | Informasi ketersediaan buku menjadi tidak akurat | Status diperbarui saat peminjaman dan pengembalian |
| 6 | Tanggal transaksi tidak valid | Tanggal pengembalian lebih awal dari tanggal peminjaman | Riwayat transaksi menjadi tidak logis | Tanggal transaksi diperiksa sebelum disimpan |
| 7 | Data denda tidak sesuai | `hari_terlambat` tidak sesuai dengan tanggal jatuh tempo dan pengembalian | Nominal denda dapat menjadi salah | Hari keterlambatan dan nominal denda diperiksa berdasarkan aturan yang berlaku |
| 8 | Data historis berubah atau hilang | Riwayat peminjaman dihapus setelah transaksi selesai | Riwayat transaksi tidak dapat ditelusuri | Data transaksi historis dipertahankan dan tidak dihapus |

### 10.1 Prioritas Penanganan Masalah

Masalah yang perlu mendapat perhatian utama adalah duplikasi identitas, ketidaksesuaian status eksemplar, kesalahan tanggal transaksi, dan perubahan data historis.

Duplikasi identitas dapat menyebabkan data anggota, buku, atau eksemplar tertukar. Ketidaksesuaian status eksemplar dapat menyebabkan informasi ketersediaan buku menjadi tidak akurat. Kesalahan tanggal dapat memengaruhi perhitungan keterlambatan dan denda. Sementara itu, penghapusan atau perubahan data historis yang tidak tepat dapat menyebabkan riwayat transaksi sulit ditelusuri.

Oleh karena itu, setiap identitas utama harus dibuat unik, data transaksi harus diperiksa sebelum disimpan, status eksemplar harus diperbarui sesuai transaksi, dan data historis harus dipertahankan.

### Analisis Tambahan

#### TA-1 — Data Historis

Data transaksi perpustakaan perlu mempertahankan informasi mengenai kejadian yang berlangsung pada saat transaksi dilakukan. Data historis diperlukan agar riwayat peminjaman, pengembalian, dan denda dapat ditelusuri.

Pada proyek Perpustakaan Lentera AYP, elemen seperti `id_peminjaman`, `tanggal_pinjam`, `tanggal_jatuh_tempo`, `id_pengembalian`, `tanggal_pengembalian`, `hari_terlambat`, dan `nominal_denda` disimpan sebagai bagian dari data transaksi.

Data transaksi tidak dihapus setelah transaksi selesai. Hal ini dilakukan agar informasi historis tetap tersedia untuk pemeriksaan dan penyusunan laporan.

#### TA-2 — Data Turunan

Beberapa nilai dalam sistem perpustakaan dapat diperoleh melalui perhitungan berdasarkan data yang sudah tersedia.

Contohnya adalah `hari_terlambat`, yang dihitung berdasarkan selisih antara `tanggal_jatuh_tempo` dan tanggal pengembalian. Apabila buku belum dikembalikan, keterlambatan dapat dihitung berdasarkan tanggal pemeriksaan untuk mengetahui jumlah hari keterlambatan dalam laporan.

Selanjutnya, `nominal_denda` dihitung berdasarkan jumlah hari keterlambatan dan tarif denda sebesar Rp8.000 per hari. Namun, untuk peminjaman yang belum dikembalikan, perhitungan keterlambatan hanya digunakan untuk kebutuhan pemantauan dan pelaporan, bukan untuk secara otomatis membuat catatan pada entitas `Denda`.

Pada rancangan ini, `hari_terlambat` dan `nominal_denda` dicatat pada entitas `Denda` setelah pengembalian dilakukan. Pencatatan tersebut bertujuan agar nilai denda yang berkaitan dengan transaksi pengembalian dapat ditelusuri kembali.

Dengan demikian, data keterlambatan dapat digunakan untuk menampilkan laporan peminjaman yang terlambat, baik yang sudah dikembalikan maupun yang belum dikembalikan, sedangkan data denda digunakan untuk menyimpan riwayat denda berdasarkan transaksi pengembalian.

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

Tidak terdapat entitas yang tidak memiliki proses Create. Dengan demikian, setiap entitas mempunyai proses bisnis yang jelas untuk menghasilkan data.

Operasi Delete tidak digunakan karena data transaksi perlu dipertahankan sebagai riwayat. Untuk data yang sudah tidak aktif, perubahan status dapat dilakukan tanpa menghapus data historis.

### Requirement yang Masih Kabur

#### Requirement 1 — Keamanan Data Anggota

**Pernyataan awal:**

"Data anggota harus aman."

**Perbaikan:**

Data `no_hp_anggota` dan `alamat_anggota` hanya dapat diakses oleh Petugas Perpustakaan dan Kepala/Pengelola Perpustakaan sesuai kebutuhan pekerjaan.

**Pengujian:**

Memastikan pengguna yang tidak memiliki hak akses tidak dapat melihat data nomor telepon dan alamat anggota.

#### Requirement 2 — Kecepatan Pencarian Buku

**Pernyataan awal:**

"Sistem harus cepat mencari buku."

**Perbaikan:**

Pencarian buku berdasarkan `id_buku`, `isbn_buku`, atau `judul_buku` harus menampilkan hasil maksimal dalam waktu 3 detik pada kondisi pengujian yang telah ditentukan.

**Pengujian:**

Melakukan pencarian berdasarkan salah satu parameter tersebut dan mengukur waktu sampai hasil pencarian ditampilkan. Pengujian dilakukan dengan kondisi data dan beban sistem yang ditentukan.

#### Requirement 3 — Keakuratan Laporan Stok

**Pernyataan awal:**

"Laporan stok harus akurat."

**Perbaikan:**

Informasi ketersediaan buku harus sesuai dengan status terbaru setiap `Eksemplar` setelah transaksi peminjaman atau pengembalian dicatat.

**Pengujian:**

Setelah transaksi peminjaman atau pengembalian dicatat, periksa apakah status `Eksemplar` dan informasi ketersediaan buku telah berubah sesuai dengan transaksi.