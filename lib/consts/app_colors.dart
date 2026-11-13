import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0E7C86);
  static const Color primaryDark = Color(0xFF0A5A63);
  static const Color accent = Color(0xFF2EC4B6);
  static const Color background = Color(0xFFF4FAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF12303A);
  static const Color textMuted = Color(0xFF6B8A93);
  static const Color border = Color(0xFFE0EDED);
  static const Color success = Color(0xFF34C38F);
  static const Color warning = Color(0xFFFF6B5E);
  static const Color primarySoft = Color(0x1A0E7C86);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white20 = Color(0x33FFFFFF);
  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primary, accent],
  );
}
