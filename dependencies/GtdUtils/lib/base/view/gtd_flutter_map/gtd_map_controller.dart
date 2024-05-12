import 'dart:io';

import 'package:flutter_map/flutter_map.dart';
import 'package:gtd_utils/base/view/gtd_flutter_map/gtd_map_point.dart';
import 'package:map_launcher/map_launcher.dart';

class GtdMapController {
  final flutterMapController = MapController();

  void moveToPoint(GtdMapPoint mapPoint, {double? zoom}) {
    flutterMapController.move(mapPoint.toLatLng(), zoom ?? 16);
  }

  void openMapApp({
    required GtdMapPoint mapPoint,
    required String title,
  }) async {
    final coordinate = Coords(mapPoint.latitude, mapPoint.longitude);
    final success = await _openTypedMap(
      type: MapType.google,
      coordinates: coordinate,
      title: title,
    );
    if (!success) {
      if (Platform.isIOS) {
        _openTypedMap(
          type: MapType.apple,
          coordinates: coordinate,
          title: title,
        );
      }
    }
  }

  Future<bool> _openTypedMap({
    required MapType type,
    required Coords coordinates,
    required String title,
  }) async {
    final available = await MapLauncher.isMapAvailable(type);
    if (available == true) {
      await MapLauncher.showMarker(
        mapType: type,
        coords: coordinates,
        title: title,
        description: title,
      );
      return true;
    }
    return false;
  }
}
