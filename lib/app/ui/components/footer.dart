import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Realização: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Image(
            image: const AssetImage("assets/images/logo_bar.png"),
            width: Get.width * 0.3,
          )
        ],
      ),
    );
  }
}
