import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nourou_academy/core/theme/app_theme.dart';
import 'package:nourou_academy/features/home/home_screen.dart';

void main() {
  testWidgets('HomeScreen renders greeting, XP counter, and stats', (tester) async {
    // Provide adequate size for scrollable home screen.
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light,
          home: const HomeScreen(),
        ),
      ),
    );

    // Let entrance animations complete.
    await tester.pumpAndSettle(const Duration(milliseconds: 1500));

    // Verify key UI elements.
    expect(find.text('Bonjour, Awa 👋'), findsOneWidget);
    expect(find.text('1 250 XP'), findsOneWidget);
    expect(find.text('Lecture hors connexion protégée'), findsOneWidget);
    expect(find.text('Formations populaires'), findsOneWidget);
  });
}
