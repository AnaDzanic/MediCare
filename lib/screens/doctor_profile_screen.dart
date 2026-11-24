import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/appointment.dart';
import '../models/doctor.dart';
import '../consts/app_colors.dart';
import '../consts/app_text.dart';
import '../widgets/app_card.dart';
import '../widgets/avatar_circle.dart';
import '../widgets/choice_box.dart';
import '../widgets/page_header.dart';
import '../widgets/section_title.dart';
import 'booking_success_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  final Doctor doctor;

  const DoctorProfileScreen({super.key, required this.doctor});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  static const List<String> _dayNames = [
    'Ponedeljak',
    'Utorak',
    'Sreda',
    'Četvrtak',
    'Petak',
    'Subota',
    'Nedelja',
  ];
  static const List<String> _months = [
    'januar',
    'februar',
    'mart',
    'april',
    'maj',
    'jun',
    'jul',
    'avgust',
    'septembar',
    'oktobar',
    'novembar',
    'decembar',
  ];

  final List<DateTime> _days = List.generate(
    7,
    (i) => DateTime.now().add(Duration(days: i)),
  );

  // ignore: unused_element
  String _fullDate(DateTime d) => '${d.day}. ${_months[d.month - 1]}';

  int _dayIndex = 0;
  String? _slot;

  void _confirm() {
    final appointment = Appointment(
      doctorName: widget.doctor.name,
      title: '${widget.doctor.specialty} – pregled',
      dateLabel: _fullDate(_days[_dayIndex]),
      time: _slot!,
      upcoming: true,
      status: 'Potvrđeno',
    );

    MockData.appointments.add(appointment);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => BookingSuccessScreen(appointment: appointment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          PageHeader(
            title: doctor.name,
            subtitle: '${doctor.specialty} · ${doctor.clinic}',
            showBack: true,
            bottom: Row(
              children: [
                AvatarCircle(name: doctor.name, size: 56),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    '★ ${doctor.ratingText} · ${doctor.reviews} utisaka\n${doctor.years} god. iskustva · ${doctor.city}',
                    style: AppText.onGradientBody,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle('O lekaru'),
                Text(doctor.about, style: AppText.body),
                const SizedBox(height: 16),
                AppCard(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Radno vreme', style: AppText.label),
                            const SizedBox(height: 2),
                            Text(doctor.workHours, style: AppText.muted),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SectionTitle('Izaberite termin'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(_days.length, (i) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceBox(
                          label:
                              '${_dayNames[_days[i].weekday - 1]}\n${_days[i].day}. ${_months[_days[i].month - 1].substring(0, 3)}',
                          selected: _dayIndex == i,
                          onTap: () => setState(() => _dayIndex = i),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Slobodni termini', style: AppText.label),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: doctor.slots.map((slot) {
                    return ChoiceBox(
                      label: slot,
                      selected: _slot == slot,
                      onTap: () => setState(() => _slot = slot),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: ElevatedButton(
            onPressed: _slot == null ? null : _confirm,
            child: Text(
              _slot == null
                  ? 'Izaberite vreme termina'
                  : 'Potvrdite termin · $_slot',
            ),
          ),
        ),
      ),
    );
  }
}
