import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/app.dart';
import 'package:portfolio/screens/home/home_screen.dart';

void main() {
  testWidgets('Dark mode renders without errors', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(() => tester.view.resetDevicePixelRatio());

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 2900));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 700));

    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    await tester.tap(find.byIcon(Icons.dark_mode));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byIcon(Icons.light_mode), findsOneWidget,
        reason: 'toggle icon should switch to light_mode');

    final appCtx = tester.element(find.byType(HomeScreen));
    expect(Theme.of(appCtx).brightness, Brightness.dark);
  });
}
