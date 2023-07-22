import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension LocationSearchPageObject on WidgetTester {
  Future<void> submitSearch(String text) async {
    await enterText(find.byType(TextField), text);
    await testTextInput.receiveAction(TextInputAction.done);
  }
}
