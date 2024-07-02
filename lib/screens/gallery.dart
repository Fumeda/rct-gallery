import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rct_gallery/logic/photos_cubit.dart';
import 'package:rct_gallery/logic/photos_state.dart';
import 'package:rct_gallery/widgets/loading_circle.dart';
import 'package:rct_gallery/widgets/photo_gallery.dart';
import 'package:rct_gallery/widgets/load_error.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotosCubit>(
      create: (context) => PhotosCubit()..fetchPhotos(),
      child: BlocBuilder<PhotosCubit, PhotosState>(
        builder: (context, state) {
          switch (state.status) {
            case PhotosStatus.init:
              return const LoadingCircle();

            case PhotosStatus.loading:
              return const LoadingCircle();

            case PhotosStatus.finished:
              return PhotoGallery(photos: state.photos);

            case PhotosStatus.error:
              return const LoadError(isPhotosError: true);
          }
        },
      ),
    );
  }
}
