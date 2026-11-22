import 'package:flutter/material.dart';

import '../consts/app_colors.dart';
import '../consts/app_text.dart';
import '../widgets/app_text_field.dart';
import '../widgets/page_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _send() {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Unesite e-adresu.')));
      return;
    }
    setState(() => _sent = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const PageHeader(
            title: 'Zaboravljena\nlozinka',
            subtitle: 'Poslaćemo vam link za novu lozinku.',
            showBack: true,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: _sent ? _buildConfirmation(context) : _buildForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'E-adresa',
          hint: 'ime@email.com',
          icon: Icons.mail_outline_rounded,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 8),
        ElevatedButton(onPressed: _send, child: const Text('Pošaljite link')),
      ],
    );
  }

  Widget _buildConfirmation(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Container(
          width: 96,
          height: 96,
          decoration: const BoxDecoration(
            color: AppColors.successSoft,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_rounded,
            size: 48,
            color: AppColors.success,
          ),
        ),
        const SizedBox(height: 20),
        const Text('Proverite e-poštu', style: AppText.h1),
        const SizedBox(height: 8),
        Text(
          'Poslali smo uputstvo na ${_emailController.text.trim()}.',
          textAlign: TextAlign.center,
          style: AppText.muted,
        ),
        const SizedBox(height: 28),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Nazad na prijavu'),
        ),
      ],
    );
  }
}
