import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
    required this.username,
    this.bio,
  }) : super(key: key);

  final String username;
  final String? bio;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          if (bio?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(bio!),
            ),
        ],
      ),
    );
  }
}
