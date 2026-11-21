import 'package:flutter/material.dart';

import '../consts/app_colors.dart';

class AvatarCircle extends StatelessWidget {
  final String name;
  final double size;

  const AvatarCircle({super.key, required this.name, this.size = 48});

  String _initials() {
    final parts = name
        .split(' ')
        .where((p) => p.isNotEmpty && p != 'Dr' && p != 'dr')
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0];
    return parts[0][0] + parts[parts.length - 1][0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        shape: BoxShape.circle,
      ),
      child: Text(
        _initials(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.36,
        ),
      ),
    );
  }
}
