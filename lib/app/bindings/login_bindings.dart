import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/adm_login_controller.dart';
import 'package:semeio_app/app/controllers/auth_controller.dart';
import 'package:semeio_app/app/services/geolocator_service.dart';
import 'package:semeio_app/app/services/supabase_service.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SupabaseService(), permanent: true);
    Get.put(GeolocatorService(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(AdmLoginController());
  }
}
