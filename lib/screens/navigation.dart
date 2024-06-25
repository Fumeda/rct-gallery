import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rct_gallery/logic/navigation_cubit.dart';
import 'package:rct_gallery/logic/navigation_state.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final navigationCubit = BlocProvider.of<NavigationCubit>(context);

    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(child: state.screens[state.screenIndex]),
          bottomNavigationBar: NavigationBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            onDestinationSelected: (index) {
              navigationCubit.switchScreen(index);
            },
            selectedIndex: state.screenIndex,
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
        );
      },
    );
  }
}