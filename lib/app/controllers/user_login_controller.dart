import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/auth_controller.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserLoginController extends GetxController {
  final supabaseService = Get.find<SupabaseService>();
  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  submitFormLogin() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        User? user = await authController.login(
            emailController.text, passwordController.text);
        isLoading.value = false;
        if (user == null) {
          Get.snackbar(
              "Falha no login", "Credenciais fornecidas são inválidas!");
          return;
        }
        Get.toNamed(Routes.userHome);
      } catch (err) {
        print(err);
        Get.snackbar("Aviso", "Algo deu errado, tente novamente mais tarde",
            backgroundColor: Colors.amberAccent);
      }
    }
  }
}
