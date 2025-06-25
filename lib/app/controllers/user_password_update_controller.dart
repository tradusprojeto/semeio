import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/services/supabase_service.dart';

class UserPasswordUpdateController extends GetxController {
  final supabaseService = Get.find<SupabaseService>();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  updatePassword() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar("Aviso", "Senhas precisam ser iguais",
            backgroundColor: Colors.yellow, colorText: Colors.black);
        return;
      }
      try {
        isLoading.value = true;
        final code = _getParamsFromURL();
        if (code == null) {
          isLoading.value = false;
          Get.snackbar("Aviso", "Algo deu errado, tente novamente mais tarde",
              backgroundColor: Colors.yellow, colorText: Colors.black);
          Get.toNamed(Routes.userPasswordReset);
          return;
        }
        final user =
            await supabaseService.updatePassword(code, passwordController.text);
        if (user == null) {
          isLoading.value = false;
          Get.snackbar("Aviso", "Algo deu errado, tente novamente mais tarde",
              backgroundColor: Colors.yellow, colorText: Colors.black);
          Get.toNamed(Routes.userPasswordReset);
          return;
        }
        isLoading.value = false;
        Get.snackbar("Sucesso", "Senha alterada com sucesso",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.toNamed(Routes.userLogin);
      } catch (err) {
        print(err);
        Get.snackbar("Aviso", "Algo deu errado, tente novamente mais tarde",
            backgroundColor: Colors.yellow, colorText: Colors.black);
      } finally {
        isLoading.value = false;
      }
    }
  }

  String? _getParamsFromURL() {
    final uri = Uri.base;
    final code = uri.queryParameters["code"];
    print("URI CODE: $code");
    return code;
  }

  @override
  void onClose() {
    passwordController.dispose();
    isLoading.close();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
