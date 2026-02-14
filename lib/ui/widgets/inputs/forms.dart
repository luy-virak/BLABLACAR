import 'package:flutter/material.dart';

class SubBla extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback? onTap; 

  const SubBla({
    super.key,
    this.icon,
    required this.label,
    this.onTap, 
  });

  Color _textColor() {
    return label.isEmpty ? Colors.grey : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // use the tap
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: _textColor()),
              const SizedBox(width: 8),
            ],
            Text(
                label.isEmpty ? 'No location' : label,
                textAlign: TextAlign.center,
                style: TextStyle(color: _textColor()),
              ),
          ],
        ),
      ),
    );
  }
}