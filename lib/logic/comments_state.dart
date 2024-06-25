import 'package:rct_gallery/models/comment.dart';

enum CommentsStatus {
  init,
  loading,
  finished,
  error,
}

class CommentsState {
  CommentsState({this.status = CommentsStatus.init, this.comments = const []});

  final CommentsStatus status;
  final List<Comment> comments;

  CommentsState update({
    CommentsStatus? status,
    List<Comment>? comments,
  }) {
    return CommentsState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
    );
  }
}