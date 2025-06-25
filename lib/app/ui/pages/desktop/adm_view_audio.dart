import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/adm_view_audio_controller.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';
import 'package:semeio_app/app/ui/components/footer.dart';
import 'package:semeio_app/app/ui/components/form_field.dart';
import 'package:semeio_app/app/ui/components/header.dart';

class AdmViewAudio extends GetView<AdmViewAudioController> {
  const AdmViewAudio({super.key});

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
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04, vertical: height * 0.025),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "DADOS DO ÁUDIO",
                              style: TextStyle(
                                  color: defaultCyan,
                                  fontSize: baseFontSize * 2,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Row(
                              children: [
                                Field(
                                    readOnly: true,
                                    hintText: "Primeiro nome da criança*",
                                    controller:
                                        controller.childFirstNameController,
                                    width: width * 0.145),
                                SizedBox(
                                  width: width * 0.005,
                                ),
                                Field(
                                    readOnly: true,
                                    hintText: "Sobrenome da criança*",
                                    controller:
                                        controller.childSurnameController,
                                    width: width * 0.145),
                                SizedBox(
                                  width: width * 0.005,
                                ),
                                Field(
                                    readOnly: true,
                                    hintText: "Data de nascimento*",
                                    controller:
                                        controller.childBirthDateController,
                                    width: width * 0.145),
                                SizedBox(
                                  width: width * 0.005,
                                ),
                                Field(
                                    readOnly: true,
                                    hintText: "RG",
                                    controller: controller.childRgController,
                                    width: width * 0.145),
                              ],
                            ),
                            SizedBox(height: marginSize * 0.5),
                            Row(
                              children: [
                                Field(
                                    readOnly: true,
                                    hintText: "CPF",
                                    controller: controller.childCpfController,
                                    width: width * 0.145),
                                SizedBox(
                                  width: width * 0.005,
                                ),
                                Field(
                                    readOnly: true,
                                    hintText: "E-mail*",
                                    controller: controller.childEmailController,
                                    width: width * 0.145),
                                SizedBox(
                                  width: width * 0.005,
                                ),
                                Field(
                                  hintText: "Sexo*",
                                  controller: controller.childSexController,
                                  width: width * 0.145,
                                  readOnly: true,
                                )
                              ],
                            ),
                            SizedBox(height: marginSize * 1.5),
                            Text(
                              "Endereço",
                              style: TextStyle(
                                  color: defaultCyan,
                                  fontSize: baseFontSize * 1.2,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: marginSize * 1.5),
                            Row(
                              children: [
                                Field(
                                    readOnly: true,
                                    hintText: "CEP*",
                                    controller: controller.cepController,
                                    width: width * 0.145),
                                SizedBox(
                                  width: width * 0.005,
                                ),
                                Field(
                                    readOnly: true,
                                    hintText: "Estado",
                                    controller: controller.stateController,
                                    width: width * 0.145),
                                SizedBox(
                                  width: width * 0.005,
                                ),
                                Field(
                                    readOnly: true,
                                    hintText: "Cidade",
                                    controller: controller.cityController,
                                    width: width * 0.145),
                                SizedBox(
                                  width: width * 0.005,
                                ),
                                Field(
                                    readOnly: true,
                                    hintText: "Bairro",
                                    controller: controller.districtController,
                                    width: width * 0.145),
                              ],
                            ),
                            SizedBox(height: marginSize * 1.5),
                            Text(
                              "Responsável",
                              style: TextStyle(
                                  color: defaultCyan,
                                  fontSize: baseFontSize * 1.2,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: marginSize * 1.5),
                            Row(
                              children: [
                                Field(
                                    readOnly: true,
                                    hintText: "Nome Completo*",
                                    controller:
                                        controller.guardianFullNameController,
                                    width: width * ((0.145 * 2) + 0.005)),
                                SizedBox(
                                  width: width * 0.005,
                                ),
                                Field(
                                    readOnly: true,
                                    hintText: "Data de nascimento*",
                                    controller:
                                        controller.guardianBirthDateController,
                                    width: width * 0.145),
                                SizedBox(
                                  width: width * 0.005,
                                ),
                                Field(
                                    readOnly: true,
                                    hintText: "RG",
                                    controller: controller.guardianRgController,
                                    width: width * 0.145),
                              ],
                            ),
                            SizedBox(height: marginSize * 0.5),
                            Row(
                              children: [
                                Field(
                                    readOnly: true,
                                    hintText: "CPF",
                                    controller:
                                        controller.guardianCpfController,
                                    width: width * 0.145),
                                SizedBox(
                                  width: width * 0.005,
                                ),
                                Field(
                                    readOnly: true,
                                    hintText: "E-mail*",
                                    controller:
                                        controller.guardianEmailController,
                                    width: width * ((0.145 * 2) + 0.005))
                              ],
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Center(
                              child: SizedBox(
                                width: width * 0.065,
                                height: height * 0.065,
                                child: OutlinedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            const WidgetStatePropertyAll(
                                                loginBtnColor),
                                        padding: const WidgetStatePropertyAll(
                                            EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8)),
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        side: const WidgetStatePropertyAll(
                                            BorderSide.none)),
                                    onPressed: () async {
                                      await controller.validateAudio();
                                      Get.back();
                                    },
                                    child: controller.isValidating.value
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(),
                                          )
                                        : Text(
                                            "Validar",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: baseFontSize),
                                          )),
                              ),
                            )
                          ],
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
                                  color: defaultCyan, fontSize: baseFontSize),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      await controller.loadAudio();
                                    },
                                    icon: Icon(
                                      Icons.volume_up,
                                      size: width * 0.025,
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
                                  color: defaultCyan, fontSize: baseFontSize),
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
                                    readOnly: true,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    controller:
                                        controller.transcriptionController,
                                    style: TextStyle(fontSize: baseFontSize),
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: "Digite...",
                                        hintStyle: TextStyle(
                                          color: defaultCyan,
                                          fontSize: baseFontSize,
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
