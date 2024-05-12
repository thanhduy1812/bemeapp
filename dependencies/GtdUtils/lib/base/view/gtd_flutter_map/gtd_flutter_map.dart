import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gtd_utils/base/view/gtd_flutter_map/gtd_map_controller.dart';
import 'package:gtd_utils/base/view/gtd_flutter_map/gtd_map_point.dart';
import 'package:gtd_utils/base/view/gtd_flutter_map/gtd_marker.dart';
import 'package:latlong2/latlong.dart';

class GtdFlutterMap extends StatelessWidget {
  late final GtdMapController mapController;
  final GtdMapPoint initMapPoint;
  final List<GtdMarker> markers;
  final double zoom;
  final int? selectedIndex;

  GtdFlutterMap({
    super.key,
    GtdMapController? mapController,
    this.markers = const [],
    required this.initMapPoint,
    this.zoom = 16,
    this.selectedIndex,
  }) {
    this.mapController = mapController ?? GtdMapController();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController.flutterMapController,
      options: MapOptions(
        center: LatLng(initMapPoint.latitude, initMapPoint.longitude),
        zoom: zoom,
        maxZoom: 18, ///Limit zoom to 18, map turns grey if zoom further
      ),
      nonRotatedChildren: const [
        // RichAttributionWidget(
        //   attributions: [
        //     TextSourceAttribution(
        //       'Gotadi Map',
        //       onTap: () => launchUrl(Uri.parse('https://gotadi.com')),
        //     ),
        //   ],
        // ),
      ],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.gotadi.app',
        ),
        MarkerLayer(
          // anchorPos: AnchorPos.align(AnchorAlign.center),
          rotate: true,
          // markers: markers.map((e) => e.toMarker()).toList(),
          markers: markers.mapIndexed((index, e) {
            return e.toMarker(highlight: selectedIndex == index);
          }).toList(),

          // markers: [
          //   GtdMarker(value: "134,300 VND", point: const LatLng(10.8045027, 106.7910036)).toMarker(),
          // ],
        )
      ],
    );
  }
}
