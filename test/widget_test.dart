import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('App renders without errors', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(() => tester.view.resetDevicePixelRatio());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(seconds: 2));

    expect(find.textContaining('Punno'), findsAtLeast(1));
  });
}
