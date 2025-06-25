import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:semeio_app/app/ui/components/footer.dart';
import 'package:semeio_app/app/ui/components/header.dart';

class HomePage extends StatelessWidget {
  @override
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final mapController = MapController();
    const centerOfBrazil = LatLng(-14.2350, -51.9253);
    return SafeArea(
      child: Scaffold(
        appBar: Header(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/paper_texture.png"),
                fit: BoxFit.fill),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: 250,
                child: RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.cyan),
                      children: [
                        const TextSpan(text: "Conheça a "),
                        const TextSpan(
                            text: "diversidade das cidades ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(text: "brasileiras na "),
                        WidgetSpan(
                            child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/cyan_bg.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Text(
                            "visão das crianças!",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 30),
                height: 380,
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    backgroundColor: const Color(0x00000000),
                    minZoom: 3,
                    maxZoom: 5,
                    initialZoom: 3.5,
                    initialCenter: centerOfBrazil,
                    interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
                    cameraConstraint: CameraConstraint.contain(
                        bounds: LatLngBounds.fromPoints([
                      const LatLng(6.836, -75.652),
                      const LatLng(-34.158, -25.689)
                    ])),
                  ),
                  children: [
                    TileLayer(
                      tileSize: 256,
                      tileProvider: AssetTileProvider(),
                      urlTemplate: "assets/map_tiles/{z}/{x}/{y}.png",
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: 140,
                    width: 150,
                    child: Stack(
                      children: [
                        // left_img (fica por baixo)
                        const Positioned.fill(
                          top: 0,
                          left: 0,
                          child: Image(
                            image: AssetImage("assets/images/left_img.png"),
                            fit: BoxFit
                                .cover, // Ajuste o tamanho conforme necessário
                          ),
                        ),
                        // orange_bg (fica por cima)
                        Positioned(
                          bottom: 40,
                          left: 25,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed("/audio/send");
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/orange_bg.png"),
                                      fit: BoxFit.fill)),
                              child: const Center(
                                child: Text(
                                  "ENVIE O SEU AÚDIO!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }
}
