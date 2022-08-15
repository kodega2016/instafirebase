import 'package:firebaseinsta/screens/edit_profile/edit_profile_screen.dart';
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
      onPressed: () {
        if (isCurrentUser) {
          Navigator.pushNamed(
            context,
            EditProfileScreen.routeName,
            arguments: EditProfileScreenArgs(context: context),
          );
        }
      },
      child: Text(
        isCurrentUser ? 'Edit Profile' : (isFollowing ? 'Unflow' : 'Follow'),
      ),
    );
  }
}
