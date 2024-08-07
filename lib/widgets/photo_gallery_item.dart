import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rct_gallery/logic/photos_cubit.dart';
import 'package:rct_gallery/models/photo.dart';

class PhotoGalleryItem extends StatelessWidget {
  const PhotoGalleryItem({super.key, required this.photo});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    final photosCubit = BlocProvider.of<PhotosCubit>(context);

    return InkWell(
      onTap: () {
        photosCubit.showDetails(photo, context);
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
            unnecessary to put a loadingBuilder here because it loads so incredibly fast
            you might see a frame with them on and at that point why have a loader.
            */
          // loadingBuilder: (context, child, loadingProgress) {
          //     if (loadingProgress == null) {
          //       return child;
          //     }
          //     return SizedBox(
          //       height: 300,
          //       width: 300,
          //       child: Center(
          //         child: CircularProgressIndicator(
          //           value: loadingProgress.expectedTotalBytes != null
          //               ? loadingProgress.cumulativeBytesLoaded /
          //                   loadingProgress.expectedTotalBytes!
          //               : null,
          //         ),
          //       ),
          //     );
          //   },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Refresh gallery?'),
                    IconButton(
                      onPressed: () {
                        photosCubit.fetchPhotos();
                      },
                      icon: const Icon(Icons.restart_alt),
                    ),
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
