import 'package:flutter/material.dart';

import 'package:rct_gallery/widgets/photo_gallery_item.dart';
import 'package:rct_gallery/models/photo.dart';

class PhotoGallery extends StatelessWidget {
  const PhotoGallery({required this.photos, super.key});

  final List<Photo> photos;

  @override
  build(context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
      ),
      children: [
        for (final photo in photos)
          PhotoGalleryItem(
            photo: photo,
          ),
      ],
    );
  }
}
