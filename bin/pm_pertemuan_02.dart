import 'dart:io';

// Katalog produk: Map dengan kunci kode produk, nilainya Record
final katalog = <String, ({String nama, String kategori, int harga})>{
  // final: katalog diisi sekali dan tidak diganti lagi
  'P01': (nama: 'Kopi Sidikalang 250 g', kategori: 'Minuman', harga: 45000),
  'P02': (nama: 'Teh Sidamanik 100 g', kategori: 'Minuman', harga: 25000),
  'P03': (nama: 'Sirup Markisa', kategori: 'Minuman', harga: 35000),
  'P04': (nama: 'Pancake Durian', kategori: 'Makanan', harga: 60000),
  'P05': (nama: 'Bolu Meranti', kategori: 'Makanan', harga: 80000),
};

void main() {
  print('=== KATALOG PRODUK ===');
  for (final e in katalog.entries) {
    final p = e.value;
    print('${e.key}  ${p.nama.padRight(24)}${p.harga.toString().padLeft(8)}');
  }

  // Baca satu baris pesanan; stdin bisa null, jadi pakai ??
  stdout.write('\nPesanan (contoh: P01x2, P05x1): ');
  final input = stdin.readLineSync() ?? '';

  final dipesan = <({String nama, String kategori, int harga, int jumlah})>[];
  final diabaikan = <String>[];

  for (final bagian in input.split(',')) {
    final teks = bagian.trim();
    if (teks.isEmpty) continue;

    final pecah = teks.toLowerCase().split('x');
    if (pecah.length != 2) {
      diabaikan.add(teks);
      continue;
    }

    final kode = pecah[0].trim().toUpperCase();
    final jumlah = int.tryParse(pecah[1].trim()); // bisa null
    final produk = katalog[kode]; // bisa null kalau kode tidak ada

    if (jumlah == null || jumlah <= 0 || produk == null) {
      diabaikan.add(teks);
      continue;
    }

    // Di sini produk dan jumlah sudah pasti tidak null, jadi tanpa tanda !
    dipesan.add((
      nama: produk.nama,
      kategori: produk.kategori,
      harga: produk.harga,
      jumlah: jumlah,
    ));
  }

  if (dipesan.isEmpty) {
    print('\nTidak ada pesanan yang valid.');
    if (diabaikan.isNotEmpty) print('Diabaikan: ${diabaikan.join(', ')}');
    return;
  }

  // Struk
  print('\n=== STRUK ===');
  final baris = dipesan.map((d) {
    final subtotal = d.harga * d.jumlah;
    return '${d.nama.padRight(24)}${d.jumlah} x ${subtotal.toString().padLeft(8)}';
  });
  baris.forEach(print);

  final total = dipesan.fold<int>(0, (s, d) => s + d.harga * d.jumlah);
  final diskon = total >= 100000 ? total ~/ 10 : 0;
  final bayar = total - diskon;
  final kategori = dipesan.map((d) => d.kategori).toSet();

  print('-' * 38);
  print('${'Total'.padRight(28)}${total.toString().padLeft(10)}');
  print('${'Diskon 10%'.padRight(28)}${diskon.toString().padLeft(10)}');
  print('${'Bayar'.padRight(28)}${bayar.toString().padLeft(10)}');
  print('\nKategori : ${kategori.join(', ')}');
  if (diabaikan.isNotEmpty) print('Diabaikan: ${diabaikan.join(', ')}');
}
