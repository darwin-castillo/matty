import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matty/main.dart';

void main() {
  testWidgets('App renders quiz page', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MattyApp()));
    expect(find.text('2 × ?'), findsOneWidget);
  });
}