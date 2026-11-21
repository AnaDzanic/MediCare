import 'package:flutter/material.dart';

import '../models/doctor.dart';
import '../consts/app_colors.dart';
import '../consts/app_text.dart';
import 'app_card.dart';
import 'avatar_circle.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;

  const DoctorCard({super.key, required this.doctor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        onTap: onTap,
        child: Row(
          children: [
            AvatarCircle(name: doctor.name, size: 56),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name, style: AppText.title),
                  const SizedBox(height: 2),
                  Text(
                    '${doctor.specialty} · ${doctor.clinic}',
                    style: AppText.muted,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Color(0xFFF5A623),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${doctor.ratingText} (${doctor.reviews})',
                        style: AppText.muted,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
