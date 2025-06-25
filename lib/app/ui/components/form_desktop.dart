import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';
import 'package:semeio_app/app/core/validators/form_validators.dart';
import 'package:semeio_app/app/ui/components/form_field.dart';

class SemeioFormDesktop extends GetView {
  const SemeioFormDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    double totalWidth = Get.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      width: Get.width * 0.6,
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Envie o seu áudio e participe!",
              style: TextStyle(
                  color: formsCyan, fontWeight: FontWeight.w900, fontSize: 35),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Preencha seus dados corretamente:",
              style: TextStyle(
                  color: formsCyan, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Field(
                    hintText: "Primeiro nome da criança",
                    validator: validateName,
                    controller: null,
                    width: totalWidth * 0.15),
                SizedBox(
                  width: totalWidth * 0.01,
                ),
                Field(
                    hintText: "Sobrenome da criança",
                    validator: validateName,
                    controller: null,
                    width: totalWidth * 0.15),
                SizedBox(
                  width: totalWidth * 0.01,
                ),
                Field(
                    hintText: "Data de nascimento",
                    validator: validateBirthDate,
                    formatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter()
                    ],
                    controller: null,
                    width: totalWidth * 0.15),
                SizedBox(
                  width: totalWidth * 0.01,
                ),
                Field(
                    hintText: "RG",
                    validator: validateRg,
                    controller: null,
                    width: totalWidth * 0.15)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Field(
                    hintText: "CPF",
                    controller: null,
                    validator: validateCpf,
                    formatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter()
                    ],
                    width: totalWidth * 0.15),
                SizedBox(
                  width: totalWidth * 0.01,
                ),
                Field(
                    hintText: "E-mail",
                    validator: validateEmail,
                    controller: null,
                    width: totalWidth * 0.31)
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Endereço:",
              style: TextStyle(
                  color: formsCyan, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Field(
                  focusNode: controller.cepFocusNode,
                  controller: controller.cepController,
                  hintText: "CEP",
                  width: totalWidth * 0.15,
                  validator: validateCep,
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter()
                  ],
                ),
                SizedBox(
                  width: totalWidth * 0.01,
                ),
                Field(
                    readOnly: true,
                    controller: controller.cityController,
                    validator: validateCity,
                    hintText: "Cidade",
                    width: totalWidth * 0.15),
                SizedBox(
                  width: totalWidth * 0.01,
                ),
                Field(
                    readOnly: true,
                    controller: controller.districtController,
                    validator: validateBairro,
                    hintText: "Bairro",
                    width: totalWidth * 0.15),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Preencha os dados do responsável:",
              style: TextStyle(
                  color: formsCyan, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Field(
                    hintText: "Nome completo",
                    validator: validateName,
                    controller: null,
                    width: totalWidth * 0.31),
                SizedBox(
                  width: totalWidth * 0.01,
                ),
                Field(
                    hintText: "Data de nascimento",
                    validator: validateBirthDate,
                    formatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter()
                    ],
                    controller: null,
                    width: totalWidth * 0.15),
                SizedBox(
                  width: totalWidth * 0.01,
                ),
                Field(
                    hintText: "RG",
                    validator: validateRg,
                    controller: null,
                    width: totalWidth * 0.15)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Field(
                    hintText: "CPF",
                    controller: null,
                    validator: validateCpf,
                    formatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter()
                    ],
                    width: totalWidth * 0.15),
                SizedBox(
                  width: totalWidth * 0.01,
                ),
                Field(
                    hintText: "E-mail",
                    validator: validateEmail,
                    controller: null,
                    width: totalWidth * 0.31)
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: totalWidth * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Faça o envio do áudio:",
                        style: TextStyle(
                            color: formsCyan,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(() => TextButton(
                          onPressed: controller.useFilePicker,
                          style: ButtonStyle(
                            maximumSize: WidgetStatePropertyAll(
                                Size.fromWidth(totalWidth * 0.2)),
                            foregroundColor: WidgetStatePropertyAll((controller
                                        .formSubmited.value &&
                                    controller.selectedFileName.value.isEmpty)
                                ? Colors.red
                                : hintTextColor),
                          ),
                          child: Container(
                            width: totalWidth * 0.1,
                            alignment: AlignmentDirectional.centerStart,
                            child: Row(
                              children: [
                                const Icon(Icons.upload),
                                const SizedBox(
                                  width: 5,
                                ),
                                if (controller.selectedFileName.value == "")
                                  const Text(
                                    "Selecionar arquivo",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  )
                                else
                                  Expanded(
                                    child: Text(
                                      controller.selectedFileName.value,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                              ],
                            ),
                          ))),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Obx(() => Checkbox(
                              side: BorderSide(
                                  color: (controller.formSubmited.value &&
                                          !controller.checkBoxTruly.value)
                                      ? Colors.red
                                      : checkboxStroke,
                                  width: 1),
                              value: controller.checkBoxTruly.value,
                              onChanged: (bool? newValue) {
                                controller.checkBoxTruly.value = newValue!;
                              })),
                          Obx(() => Expanded(
                                child: Text(
                                  "Declaro que todas as informações prestadas no ato do envio são verídicas.",
                                  style: TextStyle(
                                      color: (controller.formSubmited.value &&
                                              !controller.checkBoxTruly.value)
                                          ? Colors.red
                                          : formsCyan,
                                      fontSize: 16),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Obx(() => Checkbox(
                              side: BorderSide(
                                  color: (controller.formSubmited.value &&
                                          !controller.checkBoxTruly.value)
                                      ? Colors.red
                                      : checkboxStroke,
                                  width: 1),
                              value: controller.checkBoxShare.value,
                              onChanged: (bool? newValue) {
                                controller.checkBoxShare.value = newValue!;
                              })),
                          Obx(() => Expanded(
                                child: Text(
                                  "Declaro concordar com o compartilhamento do material enviado.",
                                  style: TextStyle(
                                      color: (controller.formSubmited.value &&
                                              !controller.checkBoxTruly.value)
                                          ? Colors.red
                                          : formsCyan,
                                      fontSize: 16),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: totalWidth * 0.03,
                ),
                SizedBox(
                    width: totalWidth * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Transcreva o aúdio: ",
                          style: TextStyle(
                              color: defaultCyan,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: null,
                          maxLines: 4,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          checkboxStroke), // Cor da borda quando o campo está habilitado
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: checkboxStroke),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: "Digite...",
                              hintStyle: TextStyle(
                                color: defaultCyan,
                                fontSize: 20,
                              )),
                        )
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                onPressed: controller.submitForms,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.025,
                      vertical: Get.height * 0.01),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgSendBtn.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Text(
                    "Enviar",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
