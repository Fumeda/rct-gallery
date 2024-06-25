import 'package:flutter/material.dart';

import 'package:rct_gallery/screens/comments.dart';
import 'package:rct_gallery/screens/gallery.dart';

class NavigationState {
  NavigationState({
    this.screens = const [
      GalleryScreen(),
      CommentsScreen(),
    ],
    this.screenIndex = 0,
  });

  final List<Widget> screens;
  final int screenIndex;

  NavigationState update(int screenIndex) =>
      NavigationState(screenIndex: screenIndex);
}
