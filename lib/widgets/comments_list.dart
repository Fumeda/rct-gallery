import 'package:flutter/material.dart';

import 'package:rct_gallery/widgets/comment_card.dart';
import 'package:rct_gallery/models/comment.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key, required this.comments});

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return CommentCard(comment: comments[index]);
      },
    );
  }
}
