import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/user_home_controller.dart';

class UserHomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UserHomeController());
  }
}
