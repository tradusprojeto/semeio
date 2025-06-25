import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/user_password_reset_controller.dart';

class UserPasswordResetBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UserPasswordResetController());
  }
}
