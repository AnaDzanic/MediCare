import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/therapy.dart';
import '../consts/app_colors.dart';
import '../consts/app_text.dart';
import '../widgets/app_card.dart';
import '../widgets/page_header.dart';
import '../widgets/section_title.dart';

class TherapiesScreen extends StatefulWidget {
  const TherapiesScreen({super.key});

  @override
  State<TherapiesScreen> createState() => _TherapiesScreenState();
}

class _TherapiesScreenState extends State<TherapiesScreen> {
  bool _remindersOn = true;

  String _nowText() {
    final now = TimeOfDay.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _markTaken(Therapy therapy) {
    setState(() {
      therapy.taken = true;
      therapy.takenAt = _nowText();
    });
  }

  void _undo(Therapy therapy) {
    setState(() {
      therapy.taken = false;
      therapy.takenAt = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weekDoses = MockData.weekDoses;
    final weekTaken = weekDoses.fold<int>(0, (sum, d) => sum + d);
    final weekTotal = weekDoses.length * 2;
    final percent = (weekTaken / weekTotal * 100).round();

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const PageHeader(
            title: 'Moje terapije',
            subtitle: 'Dan po dan. Sve bliže zdravlju.',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle('Prethodnih 7 dana'),
                _buildChart(weekDoses, weekTaken, weekTotal, percent),
                const SizedBox(height: 12),
                _buildMissedWarning(),
                const SectionTitle('Danas · 12. novembar'),
                ...MockData.therapies.map(_buildTherapyCard),
                const SizedBox(height: 4),
                AppCard(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.notifications_active_rounded,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Podsetnici za lekove', style: AppText.label),
                            SizedBox(height: 2),
                            Text(
                              'Podsetnici su vidljivi samo vama.',
                              style: AppText.muted,
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _remindersOn,
                        activeColor: AppColors.primary,
                        onChanged: (value) =>
                            setState(() => _remindersOn = value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(List<int> doses, int taken, int total, int percent) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$percent%',
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    '$taken od $total doza uzeto · 5–11. novembar',
                    style: AppText.muted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 96,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(doses.length, (i) {
                final complete = doses[i] == 2;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 28,
                      height: 12 + 56 * (doses[i] / 2),
                      decoration: BoxDecoration(
                        color: complete ? AppColors.primary : AppColors.warning,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(MockData.weekLabels[i], style: AppText.muted),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissedWarning() {
    return AppCard(
      color: AppColors.warningSoft,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: AppColors.warning),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Juče u 20:00 · Propuštena doza', style: AppText.title),
                SizedBox(height: 2),
                Text(
                  'Ne duplirajte dozu. Posavetujte se sa lekarom.',
                  style: AppText.muted,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTherapyCard(Therapy therapy) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: therapy.taken
                    ? AppColors.successSoft
                    : AppColors.primarySoft,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.medication_rounded,
                color: therapy.taken ? AppColors.success : AppColors.primary,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(therapy.name, style: AppText.title),
                  const SizedBox(height: 2),
                  Text(
                    '${therapy.instruction} · ${therapy.time}',
                    style: AppText.muted,
                  ),
                  if (therapy.taken)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Uzeto u ${therapy.takenAt}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (therapy.taken)
              GestureDetector(
                onTap: () => _undo(therapy),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 32,
                ),
              )
            else
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(84, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => _markTaken(therapy),
                child: const Text('Uzeto'),
              ),
          ],
        ),
      ),
    );
  }
}
