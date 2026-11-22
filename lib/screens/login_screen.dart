import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/app_user.dart';
import '../consts/app_colors.dart';
import '../consts/app_text.dart';
import '../widgets/app_text_field.dart';
import '../widgets/gradient_header.dart';
import '../widgets/logo_mark.dart';
import '../widgets/segmented_tabs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController(
    text: MockData.patientEmail,
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '12345678',
  );

  int _roleIndex = 0; // 0 = pacijent, 1 = lekar, 2 = administrator

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unesite e-adresu i lozinku.')),
      );
      return;
    }

    final UserRole role = UserRole.values[_roleIndex];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Prijavljeni ste kao: ${role.label}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GradientHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LogoMark(size: 34, onDark: true),
                const SizedBox(height: 28),
                const Text(
                  'Dobro došli\nnazad.',
                  style: AppText.onGradientTitle,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Zdravlje počinje dobrim izborom.',
                  style: AppText.onGradientBody,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Prijavite se kao', style: AppText.label),
                const SizedBox(height: 8),
                SegmentedTabs(
                  labels: const ['Pacijent', 'Lekar', 'Administrator'],
                  selected: _roleIndex,
                  onChanged: (i) => setState(() => _roleIndex = i),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  label: 'E-adresa',
                  hint: 'ime@email.com',
                  icon: Icons.mail_outline_rounded,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                AppTextField(
                  label: 'Lozinka',
                  hint: 'Unesite lozinku',
                  icon: Icons.lock_outline_rounded,
                  obscure: true,
                  controller: _passwordController,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Zaboravili ste lozinku?'),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Prijavite se'),
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Nemate nalog? Registrujte se'),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Demo verzija: uđite sa bilo kojom e-adresom i lozinkom.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
