import 'package:flutter/material.dart';
import 'package:gtd_utils/helpers/extension/image_extension.dart';

class GtdListHorizontalImages extends StatelessWidget {
  final List<String> images;
  const GtdListHorizontalImages({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            var imageUrl = images[index];
            return Card(
              margin: EdgeInsets.zero,
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: 270,
                  child: GtdImage.cachedImgUrlWithPlaceholder(url: imageUrl, fit: BoxFit.cover),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 8,
              ),
          itemCount: images.length),
    );
  }
}
