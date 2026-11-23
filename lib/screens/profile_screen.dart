import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../consts/app_colors.dart';
import '../widgets/app_text_field.dart';
import '../widgets/avatar_circle.dart';
import '../widgets/page_header.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(
    text: MockData.patientName,
  );
  final TextEditingController _emailController = TextEditingController(
    text: MockData.patientEmail,
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '064 123 4567',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _save() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Podaci su sačuvani.')));
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
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
            title: 'Moj profil',
            subtitle: 'Vaši podaci su u sigurnim rukama.',
            showBack: true,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: AvatarCircle(name: MockData.patientName, size: 84),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  label: 'Ime i prezime',
                  hint: 'Ime i prezime',
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
                  label: 'Telefon',
                  hint: '06x xxx xxxx',
                  icon: Icons.phone_outlined,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _save,
                  child: const Text('Sačuvajte izmene'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.warning,
                    side: const BorderSide(color: AppColors.warning),
                  ),
                  onPressed: _logout,
                  child: const Text('Odjavite se'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
