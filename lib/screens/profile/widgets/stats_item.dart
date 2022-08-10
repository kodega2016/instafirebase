import 'package:flutter/material.dart';

class StatItem extends StatelessWidget {
  const StatItem({
    Key? key,
    required this.count,
    required this.label,
  }) : super(key: key);

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
