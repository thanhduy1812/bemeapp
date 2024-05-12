import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_long;

class GtdMarker {
  final String value;
  late final lat_long.LatLng point;
  final double latitude;
  final double longitude;
  final VoidCallback onMarkerTap;

  GtdMarker({
    required this.value,
    required this.latitude,
    required this.longitude,
    required this.onMarkerTap,
  }) {
    point = lat_long.LatLng(latitude, longitude);
  }

  Marker toMarker({bool highlight = false}) {
    double widthMarker = _calWidthMarker;
    return Marker(
      width: widthMarker,
      point: point,
      child: GestureDetector(
        onTap: () {
          onMarkerTap.call();
        },
        child: CustomPaint(
          painter: GtdMarkerCustomPaint(
            color: highlight ? Colors.orange : Colors.white,
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: highlight ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  double get _calWidthMarker {
    return value.characters.length * 9;
  }
}

class GtdMarkerCustomPaint extends CustomPainter {
  final Color color;

  GtdMarkerCustomPaint({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;
    const double triangleH = 10;
    const double triangleW = 10;
    final double width = size.width;
    final double height = size.height;

    final Path trianglePath = Path()
      ..moveTo(width / 2 - triangleW / 2, height)
      ..lineTo(width / 2, triangleH + height)
      ..lineTo(width / 2 + triangleW / 2, height)
      ..lineTo(width / 2 - triangleW / 2, height);
    canvas.drawPath(trianglePath, paint);
    final BorderRadius borderRadius = BorderRadius.circular(8);
    final Rect rect = Rect.fromLTRB(0, 0, width, height);
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
