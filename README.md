# Dapur Nenek Medan — Menu UMKM Kuliner

Tugas Rutin 5, Pemrograman Mobile (3KOM40215), Pertemuan 5: Pengantar Flutter dan Widget Basics dengan Material Design 3.

## (a) Identitas

| | |
|---|---|
| Nama | Lastri P. Silaban |
| NIM | 4243250037 |
| Kelas | PSIK-24C |
| Program Studi | Ilmu Komputer, FMIPA, Universitas Negeri Medan |

Aplikasi satu halaman untuk UMKM kuliner fiktif "Dapur Nenek Medan": identitas usaha, kontak, dan daftar 5 menu yang dapat ditandai favorit.

## Cara Menjalankan

```bash
git clone https://github.com/<username>/pm-tugas-05-4243250037.git
cd pm-tugas-05-4243250037
flutter pub get
flutter analyze
flutter test
flutter run
```

## (b) Tangkapan Layar

| Mode Terang | Mode Gelap |
|---|---|
| ![Mode Terang](Screenshoot/Screenshot%20Mode%20Terang.png) | ![Mode Gelap](Screenshoot/Screenshot%20Mode%20Gelap.png) |

## (c) Diagram Widget Tree

`[SL]` = StatelessWidget, `[SF]` = StatefulWidget

```
UmkmApp [SL]
└─ MaterialApp (tema: ColorScheme.fromSeed + darkTheme)
   └─ HalamanMenu [SL]
      └─ Scaffold
         ├─ AppBar
         └─ SingleChildScrollView
            └─ Column
               ├─ KepalaUsaha [SL]
               │   ├─ Image.network (cadangan: Container + Icon)
               │   ├─ Text (nama usaha), Text (deskripsi)
               │   └─ Wrap → FilledButton.icon, OutlinedButton.icon
               ├─ KartuKontak [SL]
               │   └─ Card → Column → 4 × ListTile
               ├─ Text ("Daftar Menu")
               └─ KartuMenu [SL] × 5
                   └─ Card
                      └─ ListTile
                         ├─ leading: Icon
                         ├─ title: Text (nama)
                         ├─ subtitle: Column → Text (harga), Chip (kategori)
                         └─ trailing: TombolFavorit [SF]   ← satu-satunya Stateful
                                      └─ IconButton (favorite / favorite_border)
```

## (d) Penjelasan Widget Tree, Element Tree, dan Render Tree

Widget tree adalah konfigurasi antarmuka yang saya tulis di `build()`: MaterialApp, Scaffold, Column, hingga KartuMenu. Widget bersifat immutable dan ringan, sehingga dibuat ulang setiap `build()` dipanggil. Element tree adalah instans yang bertahan lama untuk setiap posisi widget; di sinilah objek State dan BuildContext hidup. Saat `setState()` dipanggil, element ditandai kotor, `build()` dipanggil lagi, lalu Flutter membandingkan widget baru dengan yang lama berdasarkan tipe dan key. Jika cocok, element dan render object lama dipakai ulang. Render tree berisi RenderObject seperti RenderFlex dan RenderParagraph yang menghitung ukuran, posisi, lalu menggambar ke layar.

Pada aplikasi ini, HalamanMenu, KepalaUsaha, KartuKontak, dan KartuMenu dibuat Stateless karena tampilannya hanya bergantung pada parameter dari luar (nama, harga, kategori) dan tidak memiliki data yang berubah. Hanya TombolFavorit yang Stateful karena menyimpan status favorit (`_favorit`) yang berubah saat pengguna menekan ikon hati. Dengan membuat bagian Stateful sekecil mungkin, `setState()` hanya membangun ulang satu ikon, bukan seluruh halaman atau daftar menu, sehingga lebih efisien dan kode lebih mudah dirawat.

## Komponen Material 3 yang Dipakai

`FilledButton.icon`, `OutlinedButton.icon`, `IconButton`, `Chip`, `Card`, `ListTile`, `SnackBar`; seluruh warna diambil dari `Theme.of(context).colorScheme`.

## (e) Pernyataan Penggunaan AI

Kerangka kode aplikasi, widget test, dan draf README ini dibantu oleh AI. Saya telah membaca, menjalankan, dan memahami seluruh kode serta penjelasan di atas.