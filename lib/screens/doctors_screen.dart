import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/doctor.dart';
import '../consts/app_text.dart';
import '../widgets/choice_box.dart';
import '../widgets/doctor_card.dart';
import '../widgets/page_header.dart';
import 'doctor_profile_screen.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  String _query = '';
  String _specialty = 'Svi';

  List<Doctor> get _filtered {
    final q = _query.trim().toLowerCase();
    return MockData.doctors.where((d) {
      final matchesSpecialty = _specialty == 'Svi' || d.specialty == _specialty;
      final matchesQuery =
          q.isEmpty ||
          d.name.toLowerCase().contains(q) ||
          d.specialty.toLowerCase().contains(q);
      return matchesSpecialty && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final doctors = _filtered;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          PageHeader(
            title: 'Pronađite svoju\ndobru negu.',
            bottom: TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: const InputDecoration(
                hintText: 'Ime lekara ili specijalnost',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: MockData.specialties.map((s) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceBox(
                          label: s,
                          selected: _specialty == s,
                          onTap: () => setState(() => _specialty = s),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                if (doctors.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 32),
                    child: Center(
                      child: Text(
                        'Nema rezultata za vašu pretragu.',
                        style: AppText.muted,
                      ),
                    ),
                  ),
                ...doctors.map(
                  (doctor) => DoctorCard(
                    doctor: doctor,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DoctorProfileScreen(doctor: doctor),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
