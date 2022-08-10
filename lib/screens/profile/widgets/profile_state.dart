import 'package:flutter/material.dart';

import 'profile_button.dart';
import 'stats_item.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({
    Key? key,
    this.posts = 0,
    this.followers = 0,
    this.followings = 0,
    this.isFollowing = false,
    this.isCurrentUser = false,
  }) : super(key: key);

  final int posts;
  final int followers;
  final int followings;
  final bool isFollowing;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatItem(
                count: posts,
                label: 'posts',
              ),
              StatItem(
                count: followers,
                label: 'followers',
              ),
              StatItem(
                count: followings,
                label: 'following',
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ProfileButton(
              isCurrentUser: false,
              isFollowing: false,
            ),
          ),
        ],
      ),
    );
  }
}
