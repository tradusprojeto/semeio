import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/user_signup_controller.dart';

class UserSignUpBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UserSignUpController());
  }
}
