import 'package:asset_steward_app/app_shell.dart';
import 'package:asset_steward_app/features/assets/presentation/screens/assets_pageview.dart';
import 'package:asset_steward_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:asset_steward_app/features/auth/presentation/screens/login_page.dart';
import 'package:asset_steward_app/features/auth/presentation/screens/register_page.dart';
import 'package:asset_steward_app/features/home/presentation/screens/home_pageview.dart';
import 'package:asset_steward_app/features/maintenance/presentation/screens/maintenance_pageview.dart';
import 'package:asset_steward_app/features/profile/presentation/screens/profile_page.dart';
import 'package:asset_steward_app/features/scan/presentation/screens/scan_pageview.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'route_config.g.dart';

typedef RouteRedirect = FutureOr<String?> Function(BuildContext, GoRouterState);

// String rootPath = RPaths.dashboard.path;
final routerProvider = appRouterProvider;

/// A listenable wrapper that triggers router redirection when the watched Riverpod provider changes.
class MultiProviderListenable extends ChangeNotifier {
  MultiProviderListenable(Ref ref, List<dynamic> providers) {
    for (final provider in providers) {
      ref.listen(provider, (prev, next) => notifyListeners());
    }
  }
}

@riverpod
class AppRouter extends _$AppRouter {
  final _rootNavigator = GlobalKey<NavigatorState>(debugLabel: 'root');
  final _shellNavigator = GlobalKey<NavigatorState>(debugLabel: 'shell');

  GoRouter _appRouter(RouteRedirect? redirect) {
    return GoRouter(
      navigatorKey: _rootNavigator,
      redirect: redirect,
      refreshListenable: MultiProviderListenable(ref, [authCtrlProvider]),
      initialLocation: RPaths.home.path,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigator,
          routes: _routes,
          builder: (_, s, c) => AppShell(key: s.pageKey, child: c),
        ),

        GoRoute(path: RPaths.login.path, builder: (context, state) => const LoginPage()),
        GoRoute(path: RPaths.register.path, builder: (context, state) => const RegisterPage()),
      ],
      errorBuilder: (_, state) => ErrorRoutePage(error: state.error?.message),
    );
  }

  /// The app router list
  List<RouteBase> get _routes => [
    AppRoute(RPaths.home, (_) => const HomePageview()),
    AppRoute(RPaths.assets, (_) => const AssetsPageview()),
    AppRoute(RPaths.scan, (_) => const ScanPageview()),
    AppRoute(RPaths.maintenance, (_) => const MaintenancePageview()),
    AppRoute(RPaths.profile, (_) => const ProfilePage()),
  ];

  @override
  GoRouter build() {
    Ctx._key = _rootNavigator;
    String? redirectLogic(ctx, GoRouterState state) {
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

    return _appRouter(redirectLogic);
  }
}

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
