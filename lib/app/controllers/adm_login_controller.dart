import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/auth_controller.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdmLoginController extends GetxController {
  final supabaseService = Get.find<SupabaseService>();
  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLogging = false.obs;

  submitFormLogin() async {
    isLogging.value = true;
    if (formKey.currentState!.validate()) {
      User? user = await authController.login(
          emailController.text, passwordController.text);

      if (user != null) {
        final role = authController.role;
        if (role == "admin") {
          Get.toNamed(Routes.admHome);
          return;
        } else {
          await supabaseService.signOut();
        }
      }
      Get.snackbar("Falha no login", "Credenciais fornecidas são inválidas!");
    }
    isLogging.value = false;
  }
}
