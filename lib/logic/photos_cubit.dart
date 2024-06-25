import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rct_gallery/logic/photos_state.dart';
import 'package:rct_gallery/models/photo.dart';
import 'package:rct_gallery/widgets/photo_details.dart';

class PhotosCubit extends Cubit<PhotosState> {
  PhotosCubit() : super(PhotosState());

  Future<void> fetchPhotos() async {
    emit(state.update(status: PhotosStatus.loading));

    try {
      final response =
          await http.get(Uri.https('jsonplaceholder.typicode.com', '/photos'));

      final List<Photo> photos = [];

      for (final photo in json.decode(response.body)) {
        photos.add(
          Photo(
            albumId: photo['albumId'],
            id: photo['id'],
            title: photo['title'],
            url: photo['url'],
            thumbnailUrl: photo['thumbnailUrl'],
          ),
        );
      }

      emit(state.update(photos: photos, status: PhotosStatus.finished));
    } catch (error) {
      emit(state.update(status: PhotosStatus.error));
    }
  }

  void showDetails(Photo photo, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.hardEdge,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 160),
          child: PhotoDetails(photo: photo),
        );
      },
    );
  }
}
