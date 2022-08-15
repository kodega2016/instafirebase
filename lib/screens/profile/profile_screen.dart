import 'package:firebaseinsta/blocs/auth/auth_bloc.dart';
import 'package:firebaseinsta/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

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
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () async {
            //     Navigator.pushNamed(context, EditProfileScreen.routeName);
            //   },
            //   child: const Icon(Icons.add_a_photo),
            // ),
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
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            UserProfileImage(
                              profileImageUrl: state.user.profileImageUrl,
                              radius: 50,
                            ),
                            ProfileStats(
                              followers: state.user.followers,
                              followings: state.user.following,
                              isCurrentUser: state.isCurrentUser,
                              isFollowing: state.isFollowing,
                              posts: 0,
                            ),
                          ],
                        ),
                      ),
                      ProfileInfo(
                        username: state.user.username,
                        bio: state.user.bio,
                      ),
                    ],
                  ),
                ),
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
