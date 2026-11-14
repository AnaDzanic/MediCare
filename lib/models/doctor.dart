class Doctor {
  final String name;
  final String specialty;
  final String clinic;
  final String city;
  final String about;
  final String workHours;
  final double rating;
  final int reviews;
  final int years;
  final List<String> slots; 

  const Doctor({
    required this.name,
    required this.specialty,
    required this.clinic,
    required this.city,
    required this.about,
    required this.workHours,
    required this.rating,
    required this.reviews,
    required this.years,
    required this.slots,
  });

  String get ratingText => rating.toString().replaceAll('.', ',');
}