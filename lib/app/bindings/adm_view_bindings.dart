import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/adm_view_audio_controller.dart';

class AdmViewBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AdmViewAudioController());
  }
}
