class Therapy {
  final String name;
  final String instruction;
  final String time;
  bool taken;
  String? takenAt;

  Therapy({
    required this.name,
    required this.instruction,
    required this.time,
    this.taken = false,
    this.takenAt,
  });
}
