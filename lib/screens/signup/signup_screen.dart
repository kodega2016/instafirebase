import 'package:firebaseinsta/repositories/auth/auth_repository.dart';
import 'package:firebaseinsta/screens/nav/nav_screen.dart';
import 'package:firebaseinsta/screens/signup/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const String routeName = 'signup';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
          create: (context) => SignupCubit(
                authRepository: context.read<AuthRepository>(),
              ),
          child: const SignUpScreen()),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.signUpStatus == SignUpStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure?.message ?? ''),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.signUpStatus == SignUpStatus.success) {
            Navigator.pushReplacementNamed(context, NavScreen.routeName);
          }
        },
        builder: (context, state) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      onChanged: context.read<SignupCubit>().changeName,
                      validator: (val) =>
                          (val?.isEmpty ?? true) ? 'name is required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      textInputAction: TextInputAction.next,
                      onChanged: context.read<SignupCubit>().changeEmail,
                      validator: (val) => (val?.isEmpty ?? true)
                          ? 'email address is required'
                          : (!val!.contains('@')
                              ? 'email address must be a valid one'
                              : null),
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      textInputAction: TextInputAction.done,
                      onChanged: context.read<SignupCubit>().changePassword,
                      validator: (val) => (val?.isEmpty ?? true)
                          ? 'password is required'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<SignupCubit>()
                            .signUpWithEmailAndPassword();
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
