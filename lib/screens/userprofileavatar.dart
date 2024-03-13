import 'package:flutter/material.dart';

class UserProfileAvatar extends StatelessWidget {
  final String imagePath;
  final double radius;

  const UserProfileAvatar({
    super.key,
    required this.imagePath,
    this.radius = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(imagePath),
      backgroundColor: Colors.grey, // Placeholder color if image fails to load
    );
  }
}