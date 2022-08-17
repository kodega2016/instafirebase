import 'package:firebaseinsta/blocs/auth/auth_bloc.dart';
import 'package:firebaseinsta/models/post_model.dart';
import 'package:firebaseinsta/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          (state.posts);
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
                SliverToBoxAdapter(
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Theme.of(context).primaryColor,
                    indicatorWeight: 3.0,
                    onTap: (i) => context.read<ProfileBloc>().add(
                          ProfileToggleGridView(isGridView: i == 0),
                        ),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.grid_on, size: 28),
                      ),
                      Tab(
                        icon: Icon(Icons.list, size: 28),
                      ),
                    ],
                  ),
                ),
                state.status == ProfileStatus.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state.isGridView
                        ? SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final PostModel post = state.posts[index];
                                return Card(
                                  child: Center(
                                    child: Image.network(
                                      post.imageUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              childCount: state.posts.length,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 6 / 5,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final PostModel post = state.posts[index];
                                return SizedBox(
                                  // height: 120,
                                  child: Card(
                                    child: Image.network(
                                      post.imageUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              childCount: state.posts.length,
                            ),
                          )
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
