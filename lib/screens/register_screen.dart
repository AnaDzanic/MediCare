import 'package:flutter/material.dart';
import 'package:medicare/screens/main_shell.dart';

import '../consts/app_colors.dart';
import '../widgets/app_text_field.dart';
import '../widgets/page_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Popunite sva polja.')));
      return;
    }
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lozinka mora imati bar 6 znakova.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nalog je napravljen. Sada se prijavite.')),
    );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const PageHeader(
            title: 'Napravite nalog',
            subtitle: 'Jedan mali korak za zdraviji dan.',
            showBack: true,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  label: 'Ime i prezime',
                  hint: 'Milena Nikolić',
                  icon: Icons.person_outline_rounded,
                  controller: _nameController,
                ),
                AppTextField(
                  label: 'E-adresa',
                  hint: 'ime@email.com',
                  icon: Icons.mail_outline_rounded,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                AppTextField(
                  label: 'Lozinka',
                  hint: 'Najmanje 6 znakova',
                  icon: Icons.lock_outline_rounded,
                  obscure: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Napravite nalog'),
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Već imate nalog? Prijavite se'),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Kreiranjem naloga prihvatate Uslove korišćenja\ni Politiku privatnosti.',
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
