import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pm_tugas_05_4243250037/main.dart';

void main() {
  testWidgets('Ikon favorit berubah setelah ditekan', (tester) async {
    await tester.pumpWidget(const UmkmApp());

    // Awalnya semua menu belum difavoritkan.
    expect(find.byIcon(Icons.favorite_border), findsNWidgets(daftarMenu.length));
    expect(find.byIcon(Icons.favorite), findsNothing);

    // Tekan tombol favorit pada menu pertama.
    final tombol = find.byType(TombolFavorit).first;
    await tester.ensureVisible(tombol);
    await tester.pumpAndSettle();
    await tester.tap(
      find.descendant(of: tombol, matching: find.byType(IconButton)),
    );
    await tester.pump();

    // Hanya satu ikon yang berubah menjadi hati penuh, dan SnackBar tampil.
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(
      find.byIcon(Icons.favorite_border),
      findsNWidgets(daftarMenu.length - 1),
    );
    expect(find.textContaining('ditambahkan ke favorit'), findsOneWidget);
  });
}