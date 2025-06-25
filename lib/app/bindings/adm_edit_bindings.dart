import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/adm_edit_audio_controller.dart';

class AdmEditBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AdmEditAudioController());
  }
}
