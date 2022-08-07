import 'package:firebaseinsta/blocs/auth/auth_bloc.dart';
import 'package:firebaseinsta/screens/login/login_screen.dart';
import 'package:firebaseinsta/screens/nav/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = 'splash';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: SplashScreen.routeName),
      builder: (_) {
        return const SplashScreen();
      },
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, current) => prev.authStatus != current.authStatus,
        listener: (context, state) {
          if (state.authStatus == AuthStatus.authenticated) {
            Navigator.pushReplacementNamed(context, NavScreen.routeName);
          } else if (state.authStatus == AuthStatus.unauthenticated) {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }
        },
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
