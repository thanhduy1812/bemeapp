// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:latlong2/latlong.dart';

class GtdMapPoint {
  double latitude;
  double longitude;
  GtdMapPoint({
    required this.latitude,
    required this.longitude,
  });

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}
