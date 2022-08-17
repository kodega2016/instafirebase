import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebaseinsta/blocs/auth/auth_bloc.dart';
import 'package:firebaseinsta/extensions/datetime_extension.dart';
import 'package:firebaseinsta/models/post_model.dart';
import 'package:firebaseinsta/repositories/repositories.dart';
import 'package:firebaseinsta/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/widgets.dart';

class ProfileScreenArgs {
  final String userID;
  ProfileScreenArgs({required this.userID});
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String routeName = '/profile';

  static Route route({required ProfileScreenArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(
          userRepository: context.read<UserRepository>(),
          postRepository: context.read<PostRepository>(),
          authBloc: context.read<AuthBloc>(),
        )..add(ProfileLoadUser(userID: args.userID)),
        child: const ProfileScreen(),
      ),
    );
  }

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
                              posts: state.posts.length,
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
                    : (state.isGridView
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
                                return PostView(post: post);
                              },
                              childCount: state.posts.length,
                            ),
                          ))
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

class PostView extends StatelessWidget {
  const PostView({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage: post.user.profileImageUrl == null
                    ? null
                    : CachedNetworkImageProvider(post.user.profileImageUrl!),
                child: post.user.profileImageUrl == null
                    ? const Icon(Icons.person_outline)
                    : null,
              ),
              const SizedBox(width: 10),
              Text(
                post.user.username,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2.2,
            child: CachedNetworkImage(
              imageUrl: post.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.favorite_outline),
              SizedBox(width: 10),
              Icon(Icons.message_outlined),
            ],
          ),
          const SizedBox(height: 16),
          Text('${post.likes} likes'),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              text: post.user.username,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.black),
              children: [
                TextSpan(
                  text: ' ${post.caption}',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(post.date.timeAgo(),
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: Colors.grey)),
        ],
      ),
    );
  }
}
