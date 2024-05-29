import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:rct_gallery/models/comment.dart';
import 'package:rct_gallery/widgets/comment_card.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late Future<List<Comment>> comments;

  Future<List<Comment>> _fetchComments() async {
    final response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', '/comments'));
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
    return comments;
  }

  @override
  void initState() {
    super.initState();
    comments = _fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: comments,
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
                  'There was an issue getting to the comments\nCheck your internet connection and try again later.',
                  textAlign: TextAlign.center,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      comments = _fetchComments();
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

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return CommentCard(comment: snapshot.data![index]);
          },
        );
      },
    );
  }
}
