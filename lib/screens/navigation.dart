import 'package:flutter/material.dart';

import 'package:rct_gallery/models/photo.dart';
import 'package:rct_gallery/screens/comments.dart';
import 'package:rct_gallery/screens/gallery.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late Future<List<Photo>> photos;
  var currentPageIndex = 0;

  final screens = [
    const GalleryScreen(),
    const CommentsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.image),
            label: 'Gallery',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat),
            label: 'Comments',
          ),
        ],
      ),
      body: SafeArea(child: screens[currentPageIndex]),
    );
  } 
}
