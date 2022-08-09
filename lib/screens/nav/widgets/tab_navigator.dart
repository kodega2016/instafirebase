import 'package:firebaseinsta/enums/bottom_nav_item.dart';
import 'package:firebaseinsta/screens/add/add_screen.dart';
import 'package:firebaseinsta/screens/favourite/favourite_screen.dart';
import 'package:firebaseinsta/screens/feed/feed_screen.dart';
import 'package:firebaseinsta/screens/profile/profile_scrren.dart';
import 'package:firebaseinsta/screens/search/search_screen.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  static const String tabNavigatorRoot = '/';

  const TabNavigator({
    Key? key,
    required this.item,
    required this.navigatorKey,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;

  Map<String, WidgetBuilder> _routeBuilders() {
    return {
      tabNavigatorRoot: (context) => _getScreen(context, item),
    };
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, WidgetBuilder> routeBuilders = _routeBuilders();

    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
            settings: const RouteSettings(name: tabNavigatorRoot),
            builder: (context) {
              return routeBuilders[initialRoute]!(context);
            },
          )
        ];
      },
    );
  }

  _getScreen(BuildContext context, BottomNavItem item) {
    switch (item) {
      case BottomNavItem.feed:
        return const FeedScreen();
      case BottomNavItem.search:
        return const SearchScreen();
      case BottomNavItem.add:
        return const AddScreen();
      case BottomNavItem.favorite:
        return const FavouriteScreen();
      case BottomNavItem.profile:
        return const ProfileScreen();

      default:
    }
  }
}
