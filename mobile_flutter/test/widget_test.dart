import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_flutter/app.dart';

void main() {
  testWidgets('halaman awal menampilkan nama dan tombol aplikasi', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const VEduMatchApp());

    expect(find.text('V-EduMatch'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
    expect(find.text('Daftar'), findsOneWidget);
  });
}
