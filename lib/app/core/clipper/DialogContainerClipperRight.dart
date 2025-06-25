import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogContainerClipperRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var borderRadius = Get.height * 0.065;
    final path = Path();

    path.moveTo(borderRadius, 0);
    path.quadraticBezierTo(0, 0, 0, borderRadius);

    path.lineTo(0, size.height - borderRadius);
    path.quadraticBezierTo(0, size.height, borderRadius, size.height);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, borderRadius);
    path.quadraticBezierTo(size.width, 0, size.width - borderRadius, 0);
    path.lineTo(borderRadius, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(DialogContainerClipperRight oldClipper) => false;
}
