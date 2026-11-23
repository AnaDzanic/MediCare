import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/appointment.dart';
import '../consts/app_colors.dart';
import '../consts/app_text.dart';
import '../widgets/app_card.dart';
import '../widgets/avatar_circle.dart';
import '../widgets/doctor_card.dart';
import '../widgets/gradient_header.dart';
import '../widgets/progress_ring.dart';
import '../widgets/section_title.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final void Function(int) onGoTo;

  const HomeScreen({super.key, required this.onGoTo});

  @override
  Widget build(BuildContext context) {
    final therapies = MockData.therapies;
    final taken = therapies.where((t) => t.taken).length;
    final total = therapies.length;
    final progress = total == 0 ? 0.0 : taken / total;
    final percent = (progress * 100).round();

    final notTaken = therapies.where((t) => !t.taken).toList();
    final upcoming = MockData.appointments.where((a) => a.upcoming).toList();

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GradientHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Četvrtak, 12. novembar',
                            style: AppText.onGradientBody,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Zdravo, Milena 👋',
                            style: AppText.onGradientTitle,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ProfileScreen(),
                          ),
                        );
                      },
                      child: const AvatarCircle(
                        name: MockData.patientName,
                        size: 46,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildNextAppointment(upcoming),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  'Danas za vaše zdravlje',
                  actionText: 'Sve →',
                  onAction: () => onGoTo(4),
                ),
                AppCard(
                  onTap: () => onGoTo(4),
                  child: Row(
                    children: [
                      ProgressRing(value: progress, label: '$percent%'),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$taken od $total doze', style: AppText.title),
                            const SizedBox(height: 4),
                            Text(
                              notTaken.isEmpty
                                  ? 'Sve doze su uzete. Bravo! ✓'
                                  : 'Sledeća doza u ${notTaken.first.time}',
                              style: AppText.muted,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.event_available_rounded,
                        label: 'Zakažite\npregled',
                        onTap: () => onGoTo(1),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.folder_shared_rounded,
                        label: 'Moj\nkarton',
                        onTap: () => onGoTo(3),
                      ),
                    ),
                  ],
                ),
                SectionTitle(
                  'Preporučeni za vas',
                  actionText: 'Svi →',
                  onAction: () => onGoTo(1),
                ),
                ...MockData.doctors
                    .take(2)
                    .map((doctor) => DoctorCard(doctor: doctor, onTap: () {})),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextAppointment(List<Appointment> upcoming) {
    if (upcoming.isEmpty) {
      return AppCard(
        onTap: () => onGoTo(1),
        child: Row(
          children: const [
            Icon(Icons.event_busy_rounded, color: AppColors.primary),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Nemate zakazanih pregleda. Zakažite novi.',
                style: AppText.body,
              ),
            ),
          ],
        ),
      );
    }

    final next = upcoming.first;
    return AppCard(
      onTap: () => onGoTo(2),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.event_rounded, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'VAŠ SLEDEĆI PREGLED',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text('${next.dateLabel} · ${next.time}', style: AppText.title),
                Text(
                  '${next.doctorName} · ${next.title}',
                  style: AppText.muted,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: AppText.label)),
        ],
      ),
    );
  }
}
