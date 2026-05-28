import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_movie_explorer/main.dart';

void main() {
  testWidgets('App starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MovieExplorerApp());
    expect(find.text('Movie Explorer'), findsOneWidget);
  });
}
