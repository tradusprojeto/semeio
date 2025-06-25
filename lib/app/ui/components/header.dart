import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/header_controller.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final bool? hasSignOut;
  Header({super.key, this.hasSignOut = true});

  final HeaderController controller = Get.put(HeaderController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.12,
      child: Stack(
        children: [
          Image(
            image: const AssetImage("assets/images/new_header_img.png"),
            fit: BoxFit.fill,
            width: Get.width,
          ),
          Positioned(
            top: Get.height * 0.015,
            left: Get.width * 0.015,
            child: Image(
              image: const AssetImage("assets/images/logo_semeio.png"),
              width: Get.width * 0.08,
              fit: BoxFit.cover,
            ),
          ),
          if (hasSignOut == true)
            Positioned(
              top: Get.height * 0.02,
              right: Get.width * 0.02,
              child: IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () async {
                  await controller.signOut();
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
