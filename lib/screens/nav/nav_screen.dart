import 'package:flutter/material.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({Key? key}) : super(key: key);

  static const String routeName = 'nav';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const NavScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
