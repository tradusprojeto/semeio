import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/ui/components/footer.dart';

import 'package:semeio_app/app/ui/components/header.dart';

class SendAudio extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Header(),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/paper_texture.png"),
                  fit: BoxFit.fill)),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            width: Get.width,
            height: Get.height,
            // child: const SemeioFormMobile(),
            child: const Placeholder(),
          ),
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }

  const SendAudio({super.key});
}
