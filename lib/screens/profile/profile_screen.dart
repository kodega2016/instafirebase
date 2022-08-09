import 'package:firebaseinsta/blocs/auth/auth_bloc.dart';
import 'package:firebaseinsta/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.status == ProfileStatus.error) {
          return Scaffold(
            body: Center(
              child: Text(state.failure?.message ?? ''),
            ),
          );
        } else if (state.status == ProfileStatus.loaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.user.username,
                style: const TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequest());
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Text(state.user.username),
              ],
            ),
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
