import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseinsta/blocs/auth/auth_bloc.dart';
import 'package:firebaseinsta/blocs/simple_bloc_observer.dart';
import 'package:firebaseinsta/config/app_routes.dart';
import 'package:firebaseinsta/repositories/repositories.dart';
import 'package:firebaseinsta/screens/screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = kDebugMode;
  runApp(const InstaApp());
}

class InstaApp extends StatelessWidget {
  const InstaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<StorageRepository>(
          create: (context) => StorageRepository(),
        ),
        RepositoryProvider<PostRepository>(
          create: (context) => PostRepository(),
        ),
      ],
      child: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          authRepository: context.read<AuthRepository>(),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Insta Flutter',
          theme: ThemeData(
            primaryColor: Colors.blue,
            brightness: Brightness.light,
            fontFamily: GoogleFonts.robotoMono().fontFamily,
            scaffoldBackgroundColor: Colors.grey[50],
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(
              color: Colors.white,
              elevation: 1,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              actionsIconTheme: IconThemeData(color: Colors.black),
              iconTheme: IconThemeData(color: Colors.black),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            tabBarTheme: const TabBarTheme(labelColor: Colors.black),
            textTheme: const TextTheme(
              headline6: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          initialRoute: SplashScreen.routeName,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
