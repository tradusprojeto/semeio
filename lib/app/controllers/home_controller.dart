import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class HomeController extends GetxController {
  MapController mapController = MapController();
  final centerOfBrazil = const LatLng(-14.2350, -51.9253);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void restartMapZoom() {
    mapController.move(centerOfBrazil, 3.5);
  }
}
