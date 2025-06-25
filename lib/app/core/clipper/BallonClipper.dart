import 'package:flutter/material.dart';

class BallonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const arrowWidth = 50.0;
    const arrowHeight = 15.0;
    const borderRadius = 52.0;

    final path = Path();

    path.moveTo(arrowWidth + borderRadius, 0);

    path.lineTo(size.width - borderRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, borderRadius);

    path.lineTo(size.width, size.height - borderRadius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - borderRadius, size.height);

    path.lineTo(arrowWidth + borderRadius, size.height);
    path.quadraticBezierTo(
      arrowWidth,
      size.height,
      arrowWidth,
      size.height - borderRadius / 2,
    );

    // Desenha a asa (seta). Sobe até o “pé” da seta
    path.lineTo(arrowWidth, (size.height / 1.2) - arrowHeight);
    // Ponta da seta (vai até a esquerda total)
    path.lineTo(0, size.height / 1.2);
    // Volta até o outro “pé” da seta
    path.lineTo(arrowWidth, (size.height / 1.2));

    // Agora fecha subindo até o canto superior esquerdo arredondado
    path.lineTo(arrowWidth, borderRadius);
    path.quadraticBezierTo(
      arrowWidth,
      0,
      arrowWidth + borderRadius,
      0,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(BallonClipper oldClipper) => false;
}
