import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart' hide Path;
import 'package:semeio_app/app/controllers/MapPageController.dart';
import 'package:semeio_app/app/core/clipper/DialogContainerClipper.dart';
import 'package:semeio_app/app/core/clipper/DialogContainerClipperRight.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';
import 'package:semeio_app/app/core/utils.dart';
import 'package:semeio_app/app/core/clipper/BallonClipper.dart';
import 'package:semeio_app/app/core/clipper/MapClipper.dart';
import 'package:semeio_app/app/routes/app_pages.dart';

class MapPage extends GetView<MapPageController> {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    double baseFontSize = Get.width * 0.009;
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/user_homepage.png"))),
        child: Stack(
          children: [
            Positioned(
              bottom: Get.height * 0.12,
              right: Get.width * 0.13,
              child: TextButton(
                onPressed: () async {
                  await controller.goToUserHomePage();
                },
                child: Container(
                  width: Get.width * 0.12,
                  height: Get.width * 0.035,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image:
                              AssetImage("assets/images/send_audio_bg.png"))),
                  child: Padding(
                    padding: EdgeInsets.only(right: Get.width * 0.012),
                    child: const Text(
                      "ENVIE O SEU ÁUDIO",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: Get.width * 0.025,
              top: Get.height * 0.01,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.userLogin);
                },
                child: Container(
                  width: Get.width * 0.05,
                  height: Get.width * 0.015,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/login_btn_bg.png"))),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Obx(() => controller.isAudioSelected.value
                ? Positioned(
                    top: Get.height * 0.3,
                    right: Get.width * 0.02,
                    child: SizedBox(
                      width: Get.width * 0.4,
                      height: Get.height * 0.5,
                      child: Column(
                        children: [
                          ClipPath(
                            clipper: BallonClipper(),
                            child: Container(
                              width: Get.width * 0.3,
                              height: Get.height * 0.15,
                              padding: EdgeInsets.all(Get.width * 0.003),
                              decoration: const BoxDecoration(
                                  color: bgBallonRegionalIcons),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * 0.06,
                                    margin: EdgeInsets.only(
                                        left: Get.height * 0.065),
                                    alignment: Alignment.center,
                                    child: Image(
                                      width: Get.width * 0.05,
                                      fit: BoxFit.contain,
                                      image: AssetImage(Utils.getSymbol(
                                              controller
                                                  .selectedAudio.value.state!)!
                                          .assetUrl),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.black,
                                    width: 6,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 12, left: 6, right: 6),
                                          child: SelectableText(
                                            Utils.getSymbol(controller
                                                    .selectedAudio
                                                    .value
                                                    .state!)!
                                                .description,
                                            maxLines: 3,
                                            style: TextStyle(
                                                fontSize: baseFontSize * 0.9),
                                            scrollPhysics:
                                                const NeverScrollableScrollPhysics(),
                                          ),
                                        ),
                                        const Spacer(),
                                        Center(
                                          child: IconButton(
                                              onPressed: () {
                                                _showExpandedSymbol(
                                                    context, baseFontSize);
                                              },
                                              padding: EdgeInsets.zero,
                                              constraints: BoxConstraints(
                                                minWidth: Get.width * 0.015,
                                                minHeight: Get.width * 0.015,
                                              ),
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.075,
                          ),
                          ClipPath(
                            clipper: BallonClipper(),
                            child: Container(
                              width: Get.width * 0.3,
                              height: Get.height * 0.22,
                              padding: EdgeInsets.all(Get.width * 0.003),
                              decoration:
                                  const BoxDecoration(color: bgBallonAudio),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: Get.height * 0.025,
                                        left: Get.height * 0.065),
                                    width: Get.width * 0.07,
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Image(
                                          width: Get.width * 0.05,
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                              controller.avatar.value),
                                        ),
                                        Text(
                                            controller.selectedAudio.value
                                                .child!.firstName,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: baseFontSize * 0.7)),
                                        SizedBox(
                                          width: Get.width * 0.08,
                                          child: Text(
                                            "${Utils.calcAge(controller.selectedAudio.value.child!.birthDate)} anos, ${controller.selectedAudio.value.city}, ${controller.selectedAudio.value.state}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: baseFontSize * 0.7),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.black,
                                    width: 6,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  controller.isPlaying.value
                                                      ? await controller
                                                          .pauseAudio()
                                                      : await controller
                                                          .playAudio();
                                                },
                                                icon: Icon(
                                                  controller
                                                          .isAudioLoading.value
                                                      ? Icons.hourglass_empty
                                                      : controller
                                                              .isPlaying.value
                                                          ? Icons.pause
                                                          : Icons.volume_up,
                                                  size: Get.width * 0.015,
                                                )),
                                            Image(
                                              image: const AssetImage(
                                                  "assets/images/audioWave.png"),
                                              width: Get.width * 0.10,
                                              height: Get.height * 0.06,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                        SelectableText(
                                          style: TextStyle(
                                              fontSize: baseFontSize * 0.9),
                                          "\"${controller.selectedAudio.value.transcription}\"",
                                          maxLines: 4,
                                        ),
                                        const Spacer(),
                                        Center(
                                          child: IconButton(
                                              onPressed: () {
                                                _showExpandedAudio(
                                                    context, baseFontSize);
                                              },
                                              padding: EdgeInsets.zero,
                                              constraints: BoxConstraints(
                                                minWidth: Get.width * 0.015,
                                                minHeight: Get.width * 0.015,
                                              ),
                                              icon: const Icon(
                                                Icons.keyboard_arrow_down,
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Positioned(
                    top: Get.height * 0.33,
                    right: Get.width * 0.06,
                    child: SizedBox(
                      width: Get.width * 0.3,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla facilisi. Suspendisse potenti. Curabitur venenatis, justo eu tincidunt suscipit, odio turpis volutpat nulla, id suscipit eros arcu ut quam. Fusce eget tortor at ligula sodales facilisis. Aenean dapibus, lorem et suscipit vestibulum, purus metus malesuada justo, at molestie urna odio vel felis. Integer ullamcorper, felis nec elementum feugiat, libero lectus sagittis leo, et elementum nunc tortor nec risus. Donec tincidunt dui id lorem gravida, at dictum elit malesuada. Aliquam erat volutpat. Ut vitae ante non arcu euismod posuere. Mauris eget lacus in lorem sollicitudin volutpat.",
                        style: TextStyle(fontSize: baseFontSize),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
            Positioned(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SizedBox(
                  width: Get.width * 0.6,
                  height: Get.height * 1,
                  child: ClipPath(
                    clipper: MapClipper(),
                    child: FlutterMap(
                      mapController: controller.mapController,
                      options: MapOptions(
                          onMapReady: () => controller.isMapReady.value = true,
                          backgroundColor: const Color(0x00000000),
                          minZoom: 5,
                          maxZoom: 12,
                          initialZoom: 4.5,
                          initialCenter: controller.centerOfBrazil,
                          interactionOptions: const InteractionOptions(
                              flags: InteractiveFlag.all &
                                  ~InteractiveFlag.rotate),
                          cameraConstraint: CameraConstraint.contain(
                              bounds: LatLngBounds.fromPoints([
                            const LatLng(6.836, -75.652),
                            const LatLng(-34.158, -25.689)
                          ]))),
                      children: [
                        TileLayer(
                          tileSize: 256,
                          tileProvider: AssetTileProvider(),
                          urlTemplate: "assets/map_tiles/{z}/{x}/{y}.png",
                          maxZoom: 12,
                        ),
                        MarkerClusterLayerWidget(
                            options: MarkerClusterLayerOptions(
                                markers: controller.markers,
                                padding: const EdgeInsets.all(50),
                                maxClusterRadius: 45,
                                size: const Size(40, 40),
                                alignment: Alignment.center,
                                builder: (context, markers) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blue),
                                    child: Center(
                                      child: Text(
                                        markers.length.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                })),
                      ],
                    ),
                  ),
                );
              }),
            ),
            Positioned(
                bottom: Get.height * 0.07,
                left: Get.width * 0.5,
                child: SizedBox(
                  height: Get.height * 0.3,
                  width: Get.width * 0.025,
                  child: Column(
                    children: [
                      IconButton(
                          style: const ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12)))),
                              backgroundColor:
                                  WidgetStatePropertyAll(hintTextColor)),
                          onPressed: () {},
                          icon: Icon(
                            color: Colors.white,
                            Icons.back_hand_outlined,
                            size: Get.width * 0.015,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      IconButton(
                          style: const ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12)))),
                              backgroundColor:
                                  WidgetStatePropertyAll(hintTextColor)),
                          onPressed: controller.goToCenter,
                          icon: Icon(
                            color: Colors.white,
                            Icons.trip_origin_outlined,
                            size: Get.width * 0.015,
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: hintTextColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Column(
                          children: [
                            IconButton(
                                onPressed: controller.zoomIn,
                                icon: Icon(
                                  color: Colors.white,
                                  Icons.zoom_in_outlined,
                                  size: Get.width * 0.015,
                                )),
                            Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              height: 2,
                              width: Get.width * 0.02,
                            ),
                            IconButton(
                                onPressed: controller.zoomOut,
                                icon: Icon(
                                  color: Colors.white,
                                  Icons.zoom_out_outlined,
                                  size: Get.width * 0.015,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        if (controller.isDialogShown.value) {
          Future.delayed(Duration.zero,
              () => _showCustomDialog(context, Get.width * 0.009));
        }
        return const SizedBox(); // Retorna um widget vazio
      }),
    );
  }

  _showCustomDialog(BuildContext context, double baseFontSize) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
            backgroundColor: Colors.transparent,
            child: SizedBox.expand(
              child: Stack(
                children: [
                  Positioned(
                      left: Get.width * 0.08,
                      top: Get.height * 0.23,
                      child: ClipPath(
                        clipper: DialogContainerClipperRight(),
                        child: Container(
                          alignment: Alignment.center,
                          decoration:
                              const BoxDecoration(color: bgBallonRegionalIcons),
                          width: Get.width * 0.22,
                          height: Get.height * 0.12,
                          child: SizedBox(
                            width: Get.width * 0.15,
                            child: Text(
                              "Clique em algum elemento do mapa, típico de cada região para mostrar um depoimento!",
                              style: TextStyle(
                                  fontSize: baseFontSize * 1.2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )),
                  Positioned(
                      top: Get.height * 0.1,
                      left: Get.width * 0.35,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: Get.width * 0.35,
                        height: Get.height * 0.15,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/modal_bg_img.png"),
                        )),
                        child: Text(
                          "Como usar?",
                          style: TextStyle(
                            fontSize: baseFontSize * 5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: GoogleFonts.kalam().fontFamily,
                          ),
                        ),
                      )),
                  Positioned(
                      bottom: Get.height * 0.33,
                      left: Get.width * 0.52,
                      child: ClipPath(
                        clipper: DialogContainerClipper(),
                        child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: bgBallonRegionalIcons),
                            width: Get.width * 0.22,
                            height: Get.height * 0.12,
                            child: SizedBox(
                              width: Get.width * 0.18,
                              child: Text(
                                "Use os ícones de movimentação para aumentar e diminuir a visualização do mapa!",
                                style: TextStyle(
                                    fontSize: baseFontSize * 1.2,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      )),
                  Positioned(
                    top: Get.height * 0.05,
                    left: Get.width * 0.7,
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => Get.back(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: closeBtn,
                          ),
                          padding: EdgeInsets.all(Get.width * 0.005),
                          child: Icon(
                            Icons.close,
                            size: Get.width * 0.025,
                            color: closeIconColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  _showExpandedSymbol(BuildContext context, double baseFontSize) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            alignment: Alignment.center,
            backgroundColor: bgBallonRegionalIcons,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: SizedBox(
              height: Get.height * 0.4,
              width: Get.width * 0.3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image(
                        width: Get.width * 0.05,
                        height: Get.width * 0.05,
                        fit: BoxFit.contain,
                        image: AssetImage(Utils.getSymbol(
                                controller.selectedAudio.value.state!)!
                            .assetUrl),
                      ),
                    ),
                    SelectableText(
                      Utils.getSymbol(controller.selectedAudio.value.state!)!
                          .description,
                      style: TextStyle(fontSize: baseFontSize),
                      maxLines: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _showExpandedAudio(BuildContext context, double baseFontSize) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            alignment: Alignment.center,
            backgroundColor: bgBallonAudio,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: SizedBox(
              height: Get.height * 0.4,
              width: Get.width * 0.3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image(
                          width: Get.width * 0.05,
                          fit: BoxFit.contain,
                          image: AssetImage(controller.avatar.value),
                        ),
                        Text(controller.selectedAudio.value.child!.firstName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: baseFontSize * 0.7)),
                        SizedBox(
                          width: Get.width * 0.2,
                          child: Text(
                            "${Utils.calcAge(controller.selectedAudio.value.child!.birthDate)} anos, ${controller.selectedAudio.value.city}, ${controller.selectedAudio.value.state}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: baseFontSize * 0.7),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.0025,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      alignment: Alignment.topLeft,
                      child: SelectableText(
                        style: TextStyle(fontSize: baseFontSize),
                        "\"${controller.selectedAudio.value.transcription}\"",
                        maxLines: 7,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.0025,
                    ),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  size: Get.width * 0.015,
                                )),
                            Image(
                              image: const AssetImage(
                                  "assets/images/audioWave.png"),
                              width: Get.width * 0.10,
                              height: Get.height * 0.045,
                              fit: BoxFit.cover,
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
