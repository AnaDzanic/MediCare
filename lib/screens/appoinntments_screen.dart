import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/appointment.dart';
import '../consts/app_colors.dart';
import '../consts/app_text.dart';
import '../widgets/app_card.dart';
import '../widgets/avatar_circle.dart';
import '../widgets/page_header.dart';
import '../widgets/segmented_tabs.dart';
import '../widgets/status_chip.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int _tab = 0;

  Future<void> _cancel(Appointment appointment) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Da li želite da otkažete pregled?'),
        content: const Text(
          'Ovaj termin će postati dostupan drugim pacijentima.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Zadržite termin'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              'Da, otkažite pregled',
              style: TextStyle(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => MockData.appointments.remove(appointment));
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Termin je otkazan.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final showUpcoming = _tab == 0;
    final items = MockData.appointments
        .where((a) => a.upcoming == showUpcoming)
        .toList();

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const PageHeader(
            title: 'Moji termini',
            subtitle: 'Svi vaši pregledi na jednom mestu.',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SegmentedTabs(
                  labels: const ['Predstojeći', 'Prethodni'],
                  selected: _tab,
                  onChanged: (i) => setState(() => _tab = i),
                ),
                const SizedBox(height: 20),
                if (items.isEmpty) _buildEmpty(showUpcoming),
                ...items.map(_buildCard),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(bool upcoming) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.event_busy_rounded,
              size: 56,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: 12),
            Text(
              upcoming
                  ? 'Nemate zakazanih pregleda.'
                  : 'Još nema prethodnih pregleda.',
              style: AppText.title,
            ),
            const SizedBox(height: 4),
            const Text(
              'Kada budete spremni, tu smo za vas.',
              style: AppText.muted,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Appointment a) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AvatarCircle(name: a.doctorName, size: 48),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.doctorName, style: AppText.title),
                      Text(a.title, style: AppText.muted),
                    ],
                  ),
                ),
                StatusChip(
                  text: a.status,
                  color: a.upcoming ? AppColors.primary : AppColors.textMuted,
                  softColor: a.upcoming
                      ? AppColors.primarySoft
                      : AppColors.border,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(
                  Icons.event_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text('${a.dateLabel} · ${a.time}', style: AppText.body),
              ],
            ),
            const SizedBox(height: 14),
            if (a.upcoming)
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.warning,
                  side: const BorderSide(color: AppColors.warning),
                  minimumSize: const Size(double.infinity, 46),
                ),
                onPressed: () => _cancel(a),
                child: const Text('Otkažite pregled'),
              )
            else
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nalaz je dostupan u vašem kartonu.'),
                    ),
                  );
                },
                child: const Text('Pogledajte nalaz →'),
              ),
          ],
        ),
      ),
    );
  }
}
