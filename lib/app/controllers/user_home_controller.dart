import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:semeio_app/app/model/Audio.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/services/supabase_service.dart';
import 'dart:html' as html;

class UserHomeController extends GetxController {
  final supabaseService = Get.find<SupabaseService>();

  var pages = 0.obs;
  var currentPage = 0.obs;
  var actualPageItems = [].obs;
  var perPage = 0.obs;
  var audios = 0.obs;

  var checkboxCpf = false.obs;
  var checkboxAppraiser = false.obs;
  var checkboxSubmissionDate = false.obs;
  var checkboxCity = false.obs;
  var checkboxMarkAll = false.obs;

  var paginationInit = 0.obs;
  var paginationEnd = 5.obs;

  var searchController = TextEditingController();
  var shouldShowDialog = false.obs;

  var appraiserNameController = TextEditingController();

  var isOpenDialogConfirmsRemoval = false.obs;
  var isShowAudio = false.obs;
  var isPlaying = false.obs;
  var isAudioLoading = false.obs;
  var audioURL = ''.obs;
  var audioId = ''.obs;
  var audioTranscriptionController = TextEditingController();
  final audioPlayer = AudioPlayer();
  var audioIndexToDelete = 0.obs;
  var isLoadingPage = true.obs;
  var isFilteringLoader = false.obs;
  var isFiltering = false.obs;
  var filteredAudios = [].obs;

  @override
  void onInit() async {
    super.onInit();

    everAll(
      [checkboxCity, checkboxCpf, checkboxAppraiser, checkboxSubmissionDate],
      (_) async {
        bool allFiltersDisabled = [
          checkboxCity,
          checkboxCpf,
          checkboxAppraiser,
          checkboxSubmissionDate
        ].every((checkbox) => !checkbox.value);

        if (allFiltersDisabled && isFilteringLoader.value) {
          isFilteringLoader.value = false;
          isFiltering.value = false;
          searchController.clear();
          await reloadItems();
        }
      },
    );

    audios.value = await supabaseService.countItemsFromUser();
    if (audios.value < 3) {
      perPage.value = audios.value;
    } else {
      perPage.value = 3;
    }
    pages.value = audios.value != 0 ? (audios.value / perPage.value).ceil() : 0;
    pages.value < 5 ? paginationEnd.value = pages.value : 5;

    await loadAudiosUser();
    isLoadingPage.value = false;
  }

  Future<void> reloadItems() async {
    isLoadingPage.value = true;
    pages.value = 0;
    currentPage.value = 0;
    actualPageItems.value = [];
    perPage.value = 0;
    audios.value = 0;
    audios.value = await supabaseService.countItemsFromUser();

    if (audios.value < 3) {
      perPage.value = audios.value;
    } else {
      perPage.value = 3;
    }

    pages.value = audios.value != 0 ? (audios.value / perPage.value).ceil() : 0;

    pages.value < 5 ? paginationEnd.value = pages.value : 5;
    await loadAudiosUser();
    isLoadingPage.value = false;
    update();
  }

  Future<void> loadAudiosUser() async {
    int from = currentPage.value * perPage.value;
    int to = from + perPage.value - 1;
    actualPageItems.value = await supabaseService.getAudiosUserFromId(from, to);
    update();
  }

  void goToPage(int page) async {
    if (currentPage.value == page) return;
    isLoadingPage.value = true;
    currentPage.value = page;

    if (page < paginationInit.value) {
      paginationInit.value =
          paginationInit.value - 5 < 0 ? 0 : paginationInit.value - 5;
      if (paginationInit.value == 0) {
        paginationEnd.value = pages.value < 5 ? pages.value : 5;
      } else {
        paginationEnd.value = page + 1;
      }
    } else {
      if (page + 1 > paginationEnd.value) {
        paginationInit.value = page + 1 - 5;
        paginationEnd.value = page + 1;
      }
    }
    if (isFiltering.value) {
      int from = currentPage.value * perPage.value;
      int to = from + perPage.value - 1 >= filteredAudios.length
          ? filteredAudios.length - 1
          : from + perPage.value - 1;

      actualPageItems.value = filteredAudios.sublist(from, to + 1);
      isLoadingPage.value = false;
      refresh();
      return;
    }
    await loadAudiosUser();
    isLoadingPage.value = false;
    refresh();
  }

  Future<void> edit(Audio actualItem) async {
    await Get.toNamed("${Routes.userEditAudio}?audio_id=${actualItem.id}");
  }

  Future<void> removeAudio() async {
    isLoadingPage.value = true;
    final index = audioIndexToDelete.value;
    Audio audio = actualPageItems[index];
    actualPageItems[index] = Audio(
        created_by: audio.created_by,
        created_at: audio.created_at,
        modified_at: audio.modified_at,
        deleted_at: DateTime.timestamp(),
        validated_at: audio.validated_at,
        cep: audio.cep,
        child: audio.child,
        guardian: audio.guardian,
        urlToAudio: audio.urlToAudio,
        latitude: audio.latitude,
        longitude: audio.longitude,
        city: audio.city,
        district: audio.district,
        id: audio.id,
        transcription: audio.transcription);
    await supabaseService.updatePost(actualPageItems[index]);
    isLoadingPage.value = false;
    isOpenDialogConfirmsRemoval.value = false;
    await reloadItems();
  }

  void exposeAudio(int index) {
    Audio audio = actualPageItems[index];
    actualPageItems[index] = Audio(
        created_at: audio.created_at,
        modified_at: audio.modified_at,
        deleted_at: null,
        validated_at: audio.validated_at,
        cep: audio.cep,
        child: audio.child,
        guardian: audio.guardian,
        urlToAudio: audio.urlToAudio,
        latitude: audio.latitude,
        longitude: audio.longitude,
        city: audio.city,
        district: audio.district,
        id: audio.id,
        transcription: audio.transcription);
    supabaseService.updatePost(actualPageItems[index]);
    actualPageItems.refresh();
  }

  void goToCreateAudio() async {
    await Get.toNamed(Routes.desktopSendAudio);
  }

  void filterAudios() async {
    if (searchController.text.isNotEmpty) {
      isFilteringLoader.value = true;
      isLoadingPage.value = true;
      filteredAudios.value = await supabaseService.findAndFilterFromUser({
        "city": checkboxCity.value,
        "cpf": checkboxCpf.value,
        "appraiser": checkboxAppraiser.value,
        "created_at": checkboxSubmissionDate.value
      }, searchController.text);

      print("Filtrado: ${filteredAudios.length}");
      paginationEnd.value = 5;
      paginationInit.value = 0;

      audios.value = filteredAudios.length;
      pages.value =
          audios.value != 0 ? (audios.value / perPage.value).ceil() : 0;
      pages.value < 5 ? paginationEnd.value = pages.value : 5;

      currentPage.value = 0;

      int from = 0;
      int to = filteredAudios.length > (from + perPage.value - 1)
          ? from + perPage.value - 1
          : filteredAudios.length - 1;

      actualPageItems.value =
          filteredAudios.isEmpty ? [] : filteredAudios.sublist(from, to + 1);

      isLoadingPage.value = false;
      isFiltering.value = true;
      update();
    } else {
      if (isFiltering.value == true) reloadItems();
      isFiltering.value = false;
    }
  }

  void toggleShowAudio(
      final String path, final String transcription, final String id) {
    if (audioId.isNotEmpty) {
      if (audioId.value == id) {
        isShowAudio.value = !isShowAudio.value;
        audioURL.value = "";
        audioId.value = "";
        audioTranscriptionController.text = "";
        update();
        return;
      }
      audioURL.value = path;
      audioId.value = id;
      audioTranscriptionController.text = transcription;
      isShowAudio.value = false;
      isShowAudio.value = true;
      refresh();
      return;
    }
    audioURL.value = path;
    audioId.value = id;
    audioTranscriptionController.text = transcription;
    isShowAudio.value = !isShowAudio.value;
    update();
  }

  void toggleShowDialogRemove(final int? index) {
    if (index != null) {
      audioIndexToDelete.value = index;
    }
    isOpenDialogConfirmsRemoval.value = !isOpenDialogConfirmsRemoval.value;
  }

  Future<String?> loadAudio() async {
    isAudioLoading.value = true;
    final audioFile =
        await supabaseService.fetchAudioFromSupabase(audioURL.value);
    if (audioFile != null) {
      final pathToAudio = (await saveAudioTemp(audioFile, audioId.value))!;
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

  void verifyCheckBoxes(String? checkBoxName, bool? newValue) {
    if (checkBoxName == "appraiser") {
      checkboxAppraiser.value = newValue!;
      checkboxCity.value = false;
      checkboxCpf.value = false;
      checkboxSubmissionDate.value = false;
    } else if (checkBoxName == "city") {
      checkboxAppraiser.value = false;
      checkboxCity.value = newValue!;
      checkboxCpf.value = false;
      checkboxSubmissionDate.value = false;
    } else if (checkBoxName == "cpf") {
      checkboxAppraiser.value = false;
      checkboxCity.value = false;
      checkboxCpf.value = newValue!;
      checkboxSubmissionDate.value = false;
    } else {
      checkboxAppraiser.value = false;
      checkboxCity.value = false;
      checkboxCpf.value = false;
      checkboxSubmissionDate.value = newValue!;
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
}
