import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../consts/app_colors.dart';
import '../consts/app_text.dart';
import '../widgets/app_card.dart';
import '../widgets/avatar_circle.dart';
import '../widgets/page_header.dart';
import '../widgets/section_title.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final records = MockData.records;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const PageHeader(
            title: 'Moj zdravstveni karton',
            subtitle: 'Vaša zdravstvena priča.',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppCard(
                  child: Row(
                    children: [
                      AvatarCircle(name: MockData.patientName, size: 56),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(MockData.patientName, style: AppText.title),
                            SizedBox(height: 2),
                            Text('Rođena 14. 6. 1992.', style: AppText.muted),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SectionTitle('Vaša istorija nege'),
                ...List.generate(records.length, (i) {
                  final entry = records[i];
                  final isLast = i == records.length - 1;
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: 20,
                          child: Column(
                            children: [
                              Container(
                                width: 14,
                                height: 14,
                                margin: const EdgeInsets.only(top: 6),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              if (!isLast)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    color: AppColors.border,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: AppCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.date,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(entry.diagnosis, style: AppText.title),
                                  const SizedBox(height: 6),
                                  Text(entry.note, style: AppText.body),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${entry.doctorName} · Beleška lekara',
                                    style: AppText.muted,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
