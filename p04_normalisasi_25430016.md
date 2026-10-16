# Normalisasi Proyek Basis Data — Perpustakaan Lentera AYP

**NPM:** 25430016  
**Tema:** Perpustakaan Lentera AYP  
**Dokumen acuan:** `p02_kebutuhan_data_25430016.md`, `p03_erd_25430016.drawio`, dan `p03_laporan_25430016.md`

> **Catatan:** Dokumen ini mencatat proses normalisasi proyek. Dependensi fungsional (FD) harus dibaca bersama aturan bisnis dan rancangan kunci yang disebutkan sebagai dasarnya. Jika aturan yang tersedia belum cukup untuk membuktikan suatu FD, keterbatasan tersebut dinyatakan secara terbuka.

## 1. Dokumen Sumber dan Bentuk UNF

Dokumen sumber yang dipilih sebagai titik awal normalisasi adalah **Slip Peminjaman Buku**, yang dibahas pada bagian 3.6 `p02_kebutuhan_data_25430016.md`.

Elemen yang ditampilkan pada slip adalah:

- `id_peminjaman` — nomor peminjaman;
- `nomor_anggota` dan `nama_anggota`;
- `id_eksemplar` dan `judul_buku`;
- `tanggal_pinjam` dan `tanggal_jatuh_tempo`;
- `id_petugas` dan `nama_petugas`.

Satu transaksi peminjaman dapat mencakup beberapa eksemplar. Karena itu, bentuk awal yang belum dinormalisasi (UNF) dapat ditulis sebagai berikut.

```text
SLIP_PEMINJAMAN_UNF(
    id_peminjaman,
    nomor_anggota,
    nama_anggota,
    tanggal_pinjam,
    tanggal_jatuh_tempo,
    id_petugas,
    nama_petugas,
    {id_eksemplar, judul_buku}
)
```

Tanda kurung kurawal menunjukkan kelompok data berulang, bukan sintaks tabel SQL. `nama_anggota`, `nama_petugas`, dan `judul_buku` ditampilkan pada dokumen sumber, tetapi dalam skema relasional nilainya diperoleh dari entitas master masing-masing. Nama anggota berasal dari `Anggota`, nama petugas dari `Petugas`, dan judul buku diperoleh melalui relasi `Eksemplar` ke `Buku`.

## 2. Dependensi Fungsional

Dependensi fungsional (FD) digunakan untuk menjelaskan hubungan antara atribut yang menentukan atribut lainnya. Pada proyek Perpustakaan Lentera AYP, FD disusun dengan mengacu pada aturan bisnis AB-01 sampai AB-10, kamus data, dan rancangan kunci pada ERD Modul 3. Setiap FD diperiksa berdasarkan dasar penetapannya, sehingga aturan bisnis yang tertulis dapat dibedakan dari keputusan perancangan struktur basis data.

| Dependensi fungsional | Dasar penetapan | Status dan batasan |
|---|---|---|
| `nomor_anggota → atribut Anggota` | AB-01 menetapkan `nomor_anggota` sebagai atribut unik. Atribut Anggota lainnya tercantum dalam kamus data dan ERD. | Didukung oleh aturan keunikan nomor anggota dan rancangan entitas `Anggota`. Notasi `atribut Anggota` merujuk pada atribut yang ditetapkan dalam skema entitas tersebut. |
| `id_buku → atribut Buku` | `id_buku` ditetapkan sebagai PK pada ERD Modul 3. | Didukung oleh rancangan kunci primer. Penentuan atribut Buku mengikuti struktur entitas pada ERD, bukan aturan bisnis yang menjelaskan setiap atribut secara terpisah. |
| `id_eksemplar → atribut Eksemplar` | `id_eksemplar` ditetapkan sebagai PK pada ERD Modul 3. AB-09 menyatakan bahwa setiap eksemplar terhubung dengan satu buku. | Didukung oleh rancangan kunci primer dan aturan hubungan eksemplar dengan buku. FD ini tidak berarti bahwa `id_buku` menentukan seluruh atribut `Eksemplar`. |
| `id_petugas → atribut Petugas` | AB-10 menyatakan bahwa `id_petugas` unik. Atribut Petugas juga tercantum dalam kamus data dan ERD. | Didukung oleh aturan keunikan identitas petugas dan rancangan entitas `Petugas`. |
| `id_peminjaman → nomor_anggota, id_petugas, tanggal_pinjam, tanggal_jatuh_tempo, status_peminjaman` | AB-05 menjelaskan pencatatan data transaksi peminjaman. `id_peminjaman` ditetapkan sebagai PK pada ERD Modul 3. | Didukung oleh rancangan kunci dan struktur relasi `Peminjaman`. FD ini mengikuti atribut yang ditempatkan pada relasi tersebut. |
| `(id_peminjaman, id_eksemplar) → status_detail` | Pasangan `id_peminjaman` dan `id_eksemplar` ditetapkan sebagai PK komposit pada `Detail_Peminjaman`. | Didukung oleh rancangan kunci komposit. Pasangan atribut tersebut menentukan atribut nonkunci pada relasi `Detail_Peminjaman` sesuai skema yang dirancang. |
| `id_pengembalian → id_peminjaman, id_eksemplar, id_petugas, tanggal_pengembalian` | `id_pengembalian` ditetapkan sebagai PK pada ERD Modul 3. AB-06 mensyaratkan pengembalian terhubung dengan detail peminjaman yang valid. | Didukung oleh rancangan kunci dan aturan hubungan pengembalian. Pasangan `(id_peminjaman, id_eksemplar)` harus merujuk pada detail peminjaman yang valid. |
| `id_pengembalian → hari_terlambat, nominal_denda, status_bayar` | Pada relasi `Denda`, `id_pengembalian` dirancang sebagai FK sekaligus UK. | Didukung oleh rancangan constraint. Apabila FK dan UK diterapkan, satu pengembalian memiliki maksimal satu catatan denda sehingga `id_pengembalian` menentukan atribut pada catatan `Denda` tersebut. |
| `hari_terlambat → nominal_denda` | AB-08 menetapkan tarif denda sebesar Rp8.000 per hari keterlambatan. | Bersyarat. FD berlaku apabila nominal denda selalu dihitung langsung dari jumlah hari keterlambatan dengan tarif tetap, tanpa faktor penyesuaian lain. FD ini digunakan untuk mengevaluasi potensi pelanggaran BCNF pada relasi `Denda`. |

Keterangan: notasi `atribut Anggota`, `atribut Buku`, `atribut Eksemplar`, dan `atribut Petugas` digunakan untuk meringkas atribut nonkunci pada masing-masing entitas sesuai kamus data dan ERD. Notasi tersebut bukan atribut baru, melainkan ringkasan FD berdasarkan kunci entitas.

FD yang didukung oleh rancangan kunci perlu dibedakan dari FD yang didukung langsung oleh aturan bisnis. Penetapan PK atau UK menunjukkan bahwa suatu atribut atau kombinasi atribut dapat mengidentifikasi baris secara unik sesuai rancangan. Sementara itu, aturan bisnis memberikan dasar mengenai hubungan data yang berlaku dalam proses perpustakaan. Oleh karena itu, FD yang didasarkan pada struktur ERD tidak dinyatakan sebagai aturan bisnis tambahan.

Nama anggota, nama petugas, dan judul buku dikelola melalui entitas master masing-masing. Informasi tersebut tidak perlu disalin sebagai atribut pada relasi transaksi apabila dapat diperoleh melalui hubungan ant relasi. Selain itu, dokumen kebutuhan data belum menetapkan `isbn_buku`, `kode_eksemplar`, atau `kode_petugas` sebagai UK tambahan. Dengan demikian, keunikan pada atribut-atribut tersebut tidak diasumsikan dalam penetapan FD.

FD `hari_terlambat → nominal_denda` perlu diperhatikan pada pemeriksaan BCNF. Apabila tarif tetap Rp8.000 per hari diterapkan langsung, jumlah hari keterlambatan akan menentukan nominal denda. Jika FD tersebut berlaku dan `hari_terlambat` bukan superkey pada relasi `Denda`, maka relasi tersebut berpotensi tidak memenuhi BCNF. Namun, kesimpulan ini tetap bergantung pada aturan perhitungan denda yang benar-benar diterapkan dalam sistem.

## 3. Tahap 1NF

Untuk mencapai bentuk normal pertama (1NF), kelompok data eksemplar yang berulang pada bentuk UNF diubah menjadi baris-baris terpisah. Setiap baris mewakili satu eksemplar yang tercatat dalam suatu transaksi peminjaman. Dengan demikian, setiap atribut pada baris memiliki satu nilai dan tidak lagi berada dalam kelompok data berulang.

Bentuk relasi Slip Peminjaman Buku setelah diubah menjadi 1NF adalah sebagai berikut.

```text
SLIP_PEMINJAMAN_1NF(
    id_peminjaman,
    nomor_anggota,
    nama_anggota,
    tanggal_pinjam,
    tanggal_jatuh_tempo,
    id_petugas,
    nama_petugas,
    id_eksemplar,
    judul_buku
)
```

Berdasarkan rancangan `Detail_Peminjaman` pada ERD Modul 3, kandidat kunci untuk mengidentifikasi satu baris detail adalah pasangan `(id_peminjaman, id_eksemplar)`. `id_peminjaman` mengidentifikasi transaksi peminjaman, sedangkan `id_eksemplar` mengidentifikasi eksemplar yang tercatat dalam transaksi tersebut. Pasangan ini mengikuti rancangan kunci primer komposit pada `Detail_Peminjaman`.

Pada tahap ini, `nama_anggota`, `nama_petugas`, dan `judul_buku` masih dicantumkan untuk merepresentasikan informasi yang ditampilkan pada slip sumber. Namun, atribut tersebut nantinya tidak dipertahankan pada relasi transaksi hasil normalisasi. `nama_anggota` diperoleh melalui relasi master `Anggota`, `nama_petugas` melalui relasi `Petugas`, sedangkan `judul_buku` diperoleh melalui hubungan `Eksemplar` dengan `Buku`.

Perubahan dari UNF ke 1NF menghilangkan kelompok data eksemplar yang berulang. Meskipun demikian, beberapa atribut masih bergantung pada bagian tertentu dari kandidat kunci komposit. Ketergantungan tersebut menjadi dasar pemeriksaan dan pemisahan relasi pada tahap 2NF.

## 4. Tahap 2NF

Bentuk normal kedua (2NF) bertujuan menghilangkan ketergantungan parsial, yaitu ketika atribut nonkunci bergantung pada sebagian dari kunci kandidat komposit. Pada tahap 1NF, kunci kandidat untuk setiap baris detail peminjaman dirancang sebagai pasangan `(id_peminjaman, id_eksemplar)`. Oleh karena itu, atribut yang bergantung hanya pada salah satu bagian kunci perlu diperiksa sebelum relasi dipisahkan.

Berdasarkan rancangan transaksi, aturan bisnis, dan ERD Modul 3, dependensi fungsional (FD) yang digunakan untuk menjelaskan pemisahan data adalah sebagai berikut.

| Dependensi fungsional | Dasar | Keterangan |
|---|---|---|
| `id_peminjaman → nomor_anggota, tanggal_pinjam, tanggal_jatuh_tempo, id_petugas` | Rancangan kunci dan atribut transaksi pada ERD Modul 3 serta AB-05 | Atribut tersebut berkaitan dengan satu transaksi peminjaman, sehingga ditentukan oleh `id_peminjaman` sesuai rancangan relasi `Peminjaman`. |
| `id_eksemplar → judul_buku` | Setiap eksemplar merujuk pada satu buku berdasarkan AB-09 dan rancangan hubungan `Eksemplar` dengan `Buku` | Pada bentuk 1NF, `judul_buku` ditampilkan bersama `id_eksemplar` pada setiap baris detail. Judul buku dapat ditelusuri melalui eksemplar yang dipinjam. |
| `id_eksemplar → id_buku` | PK `id_eksemplar` pada ERD Modul 3 dan AB-09 | FD ini menjelaskan hubungan pada struktur master `Eksemplar`, yaitu setiap eksemplar terhubung dengan satu buku. `id_buku` digunakan untuk menghubungkan `Eksemplar` dengan `Buku`. |

FD pertama menunjukkan bahwa atribut tingkat transaksi bergantung pada `id_peminjaman`, bukan pada keseluruhan pasangan kunci detail. Sementara itu, pada data slip 1NF, `judul_buku` berkaitan dengan `id_eksemplar` karena setiap eksemplar merujuk pada satu buku. Pada struktur master, hubungan tersebut direpresentasikan melalui `id_buku` pada relasi `Eksemplar`.

Berdasarkan dependensi tersebut, atribut tingkat transaksi dipisahkan dari rincian eksemplar yang dipinjam. Hasil pemisahan relasi transaksi adalah:

```text
PEMINJAMAN_2NF(
    id_peminjaman PK,
    nomor_anggota FK,
    id_petugas FK,
    tanggal_pinjam,
    tanggal_jatuh_tempo,
    status_peminjaman
)
```

Relasi detail hasil pemisahan adalah:

```text
DETAIL_PEMINJAMAN_2NF(
    id_peminjaman PK/FK,
    id_eksemplar PK/FK,
    status_detail
)
```

Pada relasi `Peminjaman`, `id_peminjaman` menjadi PK karena relasi ini menyimpan atribut pada tingkat transaksi. Pada relasi `Detail_Peminjaman`, pasangan `(id_peminjaman, id_eksemplar)` menjadi PK komposit untuk mengidentifikasi satu eksemplar dalam suatu transaksi. Atribut `id_peminjaman` merupakan FK ke `Peminjaman`, sedangkan `id_eksemplar` merupakan FK ke `Eksemplar`.

Atribut `status_peminjaman` dan `status_detail` tetap dipertahankan berdasarkan kamus data dan rancangan ERD Modul 3. `status_peminjaman` ditempatkan pada relasi `Peminjaman`, sedangkan `status_detail` ditempatkan pada `Detail_Peminjaman`. Kedua atribut tersebut bukan elemen yang ditampilkan pada Slip Peminjaman Buku, sehingga tidak ditambahkan ke dalam daftar atribut UNF atau 1NF slip.

Atribut tampilan `nama_anggota`, `nama_petugas`, dan `judul_buku` tidak dipertahankan pada kedua relasi transaksi hasil pemisahan tersebut. `nama_anggota` diperoleh melalui relasi `Anggota`, `nama_petugas` melalui relasi `Petugas`, sedangkan `judul_buku` diperoleh melalui hubungan `Eksemplar` dengan `Buku`. Dengan demikian, informasi master tidak perlu disalin berulang pada setiap baris transaksi.

Pemisahan ini menjelaskan pengelompokan atribut berdasarkan transaksi dan identitas eksemplar. Namun, penetapan bentuk normal secara formal tetap bergantung pada FD yang berlaku pada setiap relasi. Oleh karena itu, hasil pemisahan ini tidak dianggap sebagai bukti bahwa seluruh dependensi fungsional telah teridentifikasi secara lengkap. Pemeriksaan tahap berikutnya tetap perlu memperhatikan dependensi lain yang didukung oleh dokumen kebutuhan data dan ERD.
## 5. Tahap 3NF

Bentuk normal ketiga (3NF) diperiksa dengan melihat apakah terdapat ketergantungan transitif pada atribut nonkunci. Pada proyek Perpustakaan Lentera AYP, pemeriksaan ini dilakukan dengan meninjau hubungan antaratribut pada relasi hasil tahap sebelumnya. Atribut yang menggambarkan anggota, buku, eksemplar, dan petugas ditempatkan pada relasi masing-masing agar informasi tersebut tidak perlu disalin ke setiap transaksi.

Pemisahan relasi master dan transaksi mengikuti rancangan ERD Modul 3 serta kamus data pada `p02_kebutuhan_data_25430016.md`. Namun, pemisahan tersebut tidak dengan sendirinya membuktikan bahwa semua relasi memenuhi 3NF. Kesimpulan formal tetap bergantung pada kelengkapan dependensi fungsional yang dapat ditetapkan dari aturan bisnis dan rancangan kunci.

### 5.1 Skema Relasional Hasil

Delapan relasi yang dipertahankan pada rancangan proyek adalah sebagai berikut.

```text
ANGGOTA(
    nomor_anggota PK,
    nama_anggota,
    jenis_kelamin,
    alamat_anggota,
    no_hp_anggota,
    tanggal_daftar,
    status_anggota
)
```

```text
BUKU(
    id_buku PK,
    isbn_buku,
    judul_buku,
    penulis_buku,
    penerbit_buku,
    tahun_terbit_buku,
    kategori_buku
)
```

```text
EKSEMPLAR(
    id_eksemplar PK,
    id_buku FK,
    kode_eksemplar,
    kondisi_eksemplar,
    status_eksemplar,
    lokasi_eksemplar
)
```

```text
PETUGAS(
    id_petugas PK,
    kode_petugas,
    nama_petugas,
    peran_petugas,
    status_petugas
)
```

```text
PEMINJAMAN(
    id_peminjaman PK,
    nomor_anggota FK,
    id_petugas FK,
    tanggal_pinjam,
    tanggal_jatuh_tempo,
    status_peminjaman
)
```

```text
DETAIL_PEMINJAMAN(
    id_peminjaman PK/FK,
    id_eksemplar PK/FK,
    status_detail
)
```

```text
PENGEMBALIAN(
    id_pengembalian PK,
    id_peminjaman,
    id_eksemplar,
    id_petugas FK,
    tanggal_pengembalian,
    FK (id_peminjaman, id_eksemplar)
        REFERENCES DETAIL_PEMINJAMAN (id_peminjaman, id_eksemplar),
    UNIQUE (id_peminjaman, id_eksemplar)
)
```

Pasangan `(id_peminjaman, id_eksemplar)` pada `Pengembalian` dirancang sebagai FK gabungan menuju PK komposit `Detail_Peminjaman`. Pasangan yang sama juga diberi constraint `UNIQUE`, sehingga satu detail peminjaman maksimal memiliki satu catatan pengembalian. Keunikan tersebut berlaku untuk kombinasi kedua atribut, bukan untuk masing-masing atribut secara terpisah.

```text
DENDA(
    id_denda PK,
    id_pengembalian FK/UK,
    hari_terlambat,
    nominal_denda,
    status_bayar
)
```

Pada relasi `Denda`, `id_pengembalian` ditetapkan sebagai FK sekaligus UK. Dengan demikian, satu catatan pengembalian maksimal memiliki satu catatan denda. Atribut `hari_terlambat` dan `nominal_denda` tetap dipertahankan sesuai keputusan penyimpanan nilai turunan pada Bagian 7.

### 5.2 Pemeriksaan Ketergantungan Transitif

Pemeriksaan ketergantungan transitif perlu membedakan atribut yang bergantung langsung pada kunci relasi dengan atribut yang ditentukan melalui atribut nonkunci lainnya.

Sebagai contoh, nama anggota tidak perlu disimpan pada relasi `Peminjaman` karena informasi tersebut tersedia melalui relasi `Anggota`. Demikian pula, judul buku dapat ditelusuri melalui relasi `Eksemplar` yang terhubung dengan `Buku`, sedangkan nama petugas tersedia pada relasi `Petugas`.

Penempatan atribut tersebut pada relasi master membantu mengurangi pengulangan informasi. Meskipun demikian, untuk menyatakan bahwa suatu pemisahan secara formal menghilangkan ketergantungan transitif, FD yang mendasarinya perlu ditetapkan secara jelas. Contohnya, FD `nomor_anggota → nama_anggota` didukung oleh aturan keunikan nomor anggota dan rancangan identitas pada relasi `Anggota`. Sementara itu, hubungan `id_eksemplar → id_buku` didukung oleh AB-09 dan rancangan kunci pada ERD.

Tidak semua FD untuk seluruh atribut nonkunci dijelaskan secara terpisah dalam aturan bisnis yang tersedia. Oleh karena itu, dokumen ini mencatat skema hasil berdasarkan rancangan proyek dan tidak mengklaim bahwa seluruh relasi telah terbukti memenuhi 3NF secara formal tanpa pemeriksaan FD yang lengkap.

### 5.3 Kesimpulan Tahap 3NF

Hasil tahap ini mempertahankan delapan relasi sesuai ERD Modul 3, dengan atribut master ditempatkan pada entitas masing-masing dan atribut transaksi tetap berada pada relasi transaksi. Kunci primer, kunci tamu, serta constraint gabungan pada `Pengembalian` dipertahankan agar hubungan antarrelasi tetap jelas.

Kesimpulan yang dapat ditetapkan adalah bahwa struktur tersebut mendukung pemisahan data master dan transaksi serta mengurangi pengulangan informasi. Namun, status 3NF secara formal perlu dinilai berdasarkan seluruh FD yang berlaku. FD yang belum dapat dipastikan tidak dianggap terbukti hanya karena relasi telah dipisahkan.

## 6. Pemeriksaan BCNF

Boyce-Codd Normal Form (BCNF) mensyaratkan bahwa setiap determinan pada dependensi fungsional (FD) nontrivial harus merupakan superkey. Oleh karena itu, pemeriksaan BCNF tidak cukup hanya dengan memastikan bahwa setiap relasi memiliki kunci primer (PK). Seluruh FD nontrivial yang berlaku pada setiap relasi juga perlu diperiksa untuk memastikan bahwa determinannya merupakan superkey.

Pemeriksaan pada proyek Perpustakaan Lentera AYP dilakukan berdasarkan FD, aturan bisnis, dan rancangan kunci yang telah didokumentasikan pada bagian sebelumnya. Karena belum semua FD dapat dipastikan dari dokumen kebutuhan data dan ERD, hasil pemeriksaan berikut dibatasi pada determinan yang telah ditetapkan atau yang berpotensi memengaruhi BCNF.

| Relasi | Determinan yang diperiksa | Hasil pemeriksaan |
|---|---|---|
| `Anggota` | `nomor_anggota` | Merupakan superkey karena ditetapkan sebagai PK. Pemenuhan BCNF secara keseluruhan masih bergantung pada FD nontrivial lain yang berlaku pada relasi ini. |
| `Buku` | `id_buku` | Merupakan superkey karena ditetapkan sebagai PK. FD nontrivial lain tetap perlu diperiksa sebelum menyimpulkan bahwa relasi memenuhi BCNF. |
| `Eksemplar` | `id_eksemplar` dan `id_buku` | `id_eksemplar` merupakan superkey karena ditetapkan sebagai PK. AB-09 menyatakan bahwa setiap eksemplar terhubung dengan satu buku, tetapi hal tersebut tidak menjadikan `id_buku` sebagai superkey bagi relasi `Eksemplar`. |
| `Petugas` | `id_petugas` | Merupakan superkey karena ditetapkan sebagai PK dan AB-10 menyatakan bahwa `id_petugas` bersifat unik. FD nontrivial lain tetap perlu diperiksa. |
| `Peminjaman` | `id_peminjaman` | Merupakan superkey karena ditetapkan sebagai PK. Pemenuhan BCNF secara keseluruhan belum dapat dipastikan tanpa pemeriksaan seluruh FD yang berlaku. |
| `Detail_Peminjaman` | `(id_peminjaman, id_eksemplar)` | Merupakan superkey karena ditetapkan sebagai PK komposit. FD nontrivial lain yang mungkin berlaku tetap perlu diperiksa. |
| `Pengembalian` | `id_pengembalian` dan `(id_peminjaman, id_eksemplar)` | `id_pengembalian` merupakan superkey karena ditetapkan sebagai PK. Pasangan `(id_peminjaman, id_eksemplar)` juga merupakan superkey apabila constraint `UNIQUE` pada pasangan tersebut diterapkan sesuai rancangan. |
| `Denda` | `id_denda`, `id_pengembalian`, dan kemungkinan `hari_terlambat` | `id_denda` merupakan superkey karena ditetapkan sebagai PK. `id_pengembalian` juga merupakan superkey apabila constraint `UNIQUE` diterapkan. Jika FD `hari_terlambat → nominal_denda` berlaku, determinan `hari_terlambat` bukan superkey yang ditetapkan sehingga terdapat potensi pelanggaran BCNF. |

### 6.1 Pembahasan Hasil

Berdasarkan tabel pemeriksaan, determinan berupa PK merupakan superkey pada relasi masing-masing. Pada relasi `Pengembalian`, pasangan `(id_peminjaman, id_eksemplar)` juga menjadi superkey apabila constraint `UNIQUE` diterapkan pada kombinasi kedua atribut tersebut. Sementara itu, pada relasi `Denda`, `id_pengembalian` menjadi superkey apabila ditetapkan sebagai FK sekaligus UK sesuai rancangan.

Namun, keberadaan PK atau kunci kandidat yang telah ditetapkan belum cukup untuk membuktikan bahwa suatu relasi memenuhi BCNF. Pemeriksaan BCNF harus mencakup setiap FD nontrivial yang berlaku pada relasi tersebut. Karena daftar FD proyek belum sepenuhnya memastikan seluruh dependensi yang berlaku, hasil pemeriksaan pada tabel di atas belum dapat dianggap sebagai pembuktian formal bahwa seluruh relasi memenuhi BCNF.

Perhatian khusus diberikan pada relasi `Eksemplar` dan `Denda`. Pada relasi `Eksemplar`, AB-09 menyatakan bahwa setiap eksemplar terhubung dengan satu buku. Hubungan tersebut mendukung penempatan `id_buku` sebagai FK pada `Eksemplar`, tetapi tidak menunjukkan bahwa `id_buku` dapat mengidentifikasi seluruh atribut eksemplar. Oleh karena itu, `id_buku` tidak dapat langsung dianggap sebagai superkey pada relasi tersebut.

Pada relasi `Denda`, AB-08 menetapkan tarif denda keterlambatan sebesar Rp8.000 per hari. Jika nominal denda selalu dihitung langsung berdasarkan jumlah hari keterlambatan dengan tarif tetap tersebut, tanpa faktor penyesuaian lain, maka berlaku FD:

```text
hari_terlambat → nominal_denda
```

FD tersebut berarti bahwa jumlah hari keterlambatan menentukan nominal denda. Jika `hari_terlambat` bukan superkey pada relasi `Denda`, FD tersebut menyebabkan relasi `Denda` tidak memenuhi BCNF. Kesimpulan ini berlaku apabila aturan tarif tetap tersebut benar-benar diterapkan tanpa pengecualian atau faktor lain yang memengaruhi nominal denda.

Jika terdapat aturan lain yang memengaruhi perhitungan nominal denda, FD tersebut perlu diperiksa kembali berdasarkan aturan bisnis yang benar-benar diterapkan. Dengan demikian, penilaian terhadap relasi `Denda` perlu mempertimbangkan aturan perhitungan denda sekaligus FD yang berlaku, bukan hanya keberadaan atribut `hari_terlambat` dan `nominal_denda`.

### 6.2 Kesimpulan Pemeriksaan BCNF

Berdasarkan kunci dan FD yang telah didokumentasikan, belum tersedia bukti yang cukup untuk menyatakan bahwa seluruh relasi pada proyek Perpustakaan Lentera AYP secara formal memenuhi BCNF. Pemeriksaan menunjukkan bahwa determinan berupa kunci yang telah ditetapkan merupakan superkey, tetapi FD nontrivial lain yang mungkin berlaku tetap perlu diperiksa.

Pada relasi `Denda`, terdapat potensi pelanggaran BCNF apabila FD `hari_terlambat → nominal_denda` berlaku dan `hari_terlambat` bukan superkey. Temuan ini perlu dipertimbangkan dalam evaluasi rancangan karena kedua atribut tersebut tetap disimpan sebagai bagian dari riwayat denda, sesuai keputusan pada Bagian 7.

Untuk tahap ini, struktur delapan relasi tetap dipertahankan sesuai rancangan proyek. Keputusan untuk memisahkan relasi `Denda` belum ditetapkan. Evaluasi lebih lanjut perlu mempertimbangkan aturan bisnis, kebutuhan pencatatan riwayat transaksi, FD yang benar-benar berlaku, serta dampaknya terhadap ERD dan implementasi basis data.

## 7. Keputusan Penyimpanan Nilai Turunan

Keputusan penyimpanan nilai turunan pada bagian ini mengacu pada aturan bisnis AB-07 dan AB-08 serta kebutuhan pencatatan riwayat transaksi dalam `p02_kebutuhan_data_25430016.md`. Dua atribut yang dibahas adalah `hari_terlambat` dan `nominal_denda`. Keduanya saling berkaitan karena nominal denda dapat dihitung berdasarkan jumlah hari keterlambatan dan tarif yang berlaku.

### 7.1 `hari_terlambat`

Atribut `hari_terlambat` menunjukkan jumlah hari keterlambatan pengembalian buku. Untuk peminjaman yang sudah dikembalikan, nilainya ditentukan berdasarkan `tanggal_jatuh_tempo` dan `tanggal_pengembalian` sesuai aturan perhitungan yang diterapkan.

Untuk peminjaman yang belum dikembalikan, jumlah hari keterlambatan dapat dihitung sebagai informasi pemantauan berdasarkan tanggal saat laporan dibuat. Namun, hasil perhitungan tersebut tidak otomatis menjadi catatan pada relasi `Denda`, karena pencatatan denda perlu mengikuti proses dan aturan bisnis yang berlaku.

Pada rancangan proyek ini, `hari_terlambat` tetap disimpan dalam relasi `Denda` sebagai bagian dari riwayat denda. Nilai yang disimpan perlu diperiksa kesesuaiannya dengan tanggal sumber dan aturan perhitungan yang digunakan. Dengan demikian, informasi keterlambatan yang tercatat tetap konsisten dengan data transaksi.

### 7.2 `nominal_denda`

Berdasarkan AB-08, tarif denda keterlambatan ditetapkan sebesar Rp8.000 per hari. Oleh karena itu, nominal denda dapat dihitung berdasarkan jumlah hari keterlambatan dan tarif tersebut, selama tidak terdapat faktor penyesuaian lain dalam aturan yang diterapkan.

Pada proyek ini, `nominal_denda` tetap disimpan dalam relasi `Denda` sebagai bagian dari riwayat transaksi. Keputusan tersebut merupakan pilihan desain untuk mempertahankan nilai denda yang tercatat. Penyimpanan nilai turunan ini bukan keharusan pada setiap rancangan basis data, karena nominal denda juga dapat dihitung ketika diperlukan.

Penyimpanan `hari_terlambat` dan `nominal_denda` secara bersamaan memiliki risiko ketidaksesuaian apabila nilai tanggal, jumlah hari keterlambatan, dan nominal denda diperbarui secara terpisah. Untuk mengurangi risiko tersebut, proses pencatatan atau pembaruan denda perlu menggunakan aturan perhitungan yang konsisten serta memeriksa kesesuaian nilai yang disimpan.

### 7.3 Dampak terhadap Pemeriksaan BCNF

Keputusan menyimpan `hari_terlambat` dan `nominal_denda` secara bersamaan juga perlu dipertimbangkan dalam pemeriksaan BCNF pada Bagian 6. Apabila tarif tetap Rp8.000 per hari diterapkan langsung tanpa faktor penyesuaian lain, maka berlaku dependensi fungsional:

```text
hari_terlambat → nominal_denda
```

Jika dependensi tersebut berlaku, sedangkan `hari_terlambat` bukan superkey pada relasi `Denda`, maka relasi tersebut berpotensi tidak memenuhi BCNF. Hal ini menunjukkan bahwa penyimpanan kedua atribut dalam satu relasi perlu ditinjau berdasarkan dependensi fungsional yang benar-benar berlaku.

Pada tahap ini, kedua atribut tetap dipertahankan sesuai rancangan proyek untuk mendukung pencatatan riwayat denda. Potensi pelanggaran BCNF dicatat sebagai hal yang perlu dievaluasi lebih lanjut, bukan dianggap telah diselesaikan. Evaluasi selanjutnya perlu mempertimbangkan aturan bisnis, kebutuhan penyimpanan riwayat transaksi, dan dampak perubahan struktur relasi terhadap ERD serta implementasi basis data.

## 8. Catatan Perubahan ERD Modul 3

Bagian ini menjelaskan kesesuaian rancangan ERD Modul 3 dengan skema hasil normalisasi. Berdasarkan diagram ERD konseptual Perpustakaan Lentera AYP, terdapat delapan entitas, yaitu `Anggota`, `Buku`, `Eksemplar`, `Petugas`, `Peminjaman`, `Detail_Peminjaman`, `Pengembalian`, dan `Denda`. Penyesuaian dan penegasan rancangan yang perlu diperhatikan adalah sebagai berikut.

1. **Entitas `Eksemplar`.** Atribut `lokasi_eksemplar` sudah dicantumkan pada diagram dan sesuai dengan kamus data proyek. Entitas ini memiliki PK `id_eksemplar` serta FK `id_buku` yang menghubungkannya dengan entitas `Buku`.

2. **Entitas `Detail_Peminjaman`.** Pasangan `(id_peminjaman, id_eksemplar)` dipertahankan sebagai PK komposit sekaligus FK. `id_peminjaman` mengacu pada entitas `Peminjaman`, sedangkan `id_eksemplar` mengacu pada entitas `Eksemplar`. Pasangan tersebut digunakan untuk mengidentifikasi setiap eksemplar dalam suatu transaksi peminjaman.

3. **Entitas `Pengembalian`.** Diagram mencantumkan atribut `id_peminjaman` dan `id_eksemplar` sebagai FK yang bersama-sama merujuk pada PK komposit `Detail_Peminjaman`. Berdasarkan catatan pada ERD, pasangan tersebut juga dirancang memiliki constraint `UNIQUE`, sehingga satu detail peminjaman maksimal memiliki satu catatan pengembalian. Keunikan berlaku pada kombinasi kedua atribut, bukan pada setiap kolom secara terpisah.

4. **Entitas `Denda`.** Atribut `id_pengembalian` sudah ditandai sebagai FK sekaligus UNIQUE. Rancangan ini membatasi satu catatan pengembalian agar memiliki maksimal satu catatan denda.

5. **Penyimpanan data denda.** Atribut `hari_terlambat`, `nominal_denda`, dan `status_bayar` dipertahankan pada entitas `Denda`. Penyimpanan `hari_terlambat` dan `nominal_denda` mengikuti keputusan pada Bagian 7 untuk mempertahankan informasi denda yang tercatat. Namun, apabila tarif Rp8.000 per hari diterapkan secara tetap tanpa faktor penyesuaian lain, dependensi fungsional `hari_terlambat → nominal_denda` dapat menyebabkan relasi `Denda` tidak memenuhi BCNF apabila `hari_terlambat` bukan superkey.

Secara umum, diagram telah menampilkan delapan entitas beserta atribut, PK, FK, hubungan, dan kardinalitasnya. Catatan pada diagram juga menjelaskan penggunaan FK gabungan serta constraint UNIQUE pada `Pengembalian` dan `Denda`. Hal yang perlu dipastikan pada implementasi basis data adalah bahwa constraint tersebut benar-benar diterapkan sesuai rancangan, karena keterangan pada diagram saja belum membuktikan bahwa constraint sudah diterapkan pada database.

Catatan mengenai batas maksimal sepuluh eksemplar dalam satu transaksi peminjaman juga tercantum pada ERD. Aturan ini perlu diperhatikan saat implementasi karena batas jumlah eksemplar tidak otomatis dijamin hanya dengan PK, FK, atau constraint UNIQUE yang dibahas pada bagian ini.

## 9. Catatan Teknis Penting

Bagian ini merangkum beberapa keputusan rancangan dan batasan teknis yang perlu diperhatikan agar hasil normalisasi tetap konsisten dengan ERD Modul 3 dan dapat diterapkan pada implementasi basis data.

### 9.1 Konsistensi Kunci dan Constraint

Skema relasional mempertahankan delapan entitas dari ERD Modul 3, yaitu `Anggota`, `Buku`, `Eksemplar`, `Petugas`, `Peminjaman`, `Detail_Peminjaman`, `Pengembalian`, dan `Denda`.

Pada `Detail_Peminjaman`, pasangan `(id_peminjaman, id_eksemplar)` digunakan sebagai PK komposit sekaligus FK ke `Peminjaman` dan `Eksemplar`. Sementara itu, pada `Pengembalian`, pasangan atribut yang sama dirancang sebagai satu FK gabungan ke `Detail_Peminjaman` dan diberi constraint `UNIQUE` pada kombinasi kedua atribut. Constraint ini membatasi setiap detail peminjaman agar memiliki maksimal satu catatan pengembalian.

Pada entitas `Denda`, `id_pengembalian` dirancang sebagai FK sekaligus UNIQUE. Dengan demikian, satu catatan pengembalian dapat memiliki maksimal satu catatan denda. Constraint tersebut perlu diterapkan secara konsisten pada skema basis data, bukan hanya dicantumkan dalam dokumentasi atau ERD.

### 9.2 Batas Maksimal Eksemplar dalam Peminjaman

ERD mencatat bahwa satu transaksi peminjaman dapat mencakup maksimal sepuluh eksemplar buku. Batas tersebut merupakan aturan bisnis yang perlu diperhatikan pada implementasi basis data. PK dan FK saja tidak otomatis membatasi jumlah detail peminjaman dalam satu transaksi menjadi sepuluh baris. Oleh karena itu, mekanisme penerapan aturan tersebut perlu ditentukan dan diuji saat implementasi.

### 9.3 Penyimpanan Nilai Denda dan Pemeriksaan BCNF

Atribut `hari_terlambat` dan `nominal_denda` tetap dipertahankan pada entitas `Denda` sesuai keputusan penyimpanan nilai turunan pada Bagian 7. Keputusan ini memungkinkan informasi denda dicatat sebagai bagian dari riwayat transaksi, tetapi nilai yang disimpan harus tetap konsisten dengan tanggal pengembalian dan aturan tarif yang berlaku.

Apabila nominal denda selalu dihitung menggunakan tarif tetap Rp8.000 per hari tanpa faktor penyesuaian lain, dependensi fungsional `hari_terlambat → nominal_denda` berlaku. Jika `hari_terlambat` bukan superkey, relasi `Denda` tidak memenuhi BCNF berdasarkan dependensi tersebut. Kondisi ini perlu dicatat sebagai keterbatasan rancangan, bukan dianggap sudah terselesaikan hanya karena atribut dipertahankan.

### 9.4 Batasan Verifikasi

Dokumen ini menjelaskan rancangan normalisasi dan keputusan skema berdasarkan kebutuhan data serta ERD proyek. Keberadaan atribut, PK, FK, FK gabungan, dan constraint `UNIQUE` dalam dokumentasi belum membuktikan bahwa seluruhnya sudah diterapkan pada implementasi basis data. Penerapan constraint, pembatasan maksimal sepuluh eksemplar, dan konsistensi nilai denda tetap perlu diverifikasi melalui pengujian implementasi.

## 10. Ringkasan

Normalisasi dimulai dari Slip Peminjaman Buku yang memiliki kelompok eksemplar berulang. Tahap 1NF memisahkan setiap eksemplar menjadi satu baris, tahap 2NF memisahkan fakta transaksi dari detail eksemplar, dan tahap 3NF menempatkan informasi master pada relasi masing-masing. Skema akhir mempertahankan delapan relasi sesuai rancangan ERD Modul 3. Atribut `hari_terlambat` dan `nominal_denda` tetap disimpan sesuai keputusan proyek, sementara potensi pelanggaran BCNF pada `Denda` dan kebutuhan verifikasi constraint dicatat sebagai hal yang perlu diperhatikan pada implementasi.