import 'logic/app_route.dart';

export 'package:go_router/go_router.dart';

class RPaths {
  const RPaths._();

  static const List<RPath> navRoutes = [home, assets, scan, maintenance, profile];

  static const login = RPath('/login');
  static const register = RPath('/register');

  static const home = RPath('/home');
  static const assets = RPath('/assets');
  static const scan = RPath('/scan');
  static const maintenance = RPath('/maintenance');
  static const profile = RPath('/profile');
  
  static const manageUsers = RPath('/manage-users');
  static const locations = RPath('/locations');
  static const departments = RPath('/departments');
  static const categories = RPath('/categories');
}
