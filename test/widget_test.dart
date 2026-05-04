import 'package:flutter_test/flutter_test.dart';
import 'package:market_web/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MarketApp());
    await tester.pumpAndSettle();
    expect(find.text('M Goat'), findsWidgets);
  });
}