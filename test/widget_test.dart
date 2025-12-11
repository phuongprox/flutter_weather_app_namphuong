import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weatherapp_namphuong/main.dart';

void main() {
  testWidgets('App starts and displays title', (WidgetTester tester) async {
    await tester.pumpWidget(const WeatherApp());
    expect(find.text('Flutter Weather'), findsOneWidget);
  });
}
