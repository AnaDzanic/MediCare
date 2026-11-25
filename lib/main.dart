import 'package:flutter/material.dart';

import 'consts/app_theme.dart';
import 'screens/main_shell.dart';

void main() {
  runApp(const MediCareApp());
}

class MediCareApp extends StatelessWidget {
  const MediCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediCare',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainShell(),
    );
  }
}
