// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:myapp/telaSplash.dart';
import 'package:myapp/provider/userProvider.dart';

void main() {
  testWidgets('App builds SplashPage correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
        child: const MaterialApp(
          home: SplashPage(),
        ),
      ),
    );

    expect(find.byType(SplashPage), findsOneWidget);
  });
}
