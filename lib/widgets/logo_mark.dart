import 'package:flutter/material.dart';

import '../consts/app_colors.dart';

class LogoMark extends StatelessWidget {
  final double size;
  final bool onDark;

  const LogoMark({super.key, this.size = 36, this.onDark = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: onDark ? AppColors.white20 : AppColors.primarySoft,
            borderRadius: BorderRadius.circular(size * 0.3),
          ),
          child: Icon(
            Icons.add_rounded,
            color: onDark ? Colors.white : AppColors.primary,
            size: size * 0.7,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'MediCare',
          style: TextStyle(
            fontSize: size * 0.6,
            fontWeight: FontWeight.w700,
            color: onDark ? Colors.white : AppColors.textDark,
          ),
        ),
      ],
    );
  }
}
