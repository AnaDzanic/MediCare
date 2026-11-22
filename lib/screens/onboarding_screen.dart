import 'package:flutter/material.dart';

import '../consts/app_colors.dart';
import '../consts/app_text.dart';
import '../widgets/logo_mark.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final List<_Slide> _slides = const [
    _Slide(
      icon: Icons.folder_shared_rounded,
      title: 'Vaš karton,\nuvek uz vas.',
      text: 'Pregledi, dijagnoze i nalazi — bez papira, bez traženja. Sve je tu kada vam zatreba.',
    ),
    _Slide(
      icon: Icons.event_available_rounded,
      title: 'Do pravog lekara.\nBez čekanja.',
      text: 'Pronađite stručnjaka i zakažite pregled u terminu koji vam odgovara.',
    ),
    _Slide(
      icon: Icons.notifications_active_rounded,
      title: 'Mali podsetnik.\nVelika briga o sebi.',
      text: 'Pratite terapiju, obeležite uzetu dozu i gradite zdrave navike, dan po dan.',
    ),
  ];

  void _goToLogin() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  void _next() {
    if (_page == _slides.length - 1) {
      _goToLogin();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _page == _slides.length - 1;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.headerGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LogoMark(size: 34, onDark: true),
                    TextButton(
                      onPressed: _goToLogin,
                      child: const Text(
                        'Preskoči uvod',
                        style: TextStyle(color: AppColors.white70),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _slides.length,
                    onPageChanged: (index) => setState(() => _page = index),
                    itemBuilder: (context, index) {
                      final slide = _slides[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: const BoxDecoration(
                              color: AppColors.white20,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              slide.icon,
                              size: 72,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            slide.title,
                            textAlign: TextAlign.center,
                            style: AppText.onGradientTitle.copyWith(
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            slide.text,
                            textAlign: TextAlign.center,
                            style: AppText.onGradientBody.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_slides.length, (i) {
                    final active = i == _page;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: active ? 26 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: active ? Colors.white : AppColors.white20,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryDark,
                  ),
                  onPressed: _next,
                  child: Text(isLast ? 'Krenimo' : 'Nastavi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Slide {
  final IconData icon;
  final String title;
  final String text;

  const _Slide({required this.icon, required this.title, required this.text});
}
