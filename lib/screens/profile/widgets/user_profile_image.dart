import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    Key? key,
    this.profileImageUrl,
    required this.radius,
  }) : super(key: key);

  final double radius;
  final String? profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      backgroundImage: profileImageUrl != null
          ? CachedNetworkImageProvider(profileImageUrl!)
          : null,
      child: profileImageUrl == null
          ? const Icon(
              Icons.person,
              size: 50,
              color: Colors.blueGrey,
            )
          : null,
    );
  }
}
