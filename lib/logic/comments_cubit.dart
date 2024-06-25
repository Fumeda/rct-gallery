import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rct_gallery/models/comment.dart';
import 'package:rct_gallery/logic/comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsState());

  Future<void> fetchComments() async {
    emit(CommentsState(status: CommentsStatus.loading));

    try {
      final response = await http
          .get(Uri.https('jsonplaceholder.typicode.com', '/comments'));
      List<Comment> comments = [];

      for (final comment in json.decode(response.body)) {
        comments.add(
          Comment(
            postId: comment['postId'],
            id: comment['id'],
            name: comment['name'],
            email: comment['email'],
            body: comment['body'],
          ),
        );
      }

      emit(CommentsState(comments: comments, status: CommentsStatus.finished));
    } catch (error) {
      emit(CommentsState(status: CommentsStatus.error));
    }
    return;
  }
}
