part of 'nav_bar_cubit.dart';

class NavBarState extends Equatable {
  const NavBarState({required this.selectedItem});
  final BottomNavItem selectedItem;

  @override
  List<Object> get props => [selectedItem];
}
