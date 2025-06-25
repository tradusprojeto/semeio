import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var borderRadius = Get.height * 0.065;

    final path = Path();

    path.moveTo(0, 0);

    path.lineTo(size.width - borderRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, borderRadius);

    path.lineTo(size.width, size.height - borderRadius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - borderRadius, size.height);

    path.lineTo(borderRadius, size.height);
    path.quadraticBezierTo(
      0,
      size.height,
      0,
      size.height,
    );

    path.quadraticBezierTo(
      0,
      0,
      borderRadius,
      0,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DialogContainerClipper oldClipper) => false;
}
