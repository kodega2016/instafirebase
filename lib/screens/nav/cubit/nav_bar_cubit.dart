import 'package:equatable/equatable.dart';
import 'package:firebaseinsta/enums/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(const NavBarState(selectedItem: BottomNavItem.feed));

  void updateBottomNavItem(BottomNavItem item) {
    if (state.selectedItem != item) {
      emit(NavBarState(selectedItem: item));
    }
  }
}
