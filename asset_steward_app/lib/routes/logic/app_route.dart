import 'package:asset_steward_app/main.export.dart';
import 'package:flutter/widgets.dart';
import 'package:recase/recase.dart';

class AppRoute extends GoRoute {
  AppRoute(
    RPath path,
    Widget Function(GoRouterState s) builder, {
    super.routes,
    super.redirect,
    Function(GoRouterState s)? onPop,
    bool canPop = true,
  }) : super(
         path: path.path,
         name: path.path.snakeCase,
         onExit: (c, s) {
           onPop?.call(s);
           return canPop;
         },
         pageBuilder: (context, state) {
           final pageContent = builder(state);
           return NoTransitionPage(name: path.path.snakeCase, child: pageContent);
         },
       );
}

class RPath {
  const RPath(this.path);

  final String path;

  Future<T?> push<T extends Object?>(BuildContext context, {QMap query = const {}, Object? extra}) {
    query = query.map((k, v) => MapEntry(k, '$v'));
    final route = Uri(path: path, queryParameters: query).toString();
    return context.push(route, extra: extra);
  }

  void go(BuildContext context, {QMap query = const {}, Object? extra}) {
    final route = Uri(path: path, queryParameters: query).toString();
    return context.go(route, extra: extra);
  }

  RPath operator +(RPath newPath) => RPath('$path${newPath.path}');
}
