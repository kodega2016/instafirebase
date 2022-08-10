import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
    required this.isCurrentUser,
    required this.isFollowing,
  }) : super(key: key);

  final bool isCurrentUser;
  final bool isFollowing;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () {},
      child: Text(
        isCurrentUser ? 'Edit Profile' : (isFollowing ? 'Unflow' : 'Follow'),
      ),
    );
  }
}
