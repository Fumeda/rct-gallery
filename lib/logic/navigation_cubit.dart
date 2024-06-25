import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rct_gallery/logic/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState());

  void switchScreen(int index) {
    emit(state.update(index));
  }
}
