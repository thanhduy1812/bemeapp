import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GtdShimmer extends StatelessWidget {
  final Widget child;

  const GtdShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: child,
    );
  }

  static Widget cardLoading() {
    return const Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
    );
  }

  static Widget customShimmer({
    required double width,
    required double height,
  }) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Colors.grey.shade100,
          Colors.grey.shade600,
        ],
      ),
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
