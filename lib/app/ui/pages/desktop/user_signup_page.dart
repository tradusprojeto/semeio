import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/user_signup_controller.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';
import 'package:semeio_app/app/core/validators/form_validators.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/ui/components/footer.dart';
import 'package:semeio_app/app/ui/components/header.dart';

class UserSignUpPage extends GetView<UserSignUpController> {
  const UserSignUpPage({super.key});

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
            heightFactor: 0.8,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: [
                Image(
                  image:
                      const AssetImage("assets/images/form-signup-large2.png"),
                  height: formHeight,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: formHeight * 0.15,
                  child: SizedBox(
                    width: formWidth,
                    child: Text(
                      "CADASTRE-SE\nPREENCHA OS DADOS",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: baseFontSize * 1.18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                _buildFormLogin(formWidth, formHeight, baseFontSize * 0.88),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildFormLogin(double width, double height, double baseFontSize) {
    return Positioned(
      top: height * 0.30,
      child: Center(
        child: SizedBox(
          width: width * 0.6, // Tamanho do formulário ajustável
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nome",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: width < 940 ? 16 : 18)),
                    _buildCompactTextField(
                      hintText: "Seu nome",
                      controller: controller.userNameController,
                      width: width,
                      baseFontSize: baseFontSize,
                      validator: validateName,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: width < 940 ? 16 : 18)),
                    _buildCompactTextField(
                        hintText: "Seu email",
                        controller: controller.userEmailController,
                        width: width,
                        baseFontSize: baseFontSize,
                        validator: validateEmail,
                        keyboardType: TextInputType.emailAddress),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Senha:",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: width < 940 ? 16 : 18)),
                    _buildCompactTextField(
                        hintText: "Sua senha",
                        controller: controller.userPasswordController,
                        width: width,
                        baseFontSize: baseFontSize,
                        validator: validatePassword,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Repita a senha:",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: width < 940 ? 16 : 18)),
                    _buildCompactTextField(
                        hintText: "Confirme sua senha",
                        controller: controller.userConfirmPasswordController,
                        width: width,
                        baseFontSize: baseFontSize,
                        validator: validatePassword,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword),
                  ],
                ),
                const SizedBox(height: 10),
                Obx(
                  () => SizedBox(
                    width: width * 0.2, // Ajustando botão de acordo com a tela
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
                          : controller.submitForms,
                      child: Center(
                        child: controller.isLoading.value
                            ? const SizedBox(
                                width: 18, // Defina um tamanho fixo menor
                                height: 18,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2, // Deixa a linha mais fina
                                ),
                              )
                            : Text(
                                "Cadastrar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: baseFontSize),
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.userLogin),
                  child: Text(
                    "Voltar",
                    style: TextStyle(
                        color: Colors.white, fontSize: width < 940 ? 14 : 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactTextField({
    required String hintText,
    required TextEditingController controller,
    required double width,
    required double baseFontSize,
    String? Function(String?)? validator,
    TextInputType keyboardType =
        TextInputType.text, // Tipo de teclado, por padrão, é TextInputType.text
    bool obscureText =
        false, // Se o texto será ocultado, por padrão é false (não oculto)
  }) {
    return SizedBox(
      width: 240,
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText, // Controla se o texto será ocultado
        keyboardType: keyboardType, // Define o tipo de teclado
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: baseFontSize),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
