import 'package:asset_steward_app/app_shell.dart';
import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/asset_details_page.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/assets_pageview.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/create_asset_page.dart';
import 'package:asset_steward_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:asset_steward_app/features/auth/presentation/screens/login_page.dart';
import 'package:asset_steward_app/features/auth/presentation/screens/register_page.dart';
import 'package:asset_steward_app/features/categories/presentation/screens/categories_page.dart';
import 'package:asset_steward_app/features/departments/presentation/screens/departments_page.dart';
import 'package:asset_steward_app/features/home/presentation/screens/home_pageview.dart';
import 'package:asset_steward_app/features/locations/presentation/screens/locations_page.dart';
import 'package:asset_steward_app/features/maintenance/presentation/screens/maintenance_pageview.dart';
import 'package:asset_steward_app/features/profile/presentation/screens/profile_page.dart';
import 'package:asset_steward_app/features/scan/presentation/screens/qr_scan_result_page.dart';
import 'package:asset_steward_app/features/scan/presentation/screens/scan_pageview.dart';
import 'package:asset_steward_app/features/users/presentation/screens/manage_users_page.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'route_config.g.dart';

typedef RouteRedirect = FutureOr<String?> Function(BuildContext, GoRouterState);

/// A listenable wrapper that triggers router redirection when the watched Riverpod provider changes.
class MultiProviderListenable extends ChangeNotifier {
  MultiProviderListenable(Ref ref, List<dynamic> providers) {
    for (final provider in providers) {
      ref.listen(provider, (prev, next) => notifyListeners());
    }
  }
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final rootNavigator = GlobalKey<NavigatorState>(debugLabel: 'root');
  final shellNavigator = GlobalKey<NavigatorState>(debugLabel: 'shell');

  Ctx._key = rootNavigator;
  String? redirectLogic(BuildContext ctx, GoRouterState state) {
    final current = state.uri.path;
    Chirp.info('route redirect: $current');

    final authState = ref.read(authCtrlProvider);

    final isAuthenticated = authState.value == true;
    final isLoginPage = current == RPaths.login.path;
    final isRegisterPage = current == RPaths.register.path;

    final isAuthPage = isLoginPage || isRegisterPage;

    if (!isAuthenticated && !isAuthPage) {
      return RPaths.login.path;
    } else if (isAuthenticated && isAuthPage) {
      return RPaths.home.path;
    }

    return null;
  }

  return GoRouter(
    navigatorKey: rootNavigator,
    redirect: redirectLogic,
    refreshListenable: MultiProviderListenable(ref, [authCtrlProvider]),
    initialLocation: RPaths.home.path,
    routes: [
      ShellRoute(
        navigatorKey: shellNavigator,
        routes: [
          AppRoute(RPaths.home, (_) => const HomePageview()),
          AppRoute(RPaths.assets, (_) => const AssetsPageview()),
          AppRoute(RPaths.scan, (_) => const ScanPageview()),
          AppRoute(RPaths.maintenance, (_) => const MaintenancePageview()),
          AppRoute(RPaths.profile, (_) => const ProfilePage()),
        ],
        builder: (_, s, c) => AppShell(key: s.pageKey, child: c),
      ),
      AppRoute(RPaths.login, (_) => const LoginPage()),
      AppRoute(RPaths.register, (_) => const RegisterPage()),

      AppRoute(RPaths.manageUsers, (_) => const ManageUsersPage()),
      AppRoute(RPaths.locations, (_) => const LocationsPage()),
      AppRoute(RPaths.departments, (_) => const DepartmentsPage()),
      AppRoute(RPaths.categories, (_) => const CategoriesPage()),
      AppRoute(RPaths.createAsset, (s) => CreateAssetPage(asset: s.extra as AssetModel?)),
      AppRoute(RPaths.assetDetails(':id'), (s) => AssetDetailsPage(id: int.parse(s.pathParameters['id']!))),
      AppRoute(RPaths.qrScanResult(':id'), (s) => QRScanResultPage(assetId: int.parse(s.pathParameters['id']!))),
    ],
    errorBuilder: (_, state) => ErrorRoutePage(error: state.error?.message),
  );
}

/// The app router list

class Ctx {
  const Ctx._();
  static GlobalKey<NavigatorState>? _key;
  static BuildContext? get tryContext => _key?.currentContext;

  static BuildContext get context {
    if (_key?.currentContext == null) {
      throw StateError('No navigator context found.');
    }
    return _key!.currentContext!;
  }
}
