import 'package:flutter/material.dart';

import '../models/appointment.dart';
import '../consts/app_colors.dart';
import '../consts/app_text.dart';
import '../widgets/app_card.dart';
import '../widgets/avatar_circle.dart';

class BookingSuccessScreen extends StatelessWidget {
  final Appointment appointment;

  const BookingSuccessScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 24),
            Center(
              child: Container(
                width: 110,
                height: 110,
                decoration: const BoxDecoration(
                  color: AppColors.successSoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 72,
                  color: AppColors.success,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Termin je potvrđen',
              textAlign: TextAlign.center,
              style: AppText.h1,
            ),
            const SizedBox(height: 8),
            const Text(
              'Vaš pregled je uspešno zakazan.\nPodsetićemo vas dan ranije.',
              textAlign: TextAlign.center,
              style: AppText.muted,
            ),
            const SizedBox(height: 28),
            AppCard(
              child: Row(
                children: [
                  AvatarCircle(name: appointment.doctorName, size: 52),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appointment.doctorName, style: AppText.title),
                        const SizedBox(height: 2),
                        Text(appointment.title, style: AppText.muted),
                        const SizedBox(height: 6),
                        Text(
                          '${appointment.dateLabel} · ${appointment.time}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AppCard(
              color: AppColors.primarySoft,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pripremite se za pregled', style: AppText.title),
                  SizedBox(height: 10),
                  _Tip('Ponesite prethodne nalaze i spisak lekova.'),
                  _Tip('Dođite 10 minuta pre zakazanog termina.'),
                  _Tip('Otkazivanje bez naknade do 24 h pre pregleda.'),
                ],
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              child: const Text('Nazad na početnu'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tip extends StatelessWidget {
  final String text;

  const _Tip(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_rounded, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: AppText.body)),
        ],
      ),
    );
  }
}
