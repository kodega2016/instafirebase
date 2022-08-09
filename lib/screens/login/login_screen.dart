import 'package:firebaseinsta/repositories/auth/auth_repository.dart';
import 'package:firebaseinsta/screens/login/login/login_cubit.dart';
import 'package:firebaseinsta/screens/nav/nav_screen.dart';
import 'package:firebaseinsta/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = 'login';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: LoginScreen.routeName),
      builder: (context) {
        return BlocProvider<LoginCubit>(
          create: (_) => LoginCubit(
            authRepository: context.read<AuthRepository>(),
          ),
          child: const LoginScreen(),
        );
      },
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.loginStatus == LoginStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.failure?.message ?? ''),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state.loginStatus == LoginStatus.success) {
                Navigator.pushReplacementNamed(context, NavScreen.routeName);
              }
            },
            child: Form(
              key: _formKey,
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Instagram',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          if (state.loginStatus == LoginStatus.submitting) {
                            return const LinearProgressIndicator();
                          }
                          return Container();
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        textInputAction: TextInputAction.next,
                        onChanged: context.read<LoginCubit>().emailChanged,
                        validator: (val) => (val?.isEmpty ?? true)
                            ? 'email address is required'
                            : (!val!.contains('@')
                                ? 'email address must be a valid one'
                                : null),
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        textInputAction: TextInputAction.done,
                        onChanged: context.read<LoginCubit>().passwordChanged,
                        validator: (val) => (val?.isEmpty ?? true)
                            ? 'password is required'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            context.read<LoginCubit>().loginWithCredentials();
                          }
                        },
                        child: const Text('Log In'),
                      ),
                      const SizedBox(height: 4),
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.1),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[50],
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: const Text('No account? Sign Up'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
