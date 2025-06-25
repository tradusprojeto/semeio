import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/auth_controller.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/services/supabase_service.dart';

class HeaderController extends GetxController {
  final supabaseService = Get.find<SupabaseService>();
  final authController = Get.find<AuthController>();
  Future<void> signOut() async {
    await authController.logout();
    await Get.offNamed(Routes.userLogin);
  }
}
