import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension RouteEx on BuildContext {
  GoRouter get route => GoRouter.of(this);
  GoRouterState get routeState => GoRouterState.of(this);

  T? tryGetExtra<T>() {
    if (routeState.extra case final T t) return t;
    return null;
  }

  Map<String, String> get pathParams => routeState.pathParameters;
  String? param(String key) => pathParams[key];
  Map<String, String> get queryParams => routeState.uri.queryParameters;

  String? query(String key) => queryParams[key];

  void nPop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);

  Future<T?> nPush<T extends Object?>(Widget page, {bool? fullScreen}) {
    final route = MaterialPageRoute<T>(builder: (c) => page, fullscreenDialog: fullScreen ?? false);

    return Navigator.of(this).push<T>(route);
  }

  Future<T?> nPushReplace<T extends Object?>(Widget page) {
    final route = MaterialPageRoute<T>(builder: (c) => page);
    return Navigator.of(this).pushReplacement(route);
  }
}

extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => ColorScheme.of(this);
  TextTheme get text => TextTheme.of(this);

  MediaQueryData get mq => MediaQuery.of(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  Size get _size => MediaQuery.sizeOf(this);
  double get height => _size.height;
  double get width => _size.width;

  Brightness get bright => theme.brightness;

  bool get isDark => bright == .dark;
  bool get isLight => bright == .light;
}
