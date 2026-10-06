# Kebutuhan Data Kopma

**Nama:** Arya Yoga Pratama  
**NPM:** 25430016  
**Kelas:** A  
**Pertemuan:** 2  
**Studi Kasus:** Koperasi Mahasiswa Sejahtera (Kopma)

## 1. Studi Kasus

**Koperasi Mahasiswa Sejahtera (Kopma)** merupakan unit usaha fiktif di lingkungan kampus yang menjual berbagai kebutuhan mahasiswa, mulai dari alat tulis hingga makanan dan minuman ringan. Kopma tidak hanya melayani anggota, tetapi juga melayani pembeli umum.

Mahasiswa yang ingin menjadi anggota dapat mendaftarkan diri dengan menyerahkan data berupa NIM, nama lengkap, program studi, dan nomor HP. Setelah terdaftar, mahasiswa akan mendapatkan nomor anggota dengan format **A-xxxx**. Anggota yang berstatus aktif mendapatkan keuntungan berupa **diskon 5% setiap kali melakukan pembelian**.

Kegiatan operasional Kopma sehari-hari dilakukan oleh tiga orang kasir yang bekerja secara bergantian menggunakan sistem sif. Kasir bertugas mencatat transaksi penjualan dan mencetak nota. Selain kasir, terdapat petugas gudang yang bertugas mengecek jumlah stok barang setiap sore. Jika terdapat barang yang jumlah stoknya sudah sedikit atau telah mencapai batas minimal, petugas gudang membuat daftar pesanan pembelian atau **Purchase Order (PO)** untuk diserahkan kepada *supplier*.

Ketika barang yang dipesan datang dari *supplier*, stok barang pada sistem akan diperbarui berdasarkan faktur pembelian. Selanjutnya, pada awal setiap bulan ketua koperasi menerima laporan bulanan sebagai bahan evaluasi. Laporan tersebut berisi total pendapatan atau omzet, daftar barang yang paling banyak terjual, daftar barang yang stoknya mulai menipis, serta anggota yang paling sering melakukan pembelian.

### Permasalahan yang Ditemukan

Berdasarkan hasil wawancara pada studi kasus tersebut, terdapat beberapa permasalahan dalam kegiatan operasional Kopma, yaitu:

1. **Harga barang sering berubah.** Kopma membutuhkan sistem yang dapat menyimpan riwayat perubahan harga agar harga pada transaksi yang sudah terjadi tetap sesuai dengan harga saat transaksi dilakukan.

2. **Pencatatan stok belum sinkron.** Dalam beberapa kondisi, jumlah stok yang tercatat pada sistem tidak sesuai dengan kondisi sebenarnya. Bahkan, terdapat kemungkinan stok pada sistem menunjukkan angka minus.

3. **Anggota sering lupa membawa kartu anggota.** Oleh karena itu, kasir membutuhkan cara alternatif untuk mengecek status anggota. Pengecekan tersebut diharapkan dapat dilakukan dengan memasukkan **NIM anggota** tanpa harus menggunakan kartu member.

## 2. Aktor dan Proses Bisnis

Dalam kegiatan operasional Kopma terdapat beberapa aktor yang memiliki tugas masing-masing. Aktor tersebut terlibat dalam proses pendaftaran anggota, transaksi penjualan, pengelolaan stok barang, penerimaan barang, dan pembuatan laporan bulanan.

| Kode | Proses Bisnis | Aktor | Pemicu |
|---|---|---|---|
| PB-01 | Mendaftarkan anggota | Kasir | Mahasiswa ingin menjadi anggota |
| PB-02 | Mencatat penjualan | Kasir | Pembeli melakukan pembayaran di kasir |
| PB-03 | Memesan barang ke pemasok | Petugas gudang | Stok barang berada di bawah batas minimum |
| PB-04 | Menerima barang dari pemasok | Petugas gudang | Barang datang bersama faktur |
| PB-05 | Menyusun laporan bulanan | Ketua koperasi | Awal bulan |

### Penjelasan Proses Bisnis

1. **PB-01 – Mendaftarkan anggota**  
   Kasir melayani mahasiswa yang ingin menjadi anggota Kopma. Data mahasiswa kemudian dicatat sebagai data anggota.

2. **PB-02 – Mencatat penjualan**  
   Kasir mencatat barang yang dibeli ketika pembeli melakukan pembayaran. Pembeli dapat berasal dari anggota maupun masyarakat umum.

3. **PB-03 – Memesan barang ke pemasok**  
   Petugas gudang melakukan pengecekan stok barang. Jika stok suatu barang berada di bawah batas minimum, petugas gudang membuat pesanan pembelian kepada pemasok.

4. **PB-04 – Menerima barang dari pemasok**  
   Ketika barang yang dipesan sudah datang, petugas gudang melakukan pengecekan berdasarkan faktur pemasok. Setelah itu, jumlah stok barang diperbarui sesuai barang yang diterima.

5. **PB-05 – Menyusun laporan bulanan**  
   Pada awal bulan, ketua koperasi menerima laporan mengenai kegiatan Kopma. Laporan tersebut digunakan untuk melihat omzet, barang yang paling banyak terjual, barang yang stoknya rendah, dan anggota yang paling aktif melakukan pembelian.

## 3. Dokumen Sumber

Dokumen sumber yang digunakan dalam analisis kebutuhan data Kopma salah satunya adalah **nota penjualan**. Nota digunakan sebagai bukti transaksi yang dilakukan oleh pembeli.

Dari nota penjualan dapat diketahui beberapa data yang dibutuhkan dalam pencatatan transaksi, seperti nomor nota, tanggal dan waktu transaksi, kasir, data anggota jika pembeli merupakan anggota, barang yang dibeli, jumlah barang, dan harga barang saat transaksi.

Data harga barang pada saat transaksi perlu diperhatikan karena harga jual barang dapat berubah. Oleh karena itu, harga yang tercatat pada transaksi harus tetap menunjukkan harga yang berlaku ketika pembelian dilakukan, meskipun harga barang tersebut berubah di kemudian hari.

### Data yang Diperoleh dari Nota Penjualan

| Data | Keterangan |
|---|---|
| Nomor nota | Nomor yang digunakan sebagai identitas transaksi |
| Tanggal dan waktu | Menunjukkan kapan transaksi dilakukan |
| Kasir | Petugas yang menangani transaksi |
| Anggota | Data anggota jika pembeli merupakan anggota |
| Barang | Barang yang dibeli |
| Jumlah | Banyaknya barang yang dibeli |
| Harga saat transaksi | Harga jual barang ketika transaksi dilakukan |
| Diskon | Potongan harga yang diperoleh anggota aktif |
| Total pembayaran | Jumlah yang harus dibayarkan oleh pembeli |

### Analisis Data Turunan

Beberapa nilai pada nota dapat diperoleh dari perhitungan data lainnya. Contohnya, subtotal dapat dihitung berdasarkan jumlah barang dikalikan dengan harga saat transaksi. Total pembayaran juga dapat dihitung berdasarkan subtotal dan diskon yang diberikan.

Dengan demikian, tidak semua nilai hasil perhitungan harus disimpan sebagai data tersendiri. Namun, harga barang pada saat transaksi tetap perlu dicatat karena harga tersebut dapat berbeda dengan harga barang yang berlaku saat ini.

## 4. Entitas Kandidat dan Elemen Data

Berdasarkan proses bisnis dan dokumen sumber yang telah dianalisis, terdapat beberapa entitas yang dapat digunakan dalam perancangan basis data Kopma. Entitas tersebut berasal dari data yang dibutuhkan dalam kegiatan anggota, penjualan, pengelolaan barang, petugas, pemasok, dan pembelian.

| Entitas | Elemen Data |
|---|---|
| Anggota | Nomor anggota, NIM, nama, program studi, nomor HP, status aktif |
| Barang | Kode barang, nama barang, kategori, harga jual, stok, batas minimum stok |
| Penjualan | Nomor nota, tanggal dan waktu, kasir, anggota (opsional), bayar |
| Detail Penjualan | Nomor nota, barang, jumlah, harga saat transaksi |
| Petugas | Kode petugas, nama, peran |
| Pemasok | Kode pemasok, nama, nomor telepon, alamat |
| Pembelian | Nomor faktur, tanggal, pemasok |
| Detail Pembelian | Nomor faktur, barang, jumlah, harga beli |

### Penjelasan Entitas

1. **Anggota**  
   Entitas anggota digunakan untuk menyimpan data mahasiswa yang terdaftar sebagai anggota Kopma. Data yang dicatat meliputi nomor anggota, NIM, nama, program studi, nomor HP, dan status keaktifan anggota.

2. **Barang**  
   Entitas barang menyimpan informasi mengenai barang yang dijual oleh Kopma. Data yang diperlukan antara lain kode barang, nama, kategori, harga jual, jumlah stok, dan batas minimum stok.

3. **Penjualan**  
   Entitas penjualan digunakan untuk mencatat informasi utama dari setiap transaksi. Setiap transaksi memiliki nomor nota, waktu transaksi, kasir yang melayani, dan data anggota jika pembeli merupakan anggota.

4. **Detail Penjualan**  
   Entitas detail penjualan digunakan untuk mencatat barang yang terdapat dalam suatu transaksi. Data yang dicatat meliputi nomor nota, barang, jumlah yang dibeli, dan harga barang pada saat transaksi.

5. **Petugas**  
   Entitas petugas menyimpan data orang yang terlibat dalam kegiatan operasional Kopma. Peran petugas dapat berupa kasir, petugas gudang, atau ketua.

6. **Pemasok**  
   Entitas pemasok digunakan untuk menyimpan informasi pihak yang memasok barang ke Kopma, seperti kode pemasok, nama, nomor telepon, dan alamat.

7. **Pembelian**  
   Entitas pembelian digunakan untuk mencatat transaksi pembelian barang dari pemasok. Data utamanya berupa nomor faktur, tanggal pembelian, dan pemasok.

8. **Detail Pembelian**  
   Entitas detail pembelian mencatat barang yang diterima dari pemasok dalam suatu transaksi pembelian, termasuk jumlah barang dan harga belinya.

## 5. Aturan Bisnis

Aturan bisnis digunakan untuk menentukan ketentuan yang harus dipenuhi dalam kegiatan operasional Kopma. Berdasarkan studi kasus, terdapat beberapa aturan yang perlu diperhatikan dalam sistem.

| Kode | Aturan Bisnis |
|---|---|
| AB-01 | Setiap nota penjualan memiliki nomor yang unik dan minimal memiliki satu barang yang dibeli. |
| AB-02 | Transaksi penjualan dapat dilakukan tanpa anggota. Jika pembeli merupakan anggota, maka anggota tersebut harus berstatus aktif untuk mendapatkan diskon 5%. |
| AB-03 | Stok barang tidak boleh bernilai negatif. Transaksi penjualan ditolak jika jumlah barang yang dibeli melebihi stok yang tersedia. |
| AB-04 | Harga yang digunakan pada nota merupakan harga barang saat transaksi dan disimpan pada setiap detail penjualan. Harga tersebut tidak berubah walaupun harga barang saat ini mengalami kenaikan. |
| AB-05 | NIM anggota harus unik. Data anggota dapat dicari menggunakan nomor anggota maupun NIM. |
| AB-06 | Pemesanan barang kepada pemasok dilakukan ketika stok barang berada di bawah batas minimum yang telah ditentukan. |

### Penjelasan Aturan Bisnis

1. **AB-01**  
   Setiap transaksi harus memiliki nomor nota yang berbeda. Selain itu, sebuah transaksi tidak dapat dibuat jika belum memiliki barang yang dibeli.

2. **AB-02**  
   Pembeli umum tetap dapat melakukan pembelian tanpa menjadi anggota. Namun, jika pembeli merupakan anggota, statusnya harus aktif agar mendapatkan diskon sebesar 5%.

3. **AB-03**  
   Sistem harus mencegah stok menjadi negatif. Jika jumlah barang yang ingin dibeli lebih banyak daripada stok yang tersedia, transaksi tidak dapat dilanjutkan.

4. **AB-04**  
   Harga barang yang digunakan dalam transaksi harus disimpan pada detail penjualan. Hal ini diperlukan agar harga pada transaksi lama tetap sesuai dengan harga ketika transaksi tersebut terjadi.

5. **AB-05**  
   Setiap anggota harus mempunyai NIM yang berbeda. Kasir juga dapat mencari data anggota menggunakan nomor anggota atau NIM ketika anggota tidak membawa kartu.

6. **AB-06**  
   Jika stok suatu barang sudah berada di bawah batas minimum, petugas gudang perlu melakukan pemesanan kepada pemasok.

## 6. Kebutuhan Informasi

Kebutuhan informasi dibuat berdasarkan laporan yang dibutuhkan oleh ketua koperasi dan kebutuhan dalam kegiatan operasional Kopma. Informasi tersebut nantinya digunakan untuk melihat kondisi penjualan, stok barang, dan aktivitas anggota.

| Kode | Kebutuhan Informasi | Data yang Diperlukan |
|---|---|---|
| KI-01 | Omzet dan jumlah nota per hari dan per bulan | Penjualan, Detail Penjualan |
| KI-02 | Lima barang terlaris per bulan berdasarkan jumlah terjual | Detail Penjualan, Barang |
| KI-03 | Barang yang memiliki stok di bawah batas minimum | Barang |
| KI-04 | Sepuluh anggota dengan jumlah belanja terbesar per bulan | Penjualan, Detail Penjualan, Anggota |

### Penjelasan Kebutuhan Informasi

1. **KI-01 – Omzet dan jumlah nota**  
   Informasi ini digunakan untuk mengetahui jumlah omzet dan jumlah transaksi penjualan yang terjadi setiap hari maupun setiap bulan.

2. **KI-02 – Lima barang terlaris**  
   Informasi ini digunakan untuk mengetahui lima barang yang paling banyak terjual dalam satu bulan berdasarkan jumlah barang yang terjual.

3. **KI-03 – Barang dengan stok di bawah batas minimum**  
   Informasi ini digunakan untuk mengetahui barang yang jumlah stoknya sudah berada di bawah batas minimum. Data tersebut dapat membantu petugas gudang menentukan barang yang perlu dipesan kembali.

4. **KI-04 – Sepuluh anggota dengan belanja terbesar**  
   Informasi ini digunakan untuk mengetahui sepuluh anggota yang memiliki jumlah pembelian terbesar dalam satu bulan.

## 7. Matriks CRUD

Matriks CRUD digunakan untuk melihat hubungan antara proses bisnis dengan entitas data yang digunakan. CRUD terdiri dari Create (C), Read (R), Update (U), dan Delete (D).

Keterangan:
- **C (Create)** = membuat atau menambahkan data
- **R (Read)** = membaca atau menggunakan data
- **U (Update)** = mengubah data
- **D (Delete)** = menghapus data

| Proses | Anggota | Barang | Penjualan | Detail | Pemasok | Pembelian |
|---|---|---|---|---|---|---|
| PB-01 Daftar anggota | C |  |  |  |  |  |
| PB-02 Catat penjualan | R | R, U | C | C |  |  |
| PB-03 Pesan ke pemasok |  | R |  |  | R | C |
| PB-04 Terima barang |  | U |  |  | R | U |
| PB-05 Laporan bulanan | R | R | R | R | R | R |

### Penjelasan Matriks CRUD

1. **PB-01 – Daftar anggota**  
   Proses ini membuat data baru pada entitas Anggota sehingga memiliki operasi **Create (C)**.

2. **PB-02 – Catat penjualan**  
   Pada saat transaksi dilakukan, data anggota dapat dibaca untuk mengecek status anggota. Data barang dibaca dan stoknya diperbarui. Setelah itu, data transaksi dan detail barang yang dibeli dibuat.

3. **PB-03 – Pesan ke pemasok**  
   Petugas gudang membaca data barang untuk mengetahui kondisi stok dan membaca data pemasok yang akan menerima pesanan. Setelah pemasok dipilih, data pembelian dibuat.

4. **PB-04 – Terima barang**  
   Ketika barang datang, data barang diperbarui sesuai jumlah yang diterima. Data pemasok dibaca sebagai bagian dari informasi pemasok, sedangkan data pembelian diperbarui berdasarkan barang yang sudah diterima.

5. **PB-05 – Laporan bulanan**  
   Laporan bulanan menggunakan data dari seluruh entitas yang dibutuhkan untuk menghasilkan informasi mengenai penjualan, barang, pemasok, pembelian, dan aktivitas anggota.

## 8. Kamus Data Awal

Kamus data awal digunakan untuk menjelaskan beberapa elemen data penting yang terdapat dalam sistem Kopma. Kamus ini berisi arti dari setiap elemen, contoh nilai, aturan yang harus diperhatikan, dan pihak yang bertanggung jawab terhadap data tersebut.

| Elemen | Arti | Contoh | Aturan | Penanggung Jawab |
|---|---|---|---|---|
| `no_anggota` | Nomor anggota koperasi | A-0457 | Unik, format A-4 digit | Ketua |
| `nim_anggota` | NIM anggota | 2301010123 | Unik, 10 digit | Ketua |
| `no_hp_anggota` | Nomor HP anggota | 0812xxxx | Data pribadi, akses terbatas | Ketua |
| `no_nota_penjualan` | Nomor nota penjualan | PJ-2609-0142 | Unik per nota | Kasir |
| `harga_satuan_detail_penjualan` | Harga jual barang saat transaksi | 4000 | Bilangan bulat ≥ 0 (rupiah) | Kasir |
| `stok_barang` | Jumlah barang yang tersedia | 35 | Bilangan bulat ≥ 0 (AB-03) | Petugas gudang |

## 9. Kebutuhan Non-Fungsional

Selain kebutuhan data dan proses bisnis, Kopma juga memiliki beberapa kebutuhan non-fungsional yang perlu diperhatikan dalam pengelolaan sistem.

1. **Volume transaksi**  
   Sistem diperkirakan menangani sekitar **150 nota penjualan per hari**. Oleh karena itu, sistem perlu mampu menyimpan dan mengelola data transaksi dalam jumlah tersebut.

2. **Penyimpanan data**  
   Data transaksi penjualan perlu disimpan selama **minimal lima tahun** agar riwayat transaksi masih dapat digunakan ketika diperlukan.

3. **Pembatasan akses data pribadi**  
   Nomor HP anggota termasuk data pribadi sehingga akses terhadap data tersebut perlu dibatasi. Berdasarkan kebutuhan Kopma, **nomor HP anggota hanya boleh dilihat oleh ketua koperasi**.

## 10. Titik Analisis

### TA-1 — Harga Saat Transaksi

Harga barang yang tersimpan pada data barang dapat berubah ketika Kopma menaikkan atau menurunkan harga. Oleh karena itu, harga saat transaksi tetap perlu disimpan pada detail penjualan.

Alasannya, transaksi yang sudah terjadi harus tetap menunjukkan harga yang digunakan pada saat pembelian. Jika hanya menggunakan harga barang yang sedang berlaku, maka nota atau transaksi lama dapat menunjukkan harga yang berbeda dari kondisi sebenarnya ketika transaksi dilakukan.

### TA-2 — Data Turunan

Subtotal dan total merupakan nilai yang dapat dihitung dari data lain, seperti jumlah barang, harga saat transaksi, dan diskon. Salah satu alasan untuk tidak menyimpan nilai tersebut adalah untuk menghindari adanya data yang sama atau tidak sesuai dengan hasil perhitungan.

Namun, total masih dapat dipertimbangkan untuk disimpan jika diperlukan sebagai bagian dari pencatatan transaksi atau untuk memudahkan pemeriksaan kembali terhadap nilai transaksi. Keputusan akhir mengenai penyimpanan nilai total akan dibahas lebih lanjut pada modul berikutnya.

### TA-3 — Pemeriksaan Matriks CRUD

Pada matriks CRUD, entitas Pemasok tidak memiliki operasi Create. Hal tersebut menunjukkan bahwa belum terdapat proses bisnis yang digunakan untuk membuat atau menambahkan data pemasok.

Untuk mengatasi hal tersebut, perlu ditambahkan proses bisnis seperti **PB-06 Mengelola data pemasok**. Proses ini dapat digunakan untuk menambahkan dan memperbarui data pemasok yang digunakan oleh Kopma.

Untuk perubahan status aktif anggota, perubahan tersebut perlu dilakukan oleh pihak yang memiliki tanggung jawab terhadap data anggota. Dalam rancangan ini, penanggung jawab data anggota adalah ketua koperasi, sehingga ketua dapat melakukan perubahan status aktif anggota.

