import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:semeio_app/app/core/formatters/date_formatter.dart';
import 'package:semeio_app/app/model/Audio.dart';
import 'package:semeio_app/app/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdmViewAudioController extends GetxController {
  late var audio = const Audio.empty(
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null)
      .obs;
  final supabaseService = Get.find<SupabaseService>();

  final AudioPlayer audioPlayer = AudioPlayer();
  var isPlaying = false.obs;

  var childFirstNameController = TextEditingController();
  var childSurnameController = TextEditingController();
  var childBirthDateController = TextEditingController();
  var childRgController = TextEditingController();
  var childCpfController = TextEditingController();
  var childEmailController = TextEditingController();
  var cepController = TextEditingController();
  var cityController = TextEditingController();
  var districtController = TextEditingController();
  var guardianFullNameController = TextEditingController();
  var guardianBirthDateController = TextEditingController();
  var guardianRgController = TextEditingController();
  var guardianCpfController = TextEditingController();
  var guardianEmailController = TextEditingController();
  var appraiserNameController = TextEditingController();
  var transcriptionController = TextEditingController();
  var stateController = TextEditingController();
  var childSexController = TextEditingController();
  var pathToAudio = "";
  var isLoading = true.obs;
  var isValidating = false.obs;
  @override
  void onInit() async {
    super.onInit();
    audio.value = await supabaseService.getAudio(Get.parameters["audio_id"]!);
    initializeFields();
    isLoading.value = false;
    update();
  }

  Future<void> loadAudio() async {
    var audioFile =
        await supabaseService.fetchAudioFromSupabase(audio.value.urlToAudio!);
    if (audioFile != null) {
      pathToAudio = (await saveAudioTemp(audioFile, "${audio.value.id}"))!;
      playAudio(pathToAudio);
    }
  }

  Future<void> playAudio(String path) async {
    try {
      await audioPlayer.setUrl(path);
      await audioPlayer.play();
      isPlaying.value = true;
    } catch (e) {
      print("Erro ao tentar tocar o áudio: $e");
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

  void initializeFields() {
    childFirstNameController.text = audio.value.child!.firstName;
    childSurnameController.text = audio.value.child!.surname;
    childBirthDateController.text =
        DateFormatter.toBrazilian(audio.value.child!.birthDate);
    childRgController.text = audio.value.child!.rg;
    childCpfController.text = audio.value.child!.cpf;
    childEmailController.text = audio.value.child!.email;
    cepController.text = audio.value.cep!;
    cityController.text = audio.value.city!;
    districtController.text = audio.value.district!;
    guardianFullNameController.text = audio.value.guardian!.fullName;
    guardianBirthDateController.text = audio.value.guardian!.birthDate;
    guardianRgController.text = audio.value.guardian!.rg;
    guardianCpfController.text = audio.value.guardian!.cpf;
    guardianEmailController.text = audio.value.guardian!.email;
    transcriptionController.text = audio.value.transcription!;
    stateController.text = audio.value.state!;
    childSexController.text = audio.value.child!.sex;
  }

  Future<void> validateAudio() async {
    isValidating.value = true;
    User? currentUser = supabaseService.getCurrentUser();
    await supabaseService.updatePost(Audio(
        created_by: audio.value.created_by,
        created_at: audio.value.created_at,
        modified_at: audio.value.modified_at,
        deleted_at: audio.value.deleted_at,
        validated_at: DateTime.timestamp(),
        appraiser: await supabaseService.getUser(currentUser!.id),
        cep: cepController.text,
        child: audio.value.child,
        guardian: audio.value.guardian,
        urlToAudio: audio.value.urlToAudio,
        latitude: audio.value.latitude,
        longitude: audio.value.longitude,
        city: cityController.text,
        district: districtController.text,
        id: audio.value.id,
        transcription: audio.value.transcription,
        state: audio.value.state,
        removed_by: audio.value.removed_by,
        edited_by: audio.value.edited_by));
    isValidating.value = false;
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
    appraiserNameController.dispose();
    childSexController.dispose();
  }
}
