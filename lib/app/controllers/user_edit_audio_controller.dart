import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:semeio_app/app/core/formatters/date_formatter.dart';
import 'package:semeio_app/app/model/Audio.dart';
import 'package:semeio_app/app/model/Child.dart';
import 'package:semeio_app/app/model/Guardian.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/services/supabase_service.dart';

class UserEditAudioController extends GetxController {
  final supabaseService = Get.find<SupabaseService>();
  late var audio = const Audio.empty(null, null, null, null, null, null, null,
      null, null, null, null, null, null, null, null, null, null, null, null);

  final AudioPlayer audioPlayer = AudioPlayer();
  var isPlaying = false.obs;

  var childFirstNameController = TextEditingController();
  var childSurnameController = TextEditingController();
  var childBirthDateController = TextEditingController();
  var childRgController = TextEditingController();
  var childCpfController = TextEditingController();
  var childEmailController = TextEditingController();
  var childSex = "".obs;
  var stateController = TextEditingController();
  var cepController = TextEditingController();
  var cityController = TextEditingController();
  var districtController = TextEditingController();
  var guardianFullNameController = TextEditingController();
  var guardianBirthDateController = TextEditingController();
  var guardianRgController = TextEditingController();
  var guardianCpfController = TextEditingController();
  var guardianEmailController = TextEditingController();
  var transcriptionController = TextEditingController();

  var selectedFileName = "".obs;
  Uint8List? audioBytes;

  var pathToAudio = "";
  var isLoading = true.obs;
  var isAudioLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      audio = await supabaseService.getAudio(Get.parameters["audio_id"]!);
      childFirstNameController.text = audio.child!.firstName;
      childSurnameController.text = audio.child!.surname;
      childBirthDateController.text =
          DateFormatter.toBrazilian(audio.child!.birthDate);
      childRgController.text = audio.child!.rg;
      childCpfController.text = audio.child!.cpf;
      childEmailController.text = audio.child!.email;
      childSex.value = audio.child!.sex;
      stateController.text = audio.state!;
      cepController.text = audio.cep!;
      cityController.text = audio.city!;
      districtController.text = audio.district!;
      guardianFullNameController.text = audio.guardian!.fullName;
      guardianBirthDateController.text =
          DateFormatter.toBrazilian(audio.guardian!.birthDate);
      guardianRgController.text = audio.guardian!.rg;
      guardianCpfController.text = audio.guardian!.cpf;
      guardianEmailController.text = audio.guardian!.email;
      transcriptionController.text = audio.transcription!;
      isLoading.value = false;
    } catch (err) {
      print(err);
      await Get.toNamed(Routes.userHome);
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> loadAudio() async {
    isAudioLoading.value = true;
    final audioFile =
        await supabaseService.fetchAudioFromSupabase(audio.urlToAudio!);
    if (audioFile != null) {
      final pathToAudio = (await saveAudioTemp(audioFile, audio.id!))!;
      return pathToAudio;
    }
    return null;
  }

  Future<void> playAudio() async {
    try {
      final audioPath = await loadAudio();
      if (audioPath == null) {
        isAudioLoading.value = false;
        isPlaying.value = false;
        Get.snackbar("Aviso", "Nao foi possivel carregar o audio",
            backgroundColor: Colors.amberAccent, colorText: Colors.black);
        return;
      }
      await audioPlayer.setUrl(audioPath);
      isAudioLoading.value = false;
      isPlaying.value = true;
      await audioPlayer.play();
    } catch (e) {
      print("Erro ao tentar tocar o áudio: $e");
    }
  }

  Future<void> pauseAudio() async {
    try {
      isPlaying.value = false;
      isAudioLoading.value = true;
      await audioPlayer.pause();
      isAudioLoading.value = false;
    } catch (e) {
      print("Erro ao tentar pausar o áudio: $e");
    }
  }

  Future<String?> saveAudioTemp(Uint8List audioBytes, String filename) async {
    try {
      final blob = html.Blob([audioBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      html.window.sessionStorage[filename] = url;
      final String? blobUri = html.window.sessionStorage[filename];
      if (blobUri == null) {
        throw Exception('No recorded audio found in sessionStorage.');
      }
      return blobUri;
    } catch (e) {
      print("Erro ao salvar áudio temporário: $e");
      return null;
    }
  }

  Future<void> editAudio() async {
    try {
      Guardian newGuardian = Guardian(
          fullName: guardianFullNameController.text,
          birthDate:
              DateFormatter.toPostgreSql(guardianBirthDateController.text),
          rg: guardianRgController.text,
          cpf: guardianCpfController.text,
          email: guardianEmailController.text,
          id: audio.guardian!.id);

      Child newChild = Child(
          firstName: childFirstNameController.text,
          surname: childSurnameController.text,
          birthDate: DateFormatter.toPostgreSql(childBirthDateController.text),
          rg: childRgController.text,
          cpf: childCpfController.text,
          email: childEmailController.text,
          sex: childSex.value,
          id: audio.child!.id);

      isLoading.value = true;
      final newAudioURL = audioBytes != null
          ? await supabaseService.editAudioBinary(audioBytes!, audio.id!)
          : audio.urlToAudio;
      Audio newAudio = Audio(
        created_at: audio.created_at,
        modified_at: audio.modified_at,
        deleted_at: audio.deleted_at,
        validated_at: audio.validated_at,
        cep: cepController.text,
        child: newChild,
        guardian: newGuardian,
        urlToAudio: newAudioURL,
        latitude: audio.latitude,
        longitude: audio.longitude,
        city: cityController.text,
        district: districtController.text,
        id: audio.id,
        state: stateController.text,
        transcription: transcriptionController.text,
        created_by: audio.created_by,
        appraiser: audio.appraiser,
        removed_by: audio.removed_by,
      );

      if (newAudio != audio || audioBytes != null) {
        await supabaseService.updatePost(Audio(
            created_at: newAudio.created_at,
            modified_at: DateTime.timestamp(),
            deleted_at: newAudio.deleted_at,
            validated_at: newAudio.validated_at,
            cep: newAudio.cep,
            child: newAudio.child,
            guardian: newAudio.guardian,
            urlToAudio: newAudio.urlToAudio,
            latitude: newAudio.latitude,
            longitude: newAudio.longitude,
            city: newAudio.city,
            state: newAudio.state,
            created_by: newAudio.created_by,
            removed_by: newAudio.removed_by,
            appraiser: newAudio.appraiser,
            edited_by: await supabaseService
                .getUser(supabaseService.getCurrentUser()!.id),
            district: newAudio.district,
            id: newAudio.id,
            transcription: newAudio.transcription));
        isLoading.value = false;
        Get.snackbar("Sucesso", "Audio alterado com sucesso",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.toNamed(Routes.userHome);
        return;
      }
      isLoading.value = false;
      Get.snackbar(
          "Nada foi alterado", "Para editar, algum dado tem que ser alterado",
          duration: const Duration(seconds: 5));
      await Future.delayed(const Duration(seconds: 5));
      Get.back(result: false);
    } catch (err) {
      Get.snackbar("Aviso", "Algo deu errado, tente novamente mais tarde",
          backgroundColor: Colors.amberAccent);
      Get.back(result: false);
      rethrow;
    } finally {
      isLoading.value = false;
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    childFirstNameController.dispose();
    childSurnameController.dispose();
    childBirthDateController.dispose();
    childRgController.dispose();
    childCpfController.dispose();
    childEmailController.dispose();
    cepController.dispose();
    cityController.dispose();
    districtController.dispose();
    guardianFullNameController.dispose();
    guardianBirthDateController.dispose();
    guardianRgController.dispose();
    guardianCpfController.dispose();
    guardianEmailController.dispose();
    transcriptionController.dispose();
  }
}
