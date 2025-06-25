import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/send_audio_controller.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';
import 'package:semeio_app/app/core/validators/form_validators.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/ui/components/footer.dart';
import 'package:semeio_app/app/ui/components/header.dart';

class SendAudioDesktop extends GetView<SendAudioController> {
  const SendAudioDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;
        double baseFontSize = width * 0.009;
        double marginSize = baseFontSize * 0.52;
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Form(
                key: controller.formKey,
                child: SizedBox(
                  width: width * 0.60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Envie o seu áudio e participe!",
                            style: TextStyle(
                                color: defaultCyan,
                                fontSize: width < 940 ? 16 : 18,
                                fontWeight: FontWeight.bold),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => Get.toNamed(Routes.userHome),
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
                              iconSize:
                                  WidgetStatePropertyAll(width < 940 ? 16 : 18),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text("Preencha com seus dados corretamente:",
                          style: TextStyle(
                              color: defaultCyan,
                              fontSize: width < 940 ? 14 : 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 18),
                      if (width < 940)
                        Center(
                          widthFactor: 1.0,
                          child: Column(
                            children: [
                              _buildFieldLabelEdge(
                                hintText: "Primeiro nome da criança*",
                                width: width,
                                controller: controller.childFirstNameController,
                                validator: validateName,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              _buildFieldLabelEdge(
                                hintText: "Sobrenome da criança*",
                                width: width,
                                controller: controller.childSurnameController,
                                validator: validateName,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              _buildFieldLabelEdge(
                                hintText: "Data de nascimento*",
                                width: width,
                                controller: controller.childBirthDateController,
                                validator: validateBirthDate,
                                formatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  DataInputFormatter()
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              _buildFieldLabelEdge(
                                hintText: "RG",
                                width: width,
                                controller: controller.childRgController,
                                validator: validateRg,
                              ),
                            ],
                          ),
                        ),
                      if (width >= 940)
                        Row(
                          children: [
                            _buildFieldLabelEdge(
                              hintText: "Primeiro nome da criança*",
                              width: width * 0.145,
                              controller: controller.childFirstNameController,
                              validator: validateName,
                            ),
                            SizedBox(
                              width: width * 0.005,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "Sobrenome da criança*",
                              width: width * 0.145,
                              controller: controller.childSurnameController,
                              validator: validateName,
                            ),
                            SizedBox(
                              width: width * 0.005,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "Data de nascimento*",
                              width: width * 0.145,
                              controller: controller.childBirthDateController,
                              validator: validateBirthDate,
                              formatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                DataInputFormatter()
                              ],
                            ),
                            SizedBox(
                              width: width * 0.005,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "RG",
                              width: width * 0.145,
                              controller: controller.childRgController,
                              validator: validateRg,
                            ),
                          ],
                        ),
                      const SizedBox(height: 12),
                      if (width >= 940)
                        Row(
                          children: [
                            _buildFieldLabelEdge(
                              hintText: "CPF*",
                              width: width * 0.145,
                              formatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                CpfInputFormatter()
                              ],
                              controller: controller.childCpfController,
                              validator: validateCpf,
                            ),
                            SizedBox(
                              width: width * 0.005,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "E-mail*",
                              width: width * 0.145,
                              controller: controller.childEmailController,
                              validator: validateEmail,
                            ),
                            SizedBox(
                              width: width * 0.005,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: width * 0.145,
                              child: Obx(
                                () => SizedBox(
                                  key: ValueKey(controller.childSex.value),
                                  width: double.infinity,
                                  child: DropdownButtonFormField<String>(
                                      decoration: const InputDecoration(
                                        labelText: "Sexo*",
                                        labelStyle: TextStyle(
                                          color: defaultCyan,
                                          fontSize: 16,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: checkboxStroke),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        isDense: true,
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 16.0),
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: checkboxStroke),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        hintText: "Sexo*",
                                      ),
                                      iconEnabledColor: checkboxStroke,
                                      isExpanded: true,
                                      style:
                                          const TextStyle(color: defaultCyan),
                                      value: controller.childSex.value,
                                      items: const [
                                        DropdownMenuItem(
                                          value: "Masculino",
                                          child: Text(
                                            "Masculino",
                                            style:
                                                TextStyle(color: defaultCyan),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: "Feminino",
                                          child: Text("Feminino",
                                              style: TextStyle(
                                                  color: defaultCyan)),
                                        )
                                      ],
                                      onChanged: (String? newValue) {
                                        controller.childSex.value = newValue!;
                                      }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (width < 940)
                        Column(
                          children: [
                            _buildFieldLabelEdge(
                              hintText: "CPF*",
                              width: width,
                              formatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                CpfInputFormatter()
                              ],
                              controller: controller.childCpfController,
                              validator: validateCpf,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "E-mail*",
                              width: width,
                              controller: controller.childEmailController,
                              validator: validateEmail,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: width,
                              child: Obx(
                                () => SizedBox(
                                  key: ValueKey(controller.childSex.value),
                                  width: double.infinity,
                                  child: DropdownButtonFormField<String>(
                                      decoration: const InputDecoration(
                                        labelText: "Sexo*",
                                        labelStyle: TextStyle(
                                          color: defaultCyan,
                                          fontSize: 16,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: checkboxStroke),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        isDense: true,
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 16.0),
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: checkboxStroke),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        hintText: "Sexo*",
                                      ),
                                      iconEnabledColor: checkboxStroke,
                                      isExpanded: true,
                                      style:
                                          const TextStyle(color: defaultCyan),
                                      value: controller.childSex.value,
                                      items: const [
                                        DropdownMenuItem(
                                          value: "Masculino",
                                          child: Text(
                                            "Masculino",
                                            style:
                                                TextStyle(color: defaultCyan),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: "Feminino",
                                          child: Text("Feminino",
                                              style: TextStyle(
                                                  color: defaultCyan)),
                                        )
                                      ],
                                      onChanged: (String? newValue) {
                                        controller.childSex.value = newValue!;
                                      }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      Text(
                        "Endereço",
                        style: TextStyle(
                            color: defaultCyan,
                            fontSize: width < 940 ? 16 : 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 18),
                      if (width >= 940)
                        Row(
                          children: [
                            _buildFieldLabelEdge(
                              hintText: "CEP*",
                              width: width * 0.145,
                              controller: controller.cepController,
                              validator: validateCep,
                              formatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                CepInputFormatter()
                              ],
                              focusNode: controller.cepFocusNode,
                            ),
                            SizedBox(
                              width: width * 0.005,
                            ),
                            Obx(
                              () => _buildFieldLabelEdge(
                                hintText: "Estado",
                                width: width * 0.145,
                                controller: controller.stateController,
                                validator: validateState,
                                isLoading:
                                    controller.isLoadingCampusAddress.value,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.005,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "Cidade",
                              width: width * 0.145,
                              controller: controller.cityController,
                              validator: validateCity,
                            ),
                            SizedBox(
                              width: width * 0.005,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "Bairro",
                              width: width * 0.145,
                              controller: controller.districtController,
                              validator: validateBairro,
                            ),
                          ],
                        ),
                      if (width < 940)
                        Column(
                          children: [
                            _buildFieldLabelEdge(
                              hintText: "CEP*",
                              width: width,
                              controller: controller.cepController,
                              validator: validateCep,
                              formatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                CepInputFormatter()
                              ],
                              focusNode: controller.cepFocusNode,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Obx(
                              () => _buildFieldLabelEdge(
                                hintText: "Estado",
                                width: width,
                                controller: controller.stateController,
                                validator: validateState,
                                isLoading:
                                    controller.isLoadingCampusAddress.value,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "Cidade",
                              width: width,
                              controller: controller.cityController,
                              validator: validateCity,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "Bairro",
                              width: width,
                              controller: controller.districtController,
                              validator: validateBairro,
                            ),
                          ],
                        ),
                      const SizedBox(height: 12),
                      Text(
                        "Preencha com os dados do responsável:",
                        style: TextStyle(
                            color: defaultCyan,
                            fontSize: width < 940 ? 16 : 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      if (width >= 940)
                        Row(
                          children: [
                            _buildFieldLabelEdge(
                              hintText: "Nome completo*",
                              width: width * ((0.145 * 2) + 0.005),
                              controller: controller.guardianFullNameController,
                              validator: validateName,
                            ),
                            SizedBox(
                              width: width * 0.005,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "Data de nascimento*",
                              width: width * 0.145,
                              controller:
                                  controller.guardianBirthDateController,
                              validator: validateBirthDate,
                              formatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                DataInputFormatter()
                              ],
                            ),
                            SizedBox(
                              width: width * 0.005,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "RG",
                              width: width * 0.145,
                              controller: controller.guardianRgController,
                              validator: validateRg,
                            ),
                          ],
                        ),
                      if (width < 940)
                        Column(
                          children: [
                            _buildFieldLabelEdge(
                              hintText: "Nome completo*",
                              width: width,
                              controller: controller.guardianFullNameController,
                              validator: validateName,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "Data de nascimento*",
                              width: width,
                              controller:
                                  controller.guardianBirthDateController,
                              validator: validateBirthDate,
                              formatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                DataInputFormatter()
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "RG",
                              width: width,
                              controller: controller.guardianRgController,
                              validator: validateRg,
                            ),
                          ],
                        ),
                      const SizedBox(height: 12),
                      if (width >= 940)
                        Row(
                          children: [
                            _buildFieldLabelEdge(
                              hintText: "CPF",
                              width: width * 0.145,
                              controller: controller.guardianCpfController,
                              validator: validateCpf,
                              formatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                CpfInputFormatter()
                              ],
                            ),
                            SizedBox(
                              width: width * 0.005,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "E-mail*",
                              width: width * ((0.145 * 2) + 0.005),
                              controller: controller.guardianEmailController,
                              validator: validateEmail,
                            ),
                          ],
                        ),
                      if (width < 940)
                        Column(
                          children: [
                            _buildFieldLabelEdge(
                              hintText: "CPF",
                              width: width,
                              controller: controller.guardianCpfController,
                              validator: validateCpf,
                              formatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                CpfInputFormatter()
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            _buildFieldLabelEdge(
                              hintText: "E-mail*",
                              width: width,
                              controller: controller.guardianEmailController,
                              validator: validateEmail,
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Faça o envio do áudio:*",
                                  style: TextStyle(
                                      color: formsCyan,
                                      fontSize: width < 940 ? 16 : 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Obx(() => TextButton(
                                    onPressed: controller.useFilePicker,
                                    style: ButtonStyle(
                                      maximumSize: WidgetStatePropertyAll(
                                          Size.fromWidth(width * 0.2)),
                                      foregroundColor: WidgetStatePropertyAll(
                                          (controller.formSubmited.value &&
                                                  controller.selectedFileName
                                                      .value.isEmpty)
                                              ? Colors.red
                                              : hintTextColor),
                                    ),
                                    child: Container(
                                      width: width * 0.4,
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.upload),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          if (controller
                                                  .selectedFileName.value ==
                                              "")
                                            Text(
                                              "Selecionar arquivo",
                                              style: TextStyle(
                                                  fontSize:
                                                      width < 940 ? 12 : 14,
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
                                    ))),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Obx(() => Checkbox(
                                        side: BorderSide(
                                            color: (controller
                                                        .formSubmited.value &&
                                                    !controller
                                                        .checkBoxTruly.value)
                                                ? Colors.red
                                                : checkboxStroke,
                                            width: 1),
                                        value: controller.checkBoxTruly.value,
                                        onChanged: (bool? newValue) {
                                          controller.checkBoxTruly.value =
                                              newValue!;
                                        })),
                                    Obx(() => Expanded(
                                          child: Text(
                                            "Declaro que todas as informações prestadas no ato do envio são verídicas.",
                                            style: TextStyle(
                                                color: (controller.formSubmited
                                                            .value &&
                                                        !controller
                                                            .checkBoxTruly
                                                            .value)
                                                    ? Colors.red
                                                    : formsCyan,
                                                fontSize:
                                                    width < 940 ? 12 : 14),
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
                                            color: (controller
                                                        .formSubmited.value &&
                                                    !controller
                                                        .checkBoxTruly.value)
                                                ? Colors.red
                                                : checkboxStroke,
                                            width: 1),
                                        value: controller.checkBoxShare.value,
                                        onChanged: (bool? newValue) {
                                          controller.checkBoxShare.value =
                                              newValue!;
                                        })),
                                    Obx(() => Expanded(
                                          child: Text(
                                            "Declaro concordar com o compartilhamento do material enviado.",
                                            style: TextStyle(
                                                color: (controller.formSubmited
                                                            .value &&
                                                        !controller
                                                            .checkBoxTruly
                                                            .value)
                                                    ? Colors.red
                                                    : formsCyan,
                                                fontSize:
                                                    width < 940 ? 12 : 14),
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
                            width: width * 0.03,
                          ),
                          SizedBox(
                              width: width * 0.27,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Transcreva o aúdio: ",
                                    style: TextStyle(
                                        color: defaultCyan,
                                        fontWeight: FontWeight.bold,
                                        fontSize: width < 940 ? 14 : 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    controller:
                                        controller.transcriptionController,
                                    maxLines: 4,
                                    style: const TextStyle(
                                      color: defaultCyan,
                                      fontSize: 16.0,
                                    ),
                                    decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    checkboxStroke), // Cor da borda quando o campo está habilitado
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: checkboxStroke),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        hintText: "Digite...",
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintStyle: TextStyle(
                                          color: defaultCyan,
                                          fontSize: width < 940 ? 12 : 14,
                                        )),
                                  )
                                ],
                              ))
                        ],
                      ),
                      SizedBox(
                        height: marginSize,
                      ),
                      Obx(
                        () => TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            visualDensity: VisualDensity.compact,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: controller.isFormLoading.value
                              ? null
                              : controller.submitForms,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.025,
                              vertical: height * 0.01,
                            ),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/bgSendBtn.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: controller.isFormLoading.value
                                ? SizedBox(
                                    height: baseFontSize * 2,
                                    width: baseFontSize * 2,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    "Enviar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width < 940 ? 14 : 20,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildFieldLabelEdge({
    required String hintText,
    required TextEditingController controller,
    required double width,
    String? Function(String?)? validator,
    List<TextInputFormatter>? formatter,
    FocusNode? focusNode,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        readOnly: isLoading,
        style: const TextStyle(color: defaultCyan),
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: isLoading ? "Carregando..." : hintText,
          labelStyle: const TextStyle(
            color: defaultCyan,
            fontSize: 16,
          ),
          isDense: true,
          filled: true,
          hintStyle: const TextStyle(color: defaultCyan, fontSize: 16),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: defaultCyan,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: checkboxStroke, // Cor da borda quando não está focado
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: checkboxStroke, // Cor da borda quando o campo está focado
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red, // Cor da borda quando há erro de validação
              width: 1.5,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: defaultCyan, // Cor da borda quando o campo está desativado
              width: 1.0,
            ),
          ),
        ),
        validator: validator,
        inputFormatters: formatter ?? [],
      ),
    );
  }
}
