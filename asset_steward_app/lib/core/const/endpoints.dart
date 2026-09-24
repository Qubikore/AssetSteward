class Endpoints {
  const Endpoints._();

  static const String baseUrl = 'https://assetsteward-backend.onrender.com/api/v1/';

  static const String login = 'auth/login';
  static const String registerOrganization = 'auth/register-organization';
  static const String refresh = 'auth/refresh';
  static const String profile = 'profile';
  static const String organizationMe = 'organization/me';
  static const String users = 'users';
  static const String locations = 'locations';
  static const String departments = 'departments';
}
