// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory/Views/login_view.dart';
import 'package:inventory/main.dart';

void main() {
  testWidgets('HomePage renders register screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        title: 'YESTER',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const LoginView(),
      ),
    );

    // Verify that the register screen is shown.
    expect(find.text('Register'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });
}
