import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rct_gallery/logic/photos_cubit.dart';
import 'package:rct_gallery/logic/comments_cubit.dart';

class LoadError extends StatelessWidget {
  const LoadError({super.key, required this.isPhotosError});

  final bool isPhotosError;

  @override
  Widget build(BuildContext context) {
    final currentCubit; //DYNAMIC TYPE

    if (isPhotosError) {
      currentCubit = BlocProvider.of<PhotosCubit>(context);
    } else {
      currentCubit = BlocProvider.of<CommentsCubit>(context);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'There was an issue getting to the ${isPhotosError ? 'photos' : 'comments'}\nCheck your internet connection and try again later.',
            textAlign: TextAlign.center,
          ),
          ElevatedButton.icon(
            onPressed: () {
              isPhotosError
                  ? currentCubit.fetchPhotos()
                  : currentCubit.fetchComments();
            },
            icon: const Icon(Icons.restart_alt_rounded),
            label: const Text('Retry'),
          )
        ],
      ),
    );
  }
}
