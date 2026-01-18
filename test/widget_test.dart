// This is a basic Flutter widget test for Futly Scout.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:futly_scout/app.dart';
import 'package:futly_scout/environment/app_environment.dart';

void main() {
  setUpAll(() {
    // Initialize app environment for tests
    AppEnvironment.initialize();
  });

  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the app has loaded (check for login screen or home)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
