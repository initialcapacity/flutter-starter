import 'package:flutter_test/flutter_test.dart';

extension ForecastPageObject on WidgetTester {
  Future<void> goToSearch() async {
    await tap(find.bySemanticsLabel('Go to search'));
    await pumpAndSettle();
  }
}
