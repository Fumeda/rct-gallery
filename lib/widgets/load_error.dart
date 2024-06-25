import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rct_gallery/logic/photos_cubit.dart';
import 'package:rct_gallery/logic/comments_cubit.dart';

class LoadError extends StatelessWidget {
  const LoadError({super.key, required this.isPhotosError});

  final bool isPhotosError;

  @override
  Widget build(BuildContext context) {
    if (isPhotosError) {
      final photosCubit = BlocProvider.of<PhotosCubit>(context);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'There was an issue getting to the photos\nCheck your internet connection and try again later.',
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              onPressed: () {
                photosCubit.fetchPhotos();
              },
              icon: const Icon(Icons.restart_alt_rounded),
              label: const Text('Retry'),
            )
          ],
        ),
      );
    } else {
      final commentsCubit = BlocProvider.of<CommentsCubit>(context);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'There was an issue getting to the comments\nCheck your internet connection and try again later.',
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              onPressed: () {
                commentsCubit.fetchComments();
              },
              icon: const Icon(Icons.restart_alt_rounded),
              label: const Text('Retry'),
            )
          ],
        ),
      );
    }
  }
}
