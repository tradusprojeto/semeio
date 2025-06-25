import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/MapPageController.dart';

class MapPageBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MapPageController());
  }
}
