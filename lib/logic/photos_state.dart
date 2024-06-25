import 'package:rct_gallery/models/photo.dart';

enum PhotosStatus {
  init,
  loading,
  finished,
  error,
}

class PhotosState {
  PhotosState({this.status = PhotosStatus.init, this.photos = const []});

  final PhotosStatus status;
  final List<Photo> photos;

  PhotosState update({
    List<Photo>? photos,
    PhotosStatus? status,
  }) {
    return PhotosState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
    );
  }
}
