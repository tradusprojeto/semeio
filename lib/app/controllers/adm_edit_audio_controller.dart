import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:semeio_app/app/core/formatters/date_formatter.dart';
import 'package:semeio_app/app/model/Audio.dart';
import 'package:semeio_app/app/model/Child.dart';
import 'package:semeio_app/app/model/Guardian.dart';
import 'package:semeio_app/app/services/supabase_service.dart';

class AdmEditAudioController extends GetxController {
  final supabaseService = Get.find<SupabaseService>();
  late var audio = const Audio.empty(null, null, null, null, null, null, null,
      null, null, null, null, null, null, null, null, null, null, null, null);
  final formKey = GlobalKey<FormState>();
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
  var transcriptionController = TextEditingController();
  var stateController = TextEditingController();
  var childSex = "".obs;
  var pathToAudio = "";
  var isLoading = true.obs;
  var isEditing = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    audio = await supabaseService.getAudio(Get.parameters["audio_id"]!);
    childFirstNameController.text = audio.child!.firstName;
    childSurnameController.text = audio.child!.surname;
    childBirthDateController.text =
        DateFormatter.toBrazilian(audio.child!.birthDate);
    childRgController.text = audio.child!.rg;
    childCpfController.text = audio.child!.cpf;
    childEmailController.text = audio.child!.email;
    childSex.value = audio.child!.sex;
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
    stateController.text = audio.state!;
    isLoading.value = false;
    update();
  }

  Future<void> loadAudio() async {
    var audioFile =
        await supabaseService.fetchAudioFromSupabase(audio.urlToAudio!);
    if (audioFile != null) {
      pathToAudio = (await saveAudioTemp(audioFile, "${audio.id}"))!;
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

  Future<void> editAudio() async {
    if (formKey.currentState!.validate()) {
      isEditing.value = true;
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
            birthDate:
                DateFormatter.toPostgreSql(childBirthDateController.text),
            rg: childRgController.text,
            cpf: childCpfController.text,
            email: childEmailController.text,
            sex: childSex.value,
            id: audio.child!.id);

        Audio newAudio = Audio(
            created_by: audio.created_by,
            created_at: audio.created_at,
            modified_at: audio.modified_at,
            deleted_at: audio.deleted_at,
            validated_at: audio.validated_at,
            cep: cepController.text,
            child: newChild,
            guardian: newGuardian,
            urlToAudio: audio.urlToAudio,
            latitude: audio.latitude,
            longitude: audio.longitude,
            city: cityController.text,
            district: districtController.text,
            id: audio.id,
            state: stateController.text,
            transcription: transcriptionController.text,
            appraiser: audio.appraiser,
            removed_by: audio.removed_by);

        await supabaseService.updatePost(Audio(
            created_by: newAudio.created_by,
            edited_by: await supabaseService
                .getUser(supabaseService.getCurrentUser()!.id),
            created_at: newAudio.created_at,
            modified_at: DateTime.timestamp(),
            deleted_at: newAudio.deleted_at,
            validated_at: newAudio.validated_at,
            removed_by: newAudio.removed_by,
            appraiser: newAudio.appraiser,
            cep: newAudio.cep,
            child: newAudio.child,
            guardian: newAudio.guardian,
            urlToAudio: newAudio.urlToAudio,
            latitude: newAudio.latitude,
            longitude: newAudio.longitude,
            city: newAudio.city,
            district: newAudio.district,
            id: newAudio.id,
            state: newAudio.state,
            transcription: newAudio.transcription));
        Get.back(result: true);
        return;
      } catch (err) {
        print(err);
        Get.snackbar("Erro no preenchimento",
            "Algum campo foi mal preenchido, por favor revise.");
        isEditing.value = true;
        rethrow;
      } finally {
        isEditing.value = false;
      }
    } else {
      Get.snackbar("Erro no preenchimento",
          "Algum campo foi mal preenchido, por favor revise.");
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
    stateController.dispose();
  }
}
