import 'package:firebaseinsta/blocs/auth/auth_bloc.dart';
import 'package:firebaseinsta/config/app_routes.dart';
import 'package:firebaseinsta/enums/bottom_nav_item.dart';
import 'package:firebaseinsta/repositories/repositories.dart';
import 'package:firebaseinsta/screens/create_post/create_post_screen.dart';
import 'package:firebaseinsta/screens/create_post/cubit/create_post_cubit.dart';
import 'package:firebaseinsta/screens/favourite/favourite_screen.dart';
import 'package:firebaseinsta/screens/feed/feed_screen.dart';
import 'package:firebaseinsta/screens/profile/bloc/profile_bloc.dart';
import 'package:firebaseinsta/screens/profile/profile_screen.dart';
import 'package:firebaseinsta/screens/search/cubit/search_cubit.dart';
import 'package:firebaseinsta/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      onGenerateRoute: AppRoutes.onGenerateNestedRoute,
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
        return BlocProvider<SearchCubit>(
          create: (context) => SearchCubit(
            userRepository: context.read<UserRepository>(),
          ),
          child: SearchScreen(),
        );
      case BottomNavItem.add:
        return BlocProvider(
          create: (_) => CreatePostCubit(
            postRepository: context.read<PostRepository>(),
            authBloc: context.read<AuthBloc>(),
            storageRepository: context.read<StorageRepository>(),
          ),
          child: CreatePostScreen(),
        );
      case BottomNavItem.favorite:
        return const FavouriteScreen();
      case BottomNavItem.profile:
        return BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            authBloc: context.read<AuthBloc>(),
            userRepository: context.read<UserRepository>(),
            postRepository: context.read<PostRepository>(),
          )..add(
              ProfileLoadUser(
                userID: context.read<AuthBloc>().state.user?.uid ?? '',
              ),
            ),
          child: const ProfileScreen(),
        );

      default:
        return const Scaffold();
    }
  }
}
