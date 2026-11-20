import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nourou_academy/main.dart';

void main() {
  testWidgets('App boots into splash screen without crashing', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: NourouAcademyApp()));
    expect(find.text('Nourou'), findsOneWidget);
    expect(find.text('Academy'), findsOneWidget);
  });
}
