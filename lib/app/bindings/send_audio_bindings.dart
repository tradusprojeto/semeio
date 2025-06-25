import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/send_audio_controller.dart';

class SendAudioBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SendAudioController());
  }
}
