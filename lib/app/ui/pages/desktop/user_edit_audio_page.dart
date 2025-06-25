import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/user_edit_audio_controller.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';
import 'package:semeio_app/app/core/validators/form_validators.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/ui/components/field_label_edge.dart';
import 'package:semeio_app/app/ui/components/footer.dart';
import 'package:semeio_app/app/ui/components/header.dart';

class UserEditAudioPage extends GetView<UserEditAudioController> {
  const UserEditAudioPage({super.key});

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
          return Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.04, vertical: height * 0.025),
                    child: Row(
                      children: [
                        SingleChildScrollView(
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
                                          Get.toNamed(Routes.userHome),
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
                                const SizedBox(
                                  height: 12,
                                ),
                                if (width >= 940)
                                  Row(
                                    children: [
                                      FieldLabelEdge(
                                        hintText: "Primeiro nome",
                                        controller:
                                            controller.childFirstNameController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "Sobrenome",
                                        controller:
                                            controller.childSurnameController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "Data de nascimento",
                                        controller:
                                            controller.childBirthDateController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                        validator: validateBirthDate,
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "RG",
                                        controller:
                                            controller.childRgController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                        validator: validateRg,
                                      ),
                                    ],
                                  ),
                                if (width < 940)
                                  Column(
                                    children: [
                                      FieldLabelEdge(
                                        hintText: "Primeiro nome",
                                        controller:
                                            controller.childFirstNameController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "Sobrenome",
                                        controller:
                                            controller.childSurnameController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "Data de nascimento",
                                        controller:
                                            controller.childBirthDateController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                        validator: validateBirthDate,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "RG",
                                        controller:
                                            controller.childRgController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                        validator: validateRg,
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 18),
                                if (width >= 940)
                                  Row(
                                    children: [
                                      FieldLabelEdge(
                                        hintText: "CPF",
                                        controller:
                                            controller.childCpfController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                        validator: validateCpf,
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "E-mail",
                                        controller:
                                            controller.childEmailController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                        validator: validateEmail,
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: width * 0.145,
                                        child: Obx(
                                          () => SizedBox(
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
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  checkboxStroke),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  isDense: true,
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      color: defaultCyan,
                                                      fontSize: 16.0),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: checkboxStroke),
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
                                                onChanged: (String? newValue) {
                                                  controller.childSex.value =
                                                      newValue!;
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (width < 940)
                                  Column(
                                    children: [
                                      FieldLabelEdge(
                                        hintText: "CPF",
                                        controller:
                                            controller.childCpfController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                        validator: validateCpf,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "E-mail",
                                        controller:
                                            controller.childEmailController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                        validator: validateEmail,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: width * 0.5,
                                        child: Obx(
                                          () => SizedBox(
                                            width: double.infinity,
                                            child: DropdownButtonFormField<
                                                    String>(
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "Sexo*",
                                                  labelStyle: TextStyle(
                                                    color: defaultCyan,
                                                    fontSize: 14,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  checkboxStroke),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  isDense: true,
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintStyle: TextStyle(
                                                      color: defaultCyan,
                                                      fontSize: 14),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: checkboxStroke),
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
                                                onChanged: (String? newValue) {
                                                  controller.childSex.value =
                                                      newValue!;
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 18),
                                const Text(
                                  "Endereço",
                                  style: TextStyle(
                                      color: defaultCyan,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 18),
                                if (width >= 940)
                                  Row(
                                    children: [
                                      FieldLabelEdge(
                                        hintText: "Cep",
                                        controller: controller.cepController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                        validator: validateCep,
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "Estado",
                                        controller: controller.stateController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                        validator: validateState,
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "Cidade",
                                        controller: controller.cityController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                        validator: validateCity,
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "Bairro",
                                        controller:
                                            controller.districtController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                        validator: validateBairro,
                                      ),
                                    ],
                                  ),
                                if (width < 940)
                                  Column(
                                    children: [
                                      FieldLabelEdge(
                                        hintText: "Cep",
                                        controller: controller.cepController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                        validator: validateCep,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "Estado",
                                        controller: controller.stateController,
                                        width: width * 0.5,
                                        fontSize: 14.0,
                                        validator: validateState,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "Cidade",
                                        controller: controller.cityController,
                                        width: width * 0.5,
                                        fontSize: 14.0,
                                        validator: validateCity,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "Bairro",
                                        controller:
                                            controller.districtController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                        validator: validateBairro,
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 18),
                                const Text(
                                  "Responsável",
                                  style: TextStyle(
                                      color: defaultCyan,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 18),
                                if (width >= 940)
                                  Row(
                                    children: [
                                      FieldLabelEdge(
                                        hintText: "Nome completo",
                                        controller: controller
                                            .guardianFullNameController,
                                        width: width * ((0.145 * 2) + 0.005),
                                        fontSize: 16.0,
                                        validator: validateName,
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "Data de nascimento",
                                        controller: controller
                                            .guardianBirthDateController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                        validator: validateBirthDate,
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "RG",
                                        controller:
                                            controller.guardianRgController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                        validator: validateRg,
                                      ),
                                    ],
                                  ),
                                if (width < 940)
                                  Column(
                                    children: [
                                      FieldLabelEdge(
                                        hintText: "Nome completo",
                                        controller: controller
                                            .guardianFullNameController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                        validator: validateName,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "Data de nascimento",
                                        controller: controller
                                            .guardianBirthDateController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                        validator: validateBirthDate,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "RG",
                                        controller:
                                            controller.guardianRgController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                        validator: validateRg,
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 18),
                                if (width >= 940)
                                  Row(
                                    children: [
                                      FieldLabelEdge(
                                        hintText: "CPF",
                                        controller:
                                            controller.guardianCpfController,
                                        width: width * 0.145,
                                        fontSize: 16.0,
                                        validator: validateCpf,
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "E-mail",
                                        controller:
                                            controller.guardianEmailController,
                                        width: width * ((0.145 * 2) + 0.005),
                                        fontSize: 16.0,
                                        validator: validateEmail,
                                      ),
                                    ],
                                  ),
                                if (width < 940)
                                  Column(
                                    children: [
                                      FieldLabelEdge(
                                        hintText: "CPF",
                                        controller:
                                            controller.guardianCpfController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                        validator: validateCpf,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      FieldLabelEdge(
                                        hintText: "E-mail",
                                        controller:
                                            controller.guardianEmailController,
                                        width: width * 0.5,
                                        fontSize: 14,
                                        validator: validateEmail,
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 18),
                                Obx(
                                  () => TextButton(
                                    onPressed: controller.useFilePicker,
                                    style: ButtonStyle(
                                      textStyle: const WidgetStatePropertyAll(
                                          TextStyle(fontSize: 20)),
                                      maximumSize: WidgetStatePropertyAll(
                                          Size.fromWidth(width * 0.4)),
                                      foregroundColor: WidgetStatePropertyAll(
                                          (controller.selectedFileName.value
                                                  .isEmpty)
                                              ? Colors.red
                                              : hintTextColor),
                                    ),
                                    child: Container(
                                      width: width * 0.5,
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.upload),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          if (controller
                                                  .selectedFileName.value ==
                                              "")
                                            const Text(
                                              "Selecionar arquivo",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  decoration:
                                                      TextDecoration.underline),
                                            )
                                          else
                                            Expanded(
                                              child: Text(
                                                controller
                                                    .selectedFileName.value,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Center(
                                  child: Obx(
                                    () => SizedBox(
                                      width: width * 0.2,
                                      height: height *
                                          0.09, // Ajustando botão de acordo com a tela
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          backgroundColor: loginBtnColor,
                                        ),
                                        onPressed: controller.isLoading.value
                                            ? null
                                            : controller.editAudio,
                                        child: Center(
                                          child: controller.isLoading.value
                                              ? const SizedBox(
                                                  width: 20.0,
                                                  height: 20.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  ),
                                                )
                                              : Text(
                                                  "Editar",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: width < 940
                                                          ? 14
                                                          : 16),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
                              Text(
                                "Ouça o áudio",
                                style: TextStyle(
                                    color: defaultCyan,
                                    fontSize: width < 940 ? 18 : 20),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        controller.isPlaying.value
                                            ? await controller.pauseAudio()
                                            : await controller.playAudio();
                                      },
                                      icon: Icon(
                                        controller.isAudioLoading.value
                                            ? Icons.hourglass_empty
                                            : controller.isPlaying.value
                                                ? Icons.pause
                                                : Icons.volume_up,
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
                              Text(
                                "Veja a transcrição do áudio:",
                                style: TextStyle(
                                    color: defaultCyan,
                                    fontSize: width < 940 ? 18 : 20),
                              ),
                              const SizedBox(height: 14),
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
                                      style: const TextStyle(fontSize: 12),
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          hintText: "Digite...",
                                          hintStyle: TextStyle(
                                            color: defaultCyan,
                                            fontSize: width < 940 ? 14 : 16,
                                          ))),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
