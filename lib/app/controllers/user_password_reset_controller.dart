import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/services/supabase_service.dart';

class UserPasswordResetController extends GetxController {
  final supabaseService = Get.find<SupabaseService>();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var emailController = TextEditingController();

  sendPasswordResetLinkForEmail() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        await supabaseService
            .sendPasswordResetLinkForEmail(emailController.text);
        isLoading.value = false;
        Get.snackbar("Sucesso", "Link enviado para ${emailController.text}",
            backgroundColor: Colors.green, colorText: Colors.white);
      } catch (err) {
        print(err);
        Get.snackbar("Aviso", "Algo deu errado, tente novamente mais tarde",
            backgroundColor: Colors.amberAccent);
      } finally {
        isLoading.value = false;
      }
    }
  }
}
