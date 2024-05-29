import 'package:flutter/material.dart';

import 'package:rct_gallery/models/photo.dart';

class PhotoItem extends StatelessWidget {
  const PhotoItem({
    super.key,
    required this.photo,
    required this.onTap,
  });

  final Photo photo;
  final void Function(Photo photo) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(photo);
      },
      borderRadius: BorderRadius.circular(16),
      splashColor: Theme.of(context).colorScheme.primary,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          photo.thumbnailUrl,
          key: Key(photo.id.toString()),
          height: 150,
          width: 150,
          fit: BoxFit.fill,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
              child: child,
            );
          },
          /* 
          i don't know why, but this just doesn't want to work the way it should
          it's documented as if it chains with framebuilder, but instead only one is active at a time regardless
          */
          // loadingBuilder: (context, child, loadingProgress) {
          //   if (loadingProgress == null) {
          //     return child;
          //   }
          //   return CircularProgressIndicator(
          //     value: loadingProgress.expectedTotalBytes != null
          //         ? loadingProgress.expectedTotalBytes! /
          //             loadingProgress.cumulativeBytesLoaded
          //         : null,
          //   );
          // },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Error loading image'),
                    TextButton.icon(
                        icon: const Icon(Icons.restart_alt),
                        onPressed: () {},
                        label: const Text('Try again (TBD)')),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
