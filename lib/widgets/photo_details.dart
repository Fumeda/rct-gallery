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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            photo.url,
            height: 300,
            width: 300,
            fit: BoxFit.cover,
            /*
            there's a bug with frameBuilder where you will see a tiny white edge on the border the first time an image loads
            so i'd rather use loadingBuilder here.
            */
            // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            //   if (wasSynchronouslyLoaded) {
            //     return child;
            //   }
            //   return AnimatedOpacity(
            //     opacity: frame == null ? 0 : 1,
            //     duration: const Duration(milliseconds: 500),
            //     curve: Curves.easeIn,
            //     child: child,
            //   );
            // },

            /*
            for some reason when loading shows a blank screen instead of loading circle, and then flashes it for a second
            probably has to do with the fact it doesn't start downloading bytes until a connection is made and then the download happens.
            i know no feature to let me put something in place of the 'connection' part rather than the downloading part, so this will stay.
            */
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return SizedBox(
                height: 300,
                width: 300,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
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
