class Appointment {
  final String doctorName;
  final String title;
  final String dateLabel;
  final String time;
  final bool upcoming;
  final String status;

  const Appointment({
    required this.doctorName,
    required this.title,
    required this.dateLabel,
    required this.time,
    required this.upcoming,
    required this.status,
  });
}
