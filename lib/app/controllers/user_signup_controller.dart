import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/services/supabase_service.dart';

class UserSignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final supabaseService = Get.find<SupabaseService>();

  var isLoading = false.obs;
  var userNameController = TextEditingController();
  var userEmailController = TextEditingController();
  var userPasswordController = TextEditingController();
  var userConfirmPasswordController = TextEditingController();

  void submitForms() async {
    if (formKey.currentState!.validate()) {
      try {
        if (userPasswordController.text != userConfirmPasswordController.text) {
          Get.snackbar("Aviso", "Senhas precisam ser iguais",
              backgroundColor: Colors.amberAccent);
          return;
        }
        isLoading.value = true;
        final user = await supabaseService.signUp(userNameController.text,
            userEmailController.text, userPasswordController.text);
        if (user != null) {
          Get.snackbar(
              "Sucesso", "Para finalizar o cadastro, verifique seu email",
              backgroundColor: Colors.green);
          Get.toNamed(Routes.userLogin);
        }
      } catch (err) {
        print(err);
        Get.snackbar("Aviso", "Algo deu errado, tente novamente mais tarde",
            backgroundColor: Colors.amberAccent);
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    userNameController.dispose();
    userEmailController.dispose();
    userPasswordController.dispose();
    userConfirmPasswordController.dispose();
    isLoading.close();
    super.onClose();
  }
}
