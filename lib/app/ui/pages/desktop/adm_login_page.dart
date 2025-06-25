import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/adm_login_controller.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';
import 'package:semeio_app/app/core/validators/form_validators.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/ui/components/footer.dart';
import 'package:semeio_app/app/ui/components/header.dart';

class AdmLoginPage extends GetView<AdmLoginController> {
  const AdmLoginPage({super.key});

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
                  top: formHeight * 0.25,
                  child: SizedBox(
                    width: formWidth,
                    child: Text(
                      "ACESSAR\nÁREA ADMINISTRATIVA",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: baseFontSize * 1.65,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                buildFormLogin(formWidth, formHeight, baseFontSize),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget buildFormLogin(double width, double height, double baseFontSize) {
    return Positioned(
      top: height * 0.5,
      child: Center(
        child: SizedBox(
          width: width * 0.6,
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: baseFontSize)),
                    TextFormField(
                      validator: validateEmail,
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Digite...",
                        hintStyle: TextStyle(fontSize: baseFontSize),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Senha:",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: baseFontSize)),
                    TextFormField(
                      validator: validatePassword,
                      controller: controller.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Digite...",
                        hintStyle: TextStyle(fontSize: baseFontSize),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: width * 0.2,
                  height: height * 0.09,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      backgroundColor: loginBtnColor,
                    ),
                    onPressed: controller.submitFormLogin,
                    child: Center(
                      child: Obx(() => controller.isLogging.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator())
                          : Text(
                              "Entrar",
                              style: TextStyle(
                                  color: Colors.white, fontSize: baseFontSize),
                            )),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.userPasswordReset),
                  child: Text(
                    "Editar senha",
                    style:
                        TextStyle(color: Colors.white, fontSize: baseFontSize),
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
