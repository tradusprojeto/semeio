import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/user_password_update_controller.dart';

class UserPasswordUpdateBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UserPasswordUpdateController());
  }
}
