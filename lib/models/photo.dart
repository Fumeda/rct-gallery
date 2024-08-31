import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
  
  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String,dynamic> toJson() => _$PhotoToJson(this);
}
