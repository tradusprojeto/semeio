import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:latlong2/latlong.dart';
import 'package:semeio_app/app/core/utils.dart';
import 'package:semeio_app/app/model/Audio.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:js' as js;

class MapPageController extends GetxController {
  var centerOfBrazil = const LatLng(-14.2350, -51.9253);
  var audioList = <Audio>[].obs;
  final supabaseService = Get.find<SupabaseService>();
  final isLoading = true.obs;
  var markers = <Marker>[].obs;
  var pathAudio = "";

  var isAudioLoading = false.obs;

  final AudioPlayer audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var isAudioSelected = false.obs;

  MapController? mapController;
  var isMapReady = false.obs;
  var avatar = "".obs;
  var selectedAudio = const Audio.empty(
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
  var isDialogShown = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        isPlaying.value = false;
      }
    });
    mapController = MapController();
    await getAudios();
    showDialog();
  }

  void showDialog() {
    isDialogShown.toggle();
  }

  Future<void> getAudios() async {
    try {
      isLoading(true);
      audioList.value = await supabaseService.getAllAudiosAlreadyAudited();

      markers.value = audioList.map(
        (audio) {
          return Marker(
              width: 40,
              height: 40,
              point: LatLng(audio.latitude!, audio.longitude!),
              child: GestureDetector(
                onTap: () {
                  isAudioSelected.value = true;
                  selectedAudio.value = audio;
                  if (audioPlayer.playing) {
                    audioPlayer.stop();
                    isPlaying.value = false;
                  }
                  if (selectedAudio.value.child!.sex == "Masculino") {
                    avatar.value = "assets/images/garoto1.png";
                  } else {
                    avatar.value = "assets/images/avatar_girl.png";
                  }
                  atualizarTextoParaVLibras(selectedAudio.value.transcription!);
                  if (isMapReady.value && mapController != null) {
                    mapController!.move(
                      LatLng(audio.latitude!, audio.longitude!),
                      8,
                    );
                  } else {
                    print("Mapa ainda não está pronto!");
                  }
                },
                child: Image(
                  image: AssetImage(Utils.getSymbol(audio.state!)!.assetUrl),
                  width: 40,
                ),
              ));
        },
      ).toList();
      update();
    } finally {
      isLoading(false);
    }
  }

  Future<String?> loadAudio() async {
    isAudioLoading.value = true;
    var audioFile = await supabaseService
        .fetchAudioFromSupabase(selectedAudio.value.urlToAudio!);
    if (audioFile != null) {
      var pathToAudio =
          (await saveAudioTemp(audioFile, "${selectedAudio.value.id}"))!;
      isAudioLoading.value = false;
      return pathToAudio;
    }
    isAudioLoading.value = false;
    return null;
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

  @override
  void dispose() {
    super.dispose();
    mapController!.dispose();
  }

  void zoomIn() {
    if (isMapReady.value && mapController != null) {
      mapController!.move(
        mapController!.camera.center,
        mapController!.camera.zoom + 1,
      );
    } else {
      print("Mapa ainda não está pronto!");
    }
  }

  void zoomOut() {
    if (isMapReady.value && mapController != null) {
      double zoom = (mapController!.camera.zoom - 1) <= 4.5
          ? 4.5
          : mapController!.camera.zoom - 1;

      mapController!.move(
        mapController!.camera.center,
        zoom,
      );
    } else {
      print("Mapa ainda não está pronto!");
    }
  }

  void goToCenter() {
    if (isMapReady.value && mapController != null) {
      mapController!.move(
        centerOfBrazil,
        5.5,
      );
    } else {
      print("Mapa ainda não está pronto!");
    }
  }

  Future<void> goToUserHomePage() async {
    await Get.toNamed(Routes.userLogin);
  }

  void atualizarTextoParaVLibras(String texto) {
    js.context.callMethod('updateVlibrasText', [texto]);
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
      //isPlaying.value = false;
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
}
