import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, Get.height * 0.143)
      ..cubicTo(Get.width * 0.0841, Get.height * 0.171759, Get.width * 0.36458,
          Get.height * 0.04259, Get.width * 0.46823, 0)
      ..lineTo(Get.width * 0.5416, 0)
      ..cubicTo(Get.width * 0.5815, Get.height * 0.179666, Get.width * 0.5755,
          Get.height * 0.2898, Get.width * 0.553385, Get.height * 0.4907)
      ..lineTo(Get.width * 0.5554, Get.height * 0.3567)
      ..cubicTo(Get.width * 0.565, Get.height * 0.7745, Get.width * 0.5703,
          Get.height * 0.85694, Get.width * 0.559, Get.height)
      ..lineTo(0, Get.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
