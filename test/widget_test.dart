import 'package:flutter_test/flutter_test.dart';
import 'package:nourou_academy/main.dart';

void main() {
  testWidgets('affiche la page d’accueil Nourou Academy', (tester) async {
    await tester.pumpWidget(const NourouAcademyApp());

    expect(find.text('Nourou'), findsOneWidget);
    expect(
      find.text('Apprenez quelque chose\nde nouveau aujourd’hui ✨'),
      findsOneWidget,
    );
  });
}
