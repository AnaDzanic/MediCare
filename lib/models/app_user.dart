enum UserRole { patient, doctor, admin }

extension UserRoleLabel on UserRole {
  String get label {
    if (this == UserRole.patient) return 'Pacijent';
    if (this == UserRole.doctor) return 'Lekar';
    return 'Administrator';
  }
}

class AppUser {
  final String name;
  final String email;
  final UserRole role;

  const AppUser({required this.name, required this.email, required this.role});
}
