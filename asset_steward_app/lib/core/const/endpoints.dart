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
  static String assetReject(int id) => 'assets/$id/reject';
  static const String assetTransfer = 'assets/transfer';
  static const String assetAssign = 'assets/assign';
  static const String assetReturn = 'assets/return';
  static String assetQrCode(int id) => 'assets/$id/qrcode';
  static const String assetLabels = 'assets/labels';
  static String assetLabel(int id) => 'assets/$id/label';
  static String assetHistory(int id) => 'assets/$id/history';
  static String assetAssignmentsForAsset(int id) => 'assets/$id/assignments';
  static const String assetAssignments = 'assets/assignments';
  static String assetAssignment(int id) => 'assets/assignments/$id';
  static const String myAssetAssignments = 'assets/assignments/my';

  static const String maintenance = 'maintenance';
  static const String startMaintenance = 'maintenance/start';
  static String completeMaintenance(int id) => 'maintenance/$id/complete';
}
