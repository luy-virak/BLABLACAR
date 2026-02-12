import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final Icon? icon;

  BlaButton({
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.icon, 
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,  
      label: Text(label),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          isPrimary ? Colors.blue.shade300 : Colors.white,  // Set background to blue.300 or white
        ),
        foregroundColor: WidgetStateProperty.all(
          isPrimary ? Colors.white : Colors.blue.shade300,  // Set text color to white for primary button
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 16, vertical: 10),  // Adjust padding as necessary
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),  // Optional: Adds rounded corners to the button
          ),
        ),
      ),
    );
  }
}
