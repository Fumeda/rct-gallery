import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rct_gallery/logic/comments_cubit.dart';
import 'package:rct_gallery/logic/comments_state.dart';
import 'package:rct_gallery/widgets/comments_list.dart';
import 'package:rct_gallery/widgets/load_error.dart';
import 'package:rct_gallery/widgets/loading_circle.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentsCubit>(
      create: (context) {
        return CommentsCubit()..fetchComments();
      },
      child: BlocBuilder<CommentsCubit, CommentsState>(
        builder: (context, state) {
          switch (state.status) {
            case CommentsStatus.init:
              return const LoadingCircle();

            case CommentsStatus.loading:
              return const LoadingCircle();

            case CommentsStatus.finished:
              return CommentsList(comments: state.comments);

            case CommentsStatus.error:
              return const LoadError(isPhotosError: false);
          }
        },
      ),
    );
  }
}
