import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/adm_home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AdmHomeController());
  }
}
