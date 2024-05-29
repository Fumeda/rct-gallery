import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:rct_gallery/models/photo.dart';
import 'package:rct_gallery/widgets/photo_details.dart';
import 'package:rct_gallery/widgets/photo_item.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() {
    return _GalleryScreenState();
  }
}

class _GalleryScreenState extends State<GalleryScreen> {
  late Future<List<Photo>> photos;
  /*
  get all photos, executed at initState, not optimal but
  likely better than making a single request for each photo?
  */
  Future<List<Photo>> _fetchPhotos() async {
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
    return photos;
  }

  void _showDetails(Photo photo) {
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

  @override
  void initState() {
    super.initState();
    photos = _fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: FutureBuilder(
            future: photos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'There was an issue getting to the photos.',
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            photos = _fetchPhotos();
                          });
                        },
                        icon: const Icon(Icons.restart_alt_rounded),
                        label: const Text('Retry'),
                      )
                    ],
                  ),
                );
              }

              if (snapshot.data == null) {
                return const Text('Uh oh! snapshot is null');
              }

              return GridView(
                padding: const EdgeInsets.all(24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                ),
                children: [
                  for (final photo in snapshot.data!)
                    PhotoItem(
                      photo: photo,
                      onTap: _showDetails,
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
