import 'package:flutter/material.dart';

import 'package:rct_gallery/models/photo.dart';

class PhotoDetails extends StatelessWidget {
  const PhotoDetails({super.key, required this.photo});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.network(
            photo.url,
            height: 300,
            width: 300,
            fit: BoxFit.fill,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              }
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                child: child,
              );
            },
            //loading builder really just doesn't want to work for some reason
            // loadingBuilder: (context, child, loadingProgress) {
            //   if (loadingProgress == null) {
            //     return child;
            //   }
            //   return SizedBox(
            //     height: 300,
            //     width: 300,
            //     child: Center(
            //       child: CircularProgressIndicator(
            //         value: loadingProgress.expectedTotalBytes != null
            //             ? loadingProgress.expectedTotalBytes! /
            //                 loadingProgress.cumulativeBytesLoaded
            //             : null,
            //       ),
            //     ),
            //   );
            // },
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Error loading image'),
                            TextButton.icon(
                                icon: const Icon(Icons.restart_alt),
                                onPressed: () {},
                                label: const Text('Try again (TBD)')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text(
                    photo.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
