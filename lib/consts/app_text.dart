import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppText {
  static const TextStyle h1 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static const TextStyle title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textDark,
    height: 1.4,
  );

  static const TextStyle muted = TextStyle(
    fontSize: 13,
    color: AppColors.textMuted,
    height: 1.4,
  );

  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle onGradientTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.2,
  );

  static const TextStyle onGradientBody = TextStyle(
    fontSize: 14,
    color: AppColors.white70,
    height: 1.4,
  );
}
