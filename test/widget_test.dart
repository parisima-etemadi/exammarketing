// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exammarketing/main.dart';

void main() {
  testWidgets('App loads and shows home screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ExamStudyApp());

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify that the app title is displayed
    expect(find.text('مطالعه امتحان جامع'), findsOneWidget);
    
    // Verify that the comprehensive quiz button is present
    expect(find.text('آزمون جامع (تمام مباحث)'), findsOneWidget);
    
    // Verify that there are study topic cards
    expect(find.byType(Card), findsWidgets);
  });

  testWidgets('App has proper RTL direction', (WidgetTester tester) async {
    await tester.pumpWidget(ExamStudyApp());
    await tester.pumpAndSettle();

    // Find the Directionality widget and verify it's RTL
    final directionality = tester.widget<Directionality>(find.byType(Directionality).first);
    expect(directionality.textDirection, TextDirection.rtl);
  });
}
