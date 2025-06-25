import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/model/Audio.dart';
import 'package:semeio_app/app/model/Profile.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/services/supabase_service.dart';

class AdmHomeController extends GetxController {
  final supabaseService = Get.find<SupabaseService>();

  var pagesAudit = 0.obs;
  var currentPageAudit = 0.obs;
  var actualPageItemsToAudit = [].obs;
  var perPageAudit = 0.obs;
  var auditAudios = 0.obs;

  var pages = 0.obs;
  var currentPage = 0.obs;
  var actualPageItems = [].obs;
  var perPage = 0.obs;
  var audios = 0.obs;

  var checkboxCpf = false.obs;
  var checkboxAppraiser = false.obs;
  var checkboxSubmissionDate = false.obs;
  var checkboxCity = false.obs;

  var paginationInitAudit = 0.obs;
  var paginationEndAudit = 5.obs;

  var paginationInit = 0.obs;
  var paginationEnd = 5.obs;

  var searchController = TextEditingController();
  var shouldShowDialog = false.obs;

  var appraiserNameController = TextEditingController();
  var isLoading = true.obs;

  var isLoadingPageOfAuditedAudios = false.obs;
  var isLoadingPageOfAudios = false.obs;

  var isFiltered = false.obs;
  var filteredAudios = [].obs;
  @override
  void onInit() async {
    super.onInit();

    checkIfNameIsProvided();

    auditAudios.value = await supabaseService.countItemsToBeAudited();
    if (auditAudios.value < 6) {
      perPageAudit.value = auditAudios.value;
    } else {
      perPageAudit.value = 6;
    }
    audios.value = await supabaseService.countItemsAlreadyAudited();
    if (audios.value < 3) {
      perPage.value = audios.value;
    } else {
      perPage.value = 3;
    }

    pagesAudit.value = auditAudios.value != 0
        ? (auditAudios.value / perPageAudit.value).ceil()
        : 0;
    pages.value = audios.value != 0 ? (audios.value / perPage.value).ceil() : 0;

    pagesAudit.value < 5 ? paginationEndAudit.value = pagesAudit.value : 5;
    pages.value < 5 ? paginationEnd.value = pages.value : 5;

    await loadAudiosToBeAudited();
    await loadAudiosAlreadyAudited();
    isLoading.value = false;
  }

  Future<void> reloadItemsAudited() async {
    pagesAudit.value = 0;
    currentPageAudit.value = 0;
    actualPageItemsToAudit.value = [];
    perPageAudit.value = 0;
    auditAudios.value = 0;

    auditAudios.value = await supabaseService.countItemsToBeAudited();
    if (auditAudios.value < 6) {
      perPageAudit.value = auditAudios.value;
    } else {
      perPageAudit.value = 6;
    }

    pagesAudit.value = auditAudios.value != 0
        ? (auditAudios.value / perPageAudit.value).ceil()
        : 0;

    pagesAudit.value < 5 ? paginationEndAudit.value = pagesAudit.value : 5;

    await loadAudiosToBeAudited();
    update();
  }

  Future<void> reloadItemsAlreadyAudited() async {
    pages.value = 0;
    currentPage.value = 0;
    actualPageItems.value = [];
    perPage.value = 0;
    audios.value = 0;

    audios.value = await supabaseService.countItemsAlreadyAudited();
    if (audios.value < 3) {
      perPage.value = audios.value;
    } else {
      perPage.value = 3;
    }

    pages.value = audios.value != 0 ? (audios.value / perPage.value).ceil() : 0;

    pages.value < 5 ? paginationEnd.value = pages.value : 5;

    await loadAudiosAlreadyAudited();
    update();
  }

  Future<void> loadAudiosToBeAudited() async {
    isLoadingPageOfAudios.toggle();
    int from = currentPageAudit.value * perPageAudit.value;
    int to = from + perPageAudit.value - 1;
    actualPageItemsToAudit.value =
        await supabaseService.getAudiosToBeAudited(from, to);
    update();
    isLoadingPageOfAudios.toggle();
  }

  Future<void> loadAudiosAlreadyAudited() async {
    isLoadingPageOfAuditedAudios.toggle();
    int from = currentPage.value * perPage.value;
    int to = from + perPage.value - 1;
    actualPageItems.value =
        await supabaseService.getAudiosAlreadyAudited(from, to);
    update();
    isLoadingPageOfAuditedAudios.toggle();
  }

  void goToPageAudit(int page) {
    if (currentPageAudit.value == page) return;
    currentPageAudit.value = page;

    if (page < paginationInitAudit.value) {
      paginationInitAudit.value =
          paginationInitAudit.value - 5 < 0 ? 0 : paginationInitAudit.value - 5;
      if (paginationInitAudit.value == 0) {
        paginationEndAudit.value = pagesAudit.value < 5 ? pagesAudit.value : 5;
      } else {
        paginationEndAudit.value = page + 1;
      }
    } else {
      if ((page + 1) > paginationEndAudit.value) {
        paginationInitAudit.value = page + 1 - 5;
        paginationEndAudit.value = page + 1;
      }
    }
    loadAudiosToBeAudited();
    refresh();
  }

  void goToPage(int page) {
    if (currentPage.value == page) return;
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
    if (isFiltered.value) {
      int from = currentPage.value * perPage.value;
      int to = from + perPage.value - 1 >= filteredAudios.length
          ? filteredAudios.length - 1
          : from + perPage.value - 1;

      actualPageItems.value = filteredAudios.sublist(from, to + 1);
      refresh();
      return;
    }
    loadAudiosAlreadyAudited();
    refresh();
  }

  Future<void> edit(Audio actualItem) async {
    await Get.toNamed("${Routes.admEditAudio}?audio_id=${actualItem.id}");
  }

  Future<void> validate(Audio actualItem) async {
    await Get.toNamed("${Routes.admViewAudio}?audio_id=${actualItem.id}");
  }

  Future<void> removeAudio(int index) async {
    Audio audio = actualPageItems[index];
    Profile user =
        await supabaseService.getUser(supabaseService.getCurrentUser()!.id);
    actualPageItems[index] = Audio(
        removed_by: user,
        edited_by: audio.edited_by,
        state: audio.state,
        appraiser: audio.appraiser,
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
    actualPageItems.refresh();
  }

  Future<void> exposeAudio(int index) async {
    Audio audio = actualPageItems[index];
    actualPageItems[index] = Audio(
        created_at: audio.created_at,
        removed_by: null,
        appraiser: audio.appraiser,
        edited_by: audio.edited_by,
        state: audio.state,
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
    await supabaseService.updatePost(actualPageItems[index]);
    actualPageItems.refresh();
  }

  Future<void> checkIfNameIsProvided() async {
    shouldShowDialog.value = !(await supabaseService.checkIfNameIsProvided());
  }

  Future<void> setAppraiserName() async {
    await supabaseService.updateUserProfileName(appraiserNameController.text);
  }

  void filterAudios() async {
    if (searchController.text.isNotEmpty) {
      filteredAudios.value = await supabaseService.findAndFilter({
        "city": checkboxCity.value,
        "cpf": checkboxCpf.value,
        "appraiser": checkboxAppraiser.value,
        "created_at": checkboxSubmissionDate.value
      }, searchController.text);

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
      update();

      isFiltered.value = true;
    } else {
      if (isFiltered.value = true) reloadItemsAlreadyAudited();
      isFiltered.value = false;
    }
  }

  void verifyCheckboxes(String checkboxName, bool? newValue) {
    if (checkboxName == "appraiser") {
      checkboxAppraiser.value = newValue!;
      checkboxCity.value = false;
      checkboxCpf.value = false;
      checkboxSubmissionDate.value = false;
    } else if (checkboxName == "city") {
      checkboxAppraiser.value = false;
      checkboxCity.value = newValue!;
      checkboxCpf.value = false;
      checkboxSubmissionDate.value = false;
    } else if (checkboxName == "cpf") {
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

  void clearFilters() {
    checkboxAppraiser.value = false;
    checkboxCity.value = false;
    checkboxCpf.value = false;
    checkboxSubmissionDate.value = false;
    searchController.text = "";
    reloadItemsAlreadyAudited();
    isFiltered.value = false;
  }
}
