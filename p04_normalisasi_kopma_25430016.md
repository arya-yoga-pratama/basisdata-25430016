# Normalisasi Data Kopma — Modul 4

**Nama:** Arya Yoga Pratama  
**NPM:** 25430016  
**Kelas:** A  
**Tema:** Studi Kasus Kopma

## 1. Tahap UNF ke 1NF

### 1.1 Bentuk UNF

Pada bentuk UNF (*Unnormalized Form*), data penjualan Kopma masih digambarkan dalam satu struktur yang memuat informasi nota, petugas, anggota, dan barang. Satu nota dapat mencatat beberapa barang sehingga kelompok atribut barang masih berulang.

Struktur relasi awal:

```text
NOTA_UNF(
    no_nota_penjualan,
    tgl_penjualan,
    kode_petugas,
    nama_petugas,
    no_anggota,
    nama_anggota,
    {
        kode_barang,
        nama_barang,
        qty_detail_penjualan,
        harga_satuan_detail_penjualan,
        subtotal_detail_penjualan
    },
    jumlah_penjualan,
    diskon_penjualan,
    total_penjualan
)
```

Kelompok atribut di dalam tanda kurung kurawal merupakan kelompok data barang yang dapat berulang dalam satu nota.

### 1.2 Bentuk 1NF

Untuk memenuhi 1NF, kelompok barang yang berulang dipisahkan sehingga setiap baris hanya memuat satu barang pada satu nota. Dengan demikian, pasangan `no_nota_penjualan` dan `kode_barang` digunakan sebagai kunci primer komposit sesuai langkah pada Modul 4.

Struktur relasi 1NF:

```text
NOTA_1NF(
    no_nota_penjualan,
    kode_barang,
    tgl_penjualan,
    kode_petugas,
    nama_petugas,
    no_anggota,
    nama_anggota,
    nama_barang,
    qty_detail_penjualan,
    harga_satuan_detail_penjualan,
    subtotal_detail_penjualan,
    jumlah_penjualan,
    diskon_penjualan,
    total_penjualan
)
```

**Keterangan kunci:**

- PK komposit: `(no_nota_penjualan, kode_barang)`.
- Setiap baris mewakili satu barang pada satu nota penjualan.
- Struktur ini masih memuat atribut yang nantinya diperiksa untuk dipisahkan pada tahap 2NF dan 3NF.

### 1.3 Dependensi Fungsional (FD1–FD6)

Dependensi fungsional ditentukan berdasarkan aturan bisnis yang telah dibahas pada Modul 2, bukan hanya berdasarkan contoh data pada spreadsheet. Dependensi ini digunakan untuk mengetahui atribut yang nilainya ditentukan oleh atribut lain sebagai dasar proses normalisasi.

**Daftar dependensi fungsional:**

```text
FD1: no_nota_penjualan → tgl_penjualan, kode_petugas, no_anggota
     (AB-01)

FD2: kode_petugas → nama_petugas

FD3: no_anggota → nama_anggota
     (AB-05)

FD4: kode_barang → nama_barang

FD5: (no_nota_penjualan, kode_barang)
     → qty_detail_penjualan,
       harga_satuan_detail_penjualan
     (AB-04)

FD6: qty_detail_penjualan, harga_satuan_detail_penjualan
     → subtotal_detail_penjualan
     (turunan)
```

FD1 menunjukkan bahwa satu nomor nota menentukan tanggal penjualan, petugas yang menangani transaksi, dan anggota yang melakukan transaksi. FD2, FD3, dan FD4 menunjukkan hubungan antara kode identitas dengan nama masing-masing petugas, anggota, dan barang. FD5 menunjukkan bahwa jumlah barang dan harga satuan pada detail penjualan ditentukan berdasarkan kombinasi nomor nota dan kode barang. Sementara itu, FD6 merupakan dependensi turunan karena subtotal detail penjualan dapat dihitung dari jumlah barang dikalikan harga satuan.

Penentuan FD tersebut menjadi dasar untuk memisahkan atribut yang bergantung pada sebagian kunci komposit pada tahap 2NF dan memeriksa ketergantungan lainnya pada tahap normalisasi berikutnya.

### 1.4 Menuju Bentuk Normal Kedua (2NF)

Pada tahap 2NF, relasi diperiksa untuk mengetahui apakah terdapat atribut yang bergantung hanya pada sebagian kunci primer komposit. Berdasarkan dependensi fungsional pada tahap sebelumnya, atribut transaksi penjualan dipisahkan dari atribut yang berkaitan dengan barang.

Relasi hasil pemisahan menjadi:

```text
PENJUALAN_2NF(
    no_nota_penjualan PK,
    tgl_penjualan,
    kode_petugas FK,
    no_anggota FK,
    bayar_penjualan
)
```

```text
DETAIL_PENJUALAN_2NF(
    no_nota_penjualan PK/FK,
    kode_barang PK/FK,
    qty_detail_penjualan,
    harga_satuan_detail_penjualan,
    subtotal_detail_penjualan
)
```

```text
BARANG_2NF(
    kode_barang PK,
    nama_barang
)
```

Atribut `no_nota_penjualan` menjadi kunci primer pada relasi `PENJUALAN_2NF` karena relasi tersebut menyimpan informasi tingkat transaksi. Sementara itu, pasangan `(no_nota_penjualan, kode_barang)` menjadi kunci primer komposit pada `DETAIL_PENJUALAN_2NF` karena satu nota dapat memuat beberapa barang. Relasi `BARANG_2NF` menyimpan informasi barang berdasarkan `kode_barang`.

Harga satuan tetap berada pada detail penjualan karena harga barang pada suatu transaksi dapat berbeda dari harga barang saat ini. Dengan demikian, pemisahan ini mempertahankan informasi transaksi sekaligus mengurangi pengulangan data barang.

### 1.5 Menuju Bentuk Normal Ketiga (3NF)

Pada tahap 3NF, relasi diperiksa untuk mengetahui apakah terdapat ketergantungan transitif, yaitu ketika atribut nonkunci bergantung pada atribut nonkunci lainnya. Berdasarkan dependensi fungsional yang telah ditentukan, informasi petugas dan anggota dipisahkan dari relasi penjualan agar nama keduanya tidak perlu disimpan berulang pada setiap transaksi.

Relasi hasil pemisahan menjadi:

```text
PENJUALAN(
    no_nota_penjualan PK,
    tgl_penjualan,
    kode_petugas FK,
    no_anggota FK,
    bayar_penjualan
)
```

```text
DETAIL_PENJUALAN(
    no_nota_penjualan PK/FK,
    kode_barang PK/FK,
    qty_detail_penjualan,
    harga_satuan_detail_penjualan,
    subtotal_detail_penjualan
)
```

```text
BARANG(
    id_barang PK,
    kode_barang UK,
    nama_barang,
    kategori_barang,
    harga_jual_barang,
    stok_barang,
    stok_min_barang
)
```

```text
PETUGAS(
    id_petugas PK,
    kode_petugas UK,
    nama_petugas,
    peran_petugas
)
```

```text
ANGGOTA(
    no_anggota PK,
    nim_anggota UK,
    nama_anggota,
    prodi_anggota,
    no_hp_anggota,
    status_anggota,
    tgl_daftar_anggota
)
```

Pada skema tersebut, `PENJUALAN` menyimpan informasi transaksi, `DETAIL_PENJUALAN` menyimpan barang yang dijual pada setiap nota, sedangkan `BARANG`, `PETUGAS`, dan `ANGGOTA` menyimpan data masing-masing entitas. Kunci primer dan kunci unik mengikuti skema kanonik Kopma pada Modul 4.

Pemisahan ini mengurangi pengulangan nama petugas, nama anggota, dan nama barang pada data transaksi. Namun, pemenuhan 3NF secara formal tetap perlu diperiksa berdasarkan seluruh dependensi fungsional dan aturan bisnis yang berlaku.

### 1.6 Pemeriksaan Boyce-Codd Normal Form (BCNF)

Boyce-Codd Normal Form (BCNF) merupakan tahap normalisasi yang memeriksa apakah setiap determinan pada dependensi fungsional (FD) nontrivial merupakan superkey. Pemeriksaan ini dilakukan terhadap relasi hasil normalisasi sebelumnya untuk mengetahui apakah masih terdapat ketergantungan yang dapat menimbulkan pengulangan data.

Berdasarkan dependensi fungsional pada bagian sebelumnya, pemeriksaan BCNF dilakukan pada relasi `PENJUALAN`, `DETAIL_PENJUALAN`, `BARANG`, `PETUGAS`, dan `ANGGOTA`.

**Hasil pemeriksaan BCNF:**

| Relasi | Determinan yang diperiksa | Hasil pemeriksaan |
|---|---|---|
| `PENJUALAN` | `no_nota_penjualan` | Merupakan superkey karena menjadi kunci primer dan menentukan atribut transaksi penjualan. |
| `DETAIL_PENJUALAN` | `(no_nota_penjualan, kode_barang)` | Merupakan superkey karena pasangan tersebut menjadi kunci primer komposit untuk setiap detail barang dalam nota. |
| `BARANG` | `kode_barang` | Merupakan superkey karena menentukan informasi barang, termasuk `nama_barang`. |
| `PETUGAS` | `kode_petugas` | Menentukan `nama_petugas` sesuai FD2, dengan asumsi kode petugas mengidentifikasi satu petugas. |
| `ANGGOTA` | `no_anggota` | Menentukan `nama_anggota` sesuai FD3, dengan asumsi nomor anggota mengidentifikasi satu anggota. |

Pada relasi `DETAIL_PENJUALAN`, atribut `qty_detail_penjualan` dan `harga_satuan_detail_penjualan` bergantung pada pasangan `(no_nota_penjualan, kode_barang)`, bukan hanya pada salah satu atribut tersebut. Hal ini sesuai dengan FD5 dan alasan penggunaan kunci primer komposit pada relasi detail penjualan.

Sementara itu, `subtotal_detail_penjualan` merupakan atribut turunan yang dihitung dari jumlah barang dan harga satuan berdasarkan FD6. Apabila subtotal tetap disimpan, nilainya perlu dijaga agar sesuai dengan hasil perhitungan tersebut.

### 1.6.1 Kesimpulan Pemeriksaan BCNF

Berdasarkan FD yang telah dicatat, determinan utama pada relasi hasil normalisasi merupakan kunci atau superkey sesuai rancangan relasinya. Namun, kesimpulan bahwa seluruh relasi telah memenuhi BCNF secara formal tetap bergantung pada kelengkapan FD dan aturan bisnis yang berlaku.

Oleh karena itu, hasil pemeriksaan ini menunjukkan bahwa struktur relasi telah memisahkan informasi transaksi, detail barang, barang, petugas, dan anggota. Pemeriksaan lebih lanjut tetap diperlukan apabila ditemukan dependensi fungsional lain yang belum tercatat.

## 1.7 Latihan dan Modifikasi

Bagian ini membahas dua latihan pada Modul 4, yaitu normalisasi data nomor telepon pemasok dan contoh anomali ubah yang terjadi apabila `nama_anggota` disimpan langsung di tabel penjualan.

### 1.7.1 Normalisasi Nomor Telepon Pemasok

**Permasalahan**

Kopma ingin mencatat beberapa nomor telepon untuk setiap pemasok. Jika beberapa nomor telepon disimpan dalam satu kolom pada tabel `PEMASOK`, nilai atribut tersebut tidak lagi atomik. Oleh karena itu, data nomor telepon dipisahkan ke dalam relasi tersendiri.

**Relasi setelah normalisasi:**

```text
PEMASOK(
    id_pemasok PK,
    nama_pemasok,
    alamat_pemasok
)

TELEPON_PEMASOK(
    id_pemasok PK/FK,
    nomor_telepon PK
)
```

Pada relasi `TELEPON_PEMASOK`, kunci primer komposit terdiri dari `id_pemasok` dan `nomor_telepon`. Dengan demikian, satu pemasok dapat memiliki beberapa nomor telepon, sedangkan setiap nomor telepon dicatat sebagai satu baris tersendiri.

**Contoh data:**

| id_pemasok | nomor_telepon |
|---|---|
| P001 | 081234567890 |
| P001 | 082345678901 |
| P002 | 085678901234 |

Pada contoh tersebut, pemasok `P001` memiliki dua nomor telepon, sedangkan pemasok `P002` memiliki satu nomor telepon. Data pemasok tidak perlu diulang hanya untuk mencatat nomor telepon tambahan.

Pemisahan ini membuat data lebih terstruktur dan memudahkan penambahan maupun penghapusan nomor telepon tanpa mengubah struktur tabel pemasok. Nama atribut pemasok pada rancangan ini merupakan contoh dan perlu disesuaikan dengan nama atribut pada skema Kopma yang digunakan.

### 1.7.2 Contoh Pelanggaran 3NF dan Anomali Ubah

**Permasalahan**

Jika `nama_anggota` disimpan langsung pada tabel `PENJUALAN`, informasi nama anggota dapat berulang pada beberapa transaksi. Apabila `no_anggota` menentukan `nama_anggota`, terdapat dependensi transitif dari kunci transaksi ke nama anggota melalui nomor anggota.

Dependensi fungsionalnya adalah:

```text
no_nota_penjualan -> no_anggota
no_anggota        -> nama_anggota
```

Karena `no_nota_penjualan` menentukan `no_anggota`, kemudian `no_anggota` menentukan `nama_anggota`, maka nama anggota sebaiknya disimpan pada tabel `ANGGOTA`, bukan diulang pada tabel `PENJUALAN`.

**Contoh data yang bermasalah:**

| no_nota_penjualan | no_anggota | nama_anggota |
|---|---|---|
| N001 | A001 | Nadia Putri |
| N002 | A001 | Nadia Putri |
| N003 | A001 | Nadia Putri |

Ketiga transaksi tersebut merujuk pada anggota yang sama. Jika nama anggota berubah, semua baris transaksi yang menyimpan nama tersebut harus diperbarui. Jika hanya sebagian baris diperbarui, akan muncul ketidakkonsistenan data.

**Contoh kueri yang memperlihatkan anomali ubah:**

```sql
-- Nama anggota tersimpan berulang di tabel PENJUALAN.
UPDATE PENJUALAN
SET nama_anggota = 'Nadia Pratama'
WHERE no_nota_penjualan = 'N001';
```

Kueri tersebut hanya mengubah nama pada nota `N001`. Jika nota `N002` dan `N003` masih menyimpan nama lama, data anggota yang sama menjadi tidak konsisten.

**Perbaikan struktur relasi:**

```text
ANGGOTA(
    no_anggota PK,
    nama_anggota
)

PENJUALAN(
    no_nota_penjualan PK,
    tgl_penjualan,
    kode_petugas FK,
    no_anggota FK
)
```

Setelah pemisahan, perubahan nama anggota cukup dilakukan satu kali pada tabel `ANGGOTA`. Tabel `PENJUALAN` hanya menyimpan `no_anggota` sebagai referensi ke data anggota.

Dengan demikian, pemisahan tersebut mengurangi pengulangan data dan mencegah anomali ubah akibat penyimpanan nama anggota pada banyak baris transaksi.