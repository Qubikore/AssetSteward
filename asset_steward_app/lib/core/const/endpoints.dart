class Endpoints {
  const Endpoints._();

  static const String baseUrl =
      'https://assetsteward-backend.onrender.com/api/v1/';

  static const String login = 'auth/login';
  static const String registerOrganization = 'auth/register-organization';
  static const String refresh = 'auth/refresh';
  static const String profile = 'profile';
  static const String organizationMe = 'organization/me';
  static const String users = 'users';
  static const String locations = 'locations';
  static const String departments = 'departments';
  static const String dashboardMetrics = 'dashboard/metrics';
  static const String dashboardUtilization = 'dashboard/utilization';
  static const String categories = 'categories';
  static const String assets = 'assets';
  static String asset(int id) => 'assets/$id';
  static String assetApprove(int id) => 'assets/$id/approve';
  static const String assetTransfer = 'assets/transfer';
  static const String assetAssign = 'assets/assign';
  static String assetQrCode(int id) => 'assets/$id/qrcode';
  static const String assetLabels = 'assets/labels';
  static const String assetAssignments = 'assets/assignments';

  static const String maintenance = 'maintenance';
  static const String startMaintenance = 'maintenance/start';
  static String completeMaintenance(int id) => 'maintenance/$id/complete';
}
