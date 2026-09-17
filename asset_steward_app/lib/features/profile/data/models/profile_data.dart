import 'package:dart_mappable/dart_mappable.dart';

part 'profile_data.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class ProfileData with ProfileDataMappable {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String role;
  final String gender;
  final String? dob;
  final String? profilePicture;

  const ProfileData({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.role,
    required this.gender,
    this.dob,
    this.profilePicture,
  });

  static const fromMap = ProfileDataMapper.fromMap;
  static const fromJson = ProfileDataMapper.fromJson;
}
