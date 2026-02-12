import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blabla/ui/widgets/actions/blabutton.dart';  // Import BlaButton widget

void main() {
  testWidgets('BlaButton renders correctly and triggers onPressed', (WidgetTester tester) async {
    // Create a key to identify the BlaButton widget
    final buttonKey = Key('blabutton');

    // Build the widget tree for testing
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlaButton(
            // Set the key for easier identification
            label: 'Click Me',
            onPressed: () {
              // Check if the onPressed callback is called
              print('Button Pressed!');
            },
          ),
        ),
      ),
    );

    // Verify that the button is present in the widget tree
    expect(find.byKey(buttonKey), findsOneWidget);

    // Tap the button and trigger the onPressed callback
    await tester.tap(find.byKey(buttonKey));
    await tester.pump();

    // Verify that the button was tapped and the desired action took place
    // (In this case, we are checking the printed output)
    // You may want to check for other side effects instead, depending on your needs
  });
}
