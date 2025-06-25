import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/user_edit_audio_controller.dart';

class UserEditAudioBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UserEditAudioController());
  }
}
