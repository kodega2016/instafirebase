import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    Key? key,
    this.profileImageUrl,
    this.image,
    required this.radius,
    this.onPressed,
  }) : super(key: key);

  final double radius;
  final String? profileImageUrl;
  final File? image;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[200],
        backgroundImage: profileImageUrl != null
            ? CachedNetworkImageProvider(profileImageUrl!)
            : null,
        child: image != null
            ? Image.file(image!)
            : (profileImageUrl != null
                ? Image.network(profileImageUrl!)
                : const Icon(Icons.camera_alt)),
      ),
    );
  }
}
