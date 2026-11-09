import 'package:material_ui/material_ui.dart';

/// Satu-satunya warna yang ditulis langsung: seed color tema.
const Color _seedColor = Color(0xFFB5541C);

void main() => runApp(const UmkmApp());

/// Data sederhana untuk satu menu.
class DataMenu {
  const DataMenu(this.nama, this.harga, this.kategori);

  final String nama;
  final int harga;
  final String kategori;
}

const List<DataMenu> daftarMenu = [
  DataMenu('Soto Medan', 25000, 'Berkuah'),
  DataMenu('Mie Gomak', 22000, 'Makanan Utama'),
  DataMenu('Lontong Medan', 20000, 'Sarapan'),
  DataMenu('Bika Ambon', 45000, 'Kue'),
  DataMenu('Teh Tarik Medan', 12000, 'Minuman'),
];

/// Mengubah 25000 menjadi "Rp25.000" tanpa paket tambahan.
String formatRupiah(int nilai) {
  final s = nilai.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buffer.write('.');
    buffer.write(s[i]);
  }
  return 'Rp$buffer';
}

/// Akar aplikasi (Stateless): hanya mengatur tema.
class UmkmApp extends StatelessWidget {
  const UmkmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dapur Nenek Medan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HalamanMenu(),
    );
  }
}

/// Halaman utama (Stateless): tidak menyimpan data yang berubah.
class HalamanMenu extends StatelessWidget {
  const HalamanMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dapur Nenek Medan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KepalaUsaha(),
            const SizedBox(height: 16),
            const KartuKontak(),
            const SizedBox(height: 16),
            Text('Daftar Menu', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            for (final menu in daftarMenu)
              KartuMenu(
                nama: menu.nama,
                harga: menu.harga,
                kategori: menu.kategori,
              ),
          ],
        ),
      ),
    );
  }
}

/// Kepala halaman (Stateless): gambar, nama usaha, deskripsi, tombol aksi.
class KepalaUsaha extends StatelessWidget {
  const KepalaUsaha({super.key});

  void _tampilkanPesan(BuildContext context, String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            // Ganti dengan Image.asset('assets/images/...') bila memakai foto sendiri.
            'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            // Cadangan bila gambar gagal dimuat (tanpa internet / saat uji).
            errorBuilder: (context, error, stackTrace) => Container(
              height: 180,
              width: double.infinity,
              color: skema.primaryContainer,
              alignment: Alignment.center,
              child: Icon(
                Icons.restaurant,
                size: 64,
                color: skema.onPrimaryContainer,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Dapur Nenek Medan', style: teks.headlineSmall),
        const SizedBox(height: 4),
        Text(
          'Masakan rumahan khas Medan dengan resep turun-temurun, '
          'dimasak segar setiap hari di Jalan Merak Jingga, Medan.',
          style: teks.bodyMedium?.copyWith(color: skema.onSurfaceVariant),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.icon(
              onPressed: () => _tampilkanPesan(context, 'Membuka pemesanan...'),
              icon: const Icon(Icons.shopping_bag_outlined),
              label: const Text('Pesan'),
            ),
            OutlinedButton.icon(
              onPressed: () => _tampilkanPesan(context, 'Membuka peta...'),
              icon: const Icon(Icons.map_outlined),
              label: const Text('Lihat Lokasi'),
            ),
          ],
        ),
      ],
    );
  }
}

/// Informasi kontak (Stateless): Card + ListTile.
class KartuKontak extends StatelessWidget {
  const KartuKontak({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.phone_outlined),
            title: Text('+62 812-0000-0000'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.email_outlined),
            title: Text('halo@dapurnenekmedan.example'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text('Medan, Sumatera Utara'),
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.schedule_outlined),
            title: Text('Buka setiap hari, 08.00 - 21.00'),
          ),
        ],
      ),
    );
  }
}

/// Satu baris menu (Stateless): tampilannya hanya bergantung pada parameter.
class KartuMenu extends StatelessWidget {
  const KartuMenu({
    super.key,
    required this.nama,
    required this.harga,
    required this.kategori,
  });

  final String nama;
  final int harga;
  final String kategori;

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;

    return Card(
      child: ListTile(
        isThreeLine: true,
        leading: const Icon(Icons.restaurant_menu),
        title: Text(nama, style: teks.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatRupiah(harga)),
            const SizedBox(height: 6),
            Chip(
              label: Text(kategori),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        trailing: TombolFavorit(namaMenu: nama),
      ),
    );
  }
}

/// Tombol favorit (Stateful): satu-satunya bagian yang punya data berubah.
class TombolFavorit extends StatefulWidget {
  const TombolFavorit({super.key, required this.namaMenu});

  final String namaMenu;

  @override
  State<TombolFavorit> createState() => _TombolFavoritState();
}

class _TombolFavoritState extends State<TombolFavorit> {
  bool _favorit = false;

  void _ubah() {
    setState(() => _favorit = !_favorit);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            _favorit
                ? '${widget.namaMenu} ditambahkan ke favorit'
                : '${widget.namaMenu} dihapus dari favorit',
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: _favorit ? 'Hapus dari favorit' : 'Tandai favorit',
      onPressed: _ubah,
      icon: Icon(_favorit ? Icons.favorite : Icons.favorite_border),
      color: _favorit ? Theme.of(context).colorScheme.primary : null,
    );
  }
}