import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/user_password_update_controller.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';
import 'package:semeio_app/app/core/validators/form_validators.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/ui/components/footer.dart';
import 'package:semeio_app/app/ui/components/header.dart';

class UserPasswordUpdatePage extends GetView<UserPasswordUpdateController> {
  const UserPasswordUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        hasSignOut: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double formWidth = constraints.maxWidth * 0.4;
          double formHeight = constraints.maxHeight;
          double baseFontSize = constraints.maxWidth * 0.012;
          return Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              clipBehavior: Clip.none,
              children: [
                Image(
                  image: const AssetImage("assets/images/form-login.png"),
                  height: formHeight,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: formHeight * 0.30,
                  child: SizedBox(
                    width: formWidth,
                    child: Text(
                      "ATUALIZE SUA SENHA",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: baseFontSize * 1.65,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                _buildFormUpdatePassword(formWidth, formHeight, baseFontSize),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildFormUpdatePassword(
      double width, double height, double baseFontSize) {
    return Positioned(
      top: height * 0.45,
      child: Center(
        child: SizedBox(
          width: width * 0.70, // Tamanho do formulário ajustável
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Senha",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: baseFontSize, color: Colors.black)),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: validatePassword,
                      controller: controller.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Sua nova senha",
                        hintStyle: TextStyle(fontSize: baseFontSize),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Text("Confirme sua senha",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: baseFontSize, color: Colors.black)),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: validatePassword,
                      controller: controller.confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Confirme sua senha",
                        hintStyle: TextStyle(fontSize: baseFontSize),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14.0),
                Obx(
                  () => SizedBox(
                    width: width * 0.2,
                    height:
                        height * 0.1, // Ajustando botão de acordo com a tela
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        backgroundColor: loginBtnColor,
                      ),
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.updatePassword,
                      child: Center(
                        child: controller.isLoading.value
                            ? const SizedBox(
                                width: 20.0, // Defina um tamanho fixo menor
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2, // Deixa a linha mais fina
                                ),
                              )
                            : Text(
                                "Salvar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: baseFontSize),
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.userLogin),
                  child: Text(
                    "Voltar",
                    style: TextStyle(
                        color: Colors.white, fontSize: baseFontSize * 0.88),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
