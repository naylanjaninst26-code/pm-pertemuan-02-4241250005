# pm-pertemuan-02-4241250005

Tugas Rutin 2 - Pemrograman Mobile: Kasir Console

- Nama: Nayla Anjani Nasution
- NIM: 4241250005
- Kelas: PSIK 24C

Program console Dart untuk kasir sederhana. Pengguna mengetik satu baris pesanan, lalu program menampilkan struk lengkap dengan total, diskon, dan kategori produk.

## Cara Menjalankan

```
dart run
```

Format pesanan: kode produk, huruf `x`, jumlah, dipisah koma. Contoh: `P01x2, P05x1`.

## Fitur

- **Katalog:** 5 produk disimpan dalam `Map` (kode menjadi kunci, data produk berupa `Record`).
- **Pesanan:** satu baris diurai dengan `split`, `trim`, dan `int.tryParse`.
- **Null safety:** kode salah atau jumlah bukan angka diabaikan, program tidak crash.
- **Struk:** `map` untuk membuat baris struk, `fold` untuk menghitung total, `Set` untuk kategori unik, diskon 10% jika total mencapai Rp100.000 atau lebih.

## Skenario Uji

### Skenario 1: pesanan dengan kode tidak dikenal (diskon berlaku)

Input: `P01x2, P05x1, P09x3`

```
=== STRUK ===
Kopi Sidikalang 250 g   2 x    90000
Bolu Meranti            1 x    80000
--------------------------------------
Total                           170000
Diskon 10%                       17000
Bayar                           153000

Kategori : Minuman, Makanan
Diabaikan: P09x3
```

`P09` tidak ada di katalog, jadi diabaikan tanpa membuat program crash.

### Skenario 2: pesanan kecil (diskon tidak berlaku)

Input: `P02x1`

```
=== STRUK ===
Teh Sidamanik 100 g     1 x    25000
--------------------------------------
Total                            25000
Diskon 10%                           0
Bayar                            25000

Kategori : Minuman
```

Total di bawah Rp100.000, sehingga diskon 0.

## Penjelasan var, final, dan const

- `var`: variabel yang nilainya boleh diubah, tipenya disimpulkan otomatis. Tidak dipakai di program ini karena tidak ada nilai yang perlu diubah.
- `final`: diisi sekali saja, nilainya ditentukan saat program berjalan. Ini yang paling banyak dipakai di program ini, misalnya `katalog`, `input`, `jumlah`, `produk`, dan `total`, karena nilainya baru diketahui setelah pengguna mengetik.
- `const`: nilainya sudah pasti sejak kompilasi. Tidak dipakai di sini karena nilai-nilai penting program bergantung pada input pengguna.

## Penjelasan Null Safety

Di Dart, tipe tanpa tanda tanya (misalnya `String`) tidak boleh null, sedangkan tipe dengan tanda tanya (misalnya `String?`) boleh null. Penerapannya di program ini:

- `stdin.readLineSync() ?? ''`: hasil `readLineSync()` bisa `null`, jadi dipakai `??` agar diganti teks kosong.
- `int.tryParse(...)`: mengembalikan `null` jika teks bukan angka. Berbeda dengan `int.parse` yang membuat program berhenti dengan error.
- `katalog[kode]`: mengambil data dari `Map` selalu bisa `null` jika kodenya tidak ada. Hasilnya dicek dulu dengan `produk == null`, sehingga setelah itu Dart tahu nilainya pasti ada.

Operator `!` (paksa non-null) **tidak dipakai** di program ini, karena semua kemungkinan `null` sudah ditangani dengan pengecekan, `??`, dan `tryParse`.

## Pernyataan Penggunaan AI

Saya menggunakan Claude (AI) untuk membantu menyusun kerangka kode, menjelaskan konsep Dart (Map, Record, null safety, `fold`), dan memandu langkah penggunaan Git dan GitHub. Kode saya jalankan sendiri di laptop, saya uji dengan dua skenario di atas, dan saya pastikan `dart format` serta `dart analyze` bersih sebelum commit.