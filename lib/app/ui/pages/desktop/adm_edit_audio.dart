import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/adm_edit_audio_controller.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';
import 'package:semeio_app/app/core/validators/form_validators.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/ui/components/footer.dart';
import 'package:semeio_app/app/ui/components/form_field.dart';
import 'package:semeio_app/app/ui/components/header.dart';

class AdmEditAudio extends GetView<AdmEditAudioController> {
  const AdmEditAudio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
          double baseFontSize = constraints.maxWidth * 0.009;
          double marginSize = baseFontSize * 0.52;
          return Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04, vertical: height * 0.025),
                  child: Row(
                    children: [
                      SingleChildScrollView(
                        child: Form(
                          key: controller.formKey,
                          child: SizedBox(
                            width: width * 0.60,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "DADOS DO ÁUDIO",
                                      style: TextStyle(
                                          color: defaultCyan,
                                          fontSize: width < 940 ? 14 : 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    OutlinedButton.icon(
                                      onPressed: () =>
                                          Get.toNamed(Routes.admHome),
                                      label: const Text("Voltar",
                                          style: TextStyle(color: defaultCyan)),
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: defaultCyan,
                                      ),
                                      style: ButtonStyle(
                                        textStyle: WidgetStatePropertyAll(
                                          TextStyle(
                                            fontSize: width < 940 ? 14 : 16,
                                          ),
                                        ),
                                        side: const WidgetStatePropertyAll(
                                            BorderSide(color: defaultCyan)),
                                        iconSize: WidgetStatePropertyAll(
                                            width < 940 ? 16 : 18),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                if (width > 940)
                                  Row(
                                    children: [
                                      Field(
                                          hintText: "Primeiro nome da criança*",
                                          controller: controller
                                              .childFirstNameController,
                                          validator: validateName,
                                          width: width * 0.145),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      Field(
                                          hintText: "Sobrenome da criança*",
                                          controller:
                                              controller.childSurnameController,
                                          validator: validateName,
                                          width: width * 0.145),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      Field(
                                          hintText: "Data de nascimento*",
                                          controller: controller
                                              .childBirthDateController,
                                          validator: validateBirthDate,
                                          width: width * 0.145),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      Field(
                                          hintText: "RG",
                                          controller:
                                              controller.childRgController,
                                          width: width * 0.145),
                                    ],
                                  ),
                                if (width <= 940)
                                  Column(
                                    children: [
                                      Field(
                                          hintText: "Primeiro nome da criança*",
                                          controller: controller
                                              .childFirstNameController,
                                          validator: validateName,
                                          width: width),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Field(
                                          hintText: "Sobrenome da criança*",
                                          controller:
                                              controller.childSurnameController,
                                          validator: validateName,
                                          width: width),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Field(
                                          hintText: "Data de nascimento*",
                                          controller: controller
                                              .childBirthDateController,
                                          validator: validateBirthDate,
                                          width: width),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Field(
                                          hintText: "RG",
                                          controller:
                                              controller.childRgController,
                                          width: width),
                                    ],
                                  ),
                                const SizedBox(height: 12),
                                if (width > 940)
                                  Row(
                                    children: [
                                      Field(
                                          hintText: "CPF*",
                                          controller:
                                              controller.childCpfController,
                                          validator: validateCpf,
                                          width: width * 0.145),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      Field(
                                          hintText: "E-mail*",
                                          controller:
                                              controller.childEmailController,
                                          validator: validateEmail,
                                          width: width * 0.145),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: width * 0.145,
                                        child: Obx(() => SizedBox(
                                              width: double.infinity,
                                              child: DropdownButtonFormField<
                                                      String>(
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: "Sexo*",
                                                    labelStyle: TextStyle(
                                                      color: defaultCyan,
                                                      fontSize: 16,
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                checkboxStroke),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    isDense: true,
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color: defaultCyan,
                                                        fontSize: 20),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              checkboxStroke),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    hintText: "Sexo*",
                                                  ),
                                                  iconEnabledColor:
                                                      checkboxStroke,
                                                  isExpanded: true,
                                                  style: const TextStyle(
                                                      color: defaultCyan),
                                                  value:
                                                      controller.childSex.value,
                                                  items: const [
                                                    DropdownMenuItem(
                                                      value: "Masculino",
                                                      child: Text(
                                                        "Masculino",
                                                        style: TextStyle(
                                                            color: defaultCyan),
                                                      ),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "Feminino",
                                                      child: Text("Feminino",
                                                          style: TextStyle(
                                                              color:
                                                                  defaultCyan)),
                                                    )
                                                  ],
                                                  onChanged:
                                                      (String? newValue) {
                                                    controller.childSex.value =
                                                        newValue!;
                                                  }),
                                            )),
                                      )
                                    ],
                                  ),
                                if (width <= 940)
                                  Column(
                                    children: [
                                      Field(
                                          hintText: "CPF*",
                                          controller:
                                              controller.childCpfController,
                                          validator: validateCpf,
                                          width: width),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Field(
                                          hintText: "E-mail*",
                                          controller:
                                              controller.childEmailController,
                                          validator: validateEmail,
                                          width: width),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: width,
                                        child: Obx(() => SizedBox(
                                              width: double.infinity,
                                              child: DropdownButtonFormField<
                                                      String>(
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: "Sexo*",
                                                    labelStyle: TextStyle(
                                                      color: defaultCyan,
                                                      fontSize: 16,
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                checkboxStroke),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    isDense: true,
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    hintStyle: TextStyle(
                                                        color: defaultCyan,
                                                        fontSize: 20),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              checkboxStroke),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    hintText: "Sexo*",
                                                  ),
                                                  iconEnabledColor:
                                                      checkboxStroke,
                                                  isExpanded: true,
                                                  style: const TextStyle(
                                                      color: defaultCyan),
                                                  value:
                                                      controller.childSex.value,
                                                  items: const [
                                                    DropdownMenuItem(
                                                      value: "Masculino",
                                                      child: Text(
                                                        "Masculino",
                                                        style: TextStyle(
                                                            color: defaultCyan),
                                                      ),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "Feminino",
                                                      child: Text("Feminino",
                                                          style: TextStyle(
                                                              color:
                                                                  defaultCyan)),
                                                    )
                                                  ],
                                                  onChanged:
                                                      (String? newValue) {
                                                    controller.childSex.value =
                                                        newValue!;
                                                  }),
                                            )),
                                      )
                                    ],
                                  ),
                                const SizedBox(height: 18),
                                Text(
                                  "Endereço",
                                  style: TextStyle(
                                      color: defaultCyan,
                                      fontSize: baseFontSize * 1.2,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 12),
                                if (width > 940)
                                  Row(
                                    children: [
                                      Field(
                                          hintText: "CEP*",
                                          controller: controller.cepController,
                                          validator: validateCep,
                                          width: width * 0.145),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      Field(
                                          hintText: "Estado*",
                                          controller:
                                              controller.stateController,
                                          validator: validateState,
                                          width: width * 0.145),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      Field(
                                          hintText: "Cidade",
                                          controller: controller.cityController,
                                          width: width * 0.145),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      Field(
                                          hintText: "Bairro",
                                          controller:
                                              controller.districtController,
                                          width: width * 0.145),
                                    ],
                                  ),
                                if (width <= 940)
                                  Column(
                                    children: [
                                      Field(
                                          hintText: "CEP*",
                                          controller: controller.cepController,
                                          validator: validateCep,
                                          width: width),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Field(
                                          hintText: "Estado*",
                                          controller:
                                              controller.stateController,
                                          validator: validateState,
                                          width: width),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Field(
                                          hintText: "Cidade",
                                          controller: controller.cityController,
                                          width: width),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Field(
                                          hintText: "Bairro",
                                          controller:
                                              controller.districtController,
                                          width: width),
                                    ],
                                  ),
                                const SizedBox(height: 18),
                                Text(
                                  "Responsável",
                                  style: TextStyle(
                                      color: defaultCyan,
                                      fontSize: baseFontSize * 1.2,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 12),
                                if (width > 940)
                                  Row(
                                    children: [
                                      Field(
                                          hintText: "Nome Completo*",
                                          controller: controller
                                              .guardianFullNameController,
                                          validator: validateName,
                                          width: width * ((0.145 * 2) + 0.005)),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      Field(
                                          hintText: "Data de nascimento*",
                                          controller: controller
                                              .guardianBirthDateController,
                                          validator: validateBirthDate,
                                          width: width * 0.145),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      Field(
                                          hintText: "RG",
                                          controller:
                                              controller.guardianRgController,
                                          width: width * 0.145),
                                    ],
                                  ),
                                if (width <= 940)
                                  Column(
                                    children: [
                                      Field(
                                          hintText: "Nome Completo*",
                                          controller: controller
                                              .guardianFullNameController,
                                          validator: validateName,
                                          width: width),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Field(
                                          hintText: "Data de nascimento*",
                                          controller: controller
                                              .guardianBirthDateController,
                                          validator: validateBirthDate,
                                          width: width),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Field(
                                          hintText: "RG",
                                          controller:
                                              controller.guardianRgController,
                                          width: width),
                                    ],
                                  ),
                                const SizedBox(height: 12),
                                if (width > 940)
                                  Row(
                                    children: [
                                      Field(
                                          hintText: "CPF*",
                                          controller:
                                              controller.guardianCpfController,
                                          validator: validateCpf,
                                          width: width * 0.145),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      Field(
                                          hintText: "E-mail*",
                                          controller: controller
                                              .guardianEmailController,
                                          validator: validateEmail,
                                          width: width * ((0.145 * 2) + 0.005))
                                    ],
                                  ),
                                if (width <= 940)
                                  Column(
                                    children: [
                                      Field(
                                        hintText: "CPF*",
                                        controller:
                                            controller.guardianCpfController,
                                        validator: validateCpf,
                                        width: width,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Field(
                                          hintText: "E-mail*",
                                          controller: controller
                                              .guardianEmailController,
                                          validator: validateEmail,
                                          width: width)
                                    ],
                                  ),
                                const SizedBox(height: 18),
                                Center(
                                  child: SizedBox(
                                    width: width * 0.065,
                                    height: height * 0.065,
                                    child: OutlinedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                const WidgetStatePropertyAll(
                                                    loginBtnColor),
                                            padding:
                                                const WidgetStatePropertyAll(
                                                    EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8)),
                                            shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                            side: const WidgetStatePropertyAll(
                                                BorderSide.none)),
                                        onPressed: () async {
                                          await controller.editAudio();
                                        },
                                        child: controller.isEditing.value
                                            ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  padding: EdgeInsets.zero,
                                                ),
                                              )
                                            : Text(
                                                "EDITAR",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: baseFontSize),
                                              )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      SizedBox(
                        width: width * 0.30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Ouça o áudio",
                              style:
                                  TextStyle(color: defaultCyan, fontSize: 20),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      await controller.loadAudio();
                                    },
                                    icon: Icon(
                                      Icons.volume_up,
                                      size: width < 940 ? 30 : width * 0.025,
                                    )),
                                Image(
                                  image: const AssetImage(
                                      "assets/images/audioWave.png"),
                                  width: width * 0.15,
                                  height: height * 0.15,
                                  fit: BoxFit.cover,
                                )
                              ],
                            ),
                            SizedBox(height: marginSize),
                            const Text(
                              "Veja a transcrição do áudio:",
                              style:
                                  TextStyle(color: defaultCyan, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          checkboxStroke), // Borda do TextArea
                                  borderRadius: BorderRadius.circular(
                                      8), // Borda arredondada
                                ),
                                child: TextField(
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    controller:
                                        controller.transcriptionController,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: "Digite...",
                                        hintStyle: TextStyle(
                                          color: defaultCyan,
                                          fontSize: 18,
                                        ))),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ));
        },
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
