import 'dart:convert';
import 'dart:typed_data';

import 'package:geolocator/geolocator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/core/validators/form_validators.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/services/geolocator_service.dart';
import 'package:semeio_app/app/services/supabase_service.dart';
import 'package:http/http.dart' as http;

class SendAudioController extends GetxController {
  final geolocatorService = Get.find<GeolocatorService>();
  final supabaseService = Get.find<SupabaseService>();
  final formKey = GlobalKey<FormState>();
  var selectedFileName = "".obs;
  var checkBoxTruly = false.obs;
  var checkBoxShare = false.obs;
  Uint8List? audioBytes;
  var formSubmited = false.obs;
  Position? actualPosition;
  var isLoadingCampusAddress = false.obs;
  var isFormLoading = false.obs;

  var childFirstNameController = TextEditingController();
  var childSurnameController = TextEditingController();
  var childBirthDateController = TextEditingController();
  var childRgController = TextEditingController();
  var childCpfController = TextEditingController();
  var childEmailController = TextEditingController();
  var childSexController = TextEditingController();
  var childSex = "Masculino".obs;
  var cepController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  var districtController = TextEditingController();
  var guardianFullNameController = TextEditingController();
  var guardianBirthDateController = TextEditingController();
  var guardianRgController = TextEditingController();
  var guardianCpfController = TextEditingController();
  var guardianEmailController = TextEditingController();
  var appraiserNameController = TextEditingController();
  var transcriptionController = TextEditingController();

  final FocusNode cepFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    cepFocusNode.addListener(getAdressByCep);
  }

  Map<String, dynamic> get formData => {
        "childFirstName": childFirstNameController.text,
        "childSurname": childSurnameController.text,
        "childBirthDate": childBirthDateController.text,
        "childRg": childRgController.text,
        "childCpf": childCpfController.text,
        "childEmail": childEmailController.text,
        "childSex": childSex.value,
        "guardianName": guardianFullNameController.text,
        "guardianBirthDate": guardianBirthDateController.text,
        "guardianRg": guardianRgController.text,
        "guardianCpf": guardianCpfController.text,
        "guardianEmail": guardianEmailController.text,
        "cep": cepController.text,
        "state": stateController.text,
        "city": cityController.text,
        "district": districtController.text,
        "audioBytes": audioBytes,
        "latitude": actualPosition!.latitude,
        "longitude": actualPosition!.longitude,
        "transcription": transcriptionController.text
      };

  void getAdressByCep() async {
    if (!cepFocusNode.hasFocus) {
      if (validateCep(cepController.text) == null) {
        final cepOnlyNumbers =
            cepController.text.replaceAll(RegExp(r'[^0-9]'), "");
        final url = Uri.parse('https://viacep.com.br/ws/$cepOnlyNumbers/json/');
        try {
          isLoadingCampusAddress.value = true;
          final response = await http.get(url);
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            if (data.containsKey("erro")) {
              isLoadingCampusAddress.value = false;
              cepController.value.printError(info: "Cep inválido");
              return;
            }
            stateController.text = data["estado"];
            districtController.text = data["bairro"];
            cityController.text = data["localidade"];
            isLoadingCampusAddress.value = false;
          }
        } catch (err) {}
      }
    }
  }

  void useFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      selectedFileName.value = result.files.first.name;
      audioBytes = result.files.single.bytes!;
    } else {
      print("No file selected");
    }
  }

  void submitForms() async {
    try {
      formSubmited.value = true;
      if (formKey.currentState!.validate() &&
          audioBytes != null &&
          (checkBoxShare.value && checkBoxTruly.value) == true) {
        isFormLoading.value = true;
        actualPosition = await geolocatorService.getActualPosition();
        await supabaseService.savePost(formData);
        isFormLoading.value = false;
        Get.snackbar("Sucesso", "Audio enviado com sucesso",
            backgroundColor: Colors.green);
        Get.offAndToNamed(Routes.userHome);
      }
    } catch (err) {
      Get.snackbar("AVISO", "Não foi possível enviar o audio, tente mais tarde",
          backgroundColor: Colors.amberAccent);
      rethrow;
    } finally {
      isFormLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    childFirstNameController.dispose();
    childSurnameController.dispose();
    childBirthDateController.dispose();
    childRgController.dispose();
    childCpfController.dispose();
    childEmailController.dispose();
    cepController.dispose();
    stateController.dispose();
    cityController.dispose();
    districtController.dispose();
    guardianFullNameController.dispose();
    guardianBirthDateController.dispose();
    guardianRgController.dispose();
    guardianCpfController.dispose();
    guardianEmailController.dispose();
    appraiserNameController.dispose();
    transcriptionController.dispose();
  }
}
