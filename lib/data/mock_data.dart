import '../models/app_user.dart';
import '../models/appointment.dart';
import '../models/doctor.dart';
import '../models/record_entry.dart';
import '../models/schedule_item.dart';
import '../models/therapy.dart';

class MockData {
  static const String patientName = 'Milena Nikolić';
  static const String patientEmail = 'milena.nikolic@email.com';
  static const String doctorName = 'Dr Ana Petrović';

  static const List<String> specialties = [
    'Svi',
    'Kardiolog',
    'Internista',
    'Dermatolog',
  ];

  static final List<Doctor> doctors = [
    const Doctor(
      name: 'Dr Ana Petrović',
      specialty: 'Kardiolog',
      clinic: 'MediCare centar',
      city: 'Beograd',
      about: 'Dr Ana Petrović se bavi prevencijom, dijagnostikom i praćenjem bolesti srca. Pregled obuhvata razgovor, EKG i savet.',
      workHours: 'Ponedeljak – petak, 08:00 – 16:00',
      rating: 4.9,
      reviews: 124,
      years: 12,
      slots: ['09:00', '10:30', '11:00', '12:00', '13:30', '15:00'],
    ),
    const Doctor(
      name: 'Dr Marko Jovanović',
      specialty: 'Internista',
      clinic: 'MediCare centar',
      city: 'Beograd',
      about: 'Internista sa dugogodišnjim iskustvom u opštim pregledima, kontroli pritiska i praćenju hroničnih bolesti.',
      workHours: 'Ponedeljak – petak, 09:00 – 17:00',
      rating: 4.8,
      reviews: 98,
      years: 15,
      slots: ['09:00', '10:00', '11:30', '14:00', '16:00'],
    ),
    const Doctor(
      name: 'Dr Milica Savić',
      specialty: 'Dermatolog',
      clinic: 'MediCare centar',
      city: 'Beograd',
      about: 'Dermatolog koji se bavi pregledom i lečenjem kožnih promena, alergija i preventivnim pregledima mladeža.',
      workHours: 'Utorak – subota, 10:00 – 18:00',
      rating: 4.9,
      reviews: 86,
      years: 9,
      slots: ['10:00', '11:30', '13:00', '15:30', '17:00'],
    ),
  ];

  static final List<Appointment> appointments = [
    const Appointment(
      doctorName: 'Dr Ana Petrović',
      title: 'Kardiološki pregled',
      dateLabel: '18. novembar',
      time: '10:30',
      upcoming: true,
      status: 'Potvrđeno',
    ),
    const Appointment(
      doctorName: 'Dr Ana Petrović',
      title: 'Kontrolni pregled',
      dateLabel: '5. novembar',
      time: '09:00',
      upcoming: false,
      status: 'Završeno',
    ),
    const Appointment(
      doctorName: 'Dr Marko Jovanović',
      title: 'Opšti pregled',
      dateLabel: '20. oktobar',
      time: '11:00',
      upcoming: false,
      status: 'Završeno',
    ),
  ];

  static final List<Therapy> therapies = [
    Therapy(
      name: 'Vitamin D · 1000 IJ',
      instruction: '1 tableta · uz doručak',
      time: '08:00',
      taken: true,
      takenAt: '08:02',
    ),
    Therapy(
      name: 'Amoksicilin · 500 mg',
      instruction: '1 kapsula · posle obroka',
      time: '14:00',
    ),
  ];

  static const List<int> weekDoses = [2, 2, 1, 2, 2, 2, 1];
  static const List<String> weekLabels = ['Č', 'P', 'S', 'N', 'P', 'U', 'S'];

  static final List<RecordEntry> records = [
    const RecordEntry(
      date: '5. NOVEMBAR 2026.',
      doctorName: 'Dr Ana Petrović',
      diagnosis: 'I10 · Esencijalna hipertenzija',
      note:
          'Pritisak stabilan. Nastaviti terapiju i pratiti vrednosti kod kuće.',
    ),
    const RecordEntry(
      date: '20. OKTOBAR 2026.',
      doctorName: 'Dr Marko Jovanović',
      diagnosis: 'Z00.0 · Opšti zdravstveni pregled',
      note: 'Laboratorijski nalazi uredni. Preporučena redovna fizička aktivnost.',
    ),
  ];

  static const List<ScheduleItem> schedule = [
    ScheduleItem(
      time: '09:00',
      patient: 'Milena Nikolić',
      reason: 'Kontrolni pregled',
    ),
    ScheduleItem(time: '10:30', patient: 'Petar Ilić', reason: 'Prvi pregled'),
    ScheduleItem(
      time: '11:30',
      patient: 'Jelena Marković',
      reason: 'Kontrola pritiska',
    ),
  ];

  static final List<AppUser> users = [
    const AppUser(
      name: 'Milena Nikolić',
      email: 'milena.nikolic@email.com',
      role: UserRole.patient,
    ),
    const AppUser(
      name: 'Petar Ilić',
      email: 'petar.ilic@email.com',
      role: UserRole.patient,
    ),
    const AppUser(
      name: 'Jovana Popović',
      email: 'jovana.popovic@email.com',
      role: UserRole.patient,
    ),
    const AppUser(
      name: 'Dr Ana Petrović',
      email: 'ana.petrovic@medicare.rs',
      role: UserRole.doctor,
    ),
    const AppUser(
      name: 'Dr Marko Jovanović',
      email: 'marko.jovanovic@medicare.rs',
      role: UserRole.doctor,
    ),
  ];
}
