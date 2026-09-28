import 'package:dart_mappable/dart_mappable.dart';

part 'profile_model.mapper.dart';

@MappableEnum(caseStyle: CaseStyle.upperSnakeCase)
enum UserRole { superAdmin, hr, user }

@MappableClass(caseStyle: CaseStyle.snakeCase)
class ProfileModel with ProfileModelMappable {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final UserRole role;
  final String? gender;
  final String? dob;
  final String? profilePicture;

  const ProfileModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.role,
    this.gender,
    this.dob,
    this.profilePicture,
  });

  static const fromMap = ProfileModelMapper.fromMap;
  static const fromJson = ProfileModelMapper.fromJson;

  String? get avatar {
    if (profilePicture == null) return null;
    if (profilePicture!.startsWith('http://localhost:8080/')) {
      return 'https://assetsteward-backend.onrender.com/api/v1/${profilePicture!.replaceAll('http://localhost:8080/', '')}';
    }
    return profilePicture;
  }

  bool get isPrivileged => (role == UserRole.superAdmin || role == UserRole.hr);

  String get fullName => '$firstname $lastname';
}
