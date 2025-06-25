import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final double width;
  final double height;
  final double fontSize;
  final Color backgroundColor;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final double? iconSize;

  const CardButton({
    super.key,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.backgroundColor,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: iconSize ?? 35),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
