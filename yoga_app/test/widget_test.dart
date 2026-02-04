import 'package:flutter_test/flutter_test.dart';
import 'package:yoga_app/main.dart';

void main() {
  testWidgets('App renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const YogaApp());

    // Verify that the app renders
    expect(find.text('로딩 중...'), findsOneWidget);
  });
}
