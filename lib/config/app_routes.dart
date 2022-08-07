import 'package:firebaseinsta/screens/login/login_screen.dart';
import 'package:firebaseinsta/screens/nav/nav_screen.dart';
import 'package:firebaseinsta/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    debugPrint('route:${settings.name}');

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) {
            return const Scaffold();
          },
        );

      case SplashScreen.routeName:
        return SplashScreen.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case NavScreen.routeName:
        return NavScreen.route();

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('Page not found 🧐 '),
              ),
            );
          },
        );
    }
  }
}