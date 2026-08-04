import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/app.dart';

void main() {
  testWidgets('Mobile renders without errors', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(() => tester.view.resetDevicePixelRatio());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(seconds: 2));

    expect(find.textContaining('Punno'), findsAtLeast(1));
  });

  testWidgets('Tablet renders without errors', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(768, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(() => tester.view.resetDevicePixelRatio());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(seconds: 2));

    expect(find.textContaining('Punno'), findsAtLeast(1));
  });
}
