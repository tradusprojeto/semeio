import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final double height;
  final double width;
  final double baseFontSize;
  final VoidCallback onPressed;

  const ButtonPrimary({
    super.key,
    required this.height,
    required this.width,
    required this.baseFontSize,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.025,
          vertical: height * 0.01,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgSendBtn.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Text(
          "Enviar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: baseFontSize * 1.6,
          ),
        ),
      ),
    );
  }
}
