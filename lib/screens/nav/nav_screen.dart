import 'package:firebaseinsta/enums/enums.dart';
import 'package:firebaseinsta/screens/nav/cubit/nav_bar_cubit.dart';
import 'package:firebaseinsta/screens/nav/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavScreen extends StatelessWidget {
  NavScreen({Key? key}) : super(key: key);

  static const String routeName = 'nav';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<NavBarCubit>(
        create: (context) => NavBarCubit(),
        child: NavScreen(),
      ),
    );
  }

  final Map<BottomNavItem, GlobalKey<NavigatorState>> navigatorKeys = {
    BottomNavItem.feed: GlobalKey<NavigatorState>(),
    BottomNavItem.search: GlobalKey<NavigatorState>(),
    BottomNavItem.add: GlobalKey<NavigatorState>(),
    BottomNavItem.favorite: GlobalKey<NavigatorState>(),
    BottomNavItem.profile: GlobalKey<NavigatorState>(),
  };

  final Map<BottomNavItem, IconData> items = {
    BottomNavItem.feed: Icons.home_outlined,
    BottomNavItem.search: Icons.search_outlined,
    BottomNavItem.add: Icons.add_outlined,
    BottomNavItem.favorite: Icons.favorite_outline,
    BottomNavItem.profile: Icons.person_outline,
  };

  _selectBottomNavItem(
    BuildContext context,
    BottomNavItem bottomNavItem,
    bool isSameItem,
  ) {
    context.read<NavBarCubit>().updateBottomNavItem(bottomNavItem);

    if (isSameItem) {
      navigatorKeys[bottomNavItem]
          ?.currentState
          ?.popUntil((route) => route.isFirst);
    }
  }

  Widget _buildOffStageNavigator(
    BottomNavItem currentItem,
    bool isSelected,
  ) {
    return Offstage(
      offstage: !isSelected,
      child: TabNavigator(
        item: currentItem,
        navigatorKey: navigatorKeys[currentItem]!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavBarCubit, NavBarState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              ...items
                  .map((key, value) {
                    return MapEntry(
                      key,
                      _buildOffStageNavigator(key, key == state.selectedItem),
                    );
                  })
                  .values
                  .toList(),
            ],
          ),
          bottomNavigationBar: BottomNavBar(
            items: items,
            selectedItem: state.selectedItem,
            onTap: (val) {
              var item = BottomNavItem.values[val];
              _selectBottomNavItem(context, item, state.selectedItem == item);
            },
          ),
        );
      },
    );
  }
}
